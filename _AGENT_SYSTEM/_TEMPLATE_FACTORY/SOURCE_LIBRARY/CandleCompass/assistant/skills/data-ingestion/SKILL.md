---
name: data-ingestion
description: Build or modify Candle Compass data acquisition, normalization, caching, and validation flows. Use when adding providers/exchanges, changing OHLCV/trade fetch logic, adjusting cache keys, or handling schema/timezone quality issues.
---

# Data Ingestion

## Workflow
1. Identify the source path in `app/src/data/` and target consumer artifacts.
2. Add or adjust provider adapters with explicit retry/backoff behavior.
3. Keep cache naming deterministic and provider-aware.
4. Normalize timestamps to UTC and enforce numeric dtype cleanup.
5. Validate schema expectations before writing artifacts.
6. Keep derived artifacts aligned (`ohlcv_series`, `orderflow_proxy`, `seasonality`, `social_hype`) when inputs or schemas change.
7. Update fetch/health scripts in `app/scripts/`.
8. Add/update ingestion tests in `tests/`.

## Validation
- `python scripts/fetch_data.py`
- `python scripts/data_health_check.py`
- `python -m pytest -q tests/test_fetch_backoff.py tests/test_load_ohlcv.py tests/test_data_fetch_cache.py`

## Output Checklist
- Ingestion failures are explicit and actionable.
- Cache behavior is deterministic.
- Downstream strategy/advisory modules receive clean data.
