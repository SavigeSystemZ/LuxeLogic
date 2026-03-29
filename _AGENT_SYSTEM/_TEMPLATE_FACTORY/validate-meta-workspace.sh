#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"
WORKSPACE="${REPO_ROOT}/_META_AGENT_SYSTEM"

python3 - <<'PY' "${WORKSPACE}"
from pathlib import Path
import re
import sys

workspace = Path(sys.argv[1]).resolve()
issues: list[str] = []

required_files = [
    "README.md",
    "PLAN.md",
    "TODO.md",
    "KEY.md",
    "COMPLETION_SHEET.md",
    "TEST_APP_CAMPAIGN.md",
    "WHERE_LEFT_OFF.md",
    "PLANNED_FILES.md",
    "context/CURRENT_STATUS.md",
    "context/DECISIONS.md",
]

for rel in required_files:
    if not (workspace / rel).is_file():
        issues.append(f"Missing required maintainer workspace file: {rel}")

if issues:
    print("meta_workspace_continuity_failed")
    for item in issues:
        print(f"- {item}")
    raise SystemExit(1)

checks = {
    "PLAN.md": [
        ("## Next execution slice", "PLAN.md is missing the next execution slice"),
    ],
    "TODO.md": [
        ("## Current Priority", "TODO.md is missing current priorities"),
    ],
    "COMPLETION_SHEET.md": [
        ("## Finish Line", "COMPLETION_SHEET.md is missing the finish line section"),
        ("## Testing Phases", "COMPLETION_SHEET.md is missing the testing phases section"),
    ],
    "WHERE_LEFT_OFF.md": [
        ("## Validation Run", "WHERE_LEFT_OFF.md is missing validation evidence"),
        ("## Next Best Step", "WHERE_LEFT_OFF.md is missing the next best step"),
    ],
    "PLANNED_FILES.md": [
        ("## Current status", "PLANNED_FILES.md is missing current status"),
    ],
    "context/CURRENT_STATUS.md": [
        ("- Next best step:", "context/CURRENT_STATUS.md is missing the next best step"),
        ("- Last updated:", "context/CURRENT_STATUS.md is missing the freshness stamp"),
    ],
}

placeholder_patterns = {
    "PLAN.md": [
        "wait for the user's next",
        "next maintainer-only system-for-the-system files",
    ],
    "TODO.md": [
        "wait for the user's instructions",
        "replace this placeholder",
    ],
    "WHERE_LEFT_OFF.md": [
        "Current lane: unset",
        "Latest validation run: unset",
        "Resume confidence: low until updated",
        "wait for the user to specify",
    ],
    "PLANNED_FILES.md": [
        "ready for the next user-approved",
    ],
    "context/CURRENT_STATUS.md": [
        "resume the primary app-system work now that both installable products validate cleanly end-to-end",
    ],
}

for rel, required in checks.items():
    text = (workspace / rel).read_text()
    for needle, message in required:
        if needle not in text:
            issues.append(message)

for rel, needles in placeholder_patterns.items():
    text = (workspace / rel).read_text().lower()
    for needle in needles:
        if needle.lower() in text:
            issues.append(f"{rel} still contains stale placeholder-style text: {needle}")

decisions_text = (workspace / "context/DECISIONS.md").read_text()
entry_count = len(re.findall(r"^- Date:", decisions_text, flags=re.MULTILINE))
if entry_count < 3:
    issues.append("context/DECISIONS.md has fewer than three recorded decisions")

if issues:
    print("meta_workspace_continuity_failed")
    for item in issues:
        print(f"- {item}")
    raise SystemExit(1)

print("meta_workspace_continuity_ok")
PY
