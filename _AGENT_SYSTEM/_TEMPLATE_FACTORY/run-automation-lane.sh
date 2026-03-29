#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage: run-automation-lane.sh [--temp-root DIR] [--keep-temp-repos] [--skip-scorecard] [--skip-optional-builders] [--skip-optional-live-hosts]

Run the repo-level automation lane:
1. execute the deterministic master-template validator
2. execute optional packaging-builder smoke that skips cleanly when host tooling is unavailable
3. execute optional live external-host smoke that skips cleanly when no usable authenticated host CLI is available
EOF
}

TEMP_ROOT="/tmp"
KEEP_TEMP_REPOS=0
SKIP_SCORECARD=0
SKIP_OPTIONAL_BUILDERS=0
SKIP_OPTIONAL_LIVE_HOSTS=0

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
    --skip-optional-builders)
      SKIP_OPTIONAL_BUILDERS=1
      shift
      ;;
    --skip-optional-live-hosts)
      SKIP_OPTIONAL_LIVE_HOSTS=1
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

validator_args=(--temp-root "${TEMP_ROOT}")
builder_args=(--temp-root "${TEMP_ROOT}")

if [[ ${KEEP_TEMP_REPOS} -eq 1 ]]; then
  validator_args+=(--keep-temp-repos)
  builder_args+=(--keep)
fi

if [[ ${SKIP_SCORECARD} -eq 1 ]]; then
  validator_args+=(--skip-scorecard)
fi

bash "${SCRIPT_DIR}/validate-master-template.sh" "${validator_args[@]}"

if [[ ${SKIP_OPTIONAL_BUILDERS} -eq 0 ]]; then
  bash "${SCRIPT_DIR}/smoke-packaging-builders.sh" "${builder_args[@]}"
else
  printf '[step] smoke-packaging-builders (skipped)\n'
fi

if [[ ${SKIP_OPTIONAL_LIVE_HOSTS} -eq 0 ]]; then
  bash "${SCRIPT_DIR}/smoke-live-host-clis.sh" --temp-root "${TEMP_ROOT}" "${builder_args[@]}"
else
  printf '[step] smoke-live-host-clis (skipped)\n'
fi

echo "automation_lane_ok"
