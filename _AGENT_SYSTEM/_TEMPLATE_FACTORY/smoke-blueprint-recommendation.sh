#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

usage() {
  cat <<'EOF'
Usage: smoke-blueprint-recommendation.sh [--temp-root DIR] [--keep]

Create clean temporary repos from the master template, run the starter-blueprint
recommender, and verify that fresh installs avoid false positives while real
product/runtime signals produce coherent recommendations.
EOF
}

TEMP_ROOT="/tmp"
KEEP=0

while [[ $# -gt 0 ]]; do
  case "$1" in
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
declare -a TMP_REPOS=()

cleanup() {
  local status=$?
  if [[ ${status} -eq 0 && ${KEEP} -eq 0 ]]; then
    for repo in "${TMP_REPOS[@]-}"; do
      rm -rf "${repo}"
    done
  else
    for repo in "${TMP_REPOS[@]-}"; do
      printf 'Preserved temp repo: %s\n' "${repo}" >&2
    done
  fi
  exit ${status}
}
trap cleanup EXIT

make_repo() {
  local label="$1"
  local app_name="$2"
  local repo
  repo="$(mktemp -d "${TEMP_ROOT%/}/aiaast-blueprint-recommend.${label}.XXXXXX")"
  TMP_REPOS+=("${repo}")
  bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${repo}" --app-name "${app_name}" --strict >/dev/null
  printf '%s\n' "${repo}"
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local message="$3"
  if [[ "${haystack}" != *"${needle}"* ]]; then
    echo "${message}" >&2
    exit 1
  fi
}

# Scenario 1: blank repo should not recommend a concrete multi-surface blueprint
blank_repo="$(make_repo blank BlankRecommend)"
blank_output="$(bash "${blank_repo}/bootstrap/recommend-starter-blueprint.sh" "${blank_repo}" --write)"
assert_contains "${blank_output}" "recommended_blueprint=manual-review-required" \
  "Blank recommendation smoke failed: a clean install should require manual review, not auto-pick a blueprint."
if grep -Fq -- "- Recommended starter blueprint: UNIVERSAL_APP_PLATFORM" "${blank_repo}/PRODUCT_BRIEF.md"; then
  echo "Blank recommendation smoke failed: generated runtime foundations biased the recommendation toward UNIVERSAL_APP_PLATFORM." >&2
  exit 1
fi

# Scenario 2: explicit Next.js runtime signals should recommend the Next.js blueprint
next_repo="$(make_repo next NextRecommend)"
python3 - <<'PY' "${next_repo}"
import json
from pathlib import Path
import sys

repo = Path(sys.argv[1])
(repo / "src" / "app").mkdir(parents=True, exist_ok=True)
(repo / "src" / "app" / "page.tsx").write_text("export default function Page() { return <main>hi</main>; }\n")
(repo / "next.config.ts").write_text("export default {};\n")
pkg = {
    "name": "next-recommend",
    "private": True,
    "dependencies": {
        "next": "15.0.0",
        "react": "19.0.0",
        "react-dom": "19.0.0",
    },
}
(repo / "package.json").write_text(json.dumps(pkg, indent=2) + "\n")
PY
next_output="$(bash "${next_repo}/bootstrap/recommend-starter-blueprint.sh" "${next_repo}" --write)"
assert_contains "${next_output}" "recommended_blueprint=NEXT_JS_FULLSTACK" \
  "Next recommendation smoke failed: Next.js signals did not select NEXT_JS_FULLSTACK."

# Scenario 3: explicit FastAPI runtime signals should recommend the FastAPI blueprint
api_repo="$(make_repo fastapi FastApiRecommend)"
python3 - <<'PY' "${api_repo}"
from pathlib import Path
import sys

repo = Path(sys.argv[1])
(repo / "app").mkdir(parents=True, exist_ok=True)
(repo / "app" / "main.py").write_text(
    "from fastapi import FastAPI\n\napp = FastAPI()\n\n@app.get('/health')\ndef health():\n    return {'status': 'ok'}\n"
)
(repo / "pyproject.toml").write_text(
    "[project]\nname = 'fastapi-recommend'\nversion = '0.1.0'\ndependencies = ['fastapi', 'uvicorn']\n"
)
PY
api_output="$(bash "${api_repo}/bootstrap/recommend-starter-blueprint.sh" "${api_repo}" --write)"
assert_contains "${api_output}" "recommended_blueprint=FASTAPI_API" \
  "FastAPI recommendation smoke failed: FastAPI runtime signals did not select FASTAPI_API."

# Scenario 4: explicit multi-surface product framing should recommend the universal platform blueprint
universal_repo="$(make_repo universal UniversalRecommend)"
python3 - <<'PY' "${universal_repo}"
from pathlib import Path
import re
import sys

repo = Path(sys.argv[1])
brief = (repo / "PRODUCT_BRIEF.md").read_text()
replacements = {
    "Product category": "multi-surface app platform",
    "One-line summary": "Deliver a web app, API, worker, mobile client, and AI assistant from one repo.",
    "Primary workflows": "web dashboard, API-backed business flow, background job processing, Android client, and AI-assisted actions",
    "Recommended starter blueprint": "manual review required",
    "Recommendation confidence": "low",
    "Recommendation rationale": "review the persisted recommendation, then explicitly choose the blueprint that matches the intended product shape",
}
for label, value in replacements.items():
    brief = re.sub(rf"^- {re.escape(label)}:.*$", f"- {label}: {value}", brief, count=1, flags=re.MULTILINE)
(repo / "PRODUCT_BRIEF.md").write_text(brief)
PY
universal_output="$(bash "${universal_repo}/bootstrap/recommend-starter-blueprint.sh" "${universal_repo}" --write)"
assert_contains "${universal_output}" "recommended_blueprint=UNIVERSAL_APP_PLATFORM" \
  "Universal recommendation smoke failed: explicit multi-surface product framing did not select UNIVERSAL_APP_PLATFORM."

# Scenario 5: a truthfully filled mobile-first greenfield profile should recommend the Flutter Android blueprint
flutter_repo="$(make_repo flutter FlutterRecommend)"
python3 - <<'PY' "${flutter_repo}"
from pathlib import Path
import re
import sys

repo = Path(sys.argv[1])

def replace_label(text: str, label: str, value: str) -> str:
    return re.sub(rf"^- {re.escape(label)}:.*$", f"- {label}: {value}", text, count=1, flags=re.MULTILINE)

brief = (repo / "PRODUCT_BRIEF.md").read_text()
brief_replacements = {
    "Product category": "Android incident-response client for security operations teams",
    "One-line summary": "Give on-call analysts a focused Android client to triage alerts and capture response evidence away from the SOC desktop.",
    "Why it should exist": "The first-response workflow should not collapse when responders are away from a laptop.",
    "Primary users": "security analysts and incident commanders working from Android phones",
    "Primary workflows": "review an alert, inspect incident context, run a containment checklist, and sync the disposition back to the incident system",
    "Success indicators": "teams can complete first-response triage from a phone in under five minutes without losing notes or attachments",
    "Non-goals": "replace a SIEM or ship iOS in the first phase",
}
for label, value in brief_replacements.items():
    brief = replace_label(brief, label, value)
(repo / "PRODUCT_BRIEF.md").write_text(brief)

profile = (repo / "_system" / "PROJECT_PROFILE.md").read_text()
profile_replacements = {
    "Repo purpose": "Build an Android-first incident-response client that keeps alert triage usable away from the desktop SOC.",
    "Product category": "Android incident-response client for security operations teams",
    "Primary users": "security analysts and incident commanders",
    "Main workflows": "review alerts, run containment checklists, capture evidence notes, and sync a disposition back to the backend",
    "Primary success criteria": "first-response triage completes from a phone in under five minutes with no lost context",
    "Non-goals": "replace a SIEM or provide iOS support in phase one",
    "Runtime code roots": "mobile/flutter/lib/, ai/",
    "Primary frameworks": "Flutter, Material 3",
    "Build tools": "flutter, dart",
    "Build entrypoints": "mobile/flutter/lib/main.dart",
    "Lint": "cd mobile/flutter && flutter analyze",
    "Typecheck": "cd mobile/flutter && dart analyze",
    "Unit tests": "cd mobile/flutter && flutter test",
    "Integration tests": "cd mobile/flutter && flutter test integration_test",
    "End-to-end or smoke": "cd mobile/flutter && flutter test integration_test",
    "Build": "cd mobile/flutter && flutter build apk --debug",
    "Packaging verification": "cd mobile/flutter && flutter build appbundle --debug",
    "Mobile targets": "Android phone first",
    "Mobile release artifacts": "signed APK, release AAB",
    "Mobile build flavors": "dev, staging, production",
}
for label, value in profile_replacements.items():
    profile = replace_label(profile, label, value)
(repo / "_system" / "PROJECT_PROFILE.md").write_text(profile)
PY
flutter_output="$(bash "${flutter_repo}/bootstrap/recommend-starter-blueprint.sh" "${flutter_repo}" --write)"
assert_contains "${flutter_output}" "recommended_blueprint=FLUTTER_ANDROID_CLIENT" \
  "Flutter recommendation smoke failed: a filled Android client profile did not select FLUTTER_ANDROID_CLIENT."

printf 'blueprint_recommendation_smoke_ok scenarios=%s\n' "blank,next,fastapi,universal,flutter"
