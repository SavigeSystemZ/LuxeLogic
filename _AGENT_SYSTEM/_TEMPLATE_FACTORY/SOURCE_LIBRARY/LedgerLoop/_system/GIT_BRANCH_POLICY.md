# Ledger Loop — Git Branch Policy for System Context Backups

**Purpose:** Keep AI/system context artifacts backed up in Git without impacting product delivery on `main`.

---

## Canonical backup branch

- Branch name: `backup/system-context`
- Base branch: `main`
- Intended use: backup snapshots of system/prompt/rules/context artifacts.

---

## Files intended for this branch

- `_system/**`
- `AGENT_CONTEXT.md`
- `TODO.md`
- `FIXME.md`
- `.cursorrules`
- `PROMPT_PACK_GEMINI.md`
- Other non-runtime coordination docs as needed.

Do not use this branch for feature/runtime code unless explicitly requested.

---

## Operational rules

1. Never merge `backup/system-context` into `main`.
2. Do not open PRs from `backup/system-context` targeting `main`.
3. If a specific doc change is needed on `main`, cherry-pick that commit intentionally.
4. Treat this branch as snapshot/backup history for coding-system artifacts.

---

## Command workflow

```bash
# 1) Start from up-to-date main
git switch main
git pull --ff-only origin main

# 2) Switch/create backup branch
git switch backup/system-context || git switch -c backup/system-context

# 3) Stage only system/context files
git add _system AGENT_CONTEXT.md TODO.md FIXME.md .cursorrules PROMPT_PACK_GEMINI.md

# 4) Commit + push backup snapshot
git commit -m "chore(system-backup): snapshot prompts/rules/context"
git push -u origin backup/system-context

# 5) Return to product branch
git switch main
```
