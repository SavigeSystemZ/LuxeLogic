#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: generate-meta-operating-profile.sh [target-repo] [--write|--check]
EOF
}

TARGET_REPO=""
WRITE=0
CHECK=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --write)
      WRITE=1
      shift
      ;;
    --check)
      CHECK=1
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

if [[ ${WRITE} -eq 1 && ${CHECK} -eq 1 ]]; then
  echo "Use either --write or --check, not both." >&2
  exit 1
fi

if [[ ${WRITE} -eq 0 && ${CHECK} -eq 0 ]]; then
  WRITE=1
fi

python3 - <<'PY' "${TARGET_REPO}" "${WRITE}" "${CHECK}"
import json
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
write = sys.argv[2] == "1"
check = sys.argv[3] == "1"
version = (repo / "MOS_VERSION.md").read_text().strip().splitlines()[-1]
manifest = json.loads((repo / "meta_system" / "meta-host-adapter-manifest.json").read_text())

profile = {
    "product": "MOS",
    "version": version,
    "canonical_startup_files": manifest["canonical_startup_files"],
    "optional_context_files": manifest["optional_context_files"],
    "first_class_adapters": sorted(
        spec["tool"] for spec in manifest["generated_adapters"].values() if spec["tier"] == "first-class"
    ),
    "spec_adapters": sorted(
        spec["tool"] for spec in manifest["generated_adapters"].values() if spec["tier"] == "spec-only"
    ),
    "validation_commands": [
        "bootstrap/validate-meta-system.sh",
        "bootstrap/check-meta-install-boundary.sh",
        "bootstrap/validate-meta-instruction-layer.sh",
        "bootstrap/check-meta-host-adapter-alignment.sh",
        "bootstrap/check-meta-hallucination.sh",
        "bootstrap/lint-meta-system.sh",
        "bootstrap/system-meta-doctor.sh"
    ]
}

precedence = {
    "order": [
        "repo-local runtime and product truth",
        "repo-local MOS core contracts",
        "repo-local MOS host adapters",
        "repo-local prompt packs and emitted bundles",
        "declared plugins within owned paths",
        "host-level orchestration context"
    ]
}

capabilities = {
    "supports_review_workflow": True,
    "supports_plugins": True,
    "supports_golden_examples": True,
    "supports_prompt_emission": True,
    "supports_self_heal": True,
    "supports_hallucination_checks": True,
    "supports_auto_lint": True
}

outputs = {
    repo / "meta_system" / "meta-operating-profile.json": json.dumps(profile, indent=2) + "\n",
    repo / "meta_system" / "instruction-precedence.json": json.dumps(precedence, indent=2) + "\n",
    repo / "meta_system" / "mos-capabilities.json": json.dumps(capabilities, indent=2) + "\n",
}

errors = []
for path, content in outputs.items():
    if write:
        path.write_text(content)
    elif check:
        if not path.exists() or path.read_text() != content:
            errors.append(str(path.relative_to(repo)))

if errors:
    print("meta_operating_profile_out_of_date")
    for item in errors:
        print(f"- {item}")
    raise SystemExit(1)

print("meta_operating_profile_ok")
PY
