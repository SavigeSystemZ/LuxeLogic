#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"
TMP_DIR="$(mktemp -d /tmp/mos-prompt-bundle.XXXXXX)"
trap 'rm -rf "${TMP_DIR}"' EXIT

bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/emit-meta-host-prompt.sh" \
  "${REPO_ROOT}/MOS_TEMPLATE" \
  --tool codex \
  --prompt-pack meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md > "${TMP_DIR}/prompt.txt"

bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/emit-meta-host-bundle.sh" \
  "${REPO_ROOT}/MOS_TEMPLATE" \
  --tool codex \
  --prompt-pack meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md \
  --output "${TMP_DIR}/bundle.json" >/dev/null

python3 - <<'PY' "${TMP_DIR}/prompt.txt" "${TMP_DIR}/bundle.json"
import json
import sys
from pathlib import Path

prompt_path = Path(sys.argv[1])
bundle_path = Path(sys.argv[2])
prompt = prompt_path.read_text()
bundle = json.loads(bundle_path.read_text())

assert "META_AGENTS.md" in prompt
assert "meta_system/META_LOAD_ORDER.md" in prompt
assert "prompt" in bundle
assert "files" in bundle
assert "meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md" in bundle["files"]
print("meta_prompt_bundle_smoke_ok")
PY
