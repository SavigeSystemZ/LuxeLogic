#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: suggest-meta-baseline.sh <target-repo> [--write]
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

TARGET_REPO=""
WRITE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --write)
      WRITE=1
      shift
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

python3 - <<'PY' "${TARGET_REPO}" "${WRITE}"
from pathlib import Path
import json
import sys

root = Path(sys.argv[1]).resolve()
write = sys.argv[2] == "1"

repo_name = root.name

signals: list[str] = []
validation_commands: list[str] = []
focus_parts: list[str] = []

if (root / "TEMPLATE").is_dir():
    signals.append("app-facing installable product")
    focus_parts.append("the app-facing installable product")
if (root / "_TEMPLATE_FACTORY").is_dir():
    signals.append("app-template factory tooling")
    validation_commands.append("./_TEMPLATE_FACTORY/run-automation-lane.sh")
if (root / "MOS_TEMPLATE").is_dir():
    signals.append("meta installable product")
    focus_parts.append("the meta installable product")
if (root / "_MOS_TEMPLATE_FACTORY").is_dir():
    signals.append("meta factory tooling")
    validation_commands.append("./_MOS_TEMPLATE_FACTORY/run-automation-lane.sh")
if (root / "SOURCE_LIBRARY").is_dir() or (root / "MOS_SOURCE_LIBRARY").is_dir():
    signals.append("source library")
    focus_parts.append("the source intake library")
if (root / "docs").is_dir():
    signals.append("canonical documentation")

if not validation_commands:
    validation_commands.append("bash bootstrap/system-meta-doctor.sh . --mode installed")

if not focus_parts:
    focus_parts.append("the initial meta-system repo structure")

focus = f"Stabilize {repo_name} around " + ", ".join(focus_parts) + "."
shape = ", ".join(signals) if signals else "baseline MOS-installed repo"
next_command = validation_commands[0]

suggestions = {
    "repo_name": repo_name,
    "detected_shape": shape,
    "focus": focus,
    "next_command": next_command,
    "validation_commands": validation_commands,
}

if not write:
    print(json.dumps(suggestions, indent=2))
    raise SystemExit(0)

def replace_if_present(text: str, old: str, new: str) -> str:
    return text.replace(old, new, 1) if old in text else text

plan_path = root / "META_PLAN.md"
plan_text = plan_path.read_text()
plan_text = replace_if_present(
    plan_text,
    f"- Establish the first validated meta-system baseline for {repo_name} and record the initial system-of-systems direction.",
    f"- {focus}",
)
plan_path.write_text(plan_text)

todo_path = root / "META_TODO.md"
todo_text = todo_path.read_text()
todo_text = replace_if_present(
    todo_text,
    f"- [ ] Define the first real meta-system milestone for {repo_name}",
    f"- [ ] Confirm the first meta-system milestone for {repo_name} against the detected repo shape: {shape}",
)
todo_text = replace_if_present(
    todo_text,
    "- [ ] Review the target system or system family this repo is meant to build or govern",
    f"- [ ] Review the target system or system family this repo is meant to build or govern using the detected shape: {shape}",
)
todo_text = replace_if_present(
    todo_text,
    "- [ ] Record the first approved implementation slice and its validation path",
    f"- [ ] Record the first approved implementation slice and validate it with {', '.join(validation_commands)}",
)
todo_path.write_text(todo_text)

where_path = root / "META_WHERE_LEFT_OFF.md"
where_text = where_path.read_text()
where_text = replace_if_present(
    where_text,
    "- Next command: bash bootstrap/system-meta-doctor.sh . --mode installed",
    f"- Next command: {next_command}",
)
where_text = replace_if_present(
    where_text,
    f"- Notes: MOS continuity surfaces were seeded for {repo_name}; replace these onboarding defaults with repo-local truth as soon as the first real milestone is known.",
    f"- Notes: MOS continuity surfaces were seeded for {repo_name}; detected repo shape is {shape}; replace these onboarding defaults with repo-local truth as soon as the first real milestone is known.",
)
where_path.write_text(where_text)

status_path = root / "meta_system/context/CURRENT_STATUS.md"
status_text = status_path.read_text()
status_text = replace_if_present(
    status_text,
    "- Completion status: baseline seeded",
    f"- Completion status: baseline seeded for {shape}",
)
status_text = replace_if_present(
    status_text,
    "- Latest known passing validation: install baseline seeded; explicit repo-local validation should be recorded next",
    f"- Latest known passing validation: install baseline seeded; suggested next validation is {next_command}",
)
status_path.write_text(status_text)

print(f"suggested_meta_baseline_for={repo_name}")
print(f"suggested_meta_shape={shape}")
print(f"suggested_meta_next_command={next_command}")
PY
