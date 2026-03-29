# TODO

## Immediate Runtime / GUI Follow-up (2026-03-06)
- [x] Fix false degraded launch state caused by stale/cached Next API runtime status and launcher env/key drift
- [x] Fix standalone Next API path resolution so installed/runtime routes read real `app/runs/latest` artifacts instead of `.next/standalone`-relative paths
- [x] Repair hydration and asset scoring tooling (`hydrate_all.sh`, `score_assets.py`) and verify full hydration succeeds
- [x] Add reusable live GUI/API smoke coverage (`app/scripts/gui_surface_smoke.py`) and pass it against the detached runtime
- [x] Bridge current frontend contracts onto the older live backend so workstation pages stop dying on `404`:
  - `multi_timeframe_signal` now compatibility-falls back to legacy `signal_blend`
  - alignment alert evaluation now works locally in compatibility mode when the backend lacks the newer route
  - `portfolio/overview` now falls back to local trade/journal/position artifacts
  - `execute/manual` now retries through legacy `/api/emergency/manual`
- [x] Repoint the active user `candle_compass.service` away from stale `/opt/CandleCompass` UI code and verify the live `3967` surface serves the current workspace build
- [x] M26 trade-history attribution pass:
  - paper close records now persist `close_effect`, parent lot sizing, realized holding hours, and initial quantity context
  - `portfolio/overview` now exposes reduce/full-close/flip summary counts plus close-attribution fields on recent trades
  - `PortfolioBookWidget` and `TradeJournalWidget` now surface close mix, partial/full/flip attribution, and journal-side trade history slicing
- [ ] M28 GUI density follow-up:
  - default desktop composition now opens with chart + oracle scanner + confluence context instead of the old narrow chart/right-rail stack
  - routed workstation shell now has a shared header plus a docked utility rail for the mini-map / co-pilot on wide screens, reducing the prior fixed-overlay overlap
  - continue rebalancing inner workstation layouts so center-canvas usage remains strong beyond the shared shell pass
  - reduce remaining sparse/rail-heavy compositions identified in the screenshot audit
- [x] M28 loading-state pass:
  - replaced raw `Loading ...` / `Building ...` text with shared loading surfaces and scanner-table skeleton rows across portfolio, notifications, options, health, appearance, and dashboard fallbacks
  - removed the specific raw loading/building copy still present in the audited UI surface set
- [ ] M28 workstation visual polish:
  - tighten panel header spacing/typography inside workstation content panels
  - normalize panel chrome across dashboard widgets versus routed workstation panels
  - audit left/right dock density now that the mini-map and co-pilot no longer float over the main canvas on wide layouts
  - use screenshot references under `app/runs/latest/gui_screens/` as the baseline audit set
- [ ] Optional provider coverage follow-up:
  - social/news coverage still falls back by default on this host
  - decide whether to provision the missing social provider inputs or formalize the current fallback experience further

## IMMEDIATE: Foundation (Phase 1)
- [x] Verify Global Rename (RSIGlobe -> Candle Compass)
- [x] Enable Redis in config.yaml
- [x] Enable Polygon in config.yaml

## NEXT: Visuals (Phase 2 & 20)
- [x] Build ChartPanel with Pop-out support
- [x] Implement Chameleon Theme System (Neon/Bloomberg/Zen)
- [x] Add interactive Accent color pickers to AppearancePanel
- [x] Add "Transition Mask" cinematic reboot to all theme switches

## Singularity Tier
- [x] Phase 20: Chameleon Theme Engine (JSON-based skinning)
- [x] Phase 21: Alpha Zero RL Agent (Stable Baselines PPO)
- [x] Phase 22: Flash Infrastructure (Numba JIT Optimization)
- [x] Phase 23: Context & Documentation Sync

## System Stabilization & Polish
- [x] 2026-02-26: UI shell duplication fix (removed root-layout sidebar so dashboard `SidebarDock` is the single primary nav on `/`)
- [x] 2026-02-26: Theme compatibility hardening (seed/bridge missing CSS tokens in `ThemeContext` + full fallback token defaults in `globals.css`)
- [x] 2026-02-26: Installer UX/hang mitigation (`install_candle_compass.sh` now shows timestamped step logs, verbose pip/npm phases, and clearer long-step progress)
- [x] 2026-02-26: Added `/api/data/[...artifact]` Next route to serve `app/runs/latest/*.json` artifacts for widget polling hooks (`useWidgetData`, `SidebarDock`)
- [x] 2026-02-26: Artifact route upgraded with aliases/index/freshness metadata headers (`whale_stream.json` -> `whale_events.json`, `/api/data/_index`)
- [x] 2026-02-26: Widget data-schema normalization for real artifacts (`social_hype.json`, `whale_events.json`, `risk_dashboard.json`, `research_feed.json`)
- [x] 2026-02-26: `hydrate_all.sh` rebuilt (venv autodetect, per-step status, timeouts, failure exit code, artifact verification)
- [x] 2026-02-26: Installer hardened for real distribution flow (required SQLite data-lake init during install, optional Postgres setup only when configured, hydration via `hydrate_all.sh` with clearer non-fatal warnings)
- [x] 2026-02-26: Desktop launcher/icon reliability improved (Desktop + App Menu `.desktop`, local icon install/caching, better desktop-dir resolution)
- [x] 2026-02-26: `launch_ui_detached.sh` self-heals Node/NVM PATH and prints log tail on startup failure (`/usr/bin/env: node` diagnosis)
- [x] 2026-02-26: Hydration crash fix for strategy package import path (`src.strategies` builder exports now optional for non-Lab workflows)
- [x] 2026-02-26: Installer PostgreSQL automation v2 (detect/install/start Postgres + Redis services, interactive existing-DB choice: keep/reinitialize/fresh, secure role password generation + stored local credential hints, auto-promote installed config to Postgres peer-auth defaults)
- [x] 2026-02-26: Backend launchers now load installer-generated Postgres env hints and bootstrap local data lake on first run
- [x] 2026-02-26: Candle Compass icon upgraded (cockeyed lit candle + compass motif with B/T/S/H trading letters) for desktop/app-menu branding
- [x] 2026-02-26: Removed remaining blocking `alert()`/`confirm()` calls from touched widgets (`MemeStreamWidget`, `RiskGuardianWidget`)
- [x] **Desktop Launch Stabilization**: Implemented `desktop_entry_point.sh` with environment loading and logging to `assistant/logs`.
- [x] **Incremental Backup**: Replaced tarball logic with `rsync` mirroring via `scripts/do_backup.sh`.
- [x] **UI Build Fix**: Resolved all TypeScript and Turbopack issues for production-grade compilation.
- [x] **Snappy UI**: Integrated snappy design tokens and transitions in `globals.css`.
- [x] **Docker Optimization**: Updated `Dockerfile` for multi-stage builds and `docker-compose.yml` for health checks and resource limits.
- [x] **Zen Mode Enhancements**: Added smooth framer-motion transitions and fixed missing cyber-neon-blue variable.
- [x] Phase 24: The Nervous System (Data Integration)
  - [x] Global API Client with mock fallbacks
  - [x] WebSocket Heartbeat Context
  - [x] SWR Data Hooks (useSignals, useArbitrage, usePortfolio)
- [x] Phase 25: Control Surfaces (Unified Navigation & Command Bar)
  - [x] Sidebar Navigation
  - [x] Global Command Bar (Cmd+K)
  - [x] Lucide Icon Integration

## Backlog (Completed or In Progress)
- [x] Phase 4: Accuracy Tracking Engine (Database Signal Recording)
- [x] Phase 10: The Cortex (AI Command & Control Chatbot)
- [x] Phase 11: Evolutionary Optimization (Genetic Algo for Parameters)
- [x] Phase 12: The Whale Hunter (Institutional Orderflow Visualization)
- [x] Phase 13: The Dimension Jumper (Spatial & Triangular Arbitrage + Risk Models)
- [x] Phase 14: Flow State UX (Navigation & Gamification + Zen Mode)
- [x] Phase 15: Context Preservation Automation
- [x] Phase 16: The Laboratory (Visual Strategy Builder + Runtime Binding)
- [x] Phase 17: The Time Machine (Market Replay Simulator + Vectorized Backtest)
- [x] Phase 18: The Newsroom (Narrative Intelligence + RSS Scan)
- [x] Phase 19: Audio Interface (Voice Command)
- [x] Phase 26: Live Data Visualization (Module Resurrection & Logic Wiring)
- [x] Phase 27: Ultimate Theme Studio (The Prism)
- [x] Phase 28: Real-Time Data Reactor (WebSocket Broadcaster)
- [x] Phase 29: The Control Plane (Master Settings)
- [x] Phase 30: World Class Polish (Audio & Visual Feedback)

## Hyper-Aggressive Expansion (Completed)
- [x] Phase 31: The Omniscient Aggregator (Master Confluence Engine)
- [x] Phase 32: The DEX Hunter (Meme Coin & Early Launch Scanner)
- [x] Phase 33: Cortex Agentic Upgrade (AI Pilot with Tool-Calling)
- [x] Phase 34: Copy-Trade & Prediction (Smart Money Flow + Prophet Overlay)
- [x] Phase 35: Master Polish & Final Context Sync
- [x] Phase 36: UI Hardening & Z-Index Standardization
- [x] Phase 37: Cortex Agentic Actions & Tool Registry
- [x] Phase 38: DEX Hunter Engine & Meme Stream
- [x] Phase 39: Smart Money & Whale Copy Engine
- [x] Phase 40: Universal Cortex Adaptability System
- [x] Phase 41: Singularity Master Prompt Injection
- [x] Phase 42: The Widget Omni-Registry (The App Store)
- [x] Phase 43: Module Content Injection (Risk Guardian, Social Hype, Arbitrage)
- [x] Phase 44: The Command Deck (Sidebar Navigation & Global Palette)
- [x] Phase 45: The Time Machine Engine (Market Replay)
- [x] Phase 46: The Strategy Laboratory
- [x] Phase 47: The Newsroom (Narrative Intelligence)
- [x] Phase 48: The Flash Optimization Core (Numba & Parallel Scanner)
- [x] Phase 49: The Sentinel Alert System
- [x] Phase 50: The Missing Widgets
- [x] Phase 51: The Omni-Registry (App Store Expansion)
- [x] Phase 52: The Control Deck (Sidebar Updates)
- [x] Phase 53: The Live Wire (Data Pump Hooks)
- [x] Phase 54: The Flash Core (Performance)
- [x] Phase 55: The Sentinel (External Gateways)

## Reality Check / Integration Verification (Current Focus)
- [x] Audit RSIGlobe merge carryover (`.files`/YAML/docs) for regression risk: merge commit review, repo YAML parse validation, and repo-wide legacy-brand audit (`brand_check.py --scope repo`)
- [x] Validate frontend render styling persists after hard refresh and installed-runtime restart (no white/plain fallback UI) (2026-03-06: fixed standalone Next asset packaging/runtime sync; live `/_next/static/*` assets now return `200` and Chromium render check passed)
- [x] Run `./app/scripts/hydrate_all.sh` (full and/or `HYDRATE_SKIP_FETCH=1`) and verify key widget artifacts populate without silent failures
- [x] Validate live host launch paths on canonical ports (`3967` UI, `8010` backend, `8766` memory MCP) and fix stale status/smoke defaults (`ui_status.sh`, `e2e_smoke.py`) (2026-03-06)
- [x] Eliminate frontend realtime/log noise and chart-size warnings from automated validation (`useStream`, `LiveMarketContext`, `RiskGuardianWidget`) (2026-03-06)
- [x] Reduce installer hydration stdout noise by moving step output into structured per-step logs (`runs/logs/hydrate`) (2026-03-06)
- [x] Re-run full fresh installer and validate installed copy via live HTTP + strict installed-copy smoke on default ports (`3967`/`8010`) (2026-03-06)
- [x] Stop tracking mutable runtime artifacts under `app/runs/` so real validation no longer dirties the worktree every session (2026-03-06: `app/runs` converted to generated workspace with placeholder dirs + README; tracked runtime outputs removed from git index)
- [x] Audit `/api/data/*.json` consumers and verify widget endpoint coverage (2026-03-04: 44 widgets audited — 42 GREEN, 2 YELLOW, 0 RED)
- [x] Verify widget artifact shape coverage against all App Store modules (2026-03-04: comprehensive audit passed — all widgets have real data sources)
- [x] Consolidate duplicate theme systems (`themes.json` + `themeConfig.ts`) into one canonical source (2026-03-04: 15 themes in unified `themes.json`, ThemeEditor wired into AppearancePanel, dead ThemeSelector identified)
- [x] Reproduce installer option `1` end-to-end and confirm no perceived hang during pip/npm/build steps on this host (2026-03-06: full fresh install completed successfully at `/opt/CandleCompass`; installed copy HTTP smoke passed)
- [x] Re-test fresh installer end-to-end after latest DB/desktop/launcher fixes (2026-03-06: desktop entry + app-menu launcher created, first-launch SQLite bootstrap verified, installed copy validated on `3969/8012`)
- [x] Re-test fresh installer after standalone UI runtime packaging fix (2026-03-06: full fresh reinstall passed on `3967/8010`; CSS/JS asset smoke and Chromium render check passed)
- [ ] Verify installer PostgreSQL interactive flows on host:
  - existing DB -> keep
  - existing DB -> reinitialize
  - existing DB -> fresh setup (new DB name)
  - no Postgres running -> auto-start recovery path
- [x] Add installer smoke script/test (`--dry-run` or non-interactive preflight) to catch future install regressions (`app/scripts/installer_smoke.sh`)
- [x] Run full validation pass after UI stabilization (`npm run lint`, `npm run build`, pytest, UI smoke)
- [x] Stop tracked runtime artifact churn from `app/runs/` so real validation/install sessions no longer leave dozens of modified files in git (2026-03-06: runtime outputs untracked; placeholders retained)
- [x] Continue M26 with actionable open-position controls and richer portfolio analytics (2026-03-06: Trade-desk prefill from Portfolio landed; position trim/close ticket generation, concentration, hold-age, long/short balance, and best/weakest symbol analytics now live)

## Backend Resource Optimization (2026-03-02)
- [x] Disable access logging + reduce log level (--no-access-log --log-level warning)
- [x] Cap concurrency (--limit-concurrency 100)
- [x] Lower CPU/IO priority on launch (renice +8, ionice -c2 -n7)
- [x] Reduce WebSocket broadcast frequency (2Hz → 1Hz, configurable)
- [x] Relax scanner poll interval (1s → 5s, configurable)
- [x] Cache JSON snapshot reads by mtime (avoid re-reading unchanged files)
- [x] Connection pooling with HTTPAdapter on requests.Session
- [x] Make torch import optional (skip heavy GPU library if not needed)
- [x] Exponential backoff on whale stream reconnect (4s → up to 2min)
- [x] Document performance tuning knobs in config.yaml (backend.performance section)
- [x] Apply to both launch_backend_detached.sh and run_backend_service.sh
- [x] Validation: 239 pytest + 75 vitest + ESLint clean + next build clean

## Deep Resource Optimization (2026-03-02, session 2)
- [x] Systemd service: Nice=10, CPUWeight=20, IOWeight=20, IOSchedulingClass, MemoryHigh=768M
- [x] Shared httpx.AsyncClient with keepalive + request deduplication + asyncio.Semaphore(10) hard cap
- [x] Scanner wired to async http_pool (Polygon/Binance async, ccxt sync fallback)
- [x] Skip-if-behind scheduler: poll loops skip instead of queue when behind
- [x] SQLite WAL mode + synchronous=NORMAL for better concurrent read/write
- [x] Batch insert (insert_records_batch) for bulk signal record writes
- [x] Event loop lag monitor in main.py lifespan
- [x] Enhanced /api/metrics: loop lag, queue depth, http stats, scanner polls, WS connections
- [x] config.yaml: http_pool_max_concurrent, sqlite_wal_mode, skip_if_behind knobs
- [x] Validation: 249 pytest + 76 vitest + ESLint clean + next build clean

## Comprehensive Accuracy & Validation Enhancement (2026-03-02)
- [x] Phase 1: Data Accuracy Foundation — cache TTL, price validator, timestamp normalization, 6 new schemas, ATR/slippage auditor
- [x] Phase 2: Self-Validation — accuracy trend monitor, artifact integrity monitor, orchestrator freshness gate
- [x] Phase 3: Confluence Engine — completed 3 placeholder signals (institutional/seasonality/arbitrage), wired into orchestrator
- [x] Phase 4: Missing Artifacts — ghost protocol status generator, DEX pairs schema fix, artifact health report
- [x] Phase 5-6: Frontend Trust — DataHealthWidget, useWidgetData endpoint mappings
- [x] Phase 8: Signal Audit Log — SHA-256 hash chain, tamper detection, append-only JSONL
- [x] Backend: 239 tests passing (up from 167), Frontend: 75 vitest passing, ESLint clean

## Validation & Save Pass (2026-03-01)
- [x] Frontend lint pass (0 errors, 0 warnings)
- [x] Frontend Vitest pass (`22 files / 76 tests`, 75 passed, 1 pre-existing timeout)
- [x] Frontend production build pass (`next build`)
- [x] Backend pytest pass (`167 passed`)
- [x] All `alert()`/`confirm()` blocking dialog violations eliminated (8 total across 5 files)
- [x] Security hardening: CORS, SSRF DNS resolution, path traversal, input sanitization, permissions

## Validation & Save Pass (2026-02-26)
- [x] Frontend lint pass (errors resolved; warnings remain for follow-up cleanup)
- [x] Frontend Vitest pass (`15 files / 50 tests`)
- [x] Frontend production build pass (`next build`)
- [x] Backend pytest pass (`167 passed`)
- [x] Hydration script compatibility repair + successful artifact generation (`hydrate_all.sh`)
- [x] External backup rotation run (`rotate_external_backups.sh`)
- [x] Final git commit + push (current session save)

## Strategic Upgrade (Report-Driven Prompt + Product Alignment)
- [x] Integrate enhanced master system prompt with explicit market/trading/risk/UI expertise directives
- [x] Add persistent report/reference doc for prompt upgrade and world-class terminal roadmap
- [x] Align `assistant/ROADMAP.md` with report phases (prompt/system, GUI modularity, engine/tooling, scale, security/docs)
- [ ] Align prompt templates (`assistant/prompts/*`) and project rules with the upgraded master prompt terminology and directives
- [ ] Create a module capability matrix mapping backend engines -> widget surfaces -> controls -> live data contract coverage
- [ ] Define explicit compliance/auth checklist for execution-capable features (RBAC, audit log, user confirmations, kill-switch policy)

## UIA Blueprint Integration (2026-02-26)
- [x] Add canonical UIA blueprint doc (`assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`)
- [x] Add tool-ready M1 prompt pack (`assistant/prompts/M1_DASHBOARD_FRAMEWORK_PROMPT_PACK.md`)
- [x] Index UIA blueprint + M1 prompt pack in `assistant/FULL_CONTEXT_INDEX.md`
- [x] Add UIA M1-M11 milestone execution track to `assistant/ROADMAP.md`
- [x] Merge UIA quality/rollback additions into `assistant/resources/docs/QUALITY_GATES.md`
- [ ] Implement M1 Dashboard Framework in `app/ui-next` (grid drag/resize + persistence) [code integrated; manual DnD validation + final compile/build verification pending]
- [x] Decide canonical dashboard layout engine (`react-grid-layout` vs existing custom grid) and document rationale (implemented in `DashboardManager.tsx`; preserves current widget system via wrapper/context)
- [ ] Add M1 tests (layout persistence, add/remove placeholder widgets, no-console-errors manual checklist) [partial: persistence + add/remove tests added]
- [ ] Define/implement dashboard layout storage contract for future M4 user persistence (localStorage key schema + versioning)

## UIA Blueprint Addendum Integration (2026-02-26)
- [x] Add canonical addendum doc (`assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT_ADDENDUM.md`)
- [x] Add addendum multi-tool prompt-pack template (`assistant/prompts/M12_M16_ADDENDUM_PROMPT_PACK.md`)
- [x] Extend M1 prompt pack with Windsor/Windsurf + Claude variants
- [x] Index addendum docs/prompt pack in `assistant/FULL_CONTEXT_INDEX.md`
- [x] Add M12-M16 to `assistant/ROADMAP.md`
- [x] Merge addendum single-developer safeguards into `assistant/resources/docs/QUALITY_GATES.md` / branch policy docs
- [x] Implement script guardrails/automation for documented branch conventions (`main`, `backup`, `design/tools`) [local git hook guards added: `pre-commit` + `pre-push`; explicit env overrides required for backup/design exceptions]
- [x] Create tool-usage log template for milestone execution (`tool`, `prompt pack`, `constraints`, `validation`, `issues`) (`assistant/resources/docs/AI_TOOL_USAGE_LOG_TEMPLATE.md`)
- [ ] Plan M12 Navigation/Menu implementation against current `SidebarDock` + command surfaces (avoid duplicate nav systems)

## Post‑2026‑02‑26 Next Instruction Set Integration
- [x] Add canonical next-instruction-set doc (`assistant/resources/docs/CANDLE_COMPASS_NEXT_INSTRUCTION_SET_POST_2026_02_26.md`)
- [x] Add M17-M23 milestone track to `assistant/ROADMAP.md`
- [x] Map M17-M23 into executable prompt packs (multi-tool variants) after milestone specs stabilize (`assistant/prompts/M17_M23_EXPANSION_PROMPT_PACK.md` + validator)
- [ ] Add milestone-by-milestone done criteria + validation rows (matching UIA blueprint style) for M17-M23

## Upcoming Milestones (Addendum Track)
- [ ] M12: Navigation & Menu System (top-level menus, submenus, dashboard toolbar, keyboard/ARIA) [partial: Dashboard/Data/Risk/Settings IA polished, help actions now open real shortcut/tour surfaces, automated keyboard/ARIA coverage expanded, manual browser pass still pending]
- [x] M13: Theme & Skin Manager (multi-skins, custom backgrounds, persistence, upload safety) [COMPLETE 2026-03-06: custom skin library landed with provider-level persistence, import/export/edit/delete/apply flows, blocking WCAG save policy, scoped live preview, and full background/custom-accent persistence]
- [x] M14: Beginner Mode & Guided Tour (guided onboarding + simplified mode) [PARTIAL 2026-03-04: OnboardingTour component implemented with welcome modal, 6-step guided tour, SVG overlay cutout highlighting, step-by-step tooltips, localStorage persistence. Wired into layout.tsx, tour targets on sidebar/chart/widgets/toolbar/navbar/settings. Restart Tour in settings. Beginner simplified mode still TODO.]
- [x] M15: Branch & Artifact Management (backup/design branch protections, automated sync) [COMPLETE 2026-03-06: backup mirror script, design/tools publish script, manifest-driven export, branch sync smoke test, CI smoke coverage, and branch-policy docs landed]
- [x] M16: Multi-Tool Prompt Pack Extension (full milestone prompt parity across all AI tools) [COMPLETE 2026-03-06: executable `M17-M23` prompt pack added, prompt-pack validator added, CI parity check added, and prompt-pack index/docs updated]

## Upcoming Milestones (Post‑2026‑02‑26 Track)
- [ ] M17: Installer & Platform Hardening [partial: package-manager detection (`apt/dnf/yum/pacman`) + `--preflight/--dry-run` mode + non-interactive `--action` + `--pg-policy` parsing + `--system-deps reuse|refresh` policy + explicit shared-dependency status reporting + reuse-aware dependency install behavior across `apt/dnf/yum/pacman` + Fedora `dnf` mapping corrected to `postgresql-server-devel` + `valkey-compat-redis` + Arch `pacman` mapping corrected to `valkey` + PostgreSQL bootstrap fallback to direct `initdb` on `dnf`/`yum` + container matrix validation script for Fedora/Arch + state-preserving fresh-install fix avoids `/tmp` exhaustion when reusing `.venv`/frontend caches + hydration output moved into per-step logs + fresh install + installed-copy HTTP smoke rerun successfully on default ports]
- [x] M18: Theme & Appearance Consolidation (single theme source, Theme Studio, contrast validation) [COMPLETE 2026-03-04: 15 themes unified in themes.json, ThemeEditor wired into AppearancePanel, WCAG contrast checks active, dead ThemeSelector cleaned up]
- [ ] M19: Signals & Indicators Expansion (signal API + SignalSummary/SignalAnalytics widgets)
- [ ] M20: Arbitrage & Spread Engine Expansion (Gap Hunter 2.0 + scheduling + spread heatmap)
- [ ] M21: Lab, Simulation & Education Modules (Strategy Lab + Time Machine + Beginner Mode expansion)
- [ ] M26: Portfolio & P&L Deepening [partial: real overview route, journal/book widgets, durable paper ledger, allocation compass, open-position ledger, trim/close ticket prefill flow, concentration/hold-age/balance analytics, close/reduction attribution, richer history slicing, portfolio close-mix metrics; next: cost-basis storytelling, realized-vs-unrealized drilldowns, and longer-window portfolio history filters]
- [ ] M22: Alerts, AI Assistance & Research Strategy Library
- [ ] M23: Governance & Compliance Scaffolding (RBAC, audit logs, secure keys)

## M17 Implementation Checklist (Installer & Platform Hardening)
- [x] Add installer package-manager detection scaffold (`apt`, `dnf`, `yum`, `pacman`)
- [x] Add `--preflight` / `--dry-run` prerequisite mode (no side effects)
- [x] Add non-interactive action selection (`--non-interactive --action ...`)
- [x] Add non-interactive PostgreSQL DB policy selection (`--pg-policy keep|reinitialize|fresh|skip`) so automation does not block on DB prompts
- [x] Improve installer progress UX with section headers
- [x] Keep preserved install state on the target filesystem during fresh installs (prevents `.venv`/`node_modules` moves from exhausting `/tmp`)
- [x] Make `dnf`/`yum`/`pacman` dependency installation reuse-aware instead of reinstalling blindly
- [x] Make installer/preflight/purge messaging explicit that shared Node/Postgres/Redis dependencies are preserved for reuse
- [x] Add explicit reuse/status prompts for Node/Postgres/Redis installs (beyond package-manager no-op)
- [x] Correct Fedora package/runtime assumptions (`postgresql-server-devel`, `valkey-compat-redis`) and add Valkey-aware detection
- [x] Correct Arch package/runtime assumptions (`valkey`) and add Valkey-aware detection
- [x] Add PostgreSQL bootstrap fallback to direct `initdb` when distro helper scripts are unavailable or unusable
- [x] Validate Fedora (`dnf`) package mappings, service unit names, and PostgreSQL bootstrap path in container matrix smoke
- [x] Validate Arch (`pacman`) package mappings, service unit names, and PostgreSQL bootstrap path in container matrix smoke
- [x] Add machine-readable preflight output (`--preflight --json`) for CI automation scaffolding
- [ ] Validate full Fedora host/systemd service start on a real machine
- [ ] Validate full Arch host/systemd service start on a real machine
- [ ] Reduce hydration/stdout noise during installer hydration and bundle phases

## M12 Implementation Checklist (Navigation & Toolbar)
- [x] Add top-level menu bar component with nested submenus (`NavMenuBar`)
- [x] Wire menus into `Navbar` with view navigation + action callbacks
- [x] Add dashboard toolbar component (`DashboardToolbar`) with context actions
- [x] Wire toolbar actions in `CommandCenter` (add widget, save/load layout snapshot, theme/settings, undo/redo placeholders)
- [x] Add keyboard-navigation interaction tests for menu/submenu flows (`NavMenuBar.test.tsx`)
- [x] Add mobile/collapsed navigation behavior validation pass (automated interaction coverage in `NavMenuBar.test.tsx`)
- [x] Expand submenu coverage for all major modules (Data/Risk/Settings) with final IA polish
- [x] Add automated ARIA + keyboard accessibility regression coverage (tab, escape, active-state metadata, help overlay dispatch)
- [ ] Manual browser ARIA + keyboard verification on live UI (desktop + collapsed menu)

## Next Build Target (UIA M1: Dashboard Framework)
- [x] Audit current dashboard components (`CommandCenter`, `DashboardWidget`, widget registry) for M1-compatible integration path
- [x] Create `DashboardManager.tsx` context/provider with typed widget layout state
- [x] Create `WidgetWrapper.tsx` with drag/resize/remove chrome
- [x] Create `WidgetPlaceholder.tsx` and initial placeholder shell support
- [x] Wire M1 dashboard manager into default dashboard page without breaking existing widgets
- [ ] Validate M1 with lint/tests/manual drag+resize+refresh persistence pass
- [ ] Manual browser verify M1 drag/resize behavior on real dashboard (desktop + one smaller breakpoint)
- [ ] Resolve/confirm local `next build` and `tsc --noEmit` stall behavior on this host after M1 changes (or verify on alternate host)

## Remaining Items / Future Phases
- [x] **Phase 56: True On-Chain "Snipe" Execution (Phase F)**
  - Integrate Web3.py / Solana.py for direct smart contract interaction.
  - Upgrade DEX Hunter to output signed transactions instead of simulated orders.
  - Implement slippage protection and front-running/MEV guardrails.
- [x] **Phase 57: Institutional Observability (Phase O)**
  - Refine WORM (Write Once Read Many) export logic for institutional-grade audit trails.
  - Integrate Prometheus metrics export (e.g., custom `/api/metrics`).
  - Set up alerting hooks for `runtime_error_events.jsonl` anomalies.
- [x] **Phase 58: E2E Integration Testing (Phase T)**
  - Expand UI integration tests (Vitest) for the new Confluence, Smart Money, Risk Guardian, and Arbitrage widgets.
  - Add explicit QA checks for Zen mode widget rehydration paths.
- [x] **Phase 59: Continuous Optimization**
  - Monitor live data reactor performance under high volatility.
  - Implement dynamic memory management for the vectorized backtest engine.
- [x] **Phase 60: Sentinel UI & Cortex Visuals**
  - Sentinel Alert Builder UI.
  - Cortex Chat-to-Chart Widget Generation.
  - Sniper Manual Trade Deck.
  - Genetic Optimizer Start UI.

## Session 2026-03-06: Completed Work (Codex)
- [x] Full fresh installer rerun completed successfully (`--non-interactive --action fresh --pg-policy keep`)
- [x] Installer preserve-state bug fixed (`/tmp` exhaustion during `.venv` move)
- [x] M17 dependency reuse UX hardened: `dnf`/`yum`/`pacman` now skip already-installed packages and preflight/purge paths state clearly that shared dependencies are preserved
- [x] M17 cross-distro package/runtime mappings corrected:
  - Fedora `dnf`: `postgresql-server-devel` + `valkey-compat-redis`
  - Arch `pacman`: `valkey`
  - installer now detects both Redis and Valkey binaries/services
- [x] M17 PostgreSQL bootstrap hardened:
  - `--system-deps reuse|refresh` added with explicit preflight/runtime status reporting
  - `dnf`/`yum` PostgreSQL bootstrap now falls back to direct `initdb` when `postgresql-setup` is unavailable or unusable
  - `installer_host_matrix_smoke.sh` added and passed for Fedora/Arch container package/unit/bootstrap validation
- [x] Full fresh installer rerun completed again after the latest M17 changes (`--non-interactive --action fresh --pg-policy keep --system-deps reuse`)
- [x] Installed-copy HTTP smoke rerun passed after the latest M17 changes (`3969` UI / `8012` backend)
- [x] M12 help-surface/menu polish completed with expanded keyboard/ARIA regression coverage
- [x] M13 Theme & Skin Manager completed:
  - provider-level custom theme persistence and selection
  - custom skin library (apply/edit/import/export/delete)
  - scoped Theme Studio live preview
  - blocking WCAG contrast save policy
  - `src/lib/theme.test.ts` added
- [x] M15 Branch & Artifact Management completed:
  - `git_sync_backup_branch.sh` formalized `main -> backup/*` mirroring
  - `git_sync_design_branch.sh` publishes the manifest-defined design surface to `design/*`
  - `design_tools_manifest.txt` defines the exported non-runtime surface
  - `branch_sync_smoke.sh` proves both flows against a temporary git repo
  - CI now runs installer smoke and branch-sync smoke using maintained scripts
- [x] M16 Multi-Tool Prompt Pack Extension completed:
  - `M17_M23_EXPANSION_PROMPT_PACK.md` added with Cursor/Codex/Gemini/Windsurf/Claude variants
  - `validate_prompt_packs.py` added for parity checks
  - CI now runs prompt-pack validation
  - context index and prompt-pack references updated
- [x] Validation: 343 pytest, 83 vitest, ESLint clean, next build clean

## Session 2026-03-05: Completed Work (Claude Code, Opus 4.6)
- [x] Full system reload, all 7 system files loaded and internalized
- [x] Baseline validation: 311 pytest, 76 vitest, ESLint clean, next build clean
- [x] M25 (God-Mode): NL Strategy Builder — strategy_builder.py parser + CortexAgent tool + API endpoints + NLStrategyBuilderWidget
- [x] M28 (God-Mode): Virtual Scrolling — useVirtualList.ts hook with ResizeObserver, applied to NotificationCenterWidget
- [x] M30 (God-Mode): Backend Computation Optimization — numpy-vectorized metrics_engine.py + batch_compute_metrics()
- [x] M31 (God-Mode): ARIA Navigation — role/aria-label/aria-current attributes on SidebarDock, Navbar, DashboardWidget, layout
- [x] M32 (God-Mode): Beginner/God Mode — ComplexityContext + settings panel + widget filtering in CommandCenter
- [x] M33 (God-Mode): DnD Polish — WidgetWrapper drag state feedback, cursor change, aria-roledescription, resize indicator
- [x] M35 (God-Mode): Notifications — notification_service.py + notifications router + NotificationCenterWidget
- [x] Cleanup: Removed duplicate crucible_scoreboard widget registry entry
- [x] 48 widgets total (up from 46), 343 pytest (up from 311), 76 vitest, ESLint clean, build clean

## Session 2026-03-04: Completed Work (Claude Code, Opus 4.6)
- [x] Full system reload and context internalization (all system files loaded)
- [x] Validation: 249 pytest, 76 vitest, ESLint clean, next build clean
- [x] M18 Theme Consolidation: 15 themes unified in themes.json, ThemeEditor wired into AppearancePanel
- [x] Widget Audit: 44 widgets audited — 42 GREEN, 2 YELLOW, 0 RED (all have real data sources)
- [x] Pydantic deprecation fix (min_items → min_length in simulation.py)
- [x] Backend + Frontend verified operational (port 8010 health OK, port 3967 rendering OK)
- [x] M14 Onboarding Tour: Welcome modal, 6-step guided tour with SVG overlay, step tooltips, localStorage persistence, Restart Tour in settings
- [x] Proposed M24-M28 milestones (notifications, multi-timeframe, portfolio P&L, social, mobile)

## Proposed New Milestones (M24-M28)
- [x] M24: Real-Time Notification Pipeline (push notifications, email/SMS alerts for signals, whale events, risk thresholds) [complete 2026-03-06: dispatcher routing policy supports per-event channels + quiet hours + severity thresholds; real Next notification route tree added; end-user settings surface landed; `/alerts` workstation landed; notification history/actions/search/filter flow live]
- [ ] M25: Multi-Timeframe Analysis Engine (correlated signals across 1m/5m/1h/1d, timeframe alignment scoring) [partial 2026-03-06: backend `/api/metrics/multi_timeframe_signal` landed, truthful `1d/1w/1mo` alignment live, frontend proxy + workstation widget landed, scanner ranking/workstation integration landed, alert routing landed, richer symbol controls landed, tests added; remaining: future sub-daily ingestion without fabricating intraday signals]
- [ ] M26: Portfolio Tracking & P&L Dashboard (paper-trade position tracking, realized/unrealized P&L, portfolio allocation visualization) [partial 2026-03-06: durable paper ledger landed via `app/src/portfolio/paper_book.py`, manual paper execution now persists through the real Trade desk, backend `/api/candle_compass/portfolio/overview` now returns positions + allocation + unrealized/net P&L + margin/market value, new `OpenPositionsWidget` + `AllocationCompassWidget` landed, `/portfolio` workstation materially upgraded; remaining: position reduction/close UX, richer cost-basis/history analytics, deeper allocation/risk visuals]
- [ ] M27: Community & Social Features (shared watchlists, strategy marketplace, leaderboard, signal sharing)
- [ ] M28: Mobile-Responsive Dashboard (responsive breakpoints, touch-optimized widgets, PWA manifest, offline mode)

## Recommended Next Execution Order
- [x] 1. M12 Navigation/Menu closeout batch (IA polish, help-surface wiring, automated accessibility coverage)
- [x] 2. M13 Theme & Skin Manager completion
- [ ] 3. M17 cross-distro installer/service validation and dependency reuse UX
- [x] 4. M15 branch/artifact sync automation formalization
- [x] 5. M16 multi-tool prompt-pack parity
- [x] 6. Runtime orchestration + routed workstation shell slice
  - backend-aware `launch_ui.sh` / `launch_ui_detached.sh`
  - detached backend hardening via `launch_backend_detached.sh`
  - structured degraded proxy behavior through `src/lib/api/backendProxy.ts`
  - real workstation routes added for charts/scanner/trade/risk/research/portfolio/strategy-lab/emergency
  - dashboard undo/redo is now real
- [x] 7. M24 notification delivery pipeline (build on M35 Notification Center)
  - 2026-03-06 completed:
    - dispatcher now supports `push` + `webhook`
    - admin control prefs now manage push destination + webhook credentials without truncating newer preference fields
    - scanner/whale/risk/accuracy backend events now fan out to remote delivery with cooldown throttling
    - Risk Guardian threshold breaches now emit a real risk notification
    - real Next notification route tree added
    - end-user notification settings surface added
    - `/alerts` workstation added
    - notification history/action workflow added
- [ ] 8. M25 multi-timeframe analysis (build on M19/M30 analytics foundation)
  - 2026-03-06 slice 1 complete:
    - backend `/api/metrics/multi_timeframe_signal`
    - truthful `1d/1w/1mo` alignment output with explicit intraday unavailability
    - frontend proxy route + `MultiTimeframeAlignmentWidget`
    - widget integrated into Charts / Scanner / Research
  - 2026-03-06 slice 2 complete:
    - scanner routes now support alignment-aware filtering/sorting
    - scanner workstation now renders a real selected-setup opportunity card with Trade/Cortex actions
    - detached backend `--restart` path now waits for PID/port clear before reporting health
  - 2026-03-06 slice 3 complete:
    - alignment alert evaluation route landed
    - alignment is now a first-class notification routing category
    - widget symbol controls, timeframe inspection, and manual alert emission landed
    - workstation shell restores `symbol` / `timeframe` route query params
  - remaining:
    - sub-daily ingestion without fabricated lower-timeframe data
- [ ] 9. M26 portfolio tracking and P&L dashboard expansion (build on Strategy P&L + risk widgets)
  - 2026-03-06 slice 1 complete:
    - backend `/api/candle_compass/portfolio/overview` landed
    - Next proxy route landed
    - `PortfolioBookWidget` and `TradeJournalWidget` landed
    - `/portfolio` workstation now has real book and journal surfaces
    - trade-journal notes save into `runs/latest/trade_journal.json`
  - 2026-03-06 slice 2 complete:
    - durable paper ledger landed in `app/src/portfolio/paper_book.py`
    - Trade desk paper orders now persist through the live `/api/candle_compass/execute/manual` path
    - portfolio overview now returns positions, allocation, unrealized/net P&L, market value, and margin used
    - `OpenPositionsWidget` and `AllocationCompassWidget` landed
    - `/portfolio` workstation now leads with marked book posture instead of only summary widgets
    - backend `/api/execute/manual` contract fixed and included in `app/main.py`
    - detached backend `--restart` now works even when the PID file is missing but the listener is healthy
  - remaining:
    - position reduction / close UX
    - richer cost-basis and historical analytics
    - deeper allocation / exposure visuals
- [ ] 10. M28 mobile-responsive dashboard (after nav/theme surfaces stabilize)
- [ ] 11. M27 community/social features (after portfolio + mobile surfaces exist)

## If Interrupted — Continuity Checklist
1. **Update** `assistant/context/WHERE_WE_LEFT_OFF.md`: what was done, validation commands run, any blocker.
2. **Update** this file: mark completed items `(done)`, add or refine items under "Next Best Steps / Phases" above.
3. **Optional**: Append `assistant/context/CHANGELOG.md` for significant changes.
4. **Next session**: Read `assistant/AGENTS_AND_SYSTEM.md`, then `WHERE_WE_LEFT_OFF.md` and this TODO so work resumes without drift.

## Phase Checklist (Auto-Managed)

- [x] Phase 1: Foundation + Global Rebrand
- [x] Phase 2: Killer Feature Charting Engine
- [x] Phase 3: Modular Dashboard + Categorization
- [x] Phase 5: Notifications + AI Controller
- [x] Phase 6: Seasonality + Social Sentiment
- [x] Phase 7: Risk Guardian + Execution Styles
- [x] Phase 8: Adaptive Confidence + Scoreboard
- [x] Phase 9: Ghost Protocol + Emergency Controls
- [x] Phase 14: Flow State UX (Navigation & Gamification)
- [x] Phase 15: Context Preservation Automation
