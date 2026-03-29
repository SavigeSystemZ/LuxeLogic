# AI Debug & Repair Playbook

Use this whenever something fails or regresses.

## Fix output format (always)
- Root cause (1–3 sentences)
- Fix summary
- Files changed
- Verification commands
- Risk + rollback note
- Checkpoint status (PCP done? yes/no)

## 1) Triage (classify)
- Build/import error
- Runtime crash/exception
- Wrong output / logic bug
- UI layout/rendering regression
- Performance regression
- Flaky/nondeterminism
- Environment mismatch (deps/OS/permissions)

## 2) Reproduce (deterministic)
- Exact command(s), inputs, expected vs actual
- Logs + stack traces
- UI: steps + screenshot + window size

Rule: no fix without repro OR a stated reason repro isn’t possible.

## 3) Localize
- Reduce to smallest failing surface
- Identify last known-good commit/tag
- Use bisect when appropriate
- Add temporary instrumentation behind a debug flag

## 4) Hypothesis → experiment loop
- Minimal change
- Smallest verification first
- Expand verification outward only after local pass

## 5) Fix rules
- Smallest correct fix > broad refactor
- If refactor is required: split steps
  - (A) refactor-only, no behavior change + tests
  - (B) behavior change + tests
- Add/update tests to prevent recurrence
- Remove temporary instrumentation (or convert to structured logging)

## 6) Verification ladder
1) unit/lint/typecheck
2) feature test
3) app smoke test
4) perf sanity check (if relevant)

## 7) Finish
- Run a Phase Checkpoint if you completed a Phase or landed a critical fix.

## 8) Environment / tooling (quick fixes)
- **Mypy:** “No such file or directory … .mypy_cache/…” → stale cache. From repo root: `rm -rf .mypy_cache`; re-run mypy.
- **Cursor keyring / MCP “fetch failed”:** See **docs/ENVIRONMENT_AND_MCP_MODEL.md** (bootstrap checklist) and **docs/KDE_KEYRING_AND_ENVIRONMENT.md** (password-store, argv.json).
