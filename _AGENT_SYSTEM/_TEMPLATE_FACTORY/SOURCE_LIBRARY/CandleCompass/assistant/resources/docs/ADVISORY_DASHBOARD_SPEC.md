# Advisory Dashboard Spec (Research-Only)

## Objective
Build a multi-asset advisory dashboard that synthesizes technical signals, fundamental context, and AI-style scanning to produce transparent, research-only insights (no trade execution). The system should explain why a signal exists, quantify confidence, and remain auditable.

## Principles
- Research-only: no live trading, no auto-execution, no "buy/sell" commands.
- Evidence-first: every output ties to inputs and shows reasoning.
- Risk-aware: user-selectable risk profile scales confidence and UI highlight thresholds.
- Data-quality gates: surface stale/low-coverage inputs instead of pretending certainty.
- Modular: plug in new scanners/sentiment sources without rewriting the core.

## Feature Mapping (External Inspiration)
- StocksToTrade Oracle Scanner: high-velocity scanning for high risk/reward setups.
- StocksToTrade Alpha Scanner: anomaly detection ("dark" price action) and abnormal prints.
- StocksToTrade IRIS Analytics: multi-day forecast of outsized moves.
- StockOracle: intrinsic value, color-coded health, moat analysis, AI insights.
- Trading Oracle (TBD): confirm the exact product and expected features.

## Data Model (Research-Only)
Core assets live in `src/advisory/core_models.py`.

- Asset
  - symbol, asset_type, price, tags
  - technical_data, fundamental_data, scanner_data, recommendation
- TechnicalSnapshot
  - signals (name/strength/type)
  - indicators (RSI, Bollinger, VWAP, support/resistance)
  - library_signals (MA crossover, breakouts, momentum library)
- FundamentalSnapshot (stocks only)
  - health_snapshot (Green/Yellow/Red + red flags)
  - valuation (intrinsic value + discount/premium)
  - moat_analysis (rating + insights)
- ScannerSnapshot
  - scan_alerts
  - forecast (potential_move, timeframe, confidence)
  - risk_metrics (risk_reward_ratio)
- AdvisoryRecommendation
  - action (BULLISH/BEARISH/NEUTRAL)
  - confidence (0-1)
  - reasoning list
  - primary_source

## Engines
- TechnicalSignalEngine
  - RSI, Bollinger, VWAP, support/resistance (expandable)
  - Outputs signal list + indicator snapshot
- FundamentalAnalysisEngine
  - Stock-only via yfinance
  - Scores profitability, leverage, ROE, revenue growth
  - Intrinsic value proxy (target mean/median price as placeholder)
- AIScannerEngine
  - Momentum + volume anomaly scan
  - Forecasts potential move and confidence
  - Computes risk/reward ratio (momentum vs volatility)
- UnifiedRecommendationEngine
  - Requires 2+ aligned strong signals for BULLISH/BEARISH
  - Conflicts => NEUTRAL with reasoning
  - Confidence scaled by risk profile

## UI/UX
- Top controls: asset focus, add symbol, run analysis
- Advisory cards show: price, action, confidence, technical/fundamental/scanner blocks
- Confluence block blends technical/fundamental/scanner/context into a single score
- Data quality block surfaces coverage %, data age, and warnings
- Global data freshness banner summarizes overall advisory health
- Market context block: regime + momentum + volatility + sentiment proxy (price-derived)
- Regime confidence and confluence decay use data age to down-weight stale signals
- Market regime overview aggregates regimes across the active universe
- External sentiment sources: Alternative.me Fear & Greed (crypto) + Alpha Vantage news sentiment (stocks, API key)
- DEX data source: Uniswap v3 subgraph via The Graph (requires THEGRAPH_API_KEY stored via secrets tool)
- Research aggregation: SEC EDGAR filings (requires SEC_USER_AGENT) + Alpha Vantage news
- Data source auto-mode: equities via yfinance, crypto via multi-exchange CCXT aggregate
- UI panels: Top Crypto, Top Stocks, Research Feed, Exchange Stats
- Watchlist panel allows remove/clear and uses advisory data when available
- AI Scanner Results: top opportunities ranked by confidence
- Risk profile selector: stored in localStorage and used in UI highlighting
- Clear disclaimers on research-only and no trade execution
- Module navigation bar provides anchor links and view filtering

## Operational Workflow
1. `scripts/run_advisory.py` pulls assets from `asset_universe.yaml`.
2. OHLCV fetched via `yfinance` (stocks) or `ccxt` (crypto).
3. Engines populate snapshots and recommendations.
4. JSON output -> `runs/latest/advisory_dashboard.json` for UI.

## Extension Path (Next Iterations)
- News + sentiment ingestion (aggregate-only, no advice).
- Market regime detector (bull/bear/sideways) per asset and overall.
- Confluence signal decay + time weighting.
- Signal library expansion with multi-indicator templates.
- Portfolio scenario stress tests and drawdown projections.
- "Top traders" analytics (public data only, no copy-trading execution).

## Compliance and Safety
- Always label outputs as research-only.
- Avoid personalized investment advice.
- Keep all data sources cached and versioned.
- Log inputs/outputs for auditability.
