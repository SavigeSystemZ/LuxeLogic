#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
MYAPPZ_ROOT="$(cd -- "${REPO_ROOT}/.." && pwd)"
DEFAULT_TESTS_ROOT="${MYAPPZ_ROOT}/_AI_AGENT_SYSTEM_TESTS"

usage() {
  cat <<'EOF'
Usage: prepare-test-session.sh [--tests-root DIR] [--session-id ID] [--campaign ID] [--limit N]

Create a removable dated test session outside the source repo, scaffold a fresh
test-app campaign into that session, and write session-level notes that keep
test-app context out of `_AI_AGENT_SYSTEM_TEMPLATE/`.
EOF
}

TESTS_ROOT="${DEFAULT_TESTS_ROOT}"
SESSION_ID="$(date +%F)-campaign-01"
CAMPAIGN_ID="core-matrix"
LIMIT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tests-root)
      TESTS_ROOT="${2:-}"
      shift 2
      ;;
    --session-id)
      SESSION_ID="${2:-}"
      shift 2
      ;;
    --campaign)
      CAMPAIGN_ID="${2:-}"
      shift 2
      ;;
    --limit)
      LIMIT="${2:-}"
      shift 2
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

if ! [[ "${LIMIT}" =~ ^[0-9]+$ ]]; then
  echo "--limit must be a non-negative integer." >&2
  exit 1
fi

SESSION_ROOT="${TESTS_ROOT%/}/${SESSION_ID}"
if [[ -e "${SESSION_ROOT}" ]]; then
  echo "Refusing to overwrite existing test session: ${SESSION_ROOT}" >&2
  exit 1
fi

mkdir -p "${TESTS_ROOT}"

prepare_args=(
  --output-root "${SESSION_ROOT}"
  --campaign "${CAMPAIGN_ID}"
)

if [[ "${LIMIT}" -gt 0 ]]; then
  prepare_args+=(--limit "${LIMIT}")
fi

bash "${SCRIPT_DIR}/prepare-test-app-campaign.sh" "${prepare_args[@]}"

GENERATED_ROOT="${SESSION_ROOT}/${CAMPAIGN_ID}"
APPS_ROOT="${SESSION_ROOT}/apps"
if [[ ! -d "${GENERATED_ROOT}" ]]; then
  echo "Expected generated campaign root missing: ${GENERATED_ROOT}" >&2
  exit 1
fi

mv "${GENERATED_ROOT}" "${APPS_ROOT}"

python3 - <<'PY' "${APPS_ROOT}/campaign-manifest.json" "${APPS_ROOT}/README.md" "${APPS_ROOT}"
from __future__ import annotations

import json
import sys
from pathlib import Path

manifest_path = Path(sys.argv[1]).resolve()
readme_path = Path(sys.argv[2]).resolve()
apps_root = Path(sys.argv[3]).resolve()

manifest = json.loads(manifest_path.read_text())
old_root = manifest.get("campaign_root", "")
new_root = str(apps_root)
repo_path_updates: list[tuple[str, str]] = []
manifest["campaign_root"] = new_root
for app in manifest.get("apps", []):
    slug = app["slug"]
    old_repo = app.get("repo_dir", "")
    repo_dir = str(apps_root / slug)
    app["repo_dir"] = repo_dir
    if old_repo:
        repo_path_updates.append((old_repo, repo_dir))
    app["validation_commands"] = [
        f"bootstrap/validate-system.sh {repo_dir} --strict",
        f"bootstrap/check-runtime-foundations.sh {repo_dir}",
        f"bootstrap/check-packaging-targets.sh {repo_dir}",
    ]
manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")

readme = readme_path.read_text()
if old_root:
    readme = readme.replace(old_root, new_root)
for old_repo, new_repo in repo_path_updates:
    readme = readme.replace(old_repo, new_repo)
readme_path.write_text(readme)

for path in apps_root.rglob("*"):
    if not path.is_file():
        continue
    try:
        text = path.read_text()
    except UnicodeDecodeError:
        continue

    updated = text
    if old_root:
        updated = updated.replace(old_root, new_root)
    for old_repo, new_repo in repo_path_updates:
        updated = updated.replace(old_repo, new_repo)

    if updated != text:
        path.write_text(updated)
PY

python3 - <<'PY' "${SESSION_ROOT}" "${APPS_ROOT}" "${CAMPAIGN_ID}" "${LIMIT}"
from __future__ import annotations

import json
import sys
from datetime import datetime, timezone
from pathlib import Path

session_root = Path(sys.argv[1]).resolve()
apps_root = Path(sys.argv[2]).resolve()
campaign_id = sys.argv[3]
limit = int(sys.argv[4])
manifest = json.loads((apps_root / "campaign-manifest.json").read_text())
generated_at = datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")

readme_lines = [
    "# AIAST Test Session",
    "",
    "This directory is a removable sandbox session for downstream app proofs.",
    "",
    "## Purpose",
    "",
    "- keep test-app runtime code and context out of `_AI_AGENT_SYSTEM_TEMPLATE/`",
    "- scaffold fresh repos from the current source template",
    "- record validation, findings, and cleanup boundaries in one removable session root",
    "",
    "## Session details",
    "",
    f"- Generated at: `{generated_at}`",
    f"- Campaign: `{campaign_id}`",
    f"- AIAST version: `{manifest['template_version']}`",
    f"- Apps root: `{apps_root}`",
    f"- Generated apps: `{manifest['generated_app_count']}`",
    "",
    "## Rules",
    "",
    "- Keep app-specific code, notes, and findings inside this session root.",
    "- Do not move runtime test artifacts back into `_AI_AGENT_SYSTEM_TEMPLATE/`.",
    "- Only patch the source template when a sandbox exposes a real systemic defect.",
    "- This whole session directory may be removed after the proof cycle is complete.",
    "",
    "## Apps",
    "",
]

for idx, app in enumerate(manifest["apps"], start=1):
    readme_lines.extend(
        [
            f"{idx}. `{app['app_name']}`",
            f"   - Blueprint: `{app['blueprint']}`",
            f"   - Repo: `{app['repo_dir']}`",
            f"   - Goal: {app['goal']}",
        ]
    )

readme_lines.extend(["", "## Pointers", "", "- App repos live under `apps/`.", "- Campaign metadata lives in `apps/campaign-manifest.json` and `apps/README.md`.", ""])
(session_root / "README.md").write_text("\n".join(readme_lines))

manifest_lines = [
    "# Test Manifest",
    "",
    "## Scope",
    "",
    "Run downstream app proofs outside `_AI_AGENT_SYSTEM_TEMPLATE`.",
    "",
    "## Session",
    "",
    f"- Session root: `{session_root}`",
    f"- Apps root: `{apps_root}`",
    f"- Campaign: `{campaign_id}`",
    f"- App count: `{manifest['generated_app_count']}`",
]

if limit > 0:
    manifest_lines.append(f"- Limit: `{limit}`")

manifest_lines.extend(
    [
        "",
        "## Planned sandboxes",
        "",
    ]
)

for app in manifest["apps"]:
    manifest_lines.append(f"- `{app['slug']}`")

manifest_lines.extend(
    [
        "",
        "## Rules",
        "",
        "- keep generated app code and app-specific context inside `apps/`",
        "- do not modify `_AI_AGENT_SYSTEM_TEMPLATE` unless a sandbox exposes a real system issue",
        "- record findings and fixes before cleanup",
        "",
    ]
)

(session_root / "TEST_MANIFEST.md").write_text("\n".join(manifest_lines))
PY

printf 'test_session_ready session=%s root=%s apps=%s campaign=%s\n' \
  "${SESSION_ID}" "${SESSION_ROOT}" "${APPS_ROOT}" "${CAMPAIGN_ID}"
