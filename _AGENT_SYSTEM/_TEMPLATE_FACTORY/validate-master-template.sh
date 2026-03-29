#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: validate-master-template.sh [--temp-root DIR] [--keep-temp-repos] [--skip-scorecard]

Run the full master-template proof chain in a deterministic order:
1. refresh golden-example donor scorecard
2. validate golden-example selection and promotion governance
3. regenerate template host adapters, system key, registry, operating profile, and integrity manifest
4. run source-template strict validation, conflict detection, and system doctor
5. run installed-repo smoke
6. run update-template smoke
7. run starter-blueprint application smoke
8. run starter-blueprint recommendation smoke
9. run test app campaign preparation smoke
10. run packaging-target smoke
11. run host-adapter fixture smoke
12. run external host-bundle smoke
13. run runtime-foundation smoke
EOF
}

TEMP_ROOT="/tmp"
KEEP_TEMP_REPOS=0
SKIP_SCORECARD=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --temp-root)
      TEMP_ROOT="${2:-}"
      shift 2
      ;;
    --keep-temp-repos)
      KEEP_TEMP_REPOS=1
      shift
      ;;
    --skip-scorecard)
      SKIP_SCORECARD=1
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

run_step() {
  local label="$1"
  shift
  printf '[step] %s\n' "${label}"
  "$@"
}

keep_args=()
if [[ ${KEEP_TEMP_REPOS} -eq 1 ]]; then
  keep_args+=(--keep)
fi

if [[ ${SKIP_SCORECARD} -eq 0 ]]; then
  run_step "refresh-golden-examples" bash "${SCRIPT_DIR}/refresh-golden-examples.sh"
else
  printf '[step] refresh-golden-examples (skipped)\n'
fi

run_step "validate-golden-examples" bash "${SCRIPT_DIR}/validate-golden-examples.sh"

run_step "generate-host-adapters" bash "${TEMPLATE_ROOT}/bootstrap/generate-host-adapters.sh" "${TEMPLATE_ROOT}" --write
run_step "generate-system-key" bash "${TEMPLATE_ROOT}/bootstrap/generate-system-key.sh" "${TEMPLATE_ROOT}" --write
run_step "generate-system-registry" bash "${TEMPLATE_ROOT}/bootstrap/generate-system-registry.sh" "${TEMPLATE_ROOT}" --write
run_step "generate-operating-profile" bash "${TEMPLATE_ROOT}/bootstrap/generate-operating-profile.sh" "${TEMPLATE_ROOT}" --write
run_step "generate-integrity-manifest" bash "${TEMPLATE_ROOT}/bootstrap/verify-integrity.sh" --generate --target "${TEMPLATE_ROOT}"
run_step "validate-system-strict" bash "${TEMPLATE_ROOT}/bootstrap/validate-system.sh" "${TEMPLATE_ROOT}" --strict
run_step "detect-instruction-conflicts-strict" bash "${TEMPLATE_ROOT}/bootstrap/detect-instruction-conflicts.sh" "${TEMPLATE_ROOT}" --strict
run_step "system-doctor" bash "${TEMPLATE_ROOT}/bootstrap/system-doctor.sh" "${TEMPLATE_ROOT}"
run_step "smoke-installed-repo" bash "${SCRIPT_DIR}/smoke-installed-repo.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"
run_step "smoke-update-template" bash "${SCRIPT_DIR}/smoke-update-template.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"
run_step "smoke-blueprint-application" bash "${SCRIPT_DIR}/smoke-blueprint-application.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"
run_step "smoke-blueprint-recommendation" bash "${SCRIPT_DIR}/smoke-blueprint-recommendation.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"
run_step "smoke-test-app-campaign" bash "${SCRIPT_DIR}/smoke-test-app-campaign.sh" --temp-root "${TEMP_ROOT}"
run_step "smoke-packaging-targets" bash "${SCRIPT_DIR}/smoke-packaging-targets.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"
run_step "smoke-host-adapter-fixture" bash "${SCRIPT_DIR}/smoke-host-adapter-fixture.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"
run_step "smoke-host-bundle" bash "${SCRIPT_DIR}/smoke-host-bundle.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"
run_step "smoke-runtime-foundations" bash "${SCRIPT_DIR}/smoke-runtime-foundations.sh" --temp-root "${TEMP_ROOT}" "${keep_args[@]}"

echo "master_template_validation_ok"
