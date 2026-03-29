# Candle Compass System Overview

## Purpose
Candle Compass is a research-only, multi-asset R&D environment for crypto and equities. It emphasizes reproducibility, data integrity, and transparent advisory outputs.

## Repo Segregation
- Runtime application lives under `app/`.
- Assistant behavior, prompts, rules, and context live under `assistant/`.
- Root-level `scripts/`, `src/`, `ui/`, `ui-next/`, `data/`, and configs are symlinks to `app/` for convenience.

## Core Layers
- Data ingestion and caching: `src/data` + `asset_universe.yaml`
- Tick-level order flow (optional): `src/data/trade_stream.py`, `src/data/orderflow.py` (ccxt.pro required)
  - Includes CVD, VPIN toxicity, and liquidity void scanning (DOM gaps).
- Multi-source trade stream failover: `src/data/multi_source_stream.py`
- Regime + pairs analytics: `src/analysis/regime_hmm.py`, `src/analysis/pairs_trading.py`
- NLP alpha bridge (local LLM): `src/advisory/nlp_alpha.py`
- Strategy orchestration (regime + VPIN): `src/execution/orchestrator.py`
- Signal gatekeeper (regime + VPIN + DXY): `src/execution/signal_gatekeeper.py`
- Smart execution planning (TWAP/VWAP/Iceberg, slippage optimizer): `src/execution/smart_execution.py`
- Performance analytics: `src/analysis/performance_analytics.py`
- Monte Carlo stress testing: `src/analysis/monte_carlo.py`
- Walk-forward validation: `src/backtest/walkforward.py`
- Cross-asset intelligence: `src/analysis/cross_asset.py`, `src/analysis/econ_calendar.py`
- Strategy and backtest engines: `src/strategies`, `src/backtest`, `src/portfolio`
- Advisory engines: `src/advisory` (technical, fundamental, scanner, context, confluence)
- Risk and monitoring: `src/risk`, `src/monitoring`
- UI console: `ui/` powered by `runs/latest` artifacts
- Web-first command center (Next.js): `ui-next/` (Tailwind + Framer Motion)
- Memory system: `scripts/memory_tool.py`, `scripts/memory_server.py`
- Security hardening: `src/security/secrets.py`, `src/security/ip_whitelist.py`
- Security config: `config.yaml` (`security.emergency_exchanges`, `security.live_trading`)
- Scanner defaults: MarketScanner uses `ccxt` exchanges (Coinbase/Kraken/Bitstamp/Kucoin) by default to avoid Binance 451 in restricted regions; override via `config.yaml` `scanner.crypto_source`.

## Primary Pipelines
1. Fetch/cache OHLCV via provider (yfinance/ccxt/uniswap).
2. Run advisory pipeline -> `runs/latest/advisory_dashboard.json`.
3. Run backtests -> `runs/latest/returns.parquet`, `runs/latest/equity.parquet`.
4. Generate dashboards/reports -> `runs/latest/*_dashboard.json`.
5. UI renders data from `runs/latest`.

## Key Artifacts (runs/latest)
- Advisory: `advisory_dashboard.json`
- Research dashboard: `research_dashboard.json`
- Risk dashboard: `risk_dashboard.json`
- Ranked list: `ranked_list.json`
- Ranked lists (by asset class): `ranked_list_crypto.json`, `ranked_list_stocks.json`
- Top lists: `top_lists.json`
- Research feed: `research_feed.json`
- Exchange stats: `exchange_stats.json`
- Derivatives/flow: `derivatives_dashboard.json`, `flow_dashboard.json`
- Scorecards: `scorecards.json`
- Alerts: `alerts.json`
- Optimizer/stress test: `optimizer.json`, `stress_test.json`
- App settings: `app_settings.json`
- HMM regime output: `market_regime_hmm.json`
- Regime confidence: `regime_confidence.json`
- Sentiment velocity: `sentiment_velocity.json`
- Pairs trading signal: `pairs_trade.json`
- Strategy orchestrator: `strategy_orchestrator.json`
- Execution plan: `execution_plan.json`
- Logic gate override: `logic_gate_override.json`
- Alpha report: `alpha_report.md`
- Trade heatmap: `trade_heatmap.json`
- Adverse excursion summary: `adverse_excursions.json`
- Post-mortem tags: `post_mortem_summary.json`
- Trade tags: `trade_tags.json`
- Monte Carlo guardrail: `monte_carlo.json`
- Anchored walk-forward: `walk_forward_anchored/walk_forward_anchored.parquet`
- Cross-asset intelligence: `cross_asset_intel.json`
- Economic calendar: `economic_calendar.json`
- Latency status: `latency_status.json`
- Health check: `health_check.json`
- Security lock: `security_lock.json`
- Kill switch: `kill_switch.json`
- Plots: `plots/*.png`

## Quality Gates
- Use offline fixtures for CI and regression checks.
- Update UI data contract docs when schemas change.
- Run `python scripts/ui_health_check.py --runs runs/latest` after bundle refreshes.

## Operational Scripts
- `scripts/run_ui_bundle.py` for full refresh
- `scripts/run_advisory.py` for advisory only
- `scripts/ui_health_check.py` for artifact validation
- `scripts/run_orderflow.py` for tick-level CVD + absorption alerts
- `scripts/regime_hmm.py` for HMM regime classification
- `scripts/nlp_alpha_bridge.py` for local-LLM sentiment velocity
- `scripts/pairs_trade.py` for BTC/ETH z-score signals
- `scripts/run_orchestrator.py` for regime/VPIN logic gating
- `cd ui-next && npm run dev` for the web-first command center
- `scripts/alpha_report.py` for daily alpha reporting + trade heatmap
- `scripts/cross_asset_intel.py` for macro correlation + economic gatekeeper
- `scripts/monte_carlo.py` for Monte Carlo fragility screening
- `scripts/walk_forward_anchored.py` for anchored walk-forward validation
- `scripts/health_check.py` for periodic API/disk health checks
- `scripts/smart_execute.py` for TWAP/VWAP/Iceberg execution planning
- `scripts/secrets_tool.py` for encrypted secrets management
- `scripts/ip_whitelist_check.py` for public IP allowlist validation
- `scripts/kill_switch.py` for emergency trading lock + cancel/close routines
