#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: seed-meta-working-state.sh <target-repo> [--system-name NAME]
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

TARGET_REPO=""
SYSTEM_NAME=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --system-name)
      SYSTEM_NAME="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "${TARGET_REPO}" ]]; then
        TARGET_REPO="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        exit 1
      fi
      ;;
  esac
done

if [[ -z "${TARGET_REPO}" ]]; then
  usage
  exit 1
fi

if [[ -z "${SYSTEM_NAME}" ]]; then
  SYSTEM_NAME="$(basename -- "${TARGET_REPO}")"
fi

python3 - <<'PY' "${TARGET_REPO}" "${SYSTEM_NAME}"
from datetime import datetime, timezone
from pathlib import Path
import re
import sys

root = Path(sys.argv[1]).resolve()
system_name = sys.argv[2]
timestamp = datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def replace_line(text: str, prefix: str, new_line: str) -> str:
    pattern = rf"^{re.escape(prefix)}.*$"
    return re.sub(pattern, new_line, text, flags=re.MULTILINE)


def update_text(path: Path, updater) -> None:
    text = path.read_text()
    updated = updater(text)
    path.write_text(updated)


update_text(
    root / "META_PLAN.md",
    lambda text: text.replace(
        "- Record the current milestone, current implementation lane, and the next two concrete actions.",
        f"- Establish the first validated meta-system baseline for {system_name} and record the initial system-of-systems direction.",
        1,
    ),
)

todo_path = root / "META_TODO.md"
todo_text = todo_path.read_text()
if "Replace this placeholder with the active meta-system task list." in todo_text:
    todo_path.write_text(
        "# META_TODO.md\n\n"
        "## Current Priority\n\n"
        f"- [ ] Define the first real meta-system milestone for {system_name}\n"
        "- [ ] Review the target system or system family this repo is meant to build or govern\n"
        "- [ ] Record the first approved implementation slice and its validation path\n"
    )

update_text(
    root / "META_WHERE_LEFT_OFF.md",
    lambda text: replace_line(
        replace_line(
            replace_line(
                replace_line(
                    replace_line(text, "- Current lane:", "- Current lane: baseline-onboarding"),
                    "- Next command:",
                    "- Next command: bash bootstrap/system-meta-doctor.sh . --mode installed",
                ),
                "- Latest validation run:",
                "- Latest validation run: install baseline seeded; record the first explicit repo-local validation next",
            ),
            "- Resume confidence:",
            "- Resume confidence: medium after initial seeding; raise once repo-local validation is captured",
        ),
        "- Notes:",
        f"- Notes: MOS continuity surfaces were seeded for {system_name}; replace these onboarding defaults with repo-local truth as soon as the first real milestone is known.",
    ),
)

update_text(
    root / "meta_system/context/CURRENT_STATUS.md",
    lambda text: replace_line(
        replace_line(
            replace_line(
                replace_line(
                    replace_line(text, "- Product:", f"- Product: {system_name} meta-system scaffold"),
                    "- Completion status:",
                    "- Completion status: baseline seeded",
                ),
                "- Latest known passing validation:",
                "- Latest known passing validation: install baseline seeded; explicit repo-local validation should be recorded next",
            ),
            "- Latest known failing validation:",
            "- Latest known failing validation: none recorded",
        ),
        "- Current confidence level:",
        "- Current confidence level: baseline seeded, awaiting repo-local validation",
    ),
)

update_text(
    root / "META_RELEASE_NOTES.md",
    lambda text: replace_line(
        replace_line(
            replace_line(
                replace_line(text, "- Release target:", f"- Release target: {system_name} baseline-onboarding"),
                "- Status:",
                "- Status: install baseline seeded",
            ),
            "- Release confidence:",
            "- Release confidence: baseline only until repo-local validation is recorded",
        ),
        "- Notes:",
        "- Notes: continuity surfaces were seeded during install; update after the first real validation and review cycle",
    ),
)

changelog_path = root / "META_CHANGELOG.md"
changelog_text = changelog_path.read_text()
seed_note = "- Installed repos now receive seeded meta working-state surfaces instead of only placeholder continuity files."
if seed_note not in changelog_text:
    changelog_text = changelog_text.replace("## 0.1.0\n\n- Initial Meta Operating System MVP scaffold.\n", f"## 0.1.0\n\n- Initial Meta Operating System MVP scaffold.\n- Installed repos now receive seeded meta working-state surfaces instead of only placeholder continuity files.\n", 1)
    changelog_path.write_text(changelog_text)

fixme_path = root / "META_FIXME.md"
fixme_text = fixme_path.read_text()
placeholder = "- Record known gaps, edge cases, or deferred decisions here."
seeded = "- Record known gaps, edge cases, or deferred decisions here.\n- If continuity still feels weak after onboarding, tighten the seeded working-state defaults or add stronger installed-repo checks."
if placeholder in fixme_text and "If continuity still feels weak after onboarding" not in fixme_text:
    fixme_path.write_text(fixme_text.replace(placeholder, seeded, 1))
PY

echo "Seeded meta working state for ${SYSTEM_NAME}"
