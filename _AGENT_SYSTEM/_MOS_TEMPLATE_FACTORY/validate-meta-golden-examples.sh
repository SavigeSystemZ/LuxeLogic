#!/usr/bin/env bash
set -euo pipefail

TEMPLATE_ROOT="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../MOS_TEMPLATE" && pwd)}"

python3 - <<'PY' "${TEMPLATE_ROOT}"
import json
import sys
from pathlib import Path

template = Path(sys.argv[1]).resolve()
root = template / "meta_system" / "golden-examples"
manifest = json.loads((root / "meta-golden-example-manifest.json").read_text())
issues = []

if len(manifest["categories"]) != 5:
    issues.append("golden example manifest must declare exactly five category guides")

for rel in manifest["cross_cutting_patterns"] + manifest["categories"] + manifest["working_files"]:
    if not (root / rel).is_file():
        issues.append(f"missing golden example file: {rel}")

for path in sorted(root.rglob("*.md")):
    text = path.read_text()
    for forbidden in ("/home/whyte", ".MyAppZ", "SavigeSystemZ", "WRAITHS"):
        if forbidden in text:
            issues.append(f"{path.relative_to(template)} contains non-neutral donor-specific token: {forbidden}")

if issues:
    print("meta_golden_examples_invalid")
    for item in issues:
        print(f"- {item}")
    raise SystemExit(1)

print("meta_golden_examples_ok")
PY
