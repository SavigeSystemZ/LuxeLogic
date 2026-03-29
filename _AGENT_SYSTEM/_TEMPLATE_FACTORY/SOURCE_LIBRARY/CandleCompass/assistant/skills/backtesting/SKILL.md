---
name: backtesting
description: Design, implement, or refactor backtest engines and evaluation flows for Candle Compass. Use when changing vectorized or walk-forward logic, cost/slippage modeling, equity/position accounting, or performance-metric reporting.
---

# Backtesting

## Workflow
1. Select engine path (`app/src/backtest/vectorized.py`, `app/src/backtest/walkforward.py`, or portfolio backtest modules).
2. Confirm transaction cost, slippage, and fill assumptions.
3. Implement signal-to-position and PnL accounting changes.
4. Ensure metrics include Sharpe, Sortino, drawdown, and CAGR where applicable.
5. Update script entry points under `app/scripts/` when interfaces change.
6. Add/update tests in `tests/`.

## Validation
- `python scripts/run_backtest.py`
- `python scripts/walk_forward_anchored.py`
- `python -m pytest -q tests/test_backtest_smoke.py tests/test_walkforward_anchored.py`

## Output Checklist
- Backtest outputs are reproducible.
- Cost and slippage assumptions are explicit.
- Metrics and artifacts are stable for downstream consumers.
