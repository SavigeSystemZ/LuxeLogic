#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SOURCE="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=lib/mos-lib.sh
source "${SCRIPT_DIR}/lib/mos-lib.sh"

usage() {
  cat <<'EOF'
Usage: update-meta-template.sh <target-repo> [--source <template-root>] [--strict]
EOF
}

TARGET_REPO=""
SOURCE="${DEFAULT_SOURCE}"
STRICT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source)
      SOURCE="${2:-}"
      shift 2
      ;;
    --strict)
      STRICT=1
      shift
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
RESOLVED_SOURCE="$(cd -- "${SOURCE}" && pwd)"
RESOLVED_TARGET="$(cd -- "${TARGET_REPO}" && pwd)"

if [[ "${RESOLVED_SOURCE}" == "${RESOLVED_TARGET}" ]]; then
  echo "Source and target resolve to the same directory: ${RESOLVED_SOURCE}" >&2
  echo "Use --source <template-root> when updating an installed repo from the canonical MOS template root." >&2
  exit 1
fi

python3 - <<'PY' "${RESOLVED_SOURCE}" "${RESOLVED_TARGET}"
import filecmp
import shutil
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
updated = []

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
    if not dest.exists() or not filecmp.cmp(path, dest, shallow=False):
      dest.parent.mkdir(parents=True, exist_ok=True)
      shutil.copy2(path, dest)
      updated.append(rel_text)

for item in updated:
    print(f"updated_file={item}")
print(f"updated_count={len(updated)}")
PY

bash "${SCRIPT_DIR}/install-meta-missing-files.sh" "${RESOLVED_TARGET}" --source "${RESOLVED_SOURCE}" >/dev/null
mos_write_install_metadata "${RESOLVED_TARGET}" "${RESOLVED_SOURCE}" "$(mos_template_version "${RESOLVED_SOURCE}")" "installed" "$(mos_detect_system_readme_path "${RESOLVED_TARGET}")" "update-template"

if [[ ${STRICT} -eq 1 ]]; then
  bash "${SCRIPT_DIR}/validate-meta-system.sh" "${RESOLVED_TARGET}" --strict --mode installed
  bash "${SCRIPT_DIR}/validate-meta-instruction-layer.sh" "${RESOLVED_TARGET}"
  bash "${SCRIPT_DIR}/check-meta-host-adapter-alignment.sh" "${RESOLVED_TARGET}"
  bash "${SCRIPT_DIR}/check-meta-install-boundary.sh" "${RESOLVED_TARGET}"
  mos_record_validation_success \
    "${RESOLVED_TARGET}" \
    "bootstrap/validate-meta-system.sh ${RESOLVED_TARGET} --strict --mode installed" \
    "MOS update integrity, required files, instruction-layer alignment, and boundary validation"
fi
