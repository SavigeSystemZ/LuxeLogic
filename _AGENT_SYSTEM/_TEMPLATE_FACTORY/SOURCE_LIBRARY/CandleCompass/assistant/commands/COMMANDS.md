# Command Catalog

## Environment
- `python -V`
- `python -m venv .venv`
- `source .venv/bin/activate`
- `pip install -r requirements.txt`

## Runtime Role Policy
- `curl -s http://127.0.0.1:3967/api/candle_compass | jq '.runtimeAuth'`
- `curl -s http://127.0.0.1:3967/api/candle_compass | jq '.runtimeRolePolicyAudit'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: viewer" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"runtimeRolePolicy":"status"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: operator" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"runtimeRolePolicy":"set"},"runtimeRolePolicy":{"view":"viewer","operate":"operator","destructive":"operator"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: viewer" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"runtimeRolePolicyAudit":"status"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperationConfirmText":"CONFIRM_RUNTIME_DESTRUCTIVE_ACTION","operations":{"runtimeRolePolicyAudit":"clear"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperationConfirmText":"CONFIRM_RUNTIME_DESTRUCTIVE_ACTION","runtimeRolePolicyAuditKeep":100,"operations":{"runtimeRolePolicyAudit":"trim"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperationConfirmText":"CONFIRM_RUNTIME_DESTRUCTIVE_ACTION","runtimeRolePolicyAuditKeep":100,"operations":{"runtimeRolePolicyAudit":"rotate"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperatorRole":"owner","runtimeRolePolicyAuditKeep":80,"runtimeRolePolicyAuditTimerInterval":30,"operations":{"runtimeRolePolicyAuditTimer":"install"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperatorRole":"owner","operations":{"runtimeRolePolicyAuditTimer":"status"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperatorRole":"owner","operations":{"runtimeRolePolicyAuditTimer":"stop"}}'`
- `curl -s http://127.0.0.1:3967/api/candle_compass | jq '{runtimeRolePolicyAuditTimerStatus, runtimeRolePolicyAuditTimerPreflight}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: viewer" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceLogs":"status"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: viewer" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"clear"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: operator" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"clear"}}'`

## Memory (Local)
- `python scripts/memory_tool.py ingest --replace`
- `python scripts/memory_tool.py search --query "vectorized backtest"`
- `python scripts/memory_tool.py add --title "Fix: X" --content "Issue/diagnosis/solution" --type debug --scope project`
- `python scripts/memory_tool.py list --limit 20`
- `python scripts/memory_tool.py delete --id <memory_id> --yes`
- `python scripts/memory_server.py --host 127.0.0.1 --port 8766`
- `./scripts/launch_memory_server.sh ~/candle_compass`
- `./scripts/memory_status.sh ~/candle_compass`
- `./scripts/stop_memory_server.sh ~/candle_compass`
- `./scripts/launch_backend_detached.sh ~/candle_compass`
- `./scripts/backend_status.sh ~/candle_compass`
- `./scripts/stop_backend_detached.sh ~/candle_compass`
- `./scripts/install_backend_service.sh ~/candle_compass`
- `./scripts/backend_service_status.sh`
- `./scripts/stop_backend_service.sh`
- `CANDLE_COMPASS_UI_PORT=3100 CANDLE_COMPASS_UI_HOST=127.0.0.1 ./scripts/install_service.sh ~/candle_compass`
- `CANDLE_COMPASS_BACKEND_PORT=8010 CANDLE_COMPASS_BACKEND_HOST=127.0.0.1 ./scripts/install_backend_service.sh ~/candle_compass`

## Data
- `python scripts/fetch_data.py --symbol AAPL --start 2020-01-01 --end 2024-01-01`
- `python scripts/validate_data.py data/raw/AAPL.csv`
- `python scripts/fetch_orderbook.py --exchange binance --symbol BTC/USDT --limit 50`
- `python scripts/fetch_universe.py --config asset_universe.yaml --validate`
- `python scripts/fetch_data.py --symbol BTC/USDT --provider ccxt --exchange binance --start 2020-01-01 --end 2024-01-01`
- `python scripts/data_health_check.py --config asset_universe.yaml --cache-only`
- `python scripts/run_orderflow.py --exchange coinbase --symbol BTC/USD --duration 60`
- `python scripts/run_orderflow.py --exchange coinbase --symbol BTC/USD --duration 60 --scan-orderbook`
- `python scripts/run_orderflow.py --exchange binance --secondary-exchanges kraken,bitstamp --fallback-coingecko-id bitcoin --duration 60 --verbose-failover`
- `python scripts/build_orderflow_proxy.py --universe asset_universe.yaml --symbols BTC-USD,ETH-USD --window 5`
- `python scripts/regime_hmm.py --symbol BTC/USD --provider ccxt --exchange coinbase --start 2023-01-01 --end 2024-12-31`
- `python scripts/regime_confidence.py --symbol BTC/USD --provider ccxt --exchange coinbase --start 2023-01-01 --end 2024-12-31`
- `python scripts/pairs_trade.py --symbol-a BTC/USD --symbol-b ETH/USD --provider ccxt --exchange coinbase --start 2023-01-01 --end 2024-12-31`
- `python scripts/nlp_alpha_bridge.py --provider ollama --model llama3:8b --max-headlines 25`
- `python scripts/run_orchestrator.py --symbol BTC/USD --provider ccxt --exchange coinbase --start 2023-01-01 --end 2024-12-31`
- `python scripts/alpha_report.py --trades runs/latest/trades.json`
- `python scripts/cross_asset_intel.py --symbols BTC-USD,ETH-USD`
- `python scripts/smart_execute.py --exchange binance --symbol BTC/USDT --side buy --quantity 5 --execution-style ICEBERG --duration 120 --slices 10`

## Backtest
- `python scripts/run_backtest.py --symbol BTC-USD --start 2020-01-01 --end 2024-01-01`
- `python scripts/run_portfolio_backtest.py --symbols BTC-USD,ETH-USD --start 2020-01-01 --end 2024-01-01`
- `python scripts/run_portfolio_backtest.py --universe asset_universe.yaml --start 2020-01-01 --end 2024-01-01`
- `python scripts/run_backtest.py --symbol BTC/USDT --provider ccxt --exchange binance --start 2020-01-01 --end 2024-01-01`
- `python scripts/monte_carlo.py --returns runs/latest/returns.parquet`

## Walk-Forward / Optimization
- `python scripts/walk_forward_rsi.py --symbol BTC-USD --start 2020-01-01 --end 2024-01-01`
- `python scripts/param_sweep_rsi.py --symbol BTC-USD --start 2020-01-01 --end 2024-01-01`
- `python scripts/walk_forward_anchored.py --symbol BTC-USD --start 2020-01-01 --end 2024-01-01`

## Monitoring / Regression
- `python scripts/drift_check.py --path runs/latest/returns.parquet --column returns`
- `python scripts/update_baseline.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --key single_asset`
- `python scripts/regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --key single_asset`
- `python scripts/update_risk_baseline.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --positions runs/latest/positions.parquet --key single_asset`
- `python scripts/risk_regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --positions runs/latest/positions.parquet --key single_asset`
- `python scripts/drift_check.py --path runs/latest/returns.parquet --column returns --ref_window 252 --cur_window 63`
- `python scripts/tune_drift_thresholds.py --path runs/latest/returns.parquet --column returns`
- `python scripts/recommend_drift_thresholds.py --path runs/latest/drift_tuning.json`
- `python scripts/health_check.py --config config.yaml`
- `python scripts/validate_startup_config.py --config config.yaml`
- `python scripts/e2e_smoke.py --runs runs/latest --strict`
- `python scripts/e2e_smoke.py --runs runs/latest --strict --check-http --ui-api-url http://127.0.0.1:3100/api/candle_compass --backend-health-url http://127.0.0.1:8010/api/health`
- `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"uiDetached":"status","appService":"status","memoryServer":"status","backendServer":"status"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"uiDetached":"status","appService":"status","backendService":"status","memoryServer":"status","backendServer":"status"}}'`
- `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"uiDetached":"restart"}}'`
- `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"appService":"restart"}}'`
- `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"backendServer":"restart"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"backendService":"restart"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"appService":"install"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"backendService":"install"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"status"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"clear"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" -H "x-runtime-role: operator" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"clear"}}'`
- `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceLogs":"status"}}'`

## Risk Report
- `python scripts/risk_report.py --returns runs/latest/returns.parquet`
- `python scripts/risk_dashboard.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet`
- `python scripts/risk_dashboard.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --universe asset_universe.yaml`
- `python scripts/risk_report.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --positions runs/latest/positions.parquet --universe asset_universe.yaml`
- `cat ui/risk_profiles.json`

## Stability
- `python scripts/stability_report.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --window 252`

## Diagnostics
- `python scripts/plot_diagnostics.py --equity runs/latest/equity.parquet --returns runs/latest/returns.parquet`

## Research Dashboard
- `python scripts/research_dashboard.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet`

## Security
- `python scripts/secrets_tool.py set ALPHAVANTAGE_API_KEY <value>`
- `python scripts/secrets_tool.py set POLYGON_API_KEY <value>`
- `python scripts/secrets_tool.py list`
- `python scripts/ip_whitelist_check.py`
- `python scripts/kill_switch.py --exchanges binance,coinbase`

## Asset Scoring (Non-Recommendation)
- `python scripts/score_assets.py --symbols BTC-USD,ETH-USD --start 2019-01-01 --end 2020-12-31 --cache data/fixtures`

## Ranked List (Non-Recommendation)
- `python scripts/ranked_list.py --symbols BTC-USD,ETH-USD --start 2019-01-01 --end 2020-12-31 --top 5 --cache data/fixtures`
- `python scripts/refresh_ranked_lists.py --universe asset_universe.yaml`

## Advisory Dashboard (Non-Recommendation)
- `python scripts/run_advisory.py --universe asset_universe.yaml --risk-profile moderate`
- `python scripts/alerts_runner.py --config config.yaml`

## Report Bundle
- `python scripts/report_bundle.py --out runs/latest/bundle.json`

## Ops / Backup
- `./scripts/backup_project.sh ~/candle_compass`
- `./scripts/backup_project.sh ~/candle_compass /home/whyte/.cursor full`
- `./scripts/git_connectivity_check.sh`
- `./scripts/git_tag_checkpoint.sh`
- `./scripts/git_tag_checkpoint.sh pre-refactor --push`
- `./scripts/git_backup_branch.sh`

## Installer
- `./scripts/install_candle_compass.sh ~/candle_compass`

## One-shot Run
- `./scripts/run_all.sh ~/candle_compass`

## UI
- `./scripts/launch_ui.sh ~/candle_compass`
- `./scripts/launch_ui_desktop.sh ~/candle_compass`
- `./scripts/launch_ui_detached.sh ~/candle_compass`
- `./scripts/launch_ui_detached.sh ~/candle_compass --runtime=production --no-open`
- `./scripts/launch_ui_detached.sh ~/candle_compass --runtime=development --no-open`
- `./scripts/stop_ui_detached.sh ~/candle_compass`
- `./scripts/create_desktop_launcher.sh ~/candle_compass`
- `CANDLE_COMPASS_UI_PORT=8000 CANDLE_COMPASS_UI_HOST=127.0.0.1 ./scripts/launch_ui.sh ~/candle_compass`
- `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online`
- `python scripts/ui_smoke_test.py --runs runs/latest --strict`
- `./scripts/install_bundle_timer.sh ~/candle_compass 15 "--provider yfinance"`
- `./scripts/stop_bundle_timer.sh`
- `./scripts/install_runtime_role_policy_audit_timer.sh ~/candle_compass 30 100`
- `./scripts/runtime_role_policy_audit_timer_status.sh`
- `./scripts/stop_runtime_role_policy_audit_timer.sh`
- `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online --provider uniswap`
- `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online --provider auto`
- `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online --provider ccxt_multi --exchange coinbase,kraken,bitstamp,kucoin`
- `cd ui-next && npm install`
- `cd ui-next && npm run dev`
- `cd ui-next && npm run build && npm run start`
- `python scripts/top_lists.py --universe asset_universe.yaml`
- `python scripts/build_research_feed.py --in runs/latest/advisory_dashboard.json`
- `python scripts/exchange_stats.py --universe asset_universe.yaml`
- `python scripts/derivatives_dashboard.py --universe asset_universe.yaml`
- `python scripts/flow_dashboard.py --universe asset_universe.yaml`
- `python scripts/portfolio_optimizer.py --universe asset_universe.yaml`
- `python scripts/stress_test.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet`
- `python scripts/scorecards.py --universe asset_universe.yaml`
- `python scripts/top_traders.py --input data/public/top_traders.csv`
- `python scripts/build_app_settings.py --config config.yaml`
- `python scripts/set_ui_defaults.py --theme graphite --data-source auto --data-mode online`
- `python scripts/watchlist.py --list`
- `./scripts/install_ranked_timer.sh ~/candle_compass 30`
- `./scripts/stop_ranked_timer.sh`
- `./scripts/install_alerts_timer.sh ~/candle_compass 15`
- `./scripts/stop_alerts_timer.sh`
- `./scripts/install_health_check_timer.sh ~/candle_compass 60`
- `./scripts/stop_health_check_timer.sh`
- `./scripts/install_service.sh ~/candle_compass`
- `./scripts/install_tray.sh ~/candle_compass`
- `python3 ~/candle_compass/ui/tray.py`
- `./scripts/stop_service.sh`
- `./scripts/ui_status.sh`
- `./scripts/ui_toggle.sh`
- `python scripts/ui_health_check.py --runs runs/latest`
- `./scripts/ui_status.sh`

## Metrics
- `python scripts/report_metrics.py --input runs/latest/results.parquet`
