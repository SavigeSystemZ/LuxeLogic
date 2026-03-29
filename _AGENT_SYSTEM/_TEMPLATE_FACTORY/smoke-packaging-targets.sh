#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-packaging-targets.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary repo from the master template, validate generated packaging
targets, emit hardened systemd units for all presets, and verify those units with
systemd-analyze when available.
EOF
}

APP_NAME="PackagingSmoke"
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
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-packaging-smoke.XXXXXX")"
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
bash "${TMP_REPO}/bootstrap/check-packaging-targets.sh" "${TMP_REPO}" --strict

SYSTEMD_OUT="${TMP_REPO}/ops/systemd"
mkdir -p "${SYSTEMD_OUT}"
CURRENT_USER="$(id -un)"
ENV_FILE="${TMP_REPO}/ops/env/.env.example"

bash "${TMP_REPO}/bootstrap/generate-systemd-unit.sh" \
  --preset http \
  --service-name packaging-http \
  --exec-start /bin/true \
  --working-directory "${TMP_REPO}" \
  --user "${CURRENT_USER}" \
  --environment-file "${ENV_FILE}" \
  --output-dir "${SYSTEMD_OUT}"

bash "${TMP_REPO}/bootstrap/generate-systemd-unit.sh" \
  --preset worker \
  --service-name packaging-worker \
  --exec-start /bin/true \
  --working-directory "${TMP_REPO}" \
  --user "${CURRENT_USER}" \
  --environment-file "${ENV_FILE}" \
  --output-dir "${SYSTEMD_OUT}"

bash "${TMP_REPO}/bootstrap/generate-systemd-unit.sh" \
  --preset timer \
  --service-name packaging-timer \
  --exec-start /bin/true \
  --working-directory "${TMP_REPO}" \
  --user "${CURRENT_USER}" \
  --environment-file "${ENV_FILE}" \
  --schedule "*-*-* 00:00:00" \
  --output-dir "${SYSTEMD_OUT}"

bash "${TMP_REPO}/bootstrap/check-packaging-targets.sh" "${TMP_REPO}" --strict

printf 'packaging_target_smoke_ok app_name=%s\n' "${APP_NAME}"
