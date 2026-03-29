#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"

bash -n "${REPO_ROOT}"/MOS_TEMPLATE/bootstrap/*.sh \
  "${REPO_ROOT}"/MOS_TEMPLATE/bootstrap/lib/*.sh \
  "${REPO_ROOT}"/MOS_TEMPLATE/meta_system/scripts/*.sh \
  "${REPO_ROOT}"/_MOS_TEMPLATE_FACTORY/*.sh

bash "${REPO_ROOT}/_MOS_TEMPLATE_FACTORY/build-source-manifest.sh" "${REPO_ROOT}" --write
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/generate-meta-host-adapters.sh" "${REPO_ROOT}/MOS_TEMPLATE" --write
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/generate-meta-system-registry.sh" "${REPO_ROOT}/MOS_TEMPLATE" --write
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/generate-meta-operating-profile.sh" "${REPO_ROOT}/MOS_TEMPLATE" --write
bash "${REPO_ROOT}/_MOS_TEMPLATE_FACTORY/validate-meta-golden-examples.sh" "${REPO_ROOT}/MOS_TEMPLATE"
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/validate-meta-system.sh" "${REPO_ROOT}/MOS_TEMPLATE" --strict --mode template
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/validate-meta-instruction-layer.sh" "${REPO_ROOT}/MOS_TEMPLATE"
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/detect-meta-instruction-conflicts.sh" "${REPO_ROOT}/MOS_TEMPLATE" --strict
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/check-meta-host-adapter-alignment.sh" "${REPO_ROOT}/MOS_TEMPLATE"
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/check-meta-hallucination.sh" "${REPO_ROOT}/MOS_TEMPLATE"
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/lint-meta-system.sh" "${REPO_ROOT}/MOS_TEMPLATE"
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/system-meta-doctor.sh" "${REPO_ROOT}/MOS_TEMPLATE" --strict --mode template
bash "${REPO_ROOT}/_MOS_TEMPLATE_FACTORY/smoke-prompt-bundle.sh" "${REPO_ROOT}"
bash "${REPO_ROOT}/_MOS_TEMPLATE_FACTORY/smoke-installed-meta-repo.sh" "${REPO_ROOT}"

echo "mos_template_validation_ok"
