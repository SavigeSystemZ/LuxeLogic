#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SCAN_ROOT="$(cd -- "${SCRIPT_DIR}/../../.." && pwd)"
OUTPUT_DIR="${SCRIPT_DIR}/GOLDEN_EXAMPLES"

usage() {
  cat <<'EOF'
Usage: refresh-golden-examples.sh [--scan-root <path>] [--output-dir <path>]

Scan sibling repos under ~/.MyAppZ, score their maturity signals, and rebuild the
factory-only golden-example repo scorecard.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scan-root)
      SCAN_ROOT="${2:-}"
      shift 2
      ;;
    --output-dir)
      OUTPUT_DIR="${2:-}"
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

mkdir -p "${OUTPUT_DIR}"

python3 - <<'PY' "${SCAN_ROOT}" "${OUTPUT_DIR}"
from __future__ import annotations

import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path

scan_root = Path(sys.argv[1]).resolve()
output_dir = Path(sys.argv[2]).resolve()

excluded_repos = {
    "_AI_AGENT_SYSTEM_TEMPLATE",
    "_AI_AGENT_SYSTEM_TESTS",
    "_backups",
    "containers",
    "runs",
}

prune_dir_names = {
    ".git",
    ".next",
    ".pytest_cache",
    ".ruff_cache",
    ".mypy_cache",
    ".venv",
    "__pycache__",
    "backups",
    "build",
    "coverage",
    "dist",
    "dist-electron",
    "htmlcov",
    "logs",
    "node_modules",
    "release",
    "target",
    "venv",
    "_AI_AGENT_SYSTEM_TEMPLATE",
}

context_files = [
    "AGENTS.md",
    "CLAUDE.md",
    "CODEX.md",
    "GEMINI.md",
    "PRODUCT_BRIEF.md",
    "TODO.md",
    "WHERE_LEFT_OFF.md",
    "_system/PROJECT_PROFILE.md",
    "_system/CONTEXT_INDEX.md",
]

evidence_files = [
    "ARCHITECTURE_NOTES.md",
    "CHANGELOG.md",
    "DESIGN_NOTES.md",
    "README.md",
    "RELEASE_NOTES.md",
    "RISK_REGISTER.md",
    "TEST_STRATEGY.md",
]

runtime_surface_names = {
    "ai",
    "app",
    "apps",
    "client",
    "electron",
    "mobile",
    "packages",
    "server",
    "src",
}

packaging_indicators = [
    "docker",
    "ops",
    "packaging",
    "mobile",
    "ai",
    "electron-builder.yml",
    "docker-compose.yml",
    ".github/workflows",
]

doc_dir_names = {"architecture", "assistant", "context", "contexts", "design", "docs", "managed_context", "_system"}
test_dir_names = {"test", "tests", "__tests__"}
system_surface_names = {".cursor", "_system", "bootstrap"}


def count_files(repo: Path) -> int:
    total = 0
    for root, dirs, files in os.walk(repo):
        dirs[:] = [name for name in dirs if name not in prune_dir_names]
        total += len(files)
    return total


def count_named_dirs(repo: Path, names: set[str]) -> int:
    total = 0
    for root, dirs, _ in os.walk(repo):
        dirs[:] = [name for name in dirs if name not in prune_dir_names]
        total += sum(1 for name in dirs if name in names)
    return total


def profile_completion(repo: Path) -> tuple[int, int]:
    path = repo / "_system" / "PROJECT_PROFILE.md"
    if not path.exists():
        return (0, 0)
    checked = 0
    total = 0
    for line in path.read_text().splitlines():
        stripped = line.strip()
        if stripped.startswith("- [x]"):
            checked += 1
            total += 1
        elif stripped.startswith("- [ ]"):
            total += 1
    return (checked, total)


def present_count(repo: Path, rel_paths: list[str]) -> int:
    return sum(1 for rel in rel_paths if (repo / rel).exists())


def signal_tags(metrics: dict[str, float | int]) -> list[str]:
    tags: list[str] = []
    if metrics["context_hits"] >= 7:
        tags.append("strong-context")
    if metrics["profile_completion_ratio"] >= 0.7:
        tags.append("filled-profile")
    if metrics["test_dir_count"] >= 3:
        tags.append("deep-tests")
    if metrics["doc_dir_count"] >= 5:
        tags.append("docs-heavy")
    if metrics["packaging_surface_count"] >= 4:
        tags.append("packaging-ready")
    if metrics["runtime_surface_count"] >= 4:
        tags.append("multi-surface")
    if metrics["system_surface_count"] >= 3:
        tags.append("full-aiaast")
    return tags


def score(metrics: dict[str, float | int], is_git: bool) -> float:
    total = 0.0
    total += 12.0 if is_git else 0.0
    total += min(metrics["file_count"] / 40.0, 18.0)
    total += min(metrics["test_dir_count"] * 3.0, 12.0)
    total += metrics["context_hits"] * 3.0
    total += min(metrics["doc_dir_count"] * 2.0, 12.0)
    total += metrics["system_surface_count"] * 2.0
    total += metrics["runtime_surface_count"] * 1.5
    total += metrics["packaging_surface_count"] * 1.5
    total += metrics["profile_completion_ratio"] * 10.0
    total += metrics["evidence_file_count"] * 1.5
    return round(total, 1)


entries = []
for repo in sorted(scan_root.iterdir()):
    if not repo.is_dir() or repo.name in excluded_repos:
        continue

    checked, total = profile_completion(repo)
    metrics = {
        "file_count": count_files(repo),
        "test_dir_count": count_named_dirs(repo, test_dir_names),
        "doc_dir_count": count_named_dirs(repo, doc_dir_names),
        "context_hits": present_count(repo, context_files),
        "system_surface_count": sum(1 for name in system_surface_names if (repo / name).exists()),
        "runtime_surface_count": sum(1 for name in runtime_surface_names if (repo / name).exists()),
        "packaging_surface_count": sum(1 for rel in packaging_indicators if (repo / rel).exists()),
        "evidence_file_count": present_count(repo, evidence_files),
        "profile_checked": checked,
        "profile_total": total,
        "profile_completion_ratio": round((checked / total), 3) if total else 0.0,
    }
    is_git = (repo / ".git").exists()
    tags = signal_tags(metrics)
    entries.append(
        {
            "name": repo.name,
            "path": str(repo),
            "is_git": is_git,
            "score": score(metrics, is_git),
            "signals": tags,
            "metrics": metrics,
        }
    )

entries.sort(key=lambda item: (-item["score"], item["name"].lower()))

payload = {
    "schema_version": "1.0.0",
    "generated_at": datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z"),
    "scan_root": str(scan_root),
    "excluded_repos": sorted(excluded_repos),
    "repos": entries,
}

json_path = output_dir / "repo-scorecard.json"
json_path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

lines = [
    "# Golden Example Repo Scorecard",
    "",
    "Factory-only artifact. This scorecard helps maintainers decide which repos should inform the neutral golden-example pack.",
    "",
    f"- Generated at: `{payload['generated_at']}`",
    f"- Scan root: `{scan_root}`",
    f"- Repos scored: `{len(entries)}`",
    "",
    "## Scoring inputs",
    "",
    "- git presence",
    "- non-generated file count",
    "- test-directory count",
    "- context-file coverage",
    "- docs-directory count",
    "- installed AIAST surface coverage",
    "- runtime-surface breadth",
    "- packaging/install surface breadth",
    "- working-file evidence coverage",
    "- `_system/PROJECT_PROFILE.md` completion ratio when present",
    "",
    "## Ranked repos",
    "",
    "| Repo | Score | Files | Tests | Context | Profile | Signals |",
    "| --- | ---: | ---: | ---: | ---: | ---: | --- |",
]

for item in entries:
    metrics = item["metrics"]
    profile_pct = f"{round(metrics['profile_completion_ratio'] * 100):.0f}%"
    signals = ", ".join(item["signals"]) if item["signals"] else "emerging"
    lines.append(
        f"| {item['name']} | {item['score']:.1f} | {metrics['file_count']} | {metrics['test_dir_count']} | "
        f"{metrics['context_hits']} | {profile_pct} | {signals} |"
    )

lines.extend(
    [
        "",
        "## Reading rule",
        "",
        "A high score does not automatically make a repo the one golden source. Selection stays curated per pattern so one app does not become the accidental default for every future repo.",
    ]
)

markdown_path = output_dir / "REPO_SCORECARD.md"
markdown_path.write_text("\n".join(lines) + "\n")
print(f"Wrote {json_path}")
print(f"Wrote {markdown_path}")
PY
