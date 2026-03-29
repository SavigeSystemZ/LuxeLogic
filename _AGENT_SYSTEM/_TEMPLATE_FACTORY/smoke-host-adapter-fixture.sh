#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-host-adapter-fixture.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary repo from the master template and prove that an external
host-adapter fixture can consume the canonical prompt-emitter JSON, resolve the
declared repo-local files in order, and package them into a deterministic prompt
ingestion bundle without overriding repo-local authority.
EOF
}

APP_NAME="HostAdapterSmoke"
TEMP_ROOT="/tmp"
KEEP=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --app-name)
      APP_NAME="${2:-}"
      shift 2
      ;;
    --temp-root)
      TEMP_ROOT="${2:-}"
      shift 2
      ;;
    --keep)
      KEEP=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unexpected argument: $1" >&2
      exit 1
      ;;
  esac
done

mkdir -p "${TEMP_ROOT}"
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-host-fixture-smoke.XXXXXX")"
cleanup() {
  local status=$?
  if [[ ${status} -eq 0 && ${KEEP} -eq 0 ]]; then
    rm -rf "${TMP_REPO}"
  else
    printf 'Preserved temp repo: %s\n' "${TMP_REPO}" >&2
  fi
  exit ${status}
}
trap cleanup EXIT

printf 'Temp repo: %s\n' "${TMP_REPO}"

bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${TMP_REPO}" --app-name "${APP_NAME}" --strict
bash "${TMP_REPO}/bootstrap/check-host-ingestion.sh" "${TMP_REPO}"

python3 - <<'PY' "${TMP_REPO}"
from __future__ import annotations

import hashlib
import json
import subprocess
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
emit = repo / "bootstrap" / "emit-host-prompt.sh"
fixture_path = repo / ".aiaast-host-adapter-fixture.json"

cmd_base = [
    "bash",
    str(emit),
    str(repo),
    "--task",
    "Host adapter fixture smoke",
    "--scope",
    "Factory-side verification of canonical prompt consumption",
    "--read",
    "_system/PROJECT_PROFILE.md",
    "--read",
    "WHERE_LEFT_OFF.md",
    "--constraint",
    "Keep repo-local truth authoritative.",
    "--validation",
    "bootstrap/validate-system.sh <repo> --strict",
    "--deliverable",
    "Summarize files loaded and the next validation command.",
]

json_result = subprocess.run(
    [*cmd_base, "--format", "json"],
    cwd=repo,
    text=True,
    capture_output=True,
)
if json_result.returncode != 0:
    print(json_result.stderr or json_result.stdout, file=sys.stderr)
    raise SystemExit(1)

text_result = subprocess.run(
    cmd_base,
    cwd=repo,
    text=True,
    capture_output=True,
)
if text_result.returncode != 0:
    print(text_result.stderr or text_result.stdout, file=sys.stderr)
    raise SystemExit(1)

payload = json.loads(json_result.stdout)
issues: list[str] = []

startup_files = payload.get("startup_files", [])
required_files = payload.get("required_repo_local_files", [])
if not isinstance(startup_files, list) or not startup_files:
    issues.append("Emitter payload is missing startup_files.")
if not isinstance(required_files, list) or not required_files:
    issues.append("Emitter payload is missing required_repo_local_files.")

load_sequence: list[str] = []
for rel in [*startup_files, *required_files]:
    if rel not in load_sequence:
        load_sequence.append(rel)

if load_sequence[: len(startup_files)] != startup_files:
    issues.append("Startup files are not first in the adapter load sequence.")

loaded_files: list[dict[str, object]] = []
for rel in load_sequence:
    rel_path = Path(rel)
    if rel_path.is_absolute():
        issues.append(f"Adapter payload used an absolute path: {rel}")
        continue
    path = repo / rel_path
    if not path.is_file():
        issues.append(f"Adapter payload references a missing file: {rel}")
        continue
    text = path.read_text()
    loaded_files.append(
        {
            "path": rel,
            "sha256": hashlib.sha256(text.encode("utf-8")).hexdigest(),
            "line_count": len(text.splitlines()),
        }
    )

text_prompt = text_result.stdout
startup_preamble = payload.get("startup_preamble", "")
if not isinstance(startup_preamble, str) or not startup_preamble.strip():
    issues.append("Emitter payload is missing startup_preamble.")
elif not text_prompt.startswith(startup_preamble):
    issues.append("Text prompt does not begin with the canonical startup preamble.")

if issues:
    print("host_adapter_fixture_failed")
    for issue in issues:
        print(f"- {issue}")
    raise SystemExit(1)

fixture = {
    "schema_version": "1.0.0",
    "kind": "aiaast-host-adapter-fixture",
    "startup_preamble": startup_preamble,
    "task_objective": payload["task_objective"],
    "scope": payload["scope"],
    "load_sequence": load_sequence,
    "constraints": payload["constraints"],
    "validation": payload["validation"],
    "deliverables": payload["deliverables"],
    "loaded_files": loaded_files,
}
fixture_path.write_text(json.dumps(fixture, indent=2) + "\n")
print(f"host_adapter_fixture_ok loaded_files={len(loaded_files)} bundle={fixture_path.name}")
PY

printf 'host_adapter_fixture_smoke_ok app_name=%s\n' "${APP_NAME}"
