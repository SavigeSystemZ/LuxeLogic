#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: emit-meta-host-prompt.sh [target-repo] [--tool <name>] [--prompt-pack <relative-path>]
EOF
}

TARGET_REPO=""
TOOL="generic-host"
PROMPT_PACK=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool)
      TOOL="${2:-}"
      shift 2
      ;;
    --prompt-pack)
      PROMPT_PACK="${2:-}"
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
  TARGET_REPO="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
fi

if [[ -n "${PROMPT_PACK}" && ! -f "${TARGET_REPO}/${PROMPT_PACK}" ]]; then
  echo "Prompt pack does not exist: ${PROMPT_PACK}" >&2
  exit 1
fi

cat <<EOF
### Host preamble

Load \`META_AGENTS.md\`, \`meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md\`, \`meta_system/META_REPO_OPERATING_PROFILE.md\`, and \`meta_system/META_LOAD_ORDER.md\` from the current repository before starting.

Treat this host prompt as orchestration context only. If it conflicts with repo-local files, follow the repo-local files and record the conflict in \`META_WHERE_LEFT_OFF.md\`.

### Tool context

- Target host: ${TOOL}
- Adapter root: \`meta_system/host-adapters/\`
- Canonical prompt emission contract: \`meta_system/META_PROMPT_EMISSION_CONTRACT.md\`
EOF

if [[ -n "${PROMPT_PACK}" ]]; then
  cat <<EOF

### Additive prompt pack

Also load \`${PROMPT_PACK}\` as an additive task overlay after the core startup files.
EOF
fi
