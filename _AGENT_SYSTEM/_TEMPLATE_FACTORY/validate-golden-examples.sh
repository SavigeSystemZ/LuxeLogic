#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
export AIAAST_GOLDEN_EXAMPLES_DIR="${SCRIPT_DIR}/GOLDEN_EXAMPLES"

exec python3 - <<'PY'
from __future__ import annotations

import json
import os
import re
from pathlib import Path


def extract_section(text: str, heading: str) -> str:
    pattern = rf"^## {re.escape(heading)}\s*$\n(.*?)(?=^## |\Z)"
    match = re.search(pattern, text, flags=re.MULTILINE | re.DOTALL)
    return match.group(1).strip() if match else ""


root = Path(os.environ["AIAAST_GOLDEN_EXAMPLES_DIR"]).resolve()
issues: list[str] = []

rubric_path = root / "promotion-rubric.json"
if not rubric_path.is_file():
    print("golden_example_governance_failed")
    print("- Missing promotion-rubric.json")
    raise SystemExit(1)

rubric = json.loads(rubric_path.read_text())
required_files = [str(item) for item in rubric.get("required_factory_files", [])]
for rel in required_files:
    if not (root / rel).is_file():
        issues.append(f"Missing required golden-example governance file: {rel}")

scorecard_path = root / "repo-scorecard.json"
selection_path = root / "SELECTION.md"
review_notes_path = root / "REVIEW_NOTES.md"
criteria_path = root / "PROMOTION_CRITERIA.md"
readme_path = root / "README.md"

if issues:
    print("golden_example_governance_failed")
    for issue in issues:
        print(f"- {issue}")
    raise SystemExit(1)

scorecard = json.loads(scorecard_path.read_text())
repos = {}
for item in scorecard.get("repos", []):
    name = str(item.get("name", "")).strip()
    if name:
        repos[name] = item

if not repos:
    issues.append("repo-scorecard.json does not contain any repos")

selection_text = selection_path.read_text()
review_text = review_notes_path.read_text()
criteria_text = criteria_path.read_text()
readme_text = readme_path.read_text()

for needle in ("PROMOTION_CRITERIA.md", "REVIEW_NOTES.md"):
    if needle not in selection_text:
        issues.append(f"SELECTION.md is missing required governance reference: {needle}")

for needle in ("PROMOTION_CRITERIA.md", "validate-golden-examples.sh"):
    if needle not in readme_text:
        issues.append(f"GOLDEN_EXAMPLES/README.md is missing required governance reference: {needle}")

for needle in ("promotion-rubric.json", "validate-golden-examples.sh"):
    if needle not in criteria_text:
        issues.append(f"PROMOTION_CRITERIA.md is missing required machine-readable reference: {needle}")

selection_section = extract_section(selection_text, "Current primary donors by pattern")
if not selection_section:
    issues.append("SELECTION.md is missing the 'Current primary donors by pattern' section")

selected_by_pattern: dict[str, list[str]] = {}
selection_lines = selection_section.splitlines()
for index, raw_line in enumerate(selection_lines):
    stripped = raw_line.strip()
    match = re.match(r"- ([^:]+): (.+)", stripped)
    if not match:
        continue
    pattern_name = match.group(1).strip()
    donor_names = [part.strip() for part in match.group(2).split(",") if part.strip()]
    if not donor_names:
        issues.append(f"SELECTION.md pattern has no donors: {pattern_name}")
        continue
    selected_by_pattern[pattern_name] = donor_names
    next_nonempty = ""
    for follower in selection_lines[index + 1 :]:
        follower = follower.strip()
        if follower:
            next_nonempty = follower
            break
    if not next_nonempty.startswith("Reason:"):
        issues.append(f"SELECTION.md pattern is missing an immediate reason line: {pattern_name}")

selected_donors = {name for donors in selected_by_pattern.values() for name in donors}
if not selected_donors:
    issues.append("SELECTION.md does not identify any primary donors")

review_candidates = re.findall(r"^### Candidate: (.+)$", review_text, flags=re.MULTILINE)
review_sections = {
    name: match.group(1)
    for name in review_candidates
    for match in [
        re.search(
            rf"^### Candidate: {re.escape(name)}\s*$\n(.*?)(?=^### Candidate: |\Z)",
            review_text,
            flags=re.MULTILINE | re.DOTALL,
        )
    ]
    if match
}
for name, section in review_sections.items():
    for needle in ("- Why not promoted now:", "- Decision:"):
        if needle not in section:
            issues.append(f"REVIEW_NOTES.md candidate is missing required subsection '{needle}': {name}")
    if name not in repos:
        issues.append(f"REVIEW_NOTES.md references repo missing from scorecard: {name}")

accepted_signals = set(str(item) for item in rubric.get("accepted_primary_signals", []))
minimum_score = float(rubric.get("minimum_primary_donor_score", 0.0))
minimum_signal_count = int(rubric.get("minimum_primary_signal_count", 0))
review_threshold = float(rubric.get("high_score_review_threshold", 0.0))

for donor in sorted(selected_donors):
    repo = repos.get(donor)
    if repo is None:
        issues.append(f"SELECTION.md references repo missing from scorecard: {donor}")
        continue
    score = float(repo.get("score", 0.0))
    signals = set(str(item) for item in repo.get("signals", []))
    matched_signals = sorted(signals & accepted_signals)
    if score < minimum_score:
        issues.append(
            f"Selected donor does not meet minimum score {minimum_score:.1f}: {donor} ({score:.1f})"
        )
    if len(matched_signals) < minimum_signal_count:
        issues.append(
            f"Selected donor does not meet minimum accepted-signal count {minimum_signal_count}: {donor}"
        )

for name, repo in repos.items():
    score = float(repo.get("score", 0.0))
    if score >= review_threshold and name not in selected_donors and name not in review_sections:
        issues.append(
            f"High-scoring non-selected repo is missing review notes (threshold {review_threshold:.1f}): {name}"
        )

if "Promotion still requires a concrete neutral-pattern improvement" not in review_text:
    issues.append("REVIEW_NOTES.md result summary is missing the neutral-pattern promotion rule")

if issues:
    print("golden_example_governance_failed")
    for issue in issues:
        print(f"- {issue}")
    raise SystemExit(1)

print("golden_example_governance_ok")
PY
