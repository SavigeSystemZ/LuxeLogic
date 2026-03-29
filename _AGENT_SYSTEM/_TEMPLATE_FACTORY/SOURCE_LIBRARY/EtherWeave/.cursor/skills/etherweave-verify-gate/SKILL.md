---
name: etherweave-verify-gate
description: Runs verification and secrets scan before push or checkpoint. Use when the user is about to push, commit, or checkpoint; or when they ask to verify the repo.
---

# Etherweave Verify Gate

Before push or checkpoint, run verification. If it fails, do not push; follow docs/DEBUG_REPAIR_PLAYBOOK.md.

## Steps

1. **Verify** — Run `tools/verify.sh` (import/fitness gates, lightweight secrets scan). If the script is missing, run whatever exists: e.g. `python tools/fitness_check.py`, lint, tests.
2. **Secrets** — Ensure no commit of secrets; re-run or recommend a secrets scan if available.
3. **Result** — If pass: safe to push/checkpoint. If fail: report failures, suggest fixes, do not mark phase complete.

## When to apply

- User says "verify", "check before push", or "run verification".
- Before executing checkpoint (use with etherweave-checkpoint).
- After significant code changes before commit/push.

## Stop

Do not push or mark checkpoint complete if verification fails. Resolve or record in docs/KNOWN_ISSUES.md.

Reference: AGENTS.md (Verification Gates), docs/PHASE_CHECKPOINT_PROTOCOL.md, tools/verify.sh.
