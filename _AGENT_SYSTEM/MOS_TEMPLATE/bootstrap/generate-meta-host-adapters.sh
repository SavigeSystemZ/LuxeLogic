#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: generate-meta-host-adapters.sh [target-repo] [--write|--check]
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
manifest_path = repo / "meta_system" / "meta-host-adapter-manifest.json"
manifest = json.loads(manifest_path.read_text())
startup = manifest["canonical_startup_files"]
optional = manifest["optional_context_files"]
adapters = manifest["generated_adapters"]

def render(spec):
    title = spec["title"]
    tool = spec["tool"]
    tier = spec["tier"]
    lines = [
        f"# {title}",
        "",
        f"- Tool: {tool}",
        f"- Support tier: {tier}",
        "",
        "## Load First",
        "",
    ]
    lines.extend(f"{idx}. `{item}`" for idx, item in enumerate(startup, start=1))
    lines.extend([
        "",
        "## Load When Needed",
        "",
    ])
    lines.extend(f"- `{item}`" for item in optional)
    lines.extend([
        "",
        "## Rules",
        "",
        "- Repo-local truth and repo-local MOS core contracts win over host context.",
        "- Treat this adapter as a translation layer, not the source of truth.",
        "- Keep runtime code independent from the meta-system.",
        "",
        "This file is generated from `meta_system/meta-host-adapter-manifest.json`.",
        "",
    ])
    return "\n".join(lines)

rendered = {}
for spec in adapters.values():
    rel = Path(spec["path"])
    rendered[rel] = render(spec)

errors = []
for rel, content in rendered.items():
    path = repo / rel
    if write:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content)
    elif check:
        if not path.exists():
            errors.append(f"missing generated adapter: {rel}")
        elif path.read_text() != content:
            errors.append(f"stale generated adapter: {rel}")

if errors:
    print("meta_host_adapter_alignment_failed")
    for item in errors:
        print(f"- {item}")
    raise SystemExit(1)

print("meta_host_adapters_ok")
PY
