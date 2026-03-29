#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"

bash "${REPO_ROOT}/_MOS_TEMPLATE_FACTORY/validate-mos-template.sh" "${REPO_ROOT}"
