#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage: smoke-test-app-campaign.sh [--temp-root DIR]

Run a lightweight proof that the isolated test-session wrapper can bootstrap a
curated subset of repos outside the source tree and emit the expected session
and campaign manifests.
EOF
}

TEMP_ROOT="/tmp"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --temp-root)
      TEMP_ROOT="${2:-}"
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

mkdir -p "${TEMP_ROOT}"
WORK_ROOT="$(mktemp -d "${TEMP_ROOT%/}/aiaast-test-app-campaign.XXXXXX")"
trap 'rm -rf "${WORK_ROOT}"' EXIT

bash "${SCRIPT_DIR}/prepare-test-session.sh" \
  --tests-root "${WORK_ROOT}" \
  --session-id session-smoke \
  --campaign core-matrix \
  --limit 4 >/dev/null

python3 - <<'PY' "${WORK_ROOT}/session-smoke/apps/campaign-manifest.json" "${WORK_ROOT}/session-smoke"
import json
import sys
from pathlib import Path

path = Path(sys.argv[1]).resolve()
session_root = Path(sys.argv[2]).resolve()
campaign_root = session_root / "apps"
stale_root = str(session_root / "core-matrix")
if not path.is_file():
    print(f"Missing campaign manifest: {path}", file=sys.stderr)
    raise SystemExit(1)

if not (session_root / "README.md").is_file():
    print("Missing session README.md", file=sys.stderr)
    raise SystemExit(1)

if not (session_root / "TEST_MANIFEST.md").is_file():
    print("Missing session TEST_MANIFEST.md", file=sys.stderr)
    raise SystemExit(1)

manifest = json.loads(path.read_text())
if manifest.get("campaign_id") != "core-matrix":
    print("Unexpected campaign id in smoke manifest", file=sys.stderr)
    raise SystemExit(1)

apps = manifest.get("apps") or []
if len(apps) != 4:
    print(f"Expected 4 prepared apps, found {len(apps)}", file=sys.stderr)
    raise SystemExit(1)

required = {"AIASTControlPlane", "AIASTPortalWeb", "AIASTServiceApi", "AIASTOpsMobile"}
seen = {app.get("app_name") for app in apps}
missing = sorted(required - seen)
if missing:
    print(f"Smoke manifest missing expected apps: {', '.join(missing)}", file=sys.stderr)
    raise SystemExit(1)

for rel in (
    "control-plane/_system/KEY.md",
    "ops-mobile/_system/KEY.md",
    "portal-web/_system/KEY.md",
    "service-api/_system/KEY.md",
):
    if not (campaign_root / rel).is_file():
        print(f"Missing expected generated key: {rel}", file=sys.stderr)
        raise SystemExit(1)

portal_profile = (campaign_root / "portal-web" / "_system" / "PROJECT_PROFILE.md").read_text()
if "Primary frameworks: Next.js, React" not in portal_profile:
    print("Portal-web profile did not pick up Next.js blueprint hints", file=sys.stderr)
    raise SystemExit(1)
if "Supported environments: Android" in portal_profile or "Deployment targets: Android" in portal_profile:
    print("Portal-web profile still carries false Android hints", file=sys.stderr)
    raise SystemExit(1)

service_profile = (campaign_root / "service-api" / "_system" / "PROJECT_PROFILE.md").read_text()
if "Primary frameworks: FastAPI" not in service_profile:
    print("Service-api profile did not pick up FastAPI blueprint hints", file=sys.stderr)
    raise SystemExit(1)
if "Components: mobile" in service_profile or "Packaging targets: APK, AAB" in service_profile:
    print("Service-api profile still carries false mobile packaging hints", file=sys.stderr)
    raise SystemExit(1)

mobile_readme = (campaign_root / "ops-mobile" / "mobile" / "flutter" / "README.md").read_text()
if "flutter create --platforms=android ." not in mobile_readme:
    print("Ops-mobile Flutter README is missing the flutter create bootstrap step", file=sys.stderr)
    raise SystemExit(1)

mobile_blueprint = (campaign_root / "ops-mobile" / "_system" / "starter-blueprints" / "FLUTTER_ANDROID_CLIENT.md").read_text()
if "flutter create --platforms=android ." not in mobile_blueprint:
    print("Ops-mobile mobile blueprint is missing the flutter create bootstrap step", file=sys.stderr)
    raise SystemExit(1)

stale_hits = []
for candidate in campaign_root.rglob("*"):
    if not candidate.is_file():
        continue
    try:
        text = candidate.read_text()
    except UnicodeDecodeError:
        continue
    if stale_root in text:
        stale_hits.append(str(candidate.relative_to(campaign_root)))

if stale_hits:
    print(
        "Found stale pre-move campaign paths in generated repos: "
        + ", ".join(sorted(stale_hits)),
        file=sys.stderr,
    )
    raise SystemExit(1)
PY

printf 'test_app_campaign_smoke_ok campaign=%s apps=%s\n' "core-matrix" "4"
