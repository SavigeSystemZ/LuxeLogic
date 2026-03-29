#!/usr/bin/env bash
set -euo pipefail

TARGET_REPO="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

bash "${SCRIPT_DIR}/generate-meta-host-adapters.sh" "${TARGET_REPO}" --check

python3 - <<'PY' "${TARGET_REPO}"
import json
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
manifest = json.loads((repo / "meta_system" / "meta-host-adapter-manifest.json").read_text())
declared = {Path(spec["path"]).name for spec in manifest["generated_adapters"].values()}
actual = {
    path.name
    for path in (repo / "meta_system" / "host-adapters").glob("*")
    if path.is_file() and path.name != "README.md"
}
extra = sorted(actual - declared)
if extra:
    print("meta_host_adapter_alignment_failed")
    for item in extra:
        print(f"- unexpected generated adapter file: {item}")
    raise SystemExit(1)
print("meta_host_adapter_alignment_ok")
PY
