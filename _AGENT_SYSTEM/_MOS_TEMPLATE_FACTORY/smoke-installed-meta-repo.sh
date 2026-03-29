#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"
TMP_DIR="$(mktemp -d /tmp/mos-installed-smoke.XXXXXX)"
trap 'rm -rf "${TMP_DIR}"' EXIT

TARGET="${TMP_DIR}/consumer"
mkdir -p "${TARGET}"
printf '# Existing README\n' > "${TARGET}/README.md"

bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/init-meta-project.sh" "${TARGET}" --source "${REPO_ROOT}/MOS_TEMPLATE" --strict >/dev/null
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/validate-meta-system.sh" "${TARGET}" --strict --mode installed >/dev/null
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/check-meta-install-boundary.sh" "${TARGET}" >/dev/null
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/system-meta-doctor.sh" "${TARGET}" --source "${REPO_ROOT}/MOS_TEMPLATE" --mode installed >/dev/null
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/emit-meta-host-prompt.sh" "${TARGET}" --tool cursor >/dev/null
bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/emit-meta-host-bundle.sh" "${TARGET}" --tool cursor --output "${TMP_DIR}/bundle.json" >/dev/null

if bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/init-meta-project.sh" "${TMP_DIR}/should-fail" --source "${REPO_ROOT}" >/dev/null 2>&1; then
  echo "meta_installed_repo_smoke_failed: repo root was incorrectly accepted as a MOS source" >&2
  exit 1
fi

if bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/init-meta-project.sh" "${TMP_DIR}/should-fail-installed-source" --source "${TARGET}" >/dev/null 2>&1; then
  echo "meta_installed_repo_smoke_failed: an installed MOS repo was incorrectly accepted as a MOS source" >&2
  exit 1
fi

test -f "${TARGET}/AI_META_SYSTEM_README.md"
test -f "${TARGET}/meta_system/meta-operating-profile.json"
test -f "${TARGET}/meta_system/META_SYSTEM_REGISTRY.json"
test -f "${TARGET}/meta_system/host-adapters/META_CODEX.md"
if grep -q "Replace this placeholder" "${TARGET}/META_TODO.md"; then
  echo "meta_installed_repo_smoke_failed: META_TODO.md was not seeded" >&2
  exit 1
fi
if grep -q "Current lane: unset" "${TARGET}/META_WHERE_LEFT_OFF.md"; then
  echo "meta_installed_repo_smoke_failed: META_WHERE_LEFT_OFF.md was not seeded" >&2
  exit 1
fi
if ! grep -q "detected repo shape is" "${TARGET}/META_WHERE_LEFT_OFF.md"; then
  echo "meta_installed_repo_smoke_failed: META_WHERE_LEFT_OFF.md did not receive repo-shape suggestions" >&2
  exit 1
fi
if grep -q "Completion status: template scaffolded" "${TARGET}/meta_system/context/CURRENT_STATUS.md"; then
  echo "meta_installed_repo_smoke_failed: meta current status was not seeded" >&2
  exit 1
fi
if ! grep -q "bootstrap/validate-meta-system.sh ${TARGET} --strict --mode installed -> pass" "${TARGET}/meta_system/context/CURRENT_STATUS.md"; then
  echo "meta_installed_repo_smoke_failed: strict init did not record the latest passing validation" >&2
  exit 1
fi
if ! grep -q "bootstrap/validate-meta-system.sh ${TARGET} --strict --mode installed -> pass" "${TARGET}/META_WHERE_LEFT_OFF.md"; then
  echo "meta_installed_repo_smoke_failed: strict init did not update META_WHERE_LEFT_OFF.md" >&2
  exit 1
fi

rm -f \
  "${TARGET}/META_TODO.md" \
  "${TARGET}/META_WHERE_LEFT_OFF.md" \
  "${TARGET}/meta_system/context/CURRENT_STATUS.md" \
  "${TARGET}/meta_system/META_SYSTEM_REGISTRY.json" \
  "${TARGET}/meta_system/meta-operating-profile.json" \
  "${TARGET}/meta_system/host-adapters/META_CODEX.md"

bash "${REPO_ROOT}/MOS_TEMPLATE/bootstrap/install-meta-missing-files.sh" "${TARGET}" --source "${REPO_ROOT}/MOS_TEMPLATE" --strict >/dev/null

test -f "${TARGET}/META_TODO.md"
test -f "${TARGET}/META_WHERE_LEFT_OFF.md"
test -f "${TARGET}/meta_system/context/CURRENT_STATUS.md"
test -f "${TARGET}/meta_system/META_SYSTEM_REGISTRY.json"
test -f "${TARGET}/meta_system/meta-operating-profile.json"
test -f "${TARGET}/meta_system/host-adapters/META_CODEX.md"
if grep -q "Replace this placeholder" "${TARGET}/META_TODO.md"; then
  echo "meta_installed_repo_smoke_failed: META_TODO.md was not reseeded during additive recovery" >&2
  exit 1
fi
if ! grep -q "bootstrap/validate-meta-system.sh ${TARGET} --strict --mode installed -> pass" "${TARGET}/meta_system/context/CURRENT_STATUS.md"; then
  echo "meta_installed_repo_smoke_failed: additive recovery did not record the latest passing validation" >&2
  exit 1
fi
if ! grep -q "MOS additive install integrity, required files, instruction-layer alignment, and boundary validation" "${TARGET}/META_WHERE_LEFT_OFF.md"; then
  echo "meta_installed_repo_smoke_failed: additive recovery did not update META_WHERE_LEFT_OFF.md with validation scope" >&2
  exit 1
fi
if ! grep -q "detected repo shape is" "${TARGET}/META_WHERE_LEFT_OFF.md"; then
  echo "meta_installed_repo_smoke_failed: additive recovery did not restore repo-shape suggestions" >&2
  exit 1
fi

echo "meta_installed_repo_smoke_ok"
