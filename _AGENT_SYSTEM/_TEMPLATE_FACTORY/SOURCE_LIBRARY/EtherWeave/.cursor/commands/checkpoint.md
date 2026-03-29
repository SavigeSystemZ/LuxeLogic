# Run Phase Checkpoint

Run the Etherweave phase checkpoint protocol.

**Do this now:**
1. **Preflight** — Confirm phase/milestone scope is completed. Review `git status`; ensure changes are intentional.
2. **Verify** — Run `tools/verify.sh`. If it fails, follow `docs/DEBUG_REPAIR_PLAYBOOK.md`; do not mark phase complete until resolved or recorded in `docs/KNOWN_ISSUES.md`.
3. **Commit** — Stage only intended changes. Use conventional commit (e.g. `feat(gui): ...`, `fix(lib): ...`). Commit should be cohesive and self-contained.
4. **Push/Sync** — Push branch to origin. If unavailable, record in WORKLOG and create local bundle snapshot.
5. **Protected snapshot** — If `scripts/checkpoint_phase.sh` exists, run it with milestone and phase; do not snapshot secrets.
6. **Context pack** — Update `docs/CONTEXT_PACK.md`: shipped items, decisions, verification commands, known issues, next steps.
7. **Session log** — Append checkpoint summary to `logs/cursor/` or `logs/codex/`.

Do not mark phase complete if verification fails. Reference: `docs/PHASE_CHECKPOINT_PROTOCOL.md`, **etherweave-checkpoint** skill.
