#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: emit-meta-host-bundle.sh [target-repo] [--tool <name>] [--prompt-pack <relative-path>] [--output <file>]
EOF
}

TARGET_REPO=""
TOOL="generic-host"
PROMPT_PACK=""
OUTPUT=""

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
    --output)
      OUTPUT="${2:-}"
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

prompt_cmd=(bash "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/emit-meta-host-prompt.sh" "${TARGET_REPO}" --tool "${TOOL}")
if [[ -n "${PROMPT_PACK}" ]]; then
  prompt_cmd+=(--prompt-pack "${PROMPT_PACK}")
fi
PROMPT="$("${prompt_cmd[@]}")"

python3 - <<'PY' "${TARGET_REPO}" "${TOOL}" "${PROMPT_PACK}" "${OUTPUT}" "${PROMPT}"
import json
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
tool = sys.argv[2]
prompt_pack = sys.argv[3]
output = sys.argv[4]
prompt = sys.argv[5]

files = [
    "META_AGENTS.md",
    "meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md",
    "meta_system/META_REPO_OPERATING_PROFILE.md",
    "meta_system/META_LOAD_ORDER.md",
]
if prompt_pack:
    files.append(prompt_pack)

bundle = {
    "product": "MOS",
    "tool": tool,
    "prompt": prompt,
    "files": {
        rel: (repo / rel).read_text()
        for rel in files
    },
}
content = json.dumps(bundle, indent=2) + "\n"
if output:
    Path(output).write_text(content)
else:
    print(content, end="")
PY
