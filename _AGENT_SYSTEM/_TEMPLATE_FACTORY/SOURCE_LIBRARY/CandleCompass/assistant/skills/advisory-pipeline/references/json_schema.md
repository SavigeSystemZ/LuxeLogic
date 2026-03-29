# Advisory JSON Structure (runs/latest/advisory_dashboard.json)

## Top Level
- `generated_at` (ISO timestamp)
- `risk_profile`
- `analysis_window` { `start`, `end`, `interval` }
- `confluence_summary` { `avg_score`, `avg_strength`, `bias_counts`, `alignment_counts` }
- `market_context_summary` { `overall_regime`, `regime_counts`, `avg_momentum`, `avg_volatility`, `avg_sentiment`, `avg_trend_strength` }
- `assets` (list)
- `scanner_top` (list)
- `disclaimer`

## Asset Entry
- `symbol`, `asset_type`, `price`, `tags`
- `technical` (signals + indicator snapshot)
- `fundamental` (health, valuation, moat)
- `scanner` (alerts, forecast, risk metrics)
- `confluence` (score, bias, alignment, strength, contributors)
- `context` (regime, momentum, volatility, sentiment, external)
- `data_quality` (coverage, age, status)
- `research` (SEC/Alpha Vantage items)
- `recommendation` (action, confidence, reasoning, primary_source)
