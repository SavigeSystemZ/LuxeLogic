# Verify Before Push

Run verification and (if available) secrets scan before push or checkpoint.

**Do this now:**
1. Run `tools/verify.sh` (import/fitness gates, lightweight secrets scan). If the script is missing, run whatever exists: e.g. `python tools/fitness_check.py`, lint, or tests.
2. Report the exact command output. If verification fails, do not push; follow `docs/DEBUG_REPAIR_PLAYBOOK.md` and suggest fixes.
3. If verification passes, state that it is safe to push or proceed to checkpoint.

Use **etherweave-verify-gate** skill for full procedure. Reference: AGENTS.md (Verification Gates), `docs/PHASE_CHECKPOINT_PROTOCOL.md`.
