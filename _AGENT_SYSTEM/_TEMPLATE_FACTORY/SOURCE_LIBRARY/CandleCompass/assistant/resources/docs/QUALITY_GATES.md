# Quality Gates

Use these checks to keep Candle Compass outputs reliable and reproducible.

## Data
- Validate inputs when fetching or loading data (`scripts/validate_data.py`).
- Use cached fixtures for CI/regression (`data/fixtures`).
- Run `python scripts/data_health_check.py --config asset_universe.yaml --cache-only`.

## Backtests
- Ensure transaction costs and slippage are applied.
- Track Sharpe, Sortino, CAGR, Max Drawdown.
- Update baselines only after intentional changes (`scripts/update_baseline.py`).

## Risk
- Run `python scripts/risk_report.py --returns runs/latest/returns.parquet`.
- Run `python scripts/risk_regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --positions runs/latest/positions.parquet --key single_asset`.

## Advisory
- Keep advisory outputs consistent with `assistant/resources/docs/UI_DATA_CONTRACT.md`.
- Add tests for new advisory signals or schema fields.

## UI
- Refresh bundle: `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online`.
- Validate artifacts: `python scripts/ui_health_check.py --runs runs/latest --strict`.
- Optional smoke test: `python scripts/ui_smoke_test.py --runs runs/latest --strict`.

## Memory
- Re-ingest after major context changes: `python scripts/memory_tool.py ingest --replace`.
- Never store secrets in memory.

## Blueprint Milestone Gates (UIA Expansion Plan)

Reference:
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`

For UIA milestones (M1-M11), each implementation PR/session must include:
- milestone id (`M#`) and scope summary
- explicit done criteria
- validation commands executed
- manual verification notes (if UI/ops work is involved)
- rollback notes (what to revert/disable if regression appears)

### UI-Focused Milestones (M1, M2, M6, M8)
- Run frontend lint/build for touched UI code.
- Add/Update UI tests where logic/state changes are introduced.
- Perform manual console-error check during interaction flows (drag/resize/modal/widget settings).
- Capture layout/data contract compatibility notes when widget payload shapes change.

### Backend/Strategy Milestones (M3, M5, M7, M9)
- Provide deterministic tests for strategy/backtest/risk logic.
- Document benchmark expectations and measured results where performance is a deliverable.
- Validate failure/degraded paths (missing provider/API, timeout, bad inputs).
- Update API contracts/docs when request/response shapes change.

### Security/Compliance Milestones (M10)
- Run static scans (`bandit`, `npm audit` or approved equivalents) where applicable.
- Verify no secrets are hard-coded.
- Validate auth/rate-limit behavior and audit logging for sensitive endpoints.

### Documentation/Onboarding Milestones (M11)
- Test the documented setup flow on a clean environment (or record exact assumptions if not possible).
- Ensure docs reference the current installer/runtime paths and not legacy RSIGlobe names.

## Evidence & Rollback Expectations

- Tag or note the pre-change commit hash before high-risk milestones.
- Prefer feature flags or reversible config toggles for partial rollouts.
- If validation cannot be completed in-session, record:
  - what was validated,
  - what remains unverified,
  - exact commands/steps required to finish verification.

## Single-Developer Safeguards (UIA Addendum)

Reference:
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT_ADDENDUM.md`

### Pre-Commit / Pre-Push Expectations
- Use local hooks (or equivalent scripts) to run at least:
  - lint on touched surfaces,
  - targeted tests for changed modules,
  - basic secret/credential grep guard,
  - branch guard checks (block direct commits/pushes to `backup`; warn/require confirmation for `design/tools` when runtime files are included).
- If hooks are not yet installed, record that gap in `assistant/TODO.md` and run the checks manually before commit.

### Branch Safety (Solo Workflow)
- Runtime product code should be developed on `main`.
- `backup` branch should only be updated by documented backup/sync workflows.
- `design/tools` branch should contain prompts/templates/docs/architectures, not runtime code.
- PR/session notes should mention if a change is intended for runtime (`app/`) or design-system (`assistant/`) surfaces.

### Tool Usage Logging
- For milestone work that uses AI coding tools, record:
  - tool name,
  - prompt pack/version,
  - notable constraints or tool-specific issues,
  - validation performed.
- This can be logged in session notes until a dedicated log template is implemented.

### Addendum Milestones (M12-M16)
- Navigation/theme/onboarding milestones require explicit accessibility checks (keyboard navigation, ARIA labels, contrast verification).
- Theme/background upload work requires input validation and safe storage path review.
- Branch-management milestones require dry-run or proof of branch guard behavior before considered done.
- Prompt-pack parity milestones should run `python app/scripts/validate_prompt_packs.py` and update the context index if a new prompt pack is added.
