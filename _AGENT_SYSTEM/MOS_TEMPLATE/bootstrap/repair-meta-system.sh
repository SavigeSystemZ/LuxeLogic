#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SOURCE="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=lib/mos-lib.sh
source "${SCRIPT_DIR}/lib/mos-lib.sh"

usage() {
  cat <<'EOF'
Usage: repair-meta-system.sh <target-repo> [--source <template-root>]
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

bash "${SCRIPT_DIR}/install-meta-missing-files.sh" "${TARGET_REPO}" --source "${SOURCE}" >/dev/null
bash "${SCRIPT_DIR}/generate-meta-host-adapters.sh" "${TARGET_REPO}" --write >/dev/null
bash "${SCRIPT_DIR}/generate-meta-system-registry.sh" "${TARGET_REPO}" --write >/dev/null
bash "${SCRIPT_DIR}/generate-meta-operating-profile.sh" "${TARGET_REPO}" --write >/dev/null

resolved_source="$(cd -- "${SOURCE}" && pwd)"
resolved_target="$(cd -- "${TARGET_REPO}" && pwd)"
if [[ "${resolved_source}" == "${resolved_target}" ]]; then
  mos_write_install_metadata "${TARGET_REPO}" "${SOURCE}" "$(mos_template_version "${SOURCE}")" "template-placeholder" "$(mos_detect_system_readme_path "${TARGET_REPO}")" "template-source"
else
  mos_write_install_metadata "${TARGET_REPO}" "${SOURCE}" "$(mos_template_version "${SOURCE}")" "installed" "$(mos_detect_system_readme_path "${TARGET_REPO}")" "repair-system"
fi

echo "meta_repair_ok"
