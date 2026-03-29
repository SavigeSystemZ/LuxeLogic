#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-host-bundle.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary repo from the master template, export a canonical host bundle,
then prove that a separate external workspace can consume that bundle without direct
repo access while preserving repo-local precedence.
EOF
}

APP_NAME="HostBundleSmoke"
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
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-host-bundle-repo.XXXXXX")"
TMP_HOST="$(mktemp -d "${TEMP_ROOT%/}/aiaast-host-bundle-host.XXXXXX")"
cleanup() {
  local status=$?
  if [[ ${status} -eq 0 && ${KEEP} -eq 0 ]]; then
    rm -rf "${TMP_REPO}" "${TMP_HOST}"
  else
    printf 'Preserved temp repo: %s\n' "${TMP_REPO}" >&2
    printf 'Preserved host workspace: %s\n' "${TMP_HOST}" >&2
  fi
  exit ${status}
}
trap cleanup EXIT

printf 'Temp repo: %s\n' "${TMP_REPO}"
printf 'Host workspace: %s\n' "${TMP_HOST}"

bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${TMP_REPO}" --app-name "${APP_NAME}" --strict
bash "${TMP_REPO}/bootstrap/check-host-bundle.sh" "${TMP_REPO}"

BUNDLE_PATH="${TMP_HOST}/aiaast-host-bundle.json"
bash "${TMP_REPO}/bootstrap/emit-host-bundle.sh" "${TMP_REPO}" \
  --task "External host bundle smoke" \
  --scope "Factory-side verification of zero-repo-access host ingestion" \
  --read "_system/PROJECT_PROFILE.md" \
  --read "WHERE_LEFT_OFF.md" \
  --constraint "Keep repo-local truth authoritative." \
  --validation "bootstrap/validate-system.sh <repo> --strict" \
  --deliverable "Summarize startup files, validation, and next-step status." \
  --output "${BUNDLE_PATH}" >/dev/null

python3 - <<'PY' "${BUNDLE_PATH}" "${TMP_HOST}"
from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path

bundle_path = Path(sys.argv[1]).resolve()
host_root = Path(sys.argv[2]).resolve()
issues: list[str] = []

if not bundle_path.is_file():
    print(f"Missing host bundle: {bundle_path}", file=sys.stderr)
    raise SystemExit(1)

bundle = json.loads(bundle_path.read_text())
load_sequence = bundle.get("load_sequence", [])
included_files = bundle.get("included_files", [])
prompt_payload = bundle.get("prompt_payload", {})
startup_files = prompt_payload.get("startup_files", [])

if bundle.get("kind") != "aiaast-host-bundle":
    issues.append("Bundle kind is incorrect.")
if load_sequence[: len(startup_files)] != startup_files:
    issues.append("Startup files are not first in the external host load sequence.")
if [item.get("path") for item in included_files] != load_sequence:
    issues.append("Included files do not follow the declared load sequence.")

for entry in included_files:
    rel = str(entry.get("path", ""))
    if not rel or Path(rel).is_absolute():
        issues.append(f"Bundle included an invalid path: {rel}")
        continue
    content = entry.get("content")
    if not isinstance(content, str):
        issues.append(f"Bundle is missing text content for: {rel}")
        continue
    sha = hashlib.sha256(content.encode("utf-8")).hexdigest()
    if entry.get("sha256") != sha:
        issues.append(f"Bundle sha256 mismatch for: {rel}")

prompt_text = bundle.get("prompt_text", "")
startup_preamble = prompt_payload.get("startup_preamble", "")
if not isinstance(prompt_text, str) or not prompt_text.startswith(startup_preamble):
    issues.append("Bundle prompt text does not begin with the startup preamble.")

session_prompt_path = host_root / "host-session-prompt.md"
transcript_path = host_root / "host-ingestion-transcript.json"

session_lines = [
    prompt_text.rstrip(),
    "",
    "Bundled repo-local file snapshots:",
]
session_lines.extend(
    f"- `{item['path']}` ({item['line_count']} lines, sha256 `{item['sha256']}`)"
    for item in included_files
)
session_prompt_path.write_text("\n".join(session_lines).rstrip() + "\n")

transcript = {
    "schema_version": "1.0.0",
    "kind": "aiaast-external-host-transcript",
    "bundle_path": bundle_path.name,
    "startup_files": startup_files,
    "load_sequence": load_sequence,
    "loaded_file_count": len(included_files),
    "authority": bundle.get("authority", {}),
    "next_validation": prompt_payload.get("validation", []),
}
transcript_path.write_text(json.dumps(transcript, indent=2) + "\n")

if issues:
    print("host_bundle_external_consumer_failed")
    for issue in issues:
        print(f"- {issue}")
    raise SystemExit(1)

print(
    f"host_bundle_external_consumer_ok loaded_files={len(included_files)} "
    f"prompt={session_prompt_path.name} transcript={transcript_path.name}"
)
PY

printf 'host_bundle_smoke_ok app_name=%s\n' "${APP_NAME}"
