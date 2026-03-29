---
name: risk-management
description: Design or modify Candle Compass risk controls, exposure checks, and guardrail reporting. Use when changing position sizing constraints, drawdown/exposure logic, regression baselines, or risk dashboard outputs.
---

# Risk Management

## Workflow
1. Identify risk layer (`app/src/risk/`, execution gatekeeping, or reporting scripts).
2. Define or update hard limits (per-trade, portfolio, drawdown, concentration).
3. Keep RiskGuardian and execution gate behavior synchronized with strategy/orchestrator outputs.
4. Keep sizing and exposure logic consistent across strategy and execution paths.
5. Update report/dashboard generators under `app/scripts/`.
6. Update baselines in `assistant/context/risk_baselines.json` when expected behavior changes.
7. Add/update tests for violations and guard behavior.

## Validation
- `python scripts/risk_report.py`
- `python scripts/risk_dashboard.py`
- `python -m pytest -q tests/test_risk_guardian.py tests/test_orchestrator.py tests/test_risk_report.py tests/test_risk_regression.py`

## Output Checklist
- Risk limits are explicit and test-covered.
- Report outputs remain compatible with UI consumers.
- Regression baselines reflect intentional changes.
