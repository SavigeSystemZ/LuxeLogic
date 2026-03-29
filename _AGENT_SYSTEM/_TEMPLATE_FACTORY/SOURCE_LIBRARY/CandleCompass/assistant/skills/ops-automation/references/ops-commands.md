# Ops Commands

## Bundle Refresh
- `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online`
- `./scripts/install_bundle_timer.sh ~/candle_compass 15 "--provider yfinance"`
- `./scripts/stop_bundle_timer.sh`

## UI Launch
- `./scripts/launch_ui.sh ~/candle_compass`
- `./scripts/launch_ui_desktop.sh ~/candle_compass`
- `./scripts/create_desktop_launcher.sh ~/candle_compass`

## Memory Server
- `./scripts/launch_memory_server.sh ~/candle_compass`
- `./scripts/memory_status.sh ~/candle_compass`
- `./scripts/stop_memory_server.sh ~/candle_compass`

## Services / Tray
- `./scripts/install_service.sh ~/candle_compass`
- `./scripts/install_tray.sh ~/candle_compass`
- `./scripts/stop_service.sh`
- `./scripts/ui_status.sh`
- `./scripts/ui_toggle.sh`

## Runbook
- `./scripts/run_all.sh ~/candle_compass`
