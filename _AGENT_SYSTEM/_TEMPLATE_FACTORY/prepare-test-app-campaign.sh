#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: prepare-test-app-campaign.sh --output-root DIR [--campaign ID] [--limit N]

Bootstrap a curated set of test app repos from the master template, apply the
declared starter blueprints, and emit a campaign manifest plus README so the
next build/testing phase can start immediately.

Use an exec-capable output root. Avoid `/tmp` on hosts where downstream app
builds may need Python compiled extensions or local binaries and `/tmp` is
mounted `noexec`.
EOF
}

OUTPUT_ROOT=""
CAMPAIGN_ID="core-matrix"
LIMIT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output-root)
      OUTPUT_ROOT="${2:-}"
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

if [[ -z "${OUTPUT_ROOT}" ]]; then
  usage
  exit 1
fi

if ! [[ "${LIMIT}" =~ ^[0-9]+$ ]]; then
  echo "--limit must be a non-negative integer." >&2
  exit 1
fi

CAMPAIGN_PATH="${SCRIPT_DIR}/test-app-campaigns/${CAMPAIGN_ID}.json"
if [[ ! -f "${CAMPAIGN_PATH}" ]]; then
  echo "Unknown test app campaign: ${CAMPAIGN_ID}" >&2
  echo "Expected manifest: ${CAMPAIGN_PATH}" >&2
  exit 1
fi

mkdir -p "${OUTPUT_ROOT}"

case "${OUTPUT_ROOT}" in
  /tmp|/tmp/*|/var/tmp|/var/tmp/*)
    echo "Warning: ${OUTPUT_ROOT} is under a temp root. Prefer an exec-capable path such as \$HOME/.aiaast-test-apps when downstream builds need local binaries or compiled Python extensions." >&2
    ;;
esac

CAMPAIGN_ROOT="${OUTPUT_ROOT%/}/${CAMPAIGN_ID}"
if [[ -e "${CAMPAIGN_ROOT}" ]]; then
  echo "Refusing to overwrite existing campaign root: ${CAMPAIGN_ROOT}" >&2
  exit 1
fi
mkdir -p "${CAMPAIGN_ROOT}"

SPEC_FILE="$(mktemp)"
STATUS_FILE="$(mktemp)"
trap 'rm -f "${SPEC_FILE}" "${STATUS_FILE}"' EXIT

python3 - <<'PY' "${CAMPAIGN_PATH}" "${LIMIT}" > "${SPEC_FILE}"
import json
import sys
from pathlib import Path

manifest = json.loads(Path(sys.argv[1]).read_text())
limit = int(sys.argv[2])
apps = manifest["apps"]
if limit > 0:
    apps = apps[:limit]

for app in apps:
    print(
        "\t".join(
            [
                app["slug"],
                app["app_name"],
                app["blueprint"],
                app.get("category", ""),
                app.get("goal", ""),
            ]
        )
    )
PY

TEMPLATE_VERSION="$(tr -d '\n' < "${TEMPLATE_ROOT}/_system/.template-version")"

while IFS=$'\t' read -r slug app_name blueprint category goal; do
  [[ -n "${slug}" ]] || continue
  repo_dir="${CAMPAIGN_ROOT}/${slug}"
  bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${repo_dir}" --app-name "${app_name}" --strict
  bash "${repo_dir}/bootstrap/apply-starter-blueprint.sh" "${repo_dir}" --blueprint "${blueprint}" --app-name "${app_name}"
  bash "${repo_dir}/bootstrap/validate-system.sh" "${repo_dir}" --strict
  bash "${repo_dir}/bootstrap/check-runtime-foundations.sh" "${repo_dir}"
  bash "${repo_dir}/bootstrap/check-packaging-targets.sh" "${repo_dir}"
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' \
    "${slug}" "${app_name}" "${blueprint}" "${category}" "${goal}" "${repo_dir}" >> "${STATUS_FILE}"
  printf 'prepared_test_app app_name=%s blueprint=%s repo=%s\n' \
    "${app_name}" "${blueprint}" "${repo_dir}"
done < "${SPEC_FILE}"

python3 - <<'PY' "${CAMPAIGN_PATH}" "${STATUS_FILE}" "${CAMPAIGN_ROOT}" "${TEMPLATE_VERSION}"
from __future__ import annotations

import json
import sys
from datetime import datetime, timezone
from pathlib import Path

campaign_path = Path(sys.argv[1]).resolve()
status_path = Path(sys.argv[2]).resolve()
campaign_root = Path(sys.argv[3]).resolve()
template_version = sys.argv[4]

campaign = json.loads(campaign_path.read_text())
generated_at = datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")

apps = []
for line in status_path.read_text().splitlines():
    if not line.strip():
      continue
    slug, app_name, blueprint, category, goal, repo_dir = line.split("\t")
    apps.append(
        {
            "slug": slug,
            "app_name": app_name,
            "blueprint": blueprint,
            "category": category,
            "goal": goal,
            "repo_dir": repo_dir,
            "validation_commands": [
                f"bootstrap/validate-system.sh {repo_dir} --strict",
                f"bootstrap/check-runtime-foundations.sh {repo_dir}",
                f"bootstrap/check-packaging-targets.sh {repo_dir}",
            ],
            "next_step": "Begin runtime implementation inside the prepared repo and keep the selected blueprint explicit.",
        }
    )

manifest = {
    "campaign_id": campaign["campaign_id"],
    "title": campaign["title"],
    "description": campaign["description"],
    "generated_at": generated_at,
    "template_version": template_version,
    "campaign_root": str(campaign_root),
    "generated_app_count": len(apps),
    "apps": apps,
}

(campaign_root / "campaign-manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")

lines = [
    f"# {campaign['title']}",
    "",
    campaign["description"],
    "",
    f"- Generated at: `{generated_at}`",
    f"- AIAST version: `{template_version}`",
    f"- Campaign root: `{campaign_root}`",
    f"- Generated apps: `{len(apps)}`",
    "",
    "## Apps",
]

for idx, app in enumerate(apps, start=1):
    lines.extend(
        [
            f"{idx}. `{app['app_name']}`",
            f"   - Blueprint: `{app['blueprint']}`",
            f"   - Category: `{app['category']}`",
            f"   - Goal: {app['goal']}",
            f"   - Repo: `{app['repo_dir']}`",
            f"   - First validation: `{app['validation_commands'][0]}`",
        ]
    )

lines.extend(
    [
        "",
        "## Next Step",
        "",
        "Start implementing runtime code inside the prepared repos in the listed order, keeping each selected blueprint explicit and using the generated manifest as the testing ledger.",
        "",
        "Prefer an exec-capable campaign root such as one under `$HOME/` when downstream builds will run local binaries, Node toolchains, or Python compiled extensions. Some hosts mount `/tmp` as `noexec`.",
        "",
    ]
)

(campaign_root / "README.md").write_text("\n".join(lines))
PY

app_count="$(wc -l < "${STATUS_FILE}" | tr -d ' ')"
printf 'test_app_campaign_ready campaign=%s apps=%s root=%s template_version=%s\n' \
  "${CAMPAIGN_ID}" "${app_count}" "${CAMPAIGN_ROOT}" "${TEMPLATE_VERSION}"
