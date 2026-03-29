#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SOURCE="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=lib/mos-lib.sh
source "${SCRIPT_DIR}/lib/mos-lib.sh"

usage() {
  cat <<'EOF'
Usage: init-meta-project.sh <target-repo> [--source <template-root>] [--strict]
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

mkdir -p "${TARGET_REPO}"

PREEXISTING_README=0
if [[ -f "${TARGET_REPO}/README.md" ]]; then
  PREEXISTING_README=1
fi

bash "${SCRIPT_DIR}/install-meta-missing-files.sh" "${TARGET_REPO}" --source "${SOURCE}" >/dev/null

if [[ ${PREEXISTING_README} -eq 1 && -f "${SOURCE}/README.md" && ! -f "${TARGET_REPO}/AI_META_SYSTEM_README.md" ]]; then
  cp "${SOURCE}/README.md" "${TARGET_REPO}/AI_META_SYSTEM_README.md"
fi

SYSTEM_README_PATH="README.md"
if [[ ${PREEXISTING_README} -eq 1 ]]; then
  SYSTEM_README_PATH="AI_META_SYSTEM_README.md"
fi

mos_write_install_metadata "${TARGET_REPO}" "${SOURCE}" "$(mos_template_version "${SOURCE}")" "installed" "${SYSTEM_README_PATH}" "init-project"

if [[ ${STRICT} -eq 1 ]]; then
  bash "${SCRIPT_DIR}/validate-meta-system.sh" "${TARGET_REPO}" --strict --mode installed
  bash "${SCRIPT_DIR}/validate-meta-instruction-layer.sh" "${TARGET_REPO}"
  bash "${SCRIPT_DIR}/check-meta-host-adapter-alignment.sh" "${TARGET_REPO}"
  bash "${SCRIPT_DIR}/check-meta-install-boundary.sh" "${TARGET_REPO}"
  mos_record_validation_success \
    "${TARGET_REPO}" \
    "bootstrap/validate-meta-system.sh ${TARGET_REPO} --strict --mode installed" \
    "MOS install integrity, required files, instruction-layer alignment, and boundary validation"
fi

echo "meta_project_initialized"
