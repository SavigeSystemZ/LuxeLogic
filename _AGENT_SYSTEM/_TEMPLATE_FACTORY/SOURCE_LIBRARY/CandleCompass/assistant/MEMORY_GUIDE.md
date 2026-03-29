# Memory Guide - Candle Compass

## Purpose
This project uses a local memory store to preserve durable context, preferences, and key project facts.
It is a lightweight replacement for external MCP memory providers.

## Project ID
- whyte/Candle Compass

## Memory Store
- Default path: `data/memory/memories.jsonl`
- Override with env var: `CANDLE_COMPASS_MEMORY_PATH`
- The store is local and not shared externally.

## Ingest Config
- Default config: `assistant/memory_ingest.yaml`
- Override with env var: `CANDLE_COMPASS_MEMORY_CONFIG`

## Optional Auth
- Store `CANDLE_COMPASS_MEMORY_TOKEN` in the secrets store to require a bearer token on the HTTP server.

## Quick Start
```bash
python scripts/memory_tool.py ingest --replace
python scripts/memory_tool.py search --query "vectorized backtest"
python scripts/memory_tool.py list --limit 10
```

## Related Ops
- UI artifact validation: `python scripts/ui_health_check.py --runs runs/latest`

## HTTP Server
```bash
python scripts/memory_server.py --host 127.0.0.1 --port 8766
./scripts/launch_memory_server.sh ~/candle_compass
./scripts/memory_status.sh ~/candle_compass
./scripts/stop_memory_server.sh ~/candle_compass
```

## What Gets Ingested (Default)
- Core docs: `assistant/MASTER_SYSTEM_PROMPT.md`, `assistant/ASSISTANT_LOADOUT.md`, `assistant/FULL_CONTEXT_INDEX.md`, `README.md`, `assistant/ARCHITECTURE.md`, `assistant/SECURITY.md`, `assistant/STYLEGUIDE.md`, `assistant/AI_ASSISTED_DEV.md`, `assistant/ROADMAP.md`, `assistant/TODO.md`
- Directories: `assistant/prompts/`, `assistant/rules/`, `assistant/context/`, `assistant/skills/`, `assistant/commands/`, `assistant/resources/docs/`, `scripts/`, `src/`, `ui/`, `tests/`
- Config and templates: `config.yaml`, `asset_universe.yaml`, `.env.example`, `requirements.txt`, `templates/`

## Entry Points (App)
- Single-asset backtest: `scripts/run_backtest.py`
- Portfolio backtest: `scripts/run_portfolio_backtest.py`
- Walk-forward: `scripts/walk_forward_rsi.py`
- Anchored walk-forward: `scripts/walk_forward_anchored.py`
- Parameter sweep: `scripts/param_sweep_rsi.py`
- Drift checks: `scripts/drift_check.py`, `scripts/tune_drift_thresholds.py`, `scripts/recommend_drift_thresholds.py`
- Reporting: `scripts/risk_report.py`, `scripts/risk_dashboard.py`, `scripts/stability_report.py`, `scripts/plot_diagnostics.py`, `scripts/research_dashboard.py`
- Scoring/export: `scripts/score_assets.py`, `scripts/ranked_list.py`, `scripts/report_bundle.py`
- Regime + pairs: `scripts/regime_hmm.py`, `scripts/pairs_trade.py`
- NLP alpha: `scripts/nlp_alpha_bridge.py`
- Orchestrator: `scripts/run_orchestrator.py`
- Signal gatekeeper: `src/execution/signal_gatekeeper.py` (manual override via `runs/latest/logic_gate_override.json`)
- Multi-source trade stream: `src/data/multi_source_stream.py`
- Smart execution planning: `src/execution/smart_execution.py`
- UI: `ui/index.html`, `ui/app.js`, `scripts/launch_ui.sh`, `scripts/run_all.sh`
- Web command center: `ui-next/` (`npm run dev`)
- Web data feed: `ui-next/src/app/api/candle_compass/route.ts` (supports `?symbol=` and uses `runs/latest/ohlcv_series.json` for charts plus `runs/latest/orderflow_proxy.json` for CVD/VPIN when available; persists `runs/latest/user_profile.json` and app settings now ingest profile defaults)
- Alpha reporting: `scripts/alpha_report.py` -> `runs/latest/alpha_report.md`, `trade_heatmap.json`
- Cross-asset intelligence: `scripts/cross_asset_intel.py` -> `cross_asset_intel.json`, `economic_calendar.json`
- Monte Carlo guardrail: `scripts/monte_carlo.py` -> `runs/latest/monte_carlo.json`
- Health checks: `scripts/health_check.py` -> `runs/latest/health_check.json`
- Smart execution planner: `scripts/smart_execute.py` -> `runs/latest/execution_plan.json`
- Git connectivity guardrail: `scripts/git_connectivity_check.sh` (verifies `origin/main` reachability/tracking)
- Encrypted secrets: `scripts/secrets_tool.py`
- IP whitelist check: `scripts/ip_whitelist_check.py` -> `runs/latest/security_lock.json`
- Emergency kill switch: `scripts/kill_switch.py` -> `runs/latest/kill_switch.json`

## Architecture (High-Level)
- Data: `src/data`
- Strategies: `src/strategies`
- Backtest: `src/backtest`
- Portfolio: `src/portfolio`
- Execution: `src/execution`
- Monitoring: `src/monitoring`
- Risk: `src/risk`
- Optimization: `src/optimization`
- Analysis: `src/analysis`

## Memory Types
- component
- implementation
- debug
- project_info
- user_preference

## User Defined Namespaces
- [Leave blank - user populates]

## Notes
- Do not store secrets in memory entries.
- Use the memory tool to add/search/list/delete memories.
- Advisory pipeline includes a confluence engine (`src/advisory/confluence.py`) with summary fields in advisory JSON.
- Installer uses app-only manifest at `assistant/resources/install_manifest.txt` (assistant/meta files excluded).
- Runtime application lives under `app/` with root-level symlinks for `scripts/`, `src/`, `ui/`, `ui-next/`, `data/`, and configs.
