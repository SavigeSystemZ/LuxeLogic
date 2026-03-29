#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-update-template.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary installed repo, simulate a stale upgrade target with drifted
instruction-layer entrypoints and stale target-side validators, then prove that:
1. additive updates refresh installed version markers and emit a canonical warning
2. strict updates fail against canonical source validators
3. refresh-managed strict updates restore a fully valid repo
EOF
}

APP_NAME="UpdateSmoke"
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
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-update-smoke.XXXXXX")"

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

source_version="$(cat "${TEMPLATE_ROOT}/_system/.template-version")"
source_changelog_header="$(grep -m1 '^## ' "${TEMPLATE_ROOT}/AIAST_CHANGELOG.md")"

bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${TMP_REPO}" --app-name "${APP_NAME}" --strict

python3 - <<'PY' "${TMP_REPO}"
from __future__ import annotations

import json
import re
import stat
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
legacy_version = "1.2.0"

(repo / "AGENTS.md").write_text(
    """# AGENTS.md

Read these files before making meaningful edits:

1. `_system/PROJECT_PROFILE.md`
2. `_system/CONTEXT_INDEX.md`
3. `_system/LOAD_ORDER.md`
4. `_system/VALIDATION_GATES.md`

## Core contract

- `_system/` is the agent operating layer; runtime code must not depend on it.
- App-specific truth belongs in repo files, not in tool-local memory.
- If the system picture looks contradictory or suspicious, run `bootstrap/system-doctor.sh` before continuing.
"""
)

for rel, content in {
    "bootstrap/validate-system.sh": "#!/usr/bin/env bash\nset -euo pipefail\necho system_ok\n",
    "bootstrap/validate-instruction-layer.sh": "#!/usr/bin/env bash\nset -euo pipefail\necho instruction_layer_ok\n",
}.items():
    path = repo / rel
    path.write_text(content)
    path.chmod(path.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

(repo / "_system" / ".template-version").write_text(legacy_version + "\n")

version_path = repo / "AIAST_VERSION.md"
version_path.write_text(
    re.sub(
        r"^- Current version:\s*`[^`]+`$",
        f"- Current version: `{legacy_version}`",
        version_path.read_text(),
        count=1,
        flags=re.MULTILINE,
    )
)

changelog_path = repo / "AIAST_CHANGELOG.md"
changelog_path.write_text(
    re.sub(
        r"^## [^\n]+$",
        "## 0.0.0 - 2000-01-01",
        changelog_path.read_text(),
        count=1,
        flags=re.MULTILINE,
    )
)

for rel in ("_system/aiaast-capabilities.json", "_system/.template-install.json"):
    path = repo / rel
    payload = json.loads(path.read_text())
    payload["template_version"] = legacy_version
    path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
PY

additive_output="$(bash "${TEMPLATE_ROOT}/bootstrap/update-template.sh" "${TMP_REPO}" --source "${TEMPLATE_ROOT}" 2>&1)"
printf '%s\n' "${additive_output}"

if [[ "$(cat "${TMP_REPO}/_system/.template-version")" != "${source_version}" ]]; then
  echo "Update-template smoke failed: additive update did not refresh _system/.template-version." >&2
  exit 1
fi

if ! grep -Fq -- "- Current version: \`${source_version}\`" "${TMP_REPO}/AIAST_VERSION.md"; then
  echo "Update-template smoke failed: additive update did not refresh AIAST_VERSION.md." >&2
  exit 1
fi

if ! grep -Fq -- "${source_changelog_header}" "${TMP_REPO}/AIAST_CHANGELOG.md"; then
  echo "Update-template smoke failed: additive update did not refresh AIAST_CHANGELOG.md." >&2
  exit 1
fi

if [[ "$(jq -r '.template_version' "${TMP_REPO}/_system/aiaast-capabilities.json")" != "${source_version}" ]]; then
  echo "Update-template smoke failed: additive update did not refresh _system/aiaast-capabilities.json." >&2
  exit 1
fi

if [[ "$(jq -r '.template_version' "${TMP_REPO}/_system/.template-install.json")" != "${source_version}" ]]; then
  echo "Update-template smoke failed: additive update did not refresh _system/.template-install.json." >&2
  exit 1
fi

if [[ "${additive_output}" != *"Post-update notice: canonical instruction-layer validation still fails against preserved installed surfaces."* ]]; then
  echo "Update-template smoke failed: additive update did not emit the canonical warning notice." >&2
  exit 1
fi

if [[ "${additive_output}" != *"AGENTS.md is missing required repo-local references"* ]]; then
  echo "Update-template smoke failed: additive update did not surface the canonical AGENTS.md reference failure." >&2
  exit 1
fi

set +e
strict_output="$(bash "${TEMPLATE_ROOT}/bootstrap/update-template.sh" "${TMP_REPO}" --source "${TEMPLATE_ROOT}" --strict 2>&1)"
strict_status=$?
set -e
printf '%s\n' "${strict_output}"

if [[ ${strict_status} -eq 0 ]]; then
  echo "Update-template smoke failed: strict update unexpectedly passed despite stale instruction surfaces." >&2
  exit 1
fi

if [[ "${strict_output}" != *"AGENTS.md is missing required repo-local references"* ]]; then
  echo "Update-template smoke failed: strict update did not fail on the expected AGENTS.md reference gap." >&2
  exit 1
fi

if [[ "${strict_output}" != *"AGENTS.md is missing canonical terminology markers"* ]]; then
  echo "Update-template smoke failed: strict update did not fail on the expected AGENTS.md terminology gap." >&2
  exit 1
fi

bash "${TEMPLATE_ROOT}/bootstrap/update-template.sh" "${TMP_REPO}" --source "${TEMPLATE_ROOT}" --refresh-managed --strict
bash "${TMP_REPO}/bootstrap/validate-system.sh" "${TMP_REPO}" --strict

printf 'update_template_smoke_ok app_name=%s version=%s\n' "${APP_NAME}" "${source_version}"
