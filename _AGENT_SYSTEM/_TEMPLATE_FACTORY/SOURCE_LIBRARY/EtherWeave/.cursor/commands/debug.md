# Debug / Repair

Follow the Etherweave Debug & Repair Playbook for the current failure or error.

**Do this now:**
1. **Triage** — Classify: build/import error, runtime crash, wrong output, UI regression, performance regression, flaky test, environment mismatch.
2. **Reproduce** — Exact command(s), inputs, expected vs actual. Logs and stack traces. No fix without repro or stated reason.
3. **Localize** — Smallest failing surface; last known-good commit if helpful; bisect if appropriate.
4. **Hypothesis → experiment** — Minimal change; smallest verification first.
5. **Fix** — Smallest correct fix. If refactor needed: (A) refactor-only + tests, then (B) behavior change + tests. Add/update tests to prevent recurrence.
6. **Output**: Root cause (1–3 sentences), fix summary, files changed, verification commands, risk + rollback, checkpoint status (PCP done? yes/no).

Do not mark done if verification fails. Reference: `docs/DEBUG_REPAIR_PLAYBOOK.md`, **etherweave-debug-playbook** skill.
