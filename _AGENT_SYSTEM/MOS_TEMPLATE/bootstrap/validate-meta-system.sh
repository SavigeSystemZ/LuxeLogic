#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/mos-lib.sh
source "${SCRIPT_DIR}/lib/mos-lib.sh"

usage() {
  cat <<'EOF'
Usage: validate-meta-system.sh <target-repo-or-template> [--strict] [--mode auto|template|installed]
EOF
}

TARGET=""
STRICT=0
MODE="auto"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --strict)
      STRICT=1
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
      if [[ -z "${TARGET}" ]]; then
        TARGET="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        exit 1
      fi
      ;;
  esac
done

if [[ -z "${TARGET}" || ! -d "${TARGET}" ]]; then
  echo "Target does not exist: ${TARGET}" >&2
  exit 1
fi

REPO_MODE="$(mos_resolve_repo_mode "${TARGET}" "${MODE}")"

require_file() {
  local rel="$1"
  if [[ ! -f "${TARGET}/${rel}" ]]; then
    echo "Missing required file: ${rel}" >&2
    exit 1
  fi
}

require_files() {
  local rel
  for rel in "$@"; do
    require_file "${rel}"
  done
}

require_files \
  ".installable-product-root" \
  "README.md" \
  "META_AGENTS.md" \
  "META_PLAN.md" \
  "META_TODO.md" \
  "META_FIXME.md" \
  "META_WHERE_LEFT_OFF.md" \
  "META_CHANGELOG.md" \
  "META_RELEASE_NOTES.md" \
  "MOS_VERSION.md" \
  "docs/PRD.md" \
  "docs/Architecture.md" \
  "docs/DataModel.md" \
  "docs/API_and_NFRs.md" \
  "docs/ReviewWorkflow.md" \
  "meta_system/.template-version" \
  "meta_system/.template-install.json" \
  "meta_system/README.md" \
  "meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md" \
  "meta_system/META_REPO_OPERATING_PROFILE.md" \
  "meta_system/META_LOAD_ORDER.md" \
  "meta_system/META_CONTEXT_INDEX.md" \
  "meta_system/META_MASTER_SYSTEM_PROMPT.md" \
  "meta_system/META_PROJECT_RULES.md" \
  "meta_system/META_EXECUTION_PROTOCOL.md" \
  "meta_system/META_MEMORY_RULES.md" \
  "meta_system/META_CHECKPOINT_PROTOCOL.md" \
  "meta_system/META_PROMPT_EMISSION_CONTRACT.md" \
  "meta_system/META_HOST_ADAPTER_POLICY.md" \
  "meta_system/META_PLUGIN_CONTRACT.md" \
  "meta_system/META_GOLDEN_EXAMPLES_POLICY.md" \
  "meta_system/META_VALIDATION_GATES.md" \
  "meta_system/META_SYSTEM_AWARENESS_PROTOCOL.md" \
  "meta_system/META_HALLUCINATION_DEFENSE_PROTOCOL.md" \
  "meta_system/meta-host-adapter-manifest.json" \
  "meta_system/schemas/plugin.schema.json" \
  "meta_system/meta-operating-profile.json" \
  "meta_system/instruction-precedence.json" \
  "meta_system/mos-capabilities.json" \
  "meta_system/META_SYSTEM_REGISTRY.json" \
  "meta_system/context/README.md" \
  "meta_system/context/CURRENT_STATUS.md" \
  "meta_system/context/DECISIONS.md" \
  "meta_system/context/OPEN_QUESTIONS.md" \
  "meta_system/golden-examples/README.md" \
  "meta_system/golden-examples/PATTERN_INDEX.md" \
  "meta_system/golden-examples/meta-golden-example-manifest.json" \
  "meta_system/plugins/README.md" \
  "meta_system/plugins/sample-plugin/README.md" \
  "meta_system/plugins/sample-plugin/plugin.json" \
  "meta_system/prompt-packs/README.md" \
  "meta_system/prompt-packs/M2_DEFINE_META_SYSTEM_SPEC.md" \
  "meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md" \
  "meta_system/host-adapters/README.md" \
  "meta_system/scripts/README.md" \
  "meta_system/scripts/hallucination-check.sh" \
  "meta_system/scripts/lint-all.sh" \
  "bootstrap/README.md" \
  "bootstrap/init-meta-project.sh" \
  "bootstrap/install-meta-missing-files.sh" \
  "bootstrap/seed-meta-working-state.sh" \
  "bootstrap/suggest-meta-baseline.sh" \
  "bootstrap/update-meta-template.sh" \
  "bootstrap/validate-meta-system.sh" \
  "bootstrap/validate-meta-instruction-layer.sh" \
  "bootstrap/check-meta-install-boundary.sh" \
  "bootstrap/detect-meta-instruction-conflicts.sh" \
  "bootstrap/detect-meta-drift.sh" \
  "bootstrap/repair-meta-system.sh" \
  "bootstrap/heal-meta-system.sh" \
  "bootstrap/system-meta-doctor.sh" \
  "bootstrap/generate-meta-system-registry.sh" \
  "bootstrap/generate-meta-operating-profile.sh" \
  "bootstrap/generate-meta-host-adapters.sh" \
  "bootstrap/check-meta-host-adapter-alignment.sh" \
  "bootstrap/emit-meta-host-prompt.sh" \
  "bootstrap/emit-meta-host-bundle.sh" \
  "bootstrap/check-meta-hallucination.sh" \
  "bootstrap/lint-meta-system.sh" \
  "bootstrap/lib/mos-lib.sh"

adapter_count="$(find "${TARGET}/meta_system/host-adapters" -maxdepth 1 -type f ! -name 'README.md' | wc -l | tr -d ' ')"
required_adapter_count=6
if [[ ${STRICT} -eq 1 ]]; then
  required_adapter_count=11
fi
if [[ "${adapter_count}" -lt "${required_adapter_count}" ]]; then
  echo "Expected at least ${required_adapter_count} generated adapters in meta_system/host-adapters, found ${adapter_count}." >&2
  exit 1
fi

echo "meta_system_validation_ok mode=${REPO_MODE}"
