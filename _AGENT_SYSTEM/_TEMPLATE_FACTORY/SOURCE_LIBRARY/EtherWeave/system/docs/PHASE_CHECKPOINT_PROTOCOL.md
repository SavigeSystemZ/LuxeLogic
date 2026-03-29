# Phase Checkpoint Protocol (PCP)

Run at end of every Phase (and optionally at major Steps).

## Goals
- Prevent loss of work
- Keep changes reviewable and reversible
- Ensure each phase ends verified
- Produce protected snapshot with hashes

## Required Steps
1) Preflight
   - Confirm Phase scope completed
   - Review `git status`; changes are intentional

2) Verify
   - Run `tools/verify.sh` (local gates)
   - If failing: stop → Debug/Repair Playbook

3) Commit (atomic + readable)
   - Stage only intended changes
   - Conventional Commit message
   - Commit is cohesive and self-contained

4) Push/Sync
   - Push branch to origin
   - If network/credentials unavailable: record in WORKLOG and keep bundle snapshot

5) Protected Snapshot Backup (single copy only)
   - Maintain at most one manual app backup. Run `./backup_project.sh` from repo root when a snapshot is needed; backup is stored at **`$HOME/.BackupZ-MyAppZ/EtherWeave.bak/`**; the script keeps only the most recent backup (older ones are removed). Do not create or retain multiple backup copies.
   - Optional: `scripts/checkpoint_phase.sh "<milestone>" "<phase>"` if present; output under `$HOME/.BackupZ-MyAppZ/EtherWeave.bak/checkpoints/`. Do not create more than one checkpoint snapshot per phase.

6) Context Pack
   - Update `docs/CONTEXT_PACK.md` (template-driven):
     shipped items, decisions, verification commands, known issues, next steps

## Stop conditions
- Do not mark Phase complete if verification fails.
- Do not snapshot secrets/credentials.
