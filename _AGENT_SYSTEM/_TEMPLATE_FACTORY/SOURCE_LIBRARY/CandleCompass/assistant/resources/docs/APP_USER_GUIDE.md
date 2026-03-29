# Candle Compass User Manual

This is the primary user and operator manual for Candle Compass.

## 1. Purpose and Safety
- Candle Compass is a research and decision-support platform.
- It focuses on analysis, simulation, monitoring, and operational controls.
- Live trade execution is not enabled by default.
- Treat outputs as decision support, not guaranteed outcomes.

## 2. Quick Start (Clean Install)

1. Create Python environment and install backend dependencies.
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

2. Install frontend dependencies.
```bash
cd app/ui-next
npm install
cd ../..
```

3. Generate UI artifacts.
```bash
python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online
```

4. Start UI.
```bash
cd app/ui-next
npm run dev
```

5. Open app.
- `http://127.0.0.1:3967`
- To use a different port, set `CANDLE_COMPASS_UI_PORT` (e.g. in `.env` or when launching).

## 3. Installer Path (Fast Setup)

```bash
./scripts/install_candle_compass.sh ~/candle_compass
```

Installer defaults:
- Creates `.venv`.
- Installs Python deps.
- Installs UI deps.
- Builds UI.

Useful flags:
- `--skip-python-deps`
- `--skip-ui-deps`
- `--skip-ui-build`
- `--skip-desktop-launcher`

## 4. First Session Checklist

1. Open launcher and choose a symbol.
2. Click `Refresh Symbols` if symbol list is stale.
3. If you need leveraged/synthetic pairs, toggle launcher `Symbols: Advanced` (or enable `Show advanced symbols` in Settings).
4. Click `Run Bundle`.
5. Click `Launch Primary Chart`.
6. Verify candles and BUY/SELL markers are visible.
7. Use `Ensure Core Modules` if layout is incomplete.
8. Add modules with `+ Add Module`.

## 5. Navigation Model

- Navbar:
  - `Zen: ON/OFF` toggles focused chart mode.
  - User level badge shows progression (`Rookie` -> `Whale`).
- Launcher:
  - Symbol filter + selector.
  - Run bundle and recovery controls.
  - Runtime control role/key inputs.
- Dashboard:
  - Modular widget grid.
  - Every major widget has a `Launch` pop-out action.
- Settings (`/settings`):
  - Appearance, runtime policies, symbol/quote behavior, workspace reset.
- Help (`/help`):
  - In-app guide, module anchors, health commands.

## 6. Module Usage Guide

### Price Chart
- Use timeframe/type/indicator controls per widget.
- Confirm signal markers and fallback badge state.
- Use pop-out for focused analysis.

### Recent Signals
- Use `Filter` and `Rows` controls.
- Confirm confidence and source fields before acting.

### Category Scanner
- Review category-ranked opportunities after bundle refresh.
- Use alongside Opportunity Board for prioritization.

### Opportunity Board
- Use `Market` and `Rows` dropdowns to tune feed scope.
- Cross-check with chart and signal history.

### Orderflow Heatmap
- Inspect pressure/imbalance context.
- Pair with chart for timing confirmation.

### Trade Heat Sheet
- Toggle between `Win Rate` and `Trade Count`.
- Use day/hour concentration patterns for session planning.

### Heatmap Hub
- Tab across Orderflow/Trade/Seasonality views.
- Useful for one-window context switching.

### Gap Hunter (Arbitrage)
- Monitor spatial and loop opportunities.
- Treat `Execute` as simulation/planning only.
- Validate liquidity/slippage assumptions before escalating.

### Arbitrage Hub
- Side-by-side arbitrage pane with shared controls.
- Tune `Min Spread` and row depth for signal quality.

### Strategy Laboratory
- Build no-code strategy templates.
- Save/import/export templates.
- Activate runtime profile intentionally (override vs advisory).

### Time Machine
- Run historical replay/simulation (Signal Replay or EMA Cross).
- Use replay controls for speed/seek/game mode.
- Export trade logs (CSV/JSON).

### Newsroom
- Read narrative clusters and catalyst timelines.
- Use briefing cards from ticker headlines.
- Combine with technical and whale signals.

### Signal Summary Card
- One-glance confluence across Technical/Sentiment/Whales.
- Highest value when all three indicators align.

### System Operations
- Run `Startup Check` and `E2E Check`.
- Manage detached UI/backend/memory services.
- Inspect service logs and action history.
- Manage runtime role policy audit lifecycle.

## 7. Daily Operating Workflow

1. Start UI and backend services.
2. Run `Run Bundle` to refresh data.
3. Run `Startup Check` and `E2E Check`.
4. Review chart + signals + orderflow.
5. Review opportunities and arbitrage panels.
6. Run Time Machine scenarios for candidate setups.
7. Review Newsroom narrative context.
8. Save strategy templates and settings updates.

## 8. Error Logging and Debug Artifacts

Candle Compass now writes stable logs for runtime and validation failures.

### Runtime/API Error Logs
- `app/runs/latest/runtime_error_events.jsonl`
  - Append-only JSON lines of API/runtime failures.
  - Includes `errorId`, `timestamp`, `stage`, and details.
- `app/runs/latest/runtime_error_last.json`
  - Last recorded runtime/API error snapshot.

### Service and Process Logs
- `app/runs/ui_server.log`
- `app/runs/backend_server.log`
- `app/runs/memory_server.log`
- `app/runs/bundle_refresh.log`

### Validation and Smoke Artifacts
- `app/runs/latest/startup_validation.json`
- `app/runs/latest/e2e_smoke.json`
- `app/runs/latest/health_check.json`
- `app/runs/latest/service_console_actions.json`

### One-Command Full Debug Validation Log
Run:
```bash
bash scripts/run_debug_validation.sh
```

Generated files:
- `app/runs/latest/logs/debug_validation_<timestamp>.log`
- `app/runs/latest/logs/debug_validation_<timestamp>.summary.txt`
- `app/runs/latest/logs/debug_validation_latest.log`
- `app/runs/latest/logs/debug_validation_latest.summary.txt`

If any step fails, the script exits non-zero and preserves full logs.

## 9. Troubleshooting Playbook

### A. Chart empty or signals missing
1. Run bundle refresh.
2. Re-open chart widget/pop-out.
3. Verify `runs/latest/ohlcv_series.json` exists.
4. Run `Startup Check` + `E2E Check`.

### B. Buttons do nothing / Runtime authorization failed
1. **Check runtime control key**: 
   - In launcher or Settings, ensure `Runtime Control Key` is set to your `CANDLE_COMPASS_RUNTIME_CONTROL_KEY` environment variable value.
   - Browser runtime auth is intentionally manual. The UI may bootstrap your effective role, but it will not auto-import `CANDLE_COMPASS_RUNTIME_CONTROL_KEY` into browser storage for you.
   - If missing, set it in `.env` or export it: `export CANDLE_COMPASS_RUNTIME_CONTROL_KEY="your-key-here"`
2. **Check runtime role**: 
   - Ensure `Runtime Operator Role` is set appropriately (`viewer`, `operator`, `admin`, or `owner`).
   - Some operations require `operator` or higher; destructive actions require `admin` or `owner`.
3. **Verify role policy**: 
   - Open System Operations panel and check `Role Policy Status`.
   - If policy restricts your role, you may need to update it (requires `admin`/`owner` role).
4. **Inspect error logs**:
   - Open System Operations logs panel.
   - Check `runtime_error_last.json` for specific authorization error messages.
   - Look for `runtime control authorization failed` or similar messages.
5. **Expected behavior**:
   - Missing runtime control key: Operations requiring authorization will fail with 403 errors.
   - Insufficient role: Operations will show "Role X cannot run Y. Required: Z" messages.
   - This is **expected security behavior** - the application degrades gracefully but restricts privileged operations.

**Why you see 403 (runtime authorization):**  
A 403 response with "runtime control authorization failed" means the server is correctly rejecting an operation because the request did not include a valid runtime control key (or the key did not match `CANDLE_COMPASS_RUNTIME_CONTROL_KEY`). This is **not a bug**—it is the intended security behavior. View-only actions (e.g. loading dashboard data) do not require the key; actions that change state (run bundle, restart services, clear history, set role policy) do. To fix: set the env var and enter the same value in Launcher or in `/settings?panel=runtime`, or leave the key blank to use the app in view-only mode.

**Expected vs actual errors (quick reference):**

| What you see | Expected? | Action |
|--------------|-----------|--------|
| 403 + "runtime control authorization failed" | Yes, when key is missing or wrong | Set `CANDLE_COMPASS_RUNTIME_CONTROL_KEY` and enter it manually in `/settings?panel=runtime`, or leave key blank for view-only. |
| "Role X cannot run Y. Required: Z" | Yes, when role is too low | Raise runtime role in launcher/Settings or ask an admin to update role policy. |
| Health check `warn` for missing API keys | Yes, optional keys | Configure keys in `.env` for full features, or run in degraded mode. |
| Chart/signals empty after bundle | No | Run bundle again; check `runs/latest/ohlcv_series.json` and run Startup Check. |
| Modal/dialog cannot be closed | No | All dialogs support ESC and close button; if not, report a bug. |

### C. Symbol not found
1. Click `Refresh Symbols`.
2. Enable advanced symbols if you need leveraged/synthetic pairs.
3. Rebuild catalog manually:
```bash
python scripts/build_symbol_catalog.py --universe asset_universe.yaml --runs runs/latest --out runs/latest/symbol_catalog.json --max-stocks 5000 --max-crypto 8000
```

### D. UI launch issues
1. Check `app/runs/ui_server.log`.
2. Try detached launcher scripts:
```bash
bash scripts/launch_ui_detached.sh ~/candle_compass --no-open --runtime=production
bash scripts/ui_status.sh
```

### E. You receive API error with `errorId`
1. Copy `errorId` from UI/API response.
2. Search in:
```bash
rg "ccerr_" app/runs/latest/runtime_error_events.jsonl
```
3. Review adjacent service logs and validation artifacts.

### F. Missing API keys / Degraded functionality
Some features require API keys but will operate in degraded mode if missing.

**API key configuration checklist (quick reference):**

| Step | Action |
|------|--------|
| 1 | Create or edit `.env` in the repository root (or set environment variables before starting). |
| 2 | Add `CANDLE_COMPASS_RUNTIME_CONTROL_KEY` if you need to run bundle, restart services, or change role policy (see §9.B). |
| 3 | Add `POLYGON_API_KEY` for stock data; without it, stock quotes may be unavailable. |
| 4 | Add `CANDLE_COMPASS_AI_CONTROLLER_API_KEY` for AI-powered features. |
| 5 | Add Reddit/Google credentials for social sentiment; add AlphaVantage/TheGraph/broker keys only if you use those features. |
| 6 | Restart UI/backend after changing `.env`. Health check will show `warn` for missing optional keys; app runs in degraded mode. |

**Missing API Keys Checklist (detailed):**
1. **Polygon.io** (`POLYGON_API_KEY`): Required for stock market data. Without it, stock quotes may be unavailable.
2. **AI Controller** (`CANDLE_COMPASS_AI_CONTROLLER_API_KEY`): Required for AI-powered features. Missing key disables AI features.
3. **Reddit** (`REDDIT_CLIENT_ID`, `REDDIT_CLIENT_SECRET`): Required for social sentiment analysis. Missing keys disable sentiment features.
4. **Google Trends** (`GOOGLE_TRENDS_API_KEY`): Required for trend analysis. Missing key disables trend features.
5. **AlphaVantage** (`ALPHAVANTAGE_API_KEY`): Alternative data source. Missing key uses fallback providers.
6. **TheGraph** (`THEGRAPH_API_KEY`): Required for blockchain data. Missing key disables blockchain features.
7. **Broker API** (`BROKER_API_KEY`): Required for broker integration. Missing key disables broker features.
8. **SEC User Agent** (`SEC_USER_AGENT`): Required for SEC EDGAR data. Missing key disables SEC features.

**Expected Behavior:**
- Application will start and run normally.
- Health check (`/api/candle_compass/health`) will show `warn` status for missing keys.
- Features requiring missing keys will be disabled or use fallback providers.
- No errors will be thrown - the application degrades gracefully.

**Configuration:**
- Set API keys in `.env` file in the repository root.
- Or export as environment variables before starting the application.
- See `assistant/FIXME.md` for current API key status.

### H. Bundle timer journal spam ("working directory missing")
If you see repeated `rsiglobe-bundle.service` or `candle_compass-bundle.service` failures (e.g. "Changing to the requested working directory failed"):

1. Stop legacy and current bundle timers once:
```bash
./scripts/stop_legacy_rsiglobe_services.sh
./scripts/stop_bundle_timer.sh
```
2. Only re-enable the bundle timer if the app root path exists and has `.venv` and `scripts/run_ui_bundle.py`:
```bash
./scripts/install_bundle_timer.sh /absolute/path/to/your/app 15
```
The installer validates the path and adds resource limits (memory/CPU) so the job cannot harm the host.

### G. Desktop icon not launching
- Ensure the desktop file uses an **absolute** path (installer and `create_desktop_launcher.sh` do this).
- From repo: run `./app/scripts/create_desktop_launcher.sh` from repo root (or pass app root as first arg). Launcher is created at `~/Desktop/CandleCompass.desktop` (or `$XDG_DESKTOP_DIR`) and is marked trusted so double-click works without "Allow Launching."
- After install: installer creates `Candle Compass.desktop` with the same behavior.
- If the icon does nothing on click: right‑click the desktop file → "Allow Launching" (or "Trust and Launch"); or regenerate with `./app/scripts/create_desktop_launcher.sh`. The launcher runs the app in a login shell so `node`/`npm` (e.g. from nvm) are available.

## 10. Health and Validation Commands

```bash
python scripts/ui_smoke_test.py --runs runs/latest --strict
python scripts/e2e_smoke.py --runs runs/latest --strict
python scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json
bash scripts/run_debug_validation.sh
```

## 11. Settings and Customization

Use `/settings` for:
- Theme/color scheme.
- UI scale, blur, glow, radius tuning.
- Default chart symbol/timeframe/type/indicators.
- Refresh cadence and behavior toggles.
- Runtime policy and audit controls.
- Workspace/cache reset actions.

## 12. Pop-Out and Workspace Behavior

- Major widgets support pop-outs (`Launch`).
- Allow browser pop-ups for localhost.
- Workspace state is persisted locally.
- Use reset actions in settings if UI state drifts.

## 13. Operator Handoff Checklist

Before handoff:
1. Save current settings/profile.
2. Run `bash scripts/run_debug_validation.sh`.
3. Capture:
   - `debug_validation_latest.log`
   - `runtime_error_last.json`
   - `startup_validation.json`
   - `e2e_smoke.json`
4. Note any unresolved warnings from startup validation.

## 14. Related Docs

- In-app help page: `app/ui-next/src/app/help/page.tsx`
- System overview: `assistant/resources/docs/SYSTEM_OVERVIEW.md`
- UI data contract: `assistant/resources/docs/UI_DATA_CONTRACT.md`
- Ops runbook: `assistant/resources/docs/OPS_RUNBOOK.md`
- Repo boundary + backup policy: `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`

## 15. External Backup Rotation (Outside Repo)

Run:
```bash
bash scripts/rotate_external_backups.sh
```

Default backup location:
- `$HOME/.BackupZ-MyAppZ/CandleCompass.bak` (one copy only; subsequent backups replace it)

Rotation behavior:
- keeps latest 3 snapshots
- removes older snapshots automatically

Status file:
- `app/runs/latest/external_backup_status.json`
