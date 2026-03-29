# FIXME

## Data Accuracy & Validation Systems (2026-03-02)
- (done) Cache TTL enforcement: stale cached OHLCV data now re-fetches instead of serving silently. Interval-based TTLs.
- (done) Multi-source price cross-validation: `price_validator.py` compares yfinance vs CCXT exchanges, flags divergence >2%.
- (done) Timestamp normalization: `normalize_timestamp()` converts any format to canonical ISO 8601 UTC.
- (done) Accuracy auditor hardened: ATR-based dynamic target/stop levels replace flat defaults; slippage model applied.
- (done) Accuracy trend monitor: 7d/30d rolling win rates, auto-degradation, alerts artifact.
- (done) Artifact integrity monitor: scans all runs/latest/ for existence, JSON validity, schema, freshness.
- (done) Orchestrator data freshness gate: forces HOLD on stale data.
- (done) Confluence engine completed: 3 placeholder signals now read from real artifacts (whale events, seasonality, arbitrage).
- (done) Confluence wired into orchestrator: score <0.35 forces HOLD.
- (done) Signal audit log: SHA-256 hash chain, tamper detection, append-only JSONL.
- (done) Ghost protocol status artifact generator created.
- (done) DEX pairs artifact output fixed to proper schema format.
- (done) DataHealthWidget: frontend artifact health dashboard.
- (done) 6 new Pydantic schemas: PriceValidation, AccuracyAlerts, ArtifactHealth, OptionsChain, GhostProtocolStatus, DexPairs.
- Remaining: options_chain.json artifact generator (requires yfinance `.options` API or API key), backtest benchmark validator, latency monitor.

## Security & UX Hardening (2026-03-01)
- (done) All `alert()`/`confirm()` blocking browser dialogs eliminated from codebase (8 violations across 5 files replaced with toast/ConfirmDialog).
- (done) CORS middleware added to backend; SSRF protection enhanced with DNS resolution checks.
- (done) SSR theme variable injection via inline `<head>` style + provider order fix landed. End-to-end reload verification still recommended.

## Open Integration Regressions (2026-02-26)
- Full validation pass completed on 2026-02-26 (frontend lint/tests/build, backend pytest, hydration, backup). Remaining items below are follow-up hardening/improvement work, not release blockers for the current save.
- UI sometimes renders in a degraded/plain style (white background/black text) after reload. Root causes identified include theme-token drift and shell composition duplication; SSR CSS variable injection + fallback token bridge + layout fix landed. Provider order corrected. Needs end-to-end reload verification.
- Theme system is split between `src/config/themes.json` (dynamic ThemeContext) and `src/config/themeConfig.ts` + `src/lib/theme.ts` (legacy semantic theme engine). Consolidate to a single canonical theme source to prevent styling regressions.
- `/api/data/[...artifact]` route now exists with aliasing + freshness metadata, and major widgets were normalized to real artifact shapes, but App Store-wide coverage still needs verification for all modules.
- `next build` / lint commands may appear to stall in this environment; capture reproducible logs and decide whether to pin a more stable build mode (e.g. non-Turbopack build path) for local ops scripts.
- Installer option `1` was reported as "hanging" after purge. Script now emits timestamped progress + verbose pip/npm/build output, but an end-to-end installer smoke on this host is still pending.
- Installer now initializes local SQLite data lake during install and first launch via `ensure_data_lake.py`; verify fresh-install UX after latest changes (desktop icon visibility, app menu entry, and NVM/Node discovery in launcher).
- Installer now also provisions PostgreSQL interactively (keep/reinitialize/fresh DB policies + secure role password generation). Remaining work is host-level UX verification for each policy branch; implementation is in place.
- Root-cause note for manual `launch_ui_detached.sh` startup failures on some hosts: local `next` binary may exist but fail with `/usr/bin/env: node: No such file or directory` when desktop/minimal shells omit NVM PATH. `launch_ui_detached.sh` now bootstraps NVM and prints log tails on failure.
- `hydrate_all.sh` CLI drift/timeouts were repaired and a successful hydration run was verified, but a documented "minimal local demo hydration" path (fast/offline) still needs to be codified for users without full API access.

## Open Runtime Follow-ups (2026-02-15)
- Runtime role policy now persists in `runs/latest/runtime_role_policy.json`; add backup/restore guidance for this artifact in deployment runbooks.
- Runtime role policy audit rotation now has timer scripts and API/GUI controls, but production rollout still needs host-level enablement policy (`systemctl --user` availability, timer interval baseline, and owner-role gating SOP).
- (done) Add automated API tests for runtime policy-audit timer controls (`install`/`stop`/`status`) and rotate path payload validation.
- API currently preserves HTTP `200` with per-action `ok:false` payload semantics for some runtime operation failures; UI now handles this correctly, but server-side status-code normalization remains a future cleanup candidate.
- Add stronger automated runtime-role policy API tests (status/set + hierarchy coercion + confirm enforcement) beyond smoke checks.
- (done) Add UI component tests for new Recent Signals/Opportunity Board dropdown persistence (dashboard + pop-out snapshots).
- (done) Add installer integration smoke in CI: `installer_smoke` job runs `install_candle_compass.sh` with `--skip-python-deps --skip-ui-deps --skip-ui-build --skip-desktop-launcher` and asserts .venv, requirements.txt, ui-next exist.
- Add UI integration tests for settings-driven preference propagation (`candle_compass.ui_preferences`) into dashboard refresh cadence, chart defaults, and floating chat visibility.
- Host tooling note: `npm` command path is intermittently unusable in this environment (`permission denied` on system npm binary); local validation works via `app/ui-next/node_modules/.bin/*`. Audit system Node/npm permissions to restore standard `npm run ...` flow.
- Add settings import/export schema validation and migration guards for future preference-key changes.
- Symbol catalog warnings currently include:
  - `wikipedia:*` table parse failures when `lxml` is not installed (catalog still builds via NASDAQ + run artifacts),
  - `ccxt:bybit` region block (`403`) on this host.
  Add provider/source health flags in UI and optional source-disable settings so operators can silence known non-critical feed failures.
- Symbol universe now includes large raw exchange listings; add default UI filters for synthetic/leveraged symbols to reduce operator noise while keeping full catalog available in advanced mode.
- Gap Hunter arbitrage feed currently uses ticker-level bid/ask snapshots only; add orderbook depth checks to avoid false positives on thin books.
- Triangular scanner currently reports loop opportunities from top-of-book rates; add per-leg slippage simulation and stale-ticker age guards.
- Live arbitrage scan may legitimately return zero opportunities in efficient market windows; add optional "near-miss" panel for visibility when no net-positive loops/spreads exist.
- Zen mode currently prioritizes chart focus by hiding non-chart widgets, launcher, and chat; add explicit QA checks for every widget rehydrate path when toggling back to normal mode.
- Progression unlocks are computed and displayed in navbar badge, but theme gating is not yet enforced in `/settings` theme selection UI.
- Signal summary card currently uses heuristic payload fields (technical/sentiment/whale proxies); add explicit backend confluence flags to reduce inference drift.
- (done) Strategy Lab runtime binding: activated templates drive live strategy routing via `strategy_lab_runtime.json`, orchestrator `_evaluate_strategy_lab_runtime`/`_apply_strategy_lab_runtime`, and run_orchestrator.py. No further work needed.
- `app/scripts/e2e_smoke.py --check-ws` can block longer than expected on some local runtimes; add explicit websocket probe timeout/abort safeguards so full smoke runs always terminate deterministically.
- Local runtime currently shows a listener on `127.0.0.1:3000` that can time out for HTTP probes; launcher hardening now supports alternate port startup with fail-fast checks, but port-3000 ownership/responsiveness still needs host-level audit.
- (done) Time Machine backend vectorized integration is covered by Python unit tests, but API contract tests for `timeMachineBacktest` POST path (payload guards + error semantics + fallback behavior) are still missing.
- (done) Runtime error events now append to `runs/latest/runtime_error_events.jsonl`; add retention/rotation policy so this file does not grow unbounded in long-lived deployments.
- (done) External backup rotation is currently manual (`scripts/rotate_external_backups.sh`); add optional timer automation and restore drill checklist verification.

## Open Runtime Gaps (2026-02-14)
- `POLYGON_API_KEY` missing: stock scanner universe is degraded until key is configured in encrypted secrets.
- `CANDLE_COMPASS_AI_CONTROLLER_KEY` missing: privileged `/ai/*` endpoints remain disabled.
- Social sentiment credentials incomplete: set `REDDIT_CLIENT_ID`, `REDDIT_CLIENT_SECRET`, `GOOGLE_TRENDS_API_KEY`.
- Redis unreachable at `127.0.0.1:6379` while `backend.redis.enabled=true`: start Redis locally or disable Redis for degraded local mode.

## Service Console Follow-ups
- Production hardening: set `CANDLE_COMPASS_RUNTIME_CONTROL_KEY` and `CANDLE_COMPASS_REQUIRE_RUNTIME_CONTROL_KEY=true` in deployed environments.
- Production hardening: set and document `CANDLE_COMPASS_RUNTIME_REQUIRED_ROLE` to align with operator policy (default `operator`).
- Validate `candle_compass-backend.service` rollout on target hosts using new scripts:
  - `app/scripts/install_backend_service.sh`
  - `app/scripts/stop_backend_service.sh`
  - `app/scripts/backend_service_status.sh`
- Validate destructive-operation auth in staging after policy changes:
  - confirmation text `CONFIRM_RUNTIME_DESTRUCTIVE_ACTION`,
  - role gate via `x-runtime-role` / `runtimeOperatorRole`,
  - runtime key gate via `x-runtime-control-key`.
- Local host note: default UI port `3000` was occupied by an external listener; UI service was installed on `127.0.0.1:3100`.
  - keep `CANDLE_COMPASS_UI_PORT` explicit in service install environments or add automated port-conflict handling in installer UX/API.

## Chart / Signals Follow-ups
- (done) Promote `trade_signals.json` generation into the normal bundle flow so chart markers are strategy-native rather than fallback-derived in degraded runs.
- Add signal freshness/staleness badges in chart and recent-signals modules.
