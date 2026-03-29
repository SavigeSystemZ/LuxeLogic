#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: detect-meta-instruction-conflicts.sh [target-repo] [--strict]
EOF
}

TARGET_REPO=""
STRICT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --strict)
      STRICT=1
      shift
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

python3 - <<'PY' "${TARGET_REPO}" "${STRICT}"
import json
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
strict = sys.argv[2] == "1"
issues = []

precedence = (repo / "meta_system" / "META_INSTRUCTION_PRECEDENCE_CONTRACT.md").read_text()
prompt_contract = (repo / "meta_system" / "META_PROMPT_EMISSION_CONTRACT.md").read_text()
agents = (repo / "META_AGENTS.md").read_text()
manifest = json.loads((repo / "meta_system" / "meta-host-adapter-manifest.json").read_text())

if "Host instructions never override repo-local truth." not in precedence:
    issues.append("precedence contract is missing the host-override guardrail")

if "host context wins" in (precedence + prompt_contract + agents).lower():
    issues.append("a canonical file implies host context wins over repo-local truth")

paths = [spec["path"] for spec in manifest["generated_adapters"].values()]
if len(paths) != len(set(paths)):
    issues.append("adapter manifest contains duplicate generated adapter paths")

tools = [spec["tool"] for spec in manifest["generated_adapters"].values()]
if len(tools) != len(set(tools)):
    issues.append("adapter manifest contains duplicate tool names")

if strict:
    for pack in ("M2_DEFINE_META_SYSTEM_SPEC.md", "M9_AIAST_SYSTEM_REVIEW.md"):
        text = (repo / "meta_system" / "prompt-packs" / pack).read_text()
        if "META_AGENTS.md" not in text or "META_LOAD_ORDER.md" not in text:
            issues.append(f"prompt pack missing startup references: {pack}")

if issues:
    print("meta_instruction_conflicts_detected")
    for item in issues:
        print(f"- {item}")
    raise SystemExit(1)

print("meta_instruction_conflicts_ok")
PY
