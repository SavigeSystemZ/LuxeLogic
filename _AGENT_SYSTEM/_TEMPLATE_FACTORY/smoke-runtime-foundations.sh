#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-runtime-foundations.sh [--app-name NAME] [--temp-root DIR] [--keep]

Create a clean temporary repo from the master template and run live runtime-foundation
smoke using the generated install scripts in user mode against a fake HOME.
EOF
}

APP_NAME="RuntimeSmoke"
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
TMP_REPO="$(mktemp -d "${TEMP_ROOT%/}/aiaast-runtime-smoke.XXXXXX")"
FAKE_HOME="${TMP_REPO}/.smoke-home"
mkdir -p "${FAKE_HOME}"

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
bash "${TMP_REPO}/bootstrap/check-runtime-foundations.sh" "${TMP_REPO}"

HOME="${FAKE_HOME}" bash "${TMP_REPO}/ops/install/install.sh" --mode user --skip-db --skip-service --skip-desktop
HOME="${FAKE_HOME}" bash "${TMP_REPO}/ops/install/repair.sh" --mode user --skip-db --skip-service --skip-desktop

python3 - <<'PY' "${TMP_REPO}/ops/env/.env"
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
text = path.read_text()
if "APP_EXEC_START=" in text:
    text = re.sub(r"^APP_EXEC_START=.*$", "APP_EXEC_START=true", text, flags=re.MULTILINE)
else:
    text += "\nAPP_EXEC_START=true\n"
path.write_text(text.lstrip("\n"))
PY

HOME="${FAKE_HOME}" bash "${TMP_REPO}/ops/install/install.sh" --launch
HOME="${FAKE_HOME}" bash "${TMP_REPO}/ops/install/purge.sh" --mode user

if [[ -f "${TMP_REPO}/ops/env/.env" ]]; then
  echo "Runtime smoke expected ops/env/.env to be removed by purge." >&2
  exit 1
fi

printf 'runtime_foundation_smoke_ok app_name=%s\n' "${APP_NAME}"
