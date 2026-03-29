#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

usage() {
  cat <<'EOF'
Usage: run-maintainer-lane.sh

Run the maintainer-only continuity checks without coupling them to installable product validation lanes.
EOF
}

if [[ $# -gt 0 ]]; then
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unexpected argument: $1" >&2
      exit 1
      ;;
  esac
fi

printf '[step] validate-meta-workspace\n'
bash "${SCRIPT_DIR}/validate-meta-workspace.sh" "${REPO_ROOT}"

printf '[step] git-diff-check\n'
(cd "${REPO_ROOT}" && git diff --check)

echo "maintainer_lane_ok"
