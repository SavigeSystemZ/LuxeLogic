#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: generate-meta-system-registry.sh [target-repo] [--write|--check]
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
target = repo / "meta_system" / "META_SYSTEM_REGISTRY.json"

files = []
for path in sorted(repo.rglob("*")):
    if path.is_file() and ".git" not in path.parts:
        files.append(str(path.relative_to(repo)))

data = {
    "product": "MOS",
    "version": (repo / "MOS_VERSION.md").read_text().strip().splitlines()[-1],
    "file_count": len(files),
    "files": files,
}
content = json.dumps(data, indent=2) + "\n"

if write:
    target.write_text(content)
elif check:
    if not target.exists() or target.read_text() != content:
      print("meta_system_registry_out_of_date")
      raise SystemExit(1)

print("meta_system_registry_ok")
PY
