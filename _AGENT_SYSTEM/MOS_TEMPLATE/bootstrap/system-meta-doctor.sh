#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_TARGET="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
DEFAULT_SOURCE="${DEFAULT_TARGET}"

usage() {
  cat <<'EOF'
Usage: system-meta-doctor.sh [target-repo] [--source <template-root>] [--strict] [--heal] [--mode auto|template|installed]
EOF
}

TARGET_REPO=""
SOURCE="${DEFAULT_SOURCE}"
STRICT=0
HEAL=0
MODE="auto"

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
    --heal)
      HEAL=1
      shift
      ;;
    --mode)
      MODE="${2:-}"
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
  TARGET_REPO="${DEFAULT_TARGET}"
fi

run_check() {
  local label="$1"
  shift
  local output
  if output="$("$@" 2>&1)"; then
    printf '[pass] %s\n' "${label}"
    [[ -n "${output}" ]] && printf '%s\n' "${output}"
    return 0
  fi
  printf '[fail] %s\n' "${label}"
  [[ -n "${output}" ]] && printf '%s\n' "${output}"
  return 1
}

if [[ ${HEAL} -eq 1 ]]; then
  bash "${SCRIPT_DIR}/repair-meta-system.sh" "${TARGET_REPO}" --source "${SOURCE}" >/dev/null
fi

strict_flag=()
[[ ${STRICT} -eq 1 ]] && strict_flag+=(--strict)
mode_flag=()
[[ "${MODE}" != "auto" ]] && mode_flag+=(--mode "${MODE}")

failed=0
warned=0
warning_labels=()

run_check "validate-meta-system" bash "${SCRIPT_DIR}/validate-meta-system.sh" "${TARGET_REPO}" "${strict_flag[@]}" "${mode_flag[@]}" || failed=1
run_check "check-meta-install-boundary" bash "${SCRIPT_DIR}/check-meta-install-boundary.sh" "${TARGET_REPO}" || failed=1
run_check "validate-meta-instruction-layer" bash "${SCRIPT_DIR}/validate-meta-instruction-layer.sh" "${TARGET_REPO}" || failed=1
run_check "detect-meta-instruction-conflicts" bash "${SCRIPT_DIR}/detect-meta-instruction-conflicts.sh" "${TARGET_REPO}" "${strict_flag[@]}" || failed=1
run_check "check-meta-host-adapter-alignment" bash "${SCRIPT_DIR}/check-meta-host-adapter-alignment.sh" "${TARGET_REPO}" || failed=1

if run_check "check-meta-hallucination" bash "${SCRIPT_DIR}/check-meta-hallucination.sh" "${TARGET_REPO}"; then
  true
else
  warned=1
  warning_labels+=("hallucination")
fi

if run_check "lint-meta-system" bash "${SCRIPT_DIR}/lint-meta-system.sh" "${TARGET_REPO}"; then
  true
else
  failed=1
fi

resolved_source="$(cd -- "${SOURCE}" && pwd)"
resolved_target="$(cd -- "${TARGET_REPO}" && pwd)"
if [[ "${resolved_source}" != "${resolved_target}" ]]; then
  if run_check "detect-meta-drift" bash "${SCRIPT_DIR}/detect-meta-drift.sh" "${TARGET_REPO}" --source "${SOURCE}"; then
    true
  else
    warned=1
    warning_labels+=("drift")
  fi
fi

if [[ ${failed} -eq 1 ]]; then
  echo "system_meta_doctor_failed"
  exit 1
fi

if [[ ${warned} -eq 1 ]]; then
  printf 'system_meta_doctor_warnings=%s\n' "$(IFS=,; echo "${warning_labels[*]}")"
  echo "system_meta_doctor_warn"
  exit 2
fi

echo "system_meta_doctor_ok"
