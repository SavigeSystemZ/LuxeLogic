#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: install-meta-missing-files.sh <target-repo> [--source <template-root>] [--strict]
EOF
}

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SOURCE="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=lib/mos-lib.sh
source "${SCRIPT_DIR}/lib/mos-lib.sh"

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

if [[ ! -d "${TARGET_REPO}" ]]; then
  echo "Target repo does not exist: ${TARGET_REPO}" >&2
  exit 1
fi

if [[ ! -d "${SOURCE}" ]]; then
  echo "Source template does not exist: ${SOURCE}" >&2
  exit 1
fi

mos_assert_template_root "${SOURCE}"

RESOLVED_SOURCE="$(cd -- "${SOURCE}" && pwd)"
RESOLVED_TARGET="$(cd -- "${TARGET_REPO}" && pwd)"

if [[ "${RESOLVED_SOURCE}" == "${RESOLVED_TARGET}" ]]; then
  echo "Source and target resolve to the same directory: ${RESOLVED_SOURCE}" >&2
  echo "Use --source <template-root> to point at the canonical MOS template root in template-source mode." >&2
  exit 1
fi

python3 - <<'PY' "${RESOLVED_SOURCE}" "${RESOLVED_TARGET}"
import shutil
import sys
from pathlib import Path

source = Path(sys.argv[1]).resolve()
target = Path(sys.argv[2]).resolve()
skip = {".git"}
copied = []

for path in sorted(source.rglob("*")):
    rel = path.relative_to(source)
    if any(part in skip for part in rel.parts):
        continue
    dest = target / rel
    if path.is_dir():
        dest.mkdir(parents=True, exist_ok=True)
        continue
    if dest.exists():
        continue
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(path, dest)
    copied.append(str(rel))

for item in copied:
    print(f"installed_missing_file={item}")
print(f"installed_missing_count={len(copied)}")
PY

mos_refresh_onboarding_baseline "${SCRIPT_DIR}" "${RESOLVED_TARGET}"
mos_refresh_generated_surfaces "${SCRIPT_DIR}" "${RESOLVED_TARGET}"

if [[ -f "$(mos_install_metadata_path "${RESOLVED_TARGET}")" ]]; then
  mos_write_install_metadata \
    "${RESOLVED_TARGET}" \
    "${RESOLVED_SOURCE}" \
    "$(mos_template_version "${RESOLVED_SOURCE}")" \
    "installed" \
    "$(mos_detect_system_readme_path "${RESOLVED_TARGET}")" \
    "install-missing-files"
fi

if [[ ${STRICT} -eq 1 ]]; then
  bash "${SCRIPT_DIR}/validate-meta-system.sh" "${RESOLVED_TARGET}" --strict --mode installed >/dev/null
  bash "${SCRIPT_DIR}/validate-meta-instruction-layer.sh" "${RESOLVED_TARGET}" >/dev/null
  bash "${SCRIPT_DIR}/check-meta-host-adapter-alignment.sh" "${RESOLVED_TARGET}" >/dev/null
  bash "${SCRIPT_DIR}/check-meta-install-boundary.sh" "${RESOLVED_TARGET}" >/dev/null
  mos_record_validation_success \
    "${RESOLVED_TARGET}" \
    "bootstrap/validate-meta-system.sh ${RESOLVED_TARGET} --strict --mode installed" \
    "MOS additive install integrity, required files, instruction-layer alignment, and boundary validation"
fi
