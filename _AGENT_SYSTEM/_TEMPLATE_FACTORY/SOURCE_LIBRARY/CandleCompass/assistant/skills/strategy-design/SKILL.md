---
name: strategy-design
description: Design or update trading strategy logic in Candle Compass, including signal rules, regime filters, and execution-ready outputs. Use when creating new strategies, refactoring signal generation, or adjusting strategy parameters and evaluation hooks.
---

# Strategy Design

## Workflow
1. Define objective (trend, mean reversion, stat-arb, regime-aware, hybrid).
2. Specify entry, exit, invalidation, and sizing rules explicitly.
3. Implement strategy logic under `app/src/strategies/` or orchestrator routing when multi-strategy.
4. For orchestrator-managed decisions, keep `execution_style` directives (`SMASH`/`ACCUMULATE`/`SCALP`) and recorder payload fields consistent.
5. Wire script execution paths under `app/scripts/` as needed.
6. Add test coverage for core signal transitions.
7. Validate performance through backtest/walk-forward scripts.

## Validation
- `python scripts/run_backtest.py`
- `python scripts/run_orchestrator.py`
- `python -m pytest -q tests/test_regime_logic_gate.py tests/test_orchestrator.py`

## Output Checklist
- Strategy rules are explicit and reproducible.
- Parameters and assumptions are documented in code or script help.
- Signal behavior is covered by tests.
