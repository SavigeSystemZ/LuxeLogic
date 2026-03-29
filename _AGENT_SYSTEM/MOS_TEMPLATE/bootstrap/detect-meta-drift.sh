#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SOURCE="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=lib/mos-lib.sh
source "${SCRIPT_DIR}/lib/mos-lib.sh"

usage() {
  cat <<'EOF'
Usage: detect-meta-drift.sh <target-repo> [--source <template-root>]
EOF
}

TARGET_REPO=""
SOURCE="${DEFAULT_SOURCE}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source)
      SOURCE="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "${TARGET_REPO}" ]]; then
        TARGET_REPO="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        exit 1
      fi
      ;;
  esac
done

if [[ -z "${TARGET_REPO}" ]]; then
  usage
  exit 1
fi

mos_assert_template_root "${SOURCE}"

resolved_source="$(cd -- "${SOURCE}" && pwd)"
resolved_target="$(cd -- "${TARGET_REPO}" && pwd)"
if [[ "${resolved_source}" == "${resolved_target}" ]]; then
  echo "meta_drift_skipped_same_repo"
  exit 0
fi

python3 - <<'PY' "${SOURCE}" "${TARGET_REPO}"
import filecmp
import sys
from pathlib import Path

source = Path(sys.argv[1]).resolve()
target = Path(sys.argv[2]).resolve()
stateful = {
    "META_PLAN.md",
    "META_TODO.md",
    "META_FIXME.md",
    "META_WHERE_LEFT_OFF.md",
    "META_CHANGELOG.md",
    "META_RELEASE_NOTES.md",
    "meta_system/context/CURRENT_STATUS.md",
    "meta_system/context/DECISIONS.md",
    "meta_system/context/OPEN_QUESTIONS.md",
}
local_only = {
    "README.md",
    "AI_META_SYSTEM_README.md",
    "meta_system/.template-install.json",
}
generated = {
    "meta_system/META_SYSTEM_REGISTRY.json",
    "meta_system/meta-operating-profile.json",
    "meta_system/instruction-precedence.json",
    "meta_system/mos-capabilities.json",
}

issues = []

for path in sorted(source.rglob("*")):
    rel = path.relative_to(source)
    rel_text = str(rel)
    if ".git" in rel.parts or path.is_dir():
        continue
    if rel_text in stateful or rel_text in local_only or rel_text in generated:
        continue
    if rel.parts[:2] == ("meta_system", "host-adapters") and rel.name != "README.md":
        continue
    dest = target / rel
    if not dest.exists():
        issues.append(f"missing in target: {rel_text}")
    elif not filecmp.cmp(path, dest, shallow=False):
        issues.append(f"changed from source: {rel_text}")

if issues:
    print("meta_drift_detected")
    for item in issues:
        print(f"- {item}")
    raise SystemExit(1)

print("meta_drift_ok")
PY
