#!/usr/bin/env bash
set -euo pipefail

TARGET_REPO="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"
WARNINGS=()

mapfile -t SH_FILES < <(find "${TARGET_REPO}" -type f -name '*.sh' | sort)
if command -v shellcheck >/dev/null 2>&1 && [[ ${#SH_FILES[@]} -gt 0 ]]; then
  shellcheck -x -P "${TARGET_REPO}/bootstrap" "${SH_FILES[@]}"
else
  WARNINGS+=("shellcheck_unavailable_or_no_shell_files")
fi

python3 - <<'PY' "${TARGET_REPO}"
import json
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
errors = []
for path in sorted(repo.rglob("*.json")):
    if ".git" in path.parts:
        continue
    try:
        json.loads(path.read_text())
    except Exception as exc:
        errors.append(f"{path.relative_to(repo)}: {exc}")

if errors:
    print("json_validation_failed")
    for item in errors:
        print(f"- {item}")
    raise SystemExit(1)
PY

if find "${TARGET_REPO}" -type f \( -name '*.yaml' -o -name '*.yml' \) | grep -q .; then
  if command -v yamllint >/dev/null 2>&1; then
    yamllint "${TARGET_REPO}"
  else
    WARNINGS+=("yamllint_unavailable")
  fi
fi

if find "${TARGET_REPO}" -type f -name '*.md' | grep -q .; then
  MD_CONFIG="${TARGET_REPO}/.markdownlint-cli2.jsonc"
  if command -v markdownlint >/dev/null 2>&1; then
    mapfile -t MD_FILES < <(find "${TARGET_REPO}" -type f -name '*.md' | sort)
    markdownlint "${MD_FILES[@]}"
  elif command -v markdownlint-cli2 >/dev/null 2>&1; then
    mapfile -t MD_FILES < <(find "${TARGET_REPO}" -type f -name '*.md' | sort)
    if [[ -f "${MD_CONFIG}" ]]; then
      markdownlint-cli2 --config "${MD_CONFIG}" "${MD_FILES[@]}"
    else
      markdownlint-cli2 "${MD_FILES[@]}"
    fi
  else
    WARNINGS+=("markdownlint_unavailable")
  fi
fi

if rg -n --hidden --glob '!.git' '(AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{36}|AIza[0-9A-Za-z\\-_]{35}|BEGIN [A-Z ]+PRIVATE KEY)' "${TARGET_REPO}" >/dev/null 2>&1; then
  echo "secret_scan_failed" >&2
  exit 1
fi

if [[ ${#WARNINGS[@]} -gt 0 ]]; then
  printf 'meta_lint_warnings=%s\n' "$(IFS=,; echo "${WARNINGS[*]}")"
fi

echo "meta_lint_ok"
