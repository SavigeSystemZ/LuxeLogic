#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-packaging-builders.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary repo from the master template and run optional real
packaging-builder smoke when the required host tooling is available. The current
implementation is Flatpak-first because it is the deepest-documented packaging
path in the template. Missing tools or missing local runtimes cause a clean skip.
EOF
}

APP_NAME="BuilderSmoke"
TEMP_ROOT="/tmp"
KEEP=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --app-name)
      APP_NAME="${2:-}"
      shift 2
      ;;
    --temp-root)
      TEMP_ROOT="${2:-}"
      shift 2
      ;;
    --keep)
      KEEP=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unexpected argument: $1" >&2
      exit 1
      ;;
  esac
done

mkdir -p "${TEMP_ROOT}"
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-builder-smoke.XXXXXX")"
cleanup() {
  local status=$?
  if [[ ${status} -eq 0 && ${KEEP} -eq 0 ]]; then
    rm -rf "${TMP_REPO}"
  else
    printf 'Preserved temp repo: %s\n' "${TMP_REPO}" >&2
  fi
  exit ${status}
}
trap cleanup EXIT

printf 'Temp repo: %s\n' "${TMP_REPO}"

bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${TMP_REPO}" --app-name "${APP_NAME}" --strict
bash "${TMP_REPO}/bootstrap/check-packaging-targets.sh" "${TMP_REPO}" --strict

if ! command -v flatpak-builder >/dev/null 2>&1; then
  echo "packaging_builder_smoke_skipped reason=flatpak-builder-unavailable"
  exit 0
fi

if ! command -v flatpak >/dev/null 2>&1; then
  echo "packaging_builder_smoke_skipped reason=flatpak-unavailable"
  exit 0
fi

python3 - <<'PY' "${TMP_REPO}"
from __future__ import annotations

import json
import os
import stat
import subprocess
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
manifest_path = repo / "packaging" / "flatpak-manifest.json"
manifest = json.loads(manifest_path.read_text())

command_name = str(manifest["command"]).strip()
runtime = str(manifest["runtime"]).strip()
runtime_version = str(manifest["runtime-version"]).strip()
sdk = str(manifest["sdk"]).strip()

runtime_ref = f"{runtime}//{runtime_version}"
sdk_ref = f"{sdk}//{runtime_version}"

for ref in (runtime_ref, sdk_ref):
    result = subprocess.run(
        ["flatpak", "info", ref],
        cwd=repo,
        text=True,
        capture_output=True,
    )
    if result.returncode != 0:
        print(f"packaging_builder_smoke_skipped reason=missing-flatpak-runtime ref={ref}")
        raise SystemExit(0)

dist_dir = repo / "dist"
dist_dir.mkdir(exist_ok=True)
binary_path = dist_dir / command_name
binary_path.write_text("#!/usr/bin/env bash\nset -euo pipefail\necho flatpak-builder-smoke\n")
binary_path.chmod(binary_path.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

build_dir = repo / ".flatpak-builder-smoke"
result = subprocess.run(
    ["flatpak-builder", "--force-clean", str(build_dir), str(manifest_path)],
    cwd=repo,
    text=True,
    capture_output=True,
)
if result.returncode != 0:
    stderr = (result.stderr or result.stdout).strip()
    print(f"packaging_builder_smoke_failed builder=flatpak-builder detail={stderr or 'unknown error'}")
    raise SystemExit(1)

installed_binary = build_dir / "files" / "bin" / command_name
if not installed_binary.is_file():
    print(f"packaging_builder_smoke_failed builder=flatpak-builder detail=missing-built-binary:{installed_binary}")
    raise SystemExit(1)

print(f"packaging_builder_smoke_ok builder=flatpak-builder command={command_name}")
PY

printf 'packaging_builder_smoke_complete app_name=%s\n' "${APP_NAME}"
