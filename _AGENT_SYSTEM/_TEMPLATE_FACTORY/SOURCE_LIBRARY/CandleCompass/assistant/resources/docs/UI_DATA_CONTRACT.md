# UI Data Contract

This document defines the JSON artifacts consumed by the UI console and the scripts that generate them.

## Advisory Dashboard
- File: `runs/latest/advisory_dashboard.json`
- Generator: `scripts/run_advisory.py` (via `scripts/run_ui_bundle.py`)
- Key fields:
  - `generated_at`, `risk_profile`, `analysis_window`
  - `confluence_summary`, `market_context_summary`
  - `assets[]` with `technical`, `fundamental`, `scanner`, `confluence`, `context`, `data_quality`, `research`, `recommendation`
  - `scanner_top`

## Research Dashboard
- File: `runs/latest/research_dashboard.json`
- Generator: `scripts/research_dashboard.py`
- Key fields:
  - `summary` (samples/start/end)
  - `metrics` (Sharpe, CAGR, MaxDD, etc.)
  - `risk`

## Risk Dashboard
- File: `runs/latest/risk_dashboard.json`
- Generator: `scripts/risk_dashboard.py`
- Key fields:
  - `metrics`
  - `risk`

## Ranked List
- File: `runs/latest/ranked_list.json`
- Generator: `scripts/ranked_list.py`
- Key fields:
  - `ranked[]` (symbol, score)
  - `explanation`

## Ranked Lists (Always-On)
- Files: `runs/latest/ranked_list_crypto.json`, `runs/latest/ranked_list_stocks.json`
- Generator: `scripts/refresh_ranked_lists.py`
- Key fields:
  - `ranked[]` (symbol, score)
  - `explanation`

## Top Lists
- File: `runs/latest/top_lists.json`
- Generator: `scripts/top_lists.py`
- Key fields:
  - `top_crypto[]`, `top_stocks[]`, `explanation`

## Research Feed
- File: `runs/latest/research_feed.json`
- Generator: `scripts/build_research_feed.py`
- Key fields:
  - `items[]` (source, title, published, url)

## Exchange Stats
- File: `runs/latest/exchange_stats.json`
- Generator: `scripts/exchange_stats.py`
- Key fields:
  - `exchanges[]` (exchange, assets, avg_change, avg_volume)

## App Settings
- File: `runs/latest/app_settings.json`
- Generator: `scripts/build_app_settings.py`
- Key fields:
  - `defaults` (theme, dataSource, dataMode, autoRefresh, defaultFocus, view, riskProfile, regimeOverride, dryRun)
  - `watchlist[]`
  - `alerts` (enabled, min_confidence, actions)
  - `profile` (optional user profile snapshot from `user_profile.json`)

## Notification Preferences
- File: `runs/latest/notification_prefs.json`
- Generator: Admin control API (`POST /api/candle_compass/admin/control`)
- Key fields:
  - `users.default.enabled`
  - `users.default.channels` (`email`, `sms`)
  - `users.default.email`, `users.default.phone`
  - `users.<user_id>.*` user-scoped overrides for admin-managed recipients

## Strategy Weights
- File: `runs/latest/strategy_weights.json`
- Generator: AI controller (`POST /ai/config/update_strategy_weights`) or admin control API (`POST /api/candle_compass/admin/control`)
- Key fields:
  - `updated_at`, `source`, `reason`
  - `normalize_applied`
  - `weights` (strategy -> numeric weight)
  - `rollback_from_id` (optional)

## Strategy Weight History
- File: `runs/latest/strategy_weights_history.json`
- Generator: Admin control API (`POST /api/candle_compass/admin/control`)
- Key fields:
  - `updated_at`
  - `entries[]` with `id`, `updated_at`, `source`, `reason`, `normalize_applied`, `weights`

## Admin Control Audit
- File: `runs/latest/admin_control_audit.json`
- Generator: Admin control API (`POST /api/candle_compass/admin/control`)
- Key fields:
  - `updated_at`
  - `entries[]` with:
    - `id`, `timestamp`, `action`, `status`, `role`
    - `approved_by`, `approval_reason` (when sensitive action approval is required)
    - `request.ip`, `request.user_agent`
    - `signature` (HMAC signature when signing key is configured; otherwise `unsigned`)
    - `prev_chain_hash`, `chain_hash` (hash chain for tamper-evidence)
    - `shipped`, `ship_error` (off-host webhook delivery status)
    - `worm_archived_at`, `worm_path`, `worm_error` (append-only archive status)

## Admin Control Audit Shipping Status
- File: `runs/latest/admin_control_audit_ship_status.json`
- Generator: Admin control API (`POST /api/candle_compass/admin/control`)
- Key fields:
  - `updated_at`
  - `webhook` (bool)
  - `last_event_id`
  - `shipped`
  - `error`

## Admin Control Audit Shipping Queue
- File: `runs/latest/admin_control_audit_ship_queue.json`
- Generator: Admin control API (`POST /api/candle_compass/admin/control`) and worker (`scripts/admin_audit_ship_worker.py`)
- Key fields:
  - `updated_at`
  - `items[]` with:
    - `event` (serialized `AuditEntry`)
    - `attempts`
    - `next_retry_at`
    - `last_error`

## Admin Control Audit WORM Status
- File: `runs/latest/admin_control_audit_worm_status.json`
- Generator: Admin control API (`POST /api/candle_compass/admin/control`)
- Key fields:
  - `updated_at`
  - `enabled`
  - `archived`
  - `last_event_id`
  - `file`, `directory`
  - `error`

## Admin Control Audit Worker Status
- File: `runs/latest/admin_control_audit_worker_status.json`
- Generator: `scripts/admin_audit_ship_worker.py`
- Key fields:
  - `updated_at`
  - `status` (`ok`, `degraded`, `idle`, `stopped`, `error`)
  - `mode` (`once`, `loop`)
  - `interval_seconds`
  - `processed`, `delivered`, `remaining`
  - `next_retry_at`
  - `last_error`

## Admin Control Audit WORM Export Status
- File: `runs/latest/admin_control_audit_worm_export_status.json`
- Generator: `scripts/export_audit_worm_s3.py`
- Key fields:
  - `updated_at`
  - `status` (`ok`, `degraded`, `idle`, `error`)
  - `source_dir`, `bucket`, `prefix`
  - `object_lock_enabled`
  - `processed`, `uploaded`, `skipped`, `errors`
  - `last_error`

## Admin Control Audit WORM Export State
- File: `runs/latest/admin_control_audit_worm_export_state.json`
- Generator: `scripts/export_audit_worm_s3.py`
- Key fields:
  - `updated_at`
  - `files` map keyed by archive filename:
    - `sha256`
    - `uploaded_at`
    - `object_key`
    - `size`
    - `object_lock`

## Admin Control Audit WORM Retention Validation
- File: `runs/latest/admin_control_audit_worm_retention_validation.json`
- Generator: `scripts/validate_audit_worm_retention.py` (or admin control `wormRetentionValidate`)
- Key fields:
  - `updated_at`
  - `status` (`ok`, `degraded`, `error`)
  - `bucket`, `prefix`
  - `dry_run`
  - `probe_object` (when non-dry run)
  - `requested` (`mode`, `retain_until`, `retention_days`)
  - `observed` (`object_lock_mode`, `object_lock_retain_until_date`, `content_length`)
  - `error`, `bucket_lock_error`

## Admin Control Audit WORM Environment Check
- File: `runs/latest/admin_control_audit_worm_env_check.json`
- Generator: `scripts/check_audit_worm_env.py` (or admin control `wormEnvCheckRun`)
- Key fields:
  - `updated_at`
  - `status` (`ready`, `not_ready`)
  - `ready_for_live_validation`
  - `checks`:
    - `scripts` (presence flags)
    - `dependencies` (`boto3`, `python`)
    - `credentials` (credential-mode flags)
    - `worm_config` (bucket/prefix/endpoint/region/object_lock_mode)
  - `missing[]`
  - `next_step`

## Seasonality
- File: `runs/latest/seasonality.json`
- Generator: `scripts/seasonality_report.py`
- Key fields:
  - `generated_at`, `years`
  - `assets` (symbol -> monthly and weekly seasonality stats)
  - `hotspots` (`upcoming_month`, `hotspots[]`, `min_win_rate`)

## Social Hype
- File: `runs/latest/social_hype.json`
- Generator: `scripts/social_hype_scan.py`
- Key fields:
  - `generated_at`, `timeframe`
  - `assets[]` with `symbol`, `hype_score`, `status`, `google_trends_score`, `reddit_mentions`

## Strategy Orchestrator
- File: `runs/latest/strategy_orchestrator.json`
- Generator: `scripts/run_orchestrator.py`
- Key fields:
  - `decision` (regime, regime_source, vpin, toxic, selected_strategy, action, allocation, details, note)
  - `decision.details.gatekeeper` (SignalGatekeeper decision payload)
  - `decision.details.regime_logic_gate` (RegimeLogicGate decision payload)
  - `strategy_guard` (Monte Carlo status payload)
  - `gate_override` (manual freeze payload)
  - `security_lock` (IP whitelist / kill switch lock payload)
  - `dxy_trend`, `manual_freeze`, `latency_ms`

## Order Flow
- Files: `runs/latest/cvd_signal.json`, `runs/latest/vpin_signal.json`, `runs/latest/orderflow_alerts.json`, `runs/latest/liquidity_voids.json`
- Generator: `scripts/run_orderflow.py`
- Key fields:
  - `symbol`, `generated_at`
  - `source` (active feed), `sources[]` (failover list)
  - `cvd_signal[]`, `vpin_buckets[]`, `alerts[]`, `voids[]`
  - `whale_trades.json` (optional): `trades[]` with `timestamp`, `price`, `size`, `notional`, `side`
  - Offline bundle fallback: `scripts/run_ui_bundle.py` can derive `vpin_signal.json` from `orderflow_proxy.json` when live orderflow artifacts are unavailable.

## Orderflow Proxy (OHLCV-derived)
- File: `runs/latest/orderflow_proxy.json`
- Generator: `scripts/run_ui_bundle.py` or `scripts/build_orderflow_proxy.py`
- Key fields:
  - `generated_at`, `window`
  - `symbols` (symbol -> `cvd_signal[]`, `vpin_buckets[]`, `bucket_volume`, `source`)
  - `errors` (symbol -> error string)

## OHLCV Series (Per-Symbol Chart)
- File: `runs/latest/ohlcv_series.json`
- Generator: `scripts/run_ui_bundle.py`
- Key fields:
  - `generated_at`
  - `series` (symbol -> `[{time, value}]` close series)
  - `errors` (symbol -> error string, if fetch failed)

## Opportunity Board
- File: `runs/latest/opportunity_board.json`
- Generator: `scripts/opportunity_board.py` (invoked by `scripts/run_ui_bundle.py`)
- Key fields:
  - `generated_at`
  - `market_state` (`deployable`, `gate_mode`, `gate_action`, `vpin_latest`, `pause_longs`, `security_lock`, `global_risk_multiplier`)
  - `top_overall[]`, `top_crypto[]`, `top_stocks[]`
  - Per-row fields: `symbol`, `asset_type`, `action`, `direction`, `confidence`, `move_probability`, `composite_score`, `reasons[]`

## UI API (Command Center)
- Endpoint: `GET /api/candle_compass?symbol=<SYMBOL>`
- Behavior:
  - When `symbol` is provided and `ohlcv_series.json` contains the symbol (or dash/slash variant),
    the API returns `chart` data from that OHLCV series and sets `chartSource="ohlcv"` plus `chartSymbol`.
  - Otherwise, the API falls back to `cvd_signal.json` (if present) or a synthetic series.
  - The API also returns `orderflowSource` + `orderflowSymbol` when `orderflow_proxy.json` provides per‑symbol CVD/VPIN.
  - The API returns `appSettings` from `app_settings.json` (including `watchlist`) for UI consistency warnings.
  - The API returns `bundleRefreshStatus` from `bundle_refresh_status.json` to power in-app refresh state.
  - The API returns `ghostProtocolStatus` from `ghost_protocol_status.json` for operator telemetry widgets.
- Endpoint: `POST /api/candle_compass`
- Supported write actions:
  - `gateFreeze`, `latencyMs`, `tradeTag`, `journalEntry`, `profile`, `killSwitch`
  - `runBundle` (boolean or options object) to start detached UI bundle refresh jobs.

## Admin Control API
- Endpoint: `GET /api/candle_compass/admin/control`
- Behavior:
  - Returns a consolidated admin control payload (`notificationPrefs`, `strategyWeights`, `strategyWeightsHistory`, `ghostProtocolStatus`, `auditTrail`).
  - Also returns:
    - `auditShipStatus` from `admin_control_audit_ship_status.json`
    - `auditQueueStatus` from `admin_control_audit_ship_queue.json`
    - `auditWormStatus` from `admin_control_audit_worm_status.json`
    - `auditWorkerStatus` from `admin_control_audit_worker_status.json`
    - `auditWormExportStatus` from `admin_control_audit_worm_export_status.json`
    - `auditWormRetentionValidation` from `admin_control_audit_worm_retention_validation.json`
    - `auditWormEnvCheck` from `admin_control_audit_worm_env_check.json`
    - `rolePolicy` from `admin_control_policy.json`
  - Optional export mode: `GET /api/candle_compass/admin/control?export=audit` returns full audit log payload.
- Required/optional headers:
  - `x-admin-key`: required when `CANDLE_COMPASS_ADMIN_KEY` is configured.
  - `x-admin-role`: role scope for policy enforcement (`analyst`, `operator`, `superadmin`).
- Endpoint: `POST /api/candle_compass/admin/control`
- Supported write actions:
  - `notificationPrefs` updates notification routing config.
  - `strategyWeightsUpdate` updates current strategy weights (optional normalization) and records history.
  - `strategyWeightsRollback` restores a historical strategy-weight snapshot and requires `approval` payload.
  - `policyUpdate` updates role-policy mappings and requires `approval`.
  - `auditFlush` triggers immediate queue flush attempt for pending webhook deliveries.
  - `wormExportRun` triggers detached WORM export job (`dryRun` and `force` options).
  - `wormRetentionValidate` triggers detached retention validation probe (`dryRun` option).
  - `wormEnvCheckRun` triggers detached WORM environment preflight checks.
  - `ghostTrigger` triggers backend Ghost protocol proxy and requires:
    - explicit confirm text (`CLOSE ALL`)
    - `approval` payload (`approvedBy`, `reason`)

## Execution Plan
- File: `runs/latest/execution_plan.json`
- Generator: `scripts/smart_execute.py`
- Key fields:
  - `symbol`, `exchange`, `style`
  - `orders[]` (symbol, side, quantity, order_type, limit_price, scheduled_offset_s)
  - `notes[]`

## Regime Confidence
- File: `runs/latest/regime_confidence.json`
- Generator: `scripts/regime_confidence.py`
- Key fields:
  - `confidence_score`, `regime`, `win_rate`, `samples`

## Trade Log
- File: `runs/latest/trades.json`
- Generator: backtests / simulators (when enabled)
- Key fields:
  - `trades[]` (id, symbol, side, entry_time, exit_time, pnl)

## Trade Journal
- File: `runs/latest/trade_journal.json`
- Generator: UI API (`/api/candle_compass`)
- Key fields:
  - `entries` keyed by trade_id with `user_notes`

## Portfolio Overview API
- Route: `GET /api/candle_compass/portfolio/overview`
- Backend generator: `src/api/routers/metrics.py`
- Compatibility fallback: `ui-next/src/lib/backendCompatibility.ts`
- Key summary fields:
  - `realized_pnl`, `unrealized_pnl`, `net_pnl`
  - `reduction_trades`, `full_close_trades`, `flip_close_trades`
  - `avg_realized_holding_hours`, `realized_exit_notional_usd`
  - `total_market_value_usd`, `total_margin_used_usd`
  - `concentration_pct`, `best_symbol`, `worst_symbol`
- Key `symbols[]` fields:
  - `realized_pnl`, `unrealized_pnl`, `net_pnl`
  - `reduction_trades`, `full_close_trades`, `flip_close_trades`
  - `avg_holding_hours`, `avg_closed_holding_hours`
  - `realized_exit_notional_usd`
- Key `recent_trades[]` fields:
  - `trade_id`, `symbol`, `status`, `qty`
  - `pnl`, `return_pct`, `entry_notional_usd`, `exit_notional_usd`
  - `close_effect` (`partial_reduce`, `full_close`, `flip_close`)
  - `holding_hours`
  - `parent_trade_id`, `parent_qty_before`, `parent_remaining_qty_after`
  - `user_notes`, `has_notes`

## User Profile
- File: `runs/latest/user_profile.json`
- Generator: `ui-next` API (`POST /api/candle_compass`)
- Key fields:
  - `display_name`, `handle`, `timezone`
  - `experience_level`, `market_focus`, `risk_profile`
  - `updated_at`

## Alpha Report
- File: `runs/latest/alpha_report.md`
- Generator: `scripts/alpha_report.py`

## Trade Heatmap
- File: `runs/latest/trade_heatmap.json`
- Generator: `scripts/alpha_report.py`
- Key fields:
  - `win_rate` (7x24 grid), `counts`

## Adverse Excursions
- File: `runs/latest/adverse_excursions.json`
- Generator: `scripts/alpha_report.py`
- Key fields:
  - `mae_avg`, `mae_p75`, `suggested_stop_loss`

## Post-Mortem Tags
- File: `runs/latest/post_mortem_summary.json`
- Generator: `scripts/alpha_report.py`
- Key fields:
  - `tags` (tag -> count for losing trades)

## Trade Tags
- File: `runs/latest/trade_tags.json`
- Generator: `ui-next` API (`POST /api/candle_compass`)
- Key fields:
  - `tags` (tradeId -> tag)

## Cross-Asset Intelligence
- File: `runs/latest/cross_asset_intel.json`
- Generator: `scripts/cross_asset_intel.py`
- Key fields:
  - `correlations` (macro -> symbol correlation map)
  - `lead_lag` (dxy_return, pause_longs, pause_until)
  - `economic_gate` (action, seconds_to_event, next_event)

## Economic Calendar
- File: `runs/latest/economic_calendar.json`
- Generator: `scripts/cross_asset_intel.py`

## Latency Status
- File: `runs/latest/latency_status.json`
- Generator: `ui-next` API (`POST /api/candle_compass`)
- Key fields:
  - `latency_ms`, `warning`, `updated_at`

## Health Check
- File: `runs/latest/health_check.json`
- Generator: `scripts/health_check.py`
- Key fields:
  - `status` (ok/warn/fail), `results[]`, `missing_required[]`

## Security Lock
- File: `runs/latest/security_lock.json`
- Generator: `scripts/ip_whitelist_check.py` or `scripts/kill_switch.py`
- Key fields:
  - `lock`, `reason`, `current_ip`, `allowed_ips`, `checked_at`

## Kill Switch
- File: `runs/latest/kill_switch.json`
- Generator: `scripts/kill_switch.py` or UI kill switch shortcut
- Key fields:
  - `status`, `exchanges[]`, `actions`, `errors`, `triggered_at`

## Ghost Protocol Status
- File: `runs/latest/ghost_protocol_status.json`
- Generator: `src/api/routers/execution.py` (`GET /api/emergency/close_all`)
- Key fields:
  - `updated_at`, `last_trigger_epoch`, `client_ip`, `status`, `exchanges[]`, `sms_ok`

## Logic Gate Override
- File: `runs/latest/logic_gate_override.json`
- Generator: `ui-next` API (`POST /api/candle_compass`)
- Key fields:
  - `freeze` (boolean), `updated_at`

## Emergency Execution API
- Endpoint: `GET /api/emergency/close_all?token=<SECRET>`
- Security controls:
  - token required (`CANDLE_COMPASS_GHOST_TOKEN`)
  - optional IP allowlist (`CANDLE_COMPASS_GHOST_ALLOWED_IPS`)
  - cooldown/rate limit (`CANDLE_COMPASS_GHOST_COOLDOWN_SECONDS`)
- Side effects:
  - kill switch attempt on configured exchanges
  - security lock + logic-gate freeze artifacts
  - confirmation SMS dispatch

## Bundle Refresh Status
- File: `runs/latest/bundle_refresh_status.json`
- Generator: `scripts/run_bundle_refresh_job.py` (triggered by `POST /api/candle_compass` with `runBundle`)
- Key fields:
  - `state` (`starting`, `running`, `success`, `error`)
  - `requested_at`, `started_at`, `completed_at`
  - `pid`, `exit_code`, `message`
  - `options` (`mode`, `risk_profile`, `provider`, `exchange`, `symbols`, `max_symbols`)
  - `log_path`

## Monte Carlo Stress Test
- File: `runs/latest/monte_carlo.json`
- Generator: `scripts/monte_carlo.py`
- Key fields:
  - `status` (OK/Fragile), `worst_drawdown`, `median_drawdown`, `threshold`

## Walk-Forward (Anchored)
- File: `runs/walk_forward_anchored/walk_forward_anchored.parquet`
- Generator: `scripts/walk_forward_anchored.py`
- Key fields:
  - `segment`, `train_start`, `train_end`, `test_start`, `test_end`
  - metrics (`sharpe`, `cagr`, `max_drawdown`, etc) + `param_*`

## Derivatives Context
- File: `runs/latest/derivatives_dashboard.json`
- Generator: `scripts/derivatives_dashboard.py`
- Key fields:
  - `entries[]` (symbol, funding_rate, open_interest)

## Flow Alerts
- File: `runs/latest/flow_dashboard.json`
- Generator: `scripts/flow_dashboard.py`
- Key fields:
  - `alerts[]` (symbol, volume_z, move)

## Scorecards
- File: `runs/latest/scorecards.json`
- Generator: `scripts/scorecards.py`
- Key fields:
  - `scorecards[]` (symbol, score, rating)

## Optimizer
- File: `runs/latest/optimizer.json`
- Generator: `scripts/portfolio_optimizer.py`
- Key fields:
  - `weights`, `summary`

## Stress Test
- File: `runs/latest/stress_test.json`
- Generator: `scripts/stress_test.py`
- Key fields:
  - `scenarios[]` (scenario, total_return, max_drawdown)

## Alerts
- File: `runs/latest/alerts.json`
- Generator: `scripts/alerts_runner.py`
- Key fields:
  - `alerts[]` (symbol, action, confidence)

## Top Traders
- File: `runs/latest/top_traders.json`
- Generator: `scripts/top_traders.py`
- Key fields:
  - `entries[]` (public sources)

## Plots
- Files: `runs/latest/plots/*.png`
- Generator: `scripts/plot_diagnostics.py`

## Validation
Run `python scripts/ui_health_check.py --runs runs/latest` after any schema change.
