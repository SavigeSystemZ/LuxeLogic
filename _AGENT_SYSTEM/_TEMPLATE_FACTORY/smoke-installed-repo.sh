#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-installed-repo.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary repo from the master template and verify that init, strict
validation, additive recovery for missing runtime and continuity files, instruction-conflict
detection, and system-doctor all behave correctly. Placeholder-only doctor warnings are
accepted because the temp repo still starts from template-seeded working files.
EOF
}

APP_NAME="GoldenSmoke"
TEMP_ROOT="/tmp"
KEEP=0
SECOND_REPO=""

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
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-installed-smoke.XXXXXX")"
SECOND_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-installed-reject.XXXXXX")"
cleanup() {
  local status=$?
  if [[ ${status} -eq 0 && ${KEEP} -eq 0 ]]; then
    rm -rf "${TMP_REPO}"
    rm -rf "${SECOND_REPO}"
  else
    printf 'Preserved temp repo: %s\n' "${TMP_REPO}" >&2
    printf 'Preserved temp repo: %s\n' "${SECOND_REPO}" >&2
  fi
  exit ${status}
}
trap cleanup EXIT

printf 'Temp repo: %s\n' "${TMP_REPO}"

bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${TMP_REPO}" --app-name "${APP_NAME}" --strict
bash "${TMP_REPO}/bootstrap/validate-system.sh" "${TMP_REPO}" --strict
bash "${TMP_REPO}/bootstrap/check-install-boundary.sh" "${TMP_REPO}"
bash "${TMP_REPO}/bootstrap/detect-instruction-conflicts.sh" "${TMP_REPO}" --strict

if bash "${TMP_REPO}/bootstrap/install-missing-files.sh" "${TMP_REPO}" --source "${REPO_ROOT}" >/dev/null 2>&1; then
  echo "Installed repo smoke failed: repo root was incorrectly accepted as an AIAST source." >&2
  exit 1
fi

if bash "${TMP_REPO}/bootstrap/install-missing-files.sh" "${SECOND_REPO}" --source "${TMP_REPO}" >/dev/null 2>&1; then
  echo "Installed repo smoke failed: an installed AIAST repo was incorrectly accepted as a template source." >&2
  exit 1
fi

rm -rf "${TMP_REPO}/ops" "${TMP_REPO}/packaging" "${TMP_REPO}/mobile" "${TMP_REPO}/ai"
rm -f \
  "${TMP_REPO}/PRODUCT_BRIEF.md" \
  "${TMP_REPO}/RISK_REGISTER.md" \
  "${TMP_REPO}/TEST_STRATEGY.md" \
  "${TMP_REPO}/TODO.md" \
  "${TMP_REPO}/WHERE_LEFT_OFF.md" \
  "${TMP_REPO}/_system/PROJECT_PROFILE.md" \
  "${TMP_REPO}/_system/context/CURRENT_STATUS.md"

bash "${TMP_REPO}/bootstrap/install-missing-files.sh" "${TMP_REPO}" --source "${TEMPLATE_ROOT}" --strict

if [[ ! -f "${TMP_REPO}/ops/install/install.sh" || ! -f "${TMP_REPO}/packaging/appimage.yml" || ! -f "${TMP_REPO}/mobile/flutter/pubspec.yaml" || ! -f "${TMP_REPO}/ai/llm_config.yaml" ]]; then
  echo "Installed repo smoke failed: additive install did not regenerate runtime foundations." >&2
  exit 1
fi

if ! grep -Eq -- "^- \[ \] (HIGH: )?Establish the first validated baseline for .+" "${TMP_REPO}/TODO.md"; then
  echo "Installed repo smoke failed: additive install did not reseed TODO.md." >&2
  exit 1
fi

if ! grep -Fq -- "- Product name: ${APP_NAME}" "${TMP_REPO}/PRODUCT_BRIEF.md"; then
  echo "Installed repo smoke failed: additive install did not reseed PRODUCT_BRIEF.md with the app identity." >&2
  exit 1
fi

if ! grep -Fq -- "- Selected starter blueprint: not yet selected" "${TMP_REPO}/PRODUCT_BRIEF.md"; then
  echo "Installed repo smoke failed: additive install did not restore the default starter-blueprint state in PRODUCT_BRIEF.md." >&2
  exit 1
fi

if ! grep -Fq -- "- Current phase: Onboarding" "${TMP_REPO}/WHERE_LEFT_OFF.md"; then
  echo "Installed repo smoke failed: additive install did not reseed WHERE_LEFT_OFF.md." >&2
  exit 1
fi

if ! grep -Eq -- "^- App name: .+" "${TMP_REPO}/_system/PROJECT_PROFILE.md"; then
  echo "Installed repo smoke failed: additive install did not restore the project profile identity." >&2
  exit 1
fi

if ! grep -Eq -- "^- Packaging / deploy roots: .*ops/.*packaging/.*mobile/.*ai/" "${TMP_REPO}/_system/PROJECT_PROFILE.md"; then
  echo "Installed repo smoke failed: additive install did not refresh inferred profile paths." >&2
  exit 1
fi

if ! grep -Eq -- "^- required confidence for local changes: .+" "${TMP_REPO}/TEST_STRATEGY.md"; then
  echo "Installed repo smoke failed: additive install did not seed local confidence guidance in TEST_STRATEGY.md." >&2
  exit 1
fi

if ! grep -Eq -- "^- format or lint: .+" "${TMP_REPO}/TEST_STRATEGY.md"; then
  echo "Installed repo smoke failed: additive install did not seed validation lanes in TEST_STRATEGY.md." >&2
  exit 1
fi

if ! grep -Fq -- "- Confirm the seeded validation lanes against the first real repo-local run and record any missing coverage explicitly." "${TMP_REPO}/TEST_STRATEGY.md"; then
  echo "Installed repo smoke failed: additive install did not seed the TEST_STRATEGY known-gap note." >&2
  exit 1
fi

if ! grep -Fq -- "- Risk: Validation baseline is still partially inferred or unproven" "${TMP_REPO}/RISK_REGISTER.md"; then
  echo "Installed repo smoke failed: additive install did not seed the validation risk in RISK_REGISTER.md." >&2
  exit 1
fi

if ! grep -Fq -- "- Replace or remove these seeded first-pass risks once repo-local validation evidence and project-specific profile truth exist." "${TMP_REPO}/RISK_REGISTER.md"; then
  echo "Installed repo smoke failed: additive install did not seed the RISK_REGISTER watch list." >&2
  exit 1
fi

if ! grep -Fq -- "- Latest known passing validation: bootstrap/validate-system.sh ${TMP_REPO} --strict -> pass" "${TMP_REPO}/_system/context/CURRENT_STATUS.md"; then
  echo "Installed repo smoke failed: additive install did not record the validation baseline." >&2
  exit 1
fi

set +e
doctor_output="$(bash "${TMP_REPO}/bootstrap/system-doctor.sh" "${TMP_REPO}" 2>&1)"
doctor_status=$?
set -e
printf '%s\n' "${doctor_output}"

if [[ ${doctor_status} -eq 0 ]]; then
  :
elif [[ ${doctor_status} -eq 2 && "${doctor_output}" == *"system_doctor_warnings=placeholders"* ]]; then
  printf 'Accepted placeholder-only warnings from system-doctor in the clean-room repo.\n'
else
  echo "Installed repo smoke failed during system-doctor." >&2
  exit 1
fi

printf 'installed_repo_smoke_ok app_name=%s\n' "${APP_NAME}"
