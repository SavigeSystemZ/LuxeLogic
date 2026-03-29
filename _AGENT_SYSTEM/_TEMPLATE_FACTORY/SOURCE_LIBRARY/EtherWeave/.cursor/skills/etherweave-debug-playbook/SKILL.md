---
name: etherweave-debug-playbook
description: Follows Etherweave DEBUG_REPAIR_PLAYBOOK for failures and regressions. Use when build or import fails, runtime crashes, wrong output, UI regression, test failure, or user reports a bug.
---

# Etherweave Debug Playbook

When something fails, follow **docs/DEBUG_REPAIR_PLAYBOOK.md**.

## Output format (required)

- **Root cause** — 1–3 sentences
- **Fix summary** — What was changed
- **Files changed** — List with rationale
- **Verification commands** — Exact commands and expected results
- **Risk + rollback** — How to revert
- **Checkpoint status** — PCP done? yes/no

## Steps

1. **Triage** — Build/import error, runtime crash, wrong output, UI regression, perf regression, flaky test, environment mismatch.
2. **Reproduce** — Exact command(s), inputs, expected vs actual. Logs and stack traces. No fix without repro or stated reason.
3. **Localize** — Smallest failing surface; last known-good; bisect if needed.
4. **Hypothesis → experiment** — Minimal change; verify locally first.
5. **Fix** — Smallest correct fix. If refactor: (A) refactor-only + tests, then (B) behavior change + tests. Add tests to prevent recurrence.
6. **Verification ladder** — Unit/lint/typecheck → feature test → integration. Do not skip.

## Stop

Do not mark done if verification fails. Record in docs/KNOWN_ISSUES.md or continue playbook until resolved.

Reference: docs/DEBUG_REPAIR_PLAYBOOK.md, docs/PHASE_CHECKPOINT_PROTOCOL.md.
