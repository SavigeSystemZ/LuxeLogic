#!/usr/bin/env bash
set -euo pipefail

TARGET_REPO="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"

require_text() {
  local file="$1"
  local pattern="$2"
  if ! grep -Fq "${pattern}" "${TARGET_REPO}/${file}"; then
    echo "Missing required reference '${pattern}' in ${file}" >&2
    exit 1
  fi
}

require_text "META_AGENTS.md" "meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md"
require_text "META_AGENTS.md" "docs/ReviewWorkflow.md"
require_text "meta_system/META_LOAD_ORDER.md" "meta_system/META_PROMPT_EMISSION_CONTRACT.md"
require_text "meta_system/META_LOAD_ORDER.md" "meta_system/META_HOST_ADAPTER_POLICY.md"
require_text "meta_system/META_PROMPT_EMISSION_CONTRACT.md" "META_AGENTS.md"
require_text "meta_system/META_HOST_ADAPTER_POLICY.md" "meta-host-adapter-manifest.json"

python3 - <<'PY' "${TARGET_REPO}"
import json
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
manifest = json.loads((repo / "meta_system" / "meta-host-adapter-manifest.json").read_text())
startup = manifest["canonical_startup_files"]
expected = [
    "META_AGENTS.md",
    "meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md",
    "meta_system/META_REPO_OPERATING_PROFILE.md",
    "meta_system/META_LOAD_ORDER.md",
]
if startup != expected:
    print("instruction_layer_invalid")
    print(f"- canonical_startup_files mismatch: {startup}")
    raise SystemExit(1)
print("meta_instruction_layer_ok")
PY
