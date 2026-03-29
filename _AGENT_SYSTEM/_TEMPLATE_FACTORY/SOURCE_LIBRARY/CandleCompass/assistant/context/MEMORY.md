# Memory

## Project Goals
- Build a world-class crypto trading research platform.
- Emphasize reproducibility, validation, and risk management.

## Current Baseline
- RSI + trend strategy.
- Vectorized backtester.
- Portfolio backtester with vol targeting.
- Walk-forward and parameter sweep utilities.
- Order-book ingestion and execution simulator (research-only).
- Asset universe config with multi-provider (yfinance/ccxt) OHLCV fetch.
- Drift detection and regression checks.
- Walk-forward parameter selection per window.
- CI workflow for tests.
- Risk report generation.
- Tag-based exposure analytics for portfolios via asset universe tags.
- Risk metric baselines with regression checks in CI.
- UI risk tolerance profiles (client-side thresholds).
- Advisory pipeline (technical/fundamental/scanner) with research-only dashboard output.
- Confluence engine blends advisory signals (technical/fundamental/scanner/context).
- UI console includes navigation bar, view filters, and watchlist management.

## Constraints
- Research/backtesting only (no live trading).
- All data ingestion must be cached and validated.
