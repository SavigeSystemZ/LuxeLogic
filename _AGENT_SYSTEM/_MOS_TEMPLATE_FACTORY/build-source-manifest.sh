#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: build-source-manifest.sh [repo-root] [--write|--check]
EOF
}

REPO_ROOT=""
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
      if [[ -z "${REPO_ROOT}" ]]; then
        REPO_ROOT="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        exit 1
      fi
      ;;
  esac
done

if [[ -z "${REPO_ROOT}" ]]; then
  REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
fi

if [[ ${WRITE} -eq 1 && ${CHECK} -eq 1 ]]; then
  echo "Use either --write or --check, not both." >&2
  exit 1
fi

if [[ ${WRITE} -eq 0 && ${CHECK} -eq 0 ]]; then
  WRITE=1
fi

python3 - <<'PY' "${REPO_ROOT}" "${WRITE}" "${CHECK}"
import json
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
write = sys.argv[2] == "1"
check = sys.argv[3] == "1"
target = repo / "MOS_SOURCE_LIBRARY" / "meta-source-manifest.json"

data = {
    "product": "MOS",
    "source_template_version": (repo / "MOS_TEMPLATE" / "MOS_VERSION.md").read_text().strip().splitlines()[-1],
    "donors": [
        {
            "name": "AIAST_TEMPLATE",
            "path": "TEMPLATE/",
            "role": "primary installable donor",
            "used_for": [
                "authority model",
                "bootstrap script patterns",
                "golden example policy"
            ]
        },
        {
            "name": "AIAST_TEMPLATE_FACTORY",
            "path": "_TEMPLATE_FACTORY/",
            "role": "factory pattern donor",
            "used_for": [
                "automation lane",
                "clean-room smoke",
                "source-template validation"
            ]
        },
        {
            "name": "META_AGENT_SYSTEM_WORKSPACE",
            "path": "_META_AGENT_SYSTEM/",
            "role": "boundary and maintainer-state donor",
            "used_for": [
                "master-repo-only separation",
                "maintainer context strategy"
            ]
        }
    ]
}
content = json.dumps(data, indent=2) + "\n"

if write:
    target.write_text(content)
elif check:
    if not target.exists() or target.read_text() != content:
        print("meta_source_manifest_out_of_date")
        raise SystemExit(1)

print("meta_source_manifest_ok")
PY
