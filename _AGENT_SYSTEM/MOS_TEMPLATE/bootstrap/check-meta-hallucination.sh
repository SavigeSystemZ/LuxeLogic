#!/usr/bin/env bash
set -euo pipefail

TARGET_REPO="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)}"

python3 - <<'PY' "${TARGET_REPO}"
import re
import sys
from pathlib import Path

repo = Path(sys.argv[1]).resolve()
existing = {
    str(path.relative_to(repo))
    for path in repo.rglob("*")
    if path.is_file() and ".git" not in path.parts
}
issues = []

for path in sorted(repo.rglob("*.md")):
    rel = str(path.relative_to(repo))
    for line in path.read_text().splitlines():
        for match in re.findall(r"`([^`]+)`", line):
            token = match.strip()
            if not token:
                continue
            if " " in token or token.endswith("/") or any(mark in token for mark in ("<", ">", "*")):
                continue
            if not (
                token.startswith("META_")
                or token in {"MOS_VERSION.md", "README.md", "AI_META_SYSTEM_README.md"}
                or token.startswith("meta_system/")
                or token.startswith("docs/")
                or token.startswith("bootstrap/")
            ):
                continue

            if not (
                "/" in token
                or token.startswith("META_")
                or token.startswith("MOS_")
                or token.endswith((".md", ".json", ".sh", ".rules"))
            ):
                continue

            candidates = []
            repo_candidate = (repo / token).resolve()
            local_candidate = (path.parent / token).resolve()
            meta_candidate = (repo / "meta_system" / token).resolve()

            try:
                candidates.append(str(repo_candidate.relative_to(repo)))
            except ValueError:
                pass
            try:
                candidates.append(str(local_candidate.relative_to(repo)))
            except ValueError:
                pass
            try:
                candidates.append(str(meta_candidate.relative_to(repo)))
            except ValueError:
                pass

            if not any(candidate in existing for candidate in candidates):
                issues.append(f"{rel}: references missing file {token}")

current_status = (repo / "meta_system" / "context" / "CURRENT_STATUS.md").read_text()
release_notes = (repo / "META_RELEASE_NOTES.md").read_text()
where_left_off = (repo / "META_WHERE_LEFT_OFF.md").read_text()

if "Latest known passing validation: not yet established" in current_status:
    suspicious = (
        "production-ready",
        "fully verified",
        "release ready",
        "works end-to-end",
    )
    for label, text in (
        ("META_RELEASE_NOTES.md", release_notes),
        ("META_WHERE_LEFT_OFF.md", where_left_off),
    ):
        lowered = text.lower()
        for phrase in suspicious:
            if phrase in lowered:
                issues.append(f"{label}: high-confidence claim without recorded passing validation")
                break

if issues:
    print("meta_hallucination_risk_detected")
    for item in issues:
        print(f"- {item}")
    raise SystemExit(1)

print("meta_hallucination_risk_low")
PY
