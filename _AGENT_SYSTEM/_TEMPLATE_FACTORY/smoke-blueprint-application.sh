#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-blueprint-application.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary repo from the master template, apply a starter blueprint,
and verify the repo-local operating surfaces were updated coherently.
EOF
}

APP_NAME="BlueprintSmoke"
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
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-blueprint-smoke.XXXXXX")"

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
bash "${TMP_REPO}/bootstrap/apply-starter-blueprint.sh" "${TMP_REPO}" --blueprint UNIVERSAL_APP_PLATFORM --app-name "${APP_NAME}"
bash "${TMP_REPO}/bootstrap/validate-system.sh" "${TMP_REPO}" --strict

if ! grep -Fq -- "- Selected starter blueprint: UNIVERSAL_APP_PLATFORM - Universal App Platform Blueprint" "${TMP_REPO}/PRODUCT_BRIEF.md"; then
  echo "Blueprint smoke failed: PRODUCT_BRIEF.md did not record the selected starter blueprint." >&2
  exit 1
fi

if ! grep -Fq -- "- Current target outcome: Deliver the first blueprint-aligned vertical slice for ${APP_NAME}" "${TMP_REPO}/PLAN.md"; then
  echo "Blueprint smoke failed: PLAN.md did not adopt the blueprint-aligned target outcome." >&2
  exit 1
fi

if ! grep -Fq -- "- Milestone 1: Prove the selected starter blueprint" "${TMP_REPO}/ROADMAP.md"; then
  echo "Blueprint smoke failed: ROADMAP.md did not record the first blueprint milestone." >&2
  exit 1
fi

if ! grep -Fq -- "Web build, lint, typecheck, and smoke route test" "${TMP_REPO}/PRODUCT_BRIEF.md"; then
  echo "Blueprint smoke failed: PRODUCT_BRIEF.md did not capture the blueprint validation focus." >&2
  exit 1
fi

if ! grep -Eq -- "^- \[x\] (HIGH: )?Reviewed and explicitly applied the starter blueprint: UNIVERSAL_APP_PLATFORM" "${TMP_REPO}/TODO.md"; then
  echo "Blueprint smoke failed: TODO.md did not reflect the applied blueprint." >&2
  exit 1
fi

if ! grep -Fq -- "Web build, lint, typecheck, and smoke route test" "${TMP_REPO}/TEST_STRATEGY.md"; then
  echo "Blueprint smoke failed: TEST_STRATEGY.md did not capture the blueprint validation minimum." >&2
  exit 1
fi

if ! grep -Fq -- "- Selected starter blueprint: UNIVERSAL_APP_PLATFORM - Universal App Platform Blueprint" "${TMP_REPO}/WHERE_LEFT_OFF.md"; then
  echo "Blueprint smoke failed: WHERE_LEFT_OFF.md did not record the applied blueprint decision." >&2
  exit 1
fi

if ! grep -Fq -- "DESIGN_NOTES.md, TEST_STRATEGY.md, RISK_REGISTER.md, TODO.md, WHERE_LEFT_OFF.md, ARCHITECTURE_NOTES.md, and RELEASE_NOTES.md when present" "${TMP_REPO}/WHERE_LEFT_OFF.md"; then
  echo "Blueprint smoke failed: WHERE_LEFT_OFF.md did not report the full projected surface set." >&2
  exit 1
fi

if ! grep -Fq -- "shared contracts, persistence model, auth seams, worker boundaries, mobile/API scope, and packaging depth" "${TMP_REPO}/ARCHITECTURE_NOTES.md"; then
  echo "Blueprint smoke failed: ARCHITECTURE_NOTES.md did not record the blueprint architecture seams." >&2
  exit 1
fi

if ! grep -Fq -- "- Risk: Selected starter blueprint is not yet proven end to end" "${TMP_REPO}/RISK_REGISTER.md"; then
  echo "Blueprint smoke failed: RISK_REGISTER.md did not record the blueprint-specific risk entry." >&2
  exit 1
fi

if ! grep -Fq -- 'layout rhythm: organize surfaces around the first proven workflow for `UNIVERSAL_APP_PLATFORM`' "${TMP_REPO}/DESIGN_NOTES.md"; then
  echo "Blueprint smoke failed: DESIGN_NOTES.md did not record the blueprint-aligned design rhythm." >&2
  exit 1
fi

if ! grep -Fq -- "- Target label: starter-blueprint-alignment" "${TMP_REPO}/RELEASE_NOTES.md"; then
  echo "Blueprint smoke failed: RELEASE_NOTES.md did not adopt the blueprint-aligned target label." >&2
  exit 1
fi

if ! grep -Fq -- "- Release goal: prove the first blueprint-aligned vertical slice for ${APP_NAME}" "${TMP_REPO}/RELEASE_NOTES.md"; then
  echo "Blueprint smoke failed: RELEASE_NOTES.md did not adopt the blueprint-aligned release goal." >&2
  exit 1
fi

if ! grep -Fq -- "- Release confidence: not ready until the blueprint-aligned validation minimum is proven" "${TMP_REPO}/RELEASE_NOTES.md"; then
  echo "Blueprint smoke failed: RELEASE_NOTES.md did not adopt the blueprint-aligned release confidence." >&2
  exit 1
fi

set +e
placeholder_output="$(bash "${TEMPLATE_ROOT}/bootstrap/check-placeholders.sh" "${TMP_REPO}" 2>&1)"
placeholder_status=$?
set -e

if [[ ${placeholder_status} -eq 0 ]]; then
  echo "Blueprint smoke failed: placeholder check unexpectedly passed despite unresolved repo-specific blanks." >&2
  exit 1
fi

if [[ "${placeholder_output}" != *"_system/PROJECT_PROFILE.md"* ]]; then
  echo "Blueprint smoke failed: placeholder check stopped reporting real project-profile blanks." >&2
  exit 1
fi

if [[ "${placeholder_output}" == *"FIXME.md:"* || "${placeholder_output}" == *"RISK_REGISTER.md:7:"* || "${placeholder_output}" == *"_system/context/DECISIONS.md:"* || "${placeholder_output}" == *"_system/context/ASSUMPTIONS.md:"* || "${placeholder_output}" == *"_system/context/OPEN_QUESTIONS.md:"* || "${placeholder_output}" == *"_system/mcp/MCP_SERVER_CATALOG.md:"* ]]; then
  echo "Blueprint smoke failed: placeholder check still reported entry-format or entry-template schema lines as actionable blanks." >&2
  printf '%s\n' "${placeholder_output}" >&2
  exit 1
fi

printf 'blueprint_application_smoke_ok app_name=%s blueprint=%s\n' "${APP_NAME}" "UNIVERSAL_APP_PLATFORM"
