# Architecture

## Core Modules
- `src/data`: fetching, caching, validation
- `src/strategies`: signal generation
- `src/backtest`: vectorized backtesting + walk-forward
- `src/portfolio`: portfolio sizing + backtest
- `src/execution`: execution simulator
- `src/monitoring`: drift checks
- `src/risk`: risk reports
- `src/optimization`: parameter sweep

## Data Flow
1. Fetch/cache -> validate
2. Generate signals
3. Backtest (single or portfolio)
4. Report metrics + risk
5. Drift/regression checks
