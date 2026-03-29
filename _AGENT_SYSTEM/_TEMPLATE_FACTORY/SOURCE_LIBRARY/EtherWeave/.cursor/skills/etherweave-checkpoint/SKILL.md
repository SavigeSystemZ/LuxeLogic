---
name: etherweave-checkpoint
description: Runs Etherweave phase checkpoint protocol. Verify with tools/verify.sh, commit, backup, update WORKLOG and CONTEXT_PACK. Use when user says checkpoint, end of phase, or after a major UX change or refactor.
---

# Etherweave Checkpoint

## When to Use

- **Major UX layout or workflow change** has landed
- **Major refactor** has landed
- **Tests/fitness checks pass** for a milestone
- User says **"checkpoint"** or **"end of phase"**

## Protocol (from docs/PHASE_CHECKPOINT_PROTOCOL.md)

### 1. Preflight
- Confirm phase/milestone scope is completed
- Review `git status`; ensure changes are intentional

### 2. Verify
- Run **`tools/verify.sh`** (local gates: import/fitness, lightweight secrets scan)
- If verification fails: follow **docs/DEBUG_REPAIR_PLAYBOOK.md**; do not mark phase complete until resolved or recorded in docs/KNOWN_ISSUES.md

### 3. Commit
- Stage only intended changes
- Use conventional commit message (e.g. `feat(gui): ...`, `fix(lib): ...`)
- Commit should be cohesive and self-contained

### 4. Push/Sync
- Push branch to origin
- If network/credentials unavailable: record in WORKLOG and create local bundle snapshot

### 5. Protected snapshot (single backup only)
- Maintain at most one manual app backup. Run `./backup_project.sh` from repo root when a snapshot is needed; it keeps only the most recent backup (older ones removed). Do not create or retain multiple backup copies.
- **Stop**: Do not snapshot secrets/credentials

### 6. Context pack
- Update **docs/CONTEXT_PACK.md**: shipped items, decisions, verification commands, known issues, next steps

### 7. Session log
- Append checkpoint summary to session log (e.g. `logs/cursor/` or `logs/codex/`)

## Stop Conditions

- Do **not** mark phase complete if verification fails
- Do **not** include secrets/credentials in backups or logs

## Minimal Checkpoint (no scripts)

If `tools/verify.sh` or `scripts/checkpoint_phase.sh` are missing:

1. Run any available checks (e.g. `python tools/fitness_check.py`, lint, tests)
2. Update WORKLOG.md (what/why/validate/rollback/next)
3. Update docs/CONTEXT_PACK.md or equivalent
4. One backup only: use `./backup_project.sh` (maintains single copy); document in WORKLOG

## Reference

- Full protocol: **docs/PHASE_CHECKPOINT_PROTOCOL.md**
- Debug on failure: **docs/DEBUG_REPAIR_PLAYBOOK.md**
- Agent load order and checkpoint trigger: **AGENTS.md**
