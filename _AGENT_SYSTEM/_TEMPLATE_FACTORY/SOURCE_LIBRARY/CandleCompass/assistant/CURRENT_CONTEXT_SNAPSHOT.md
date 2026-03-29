# 🧠 CANDLE COMPASS: CURRENT CONTEXT SNAPSHOT
Generated on: 2026-03-06 22:04:22

## 📋 Project Manifest
{
  "project_name": "CandleCompass",
  "version": "2.1.0-Singularity",
  "status": "M24_M26_M28_RUNTIME_STABLE_PORTFOLIO_ATTRIBUTION_ACTIVE",
  "critical_paths": {
    "rules": "assistant/rules/PROJECT_RULES.md",
    "todo": "assistant/TODO.md",
    "architecture": "assistant/ARCHITECTURE.md",
    "master_prompt": "assistant/MASTER_SYSTEM_PROMPT.md"
  },
  "state": {
    "last_phase_completed": 60,
    "active_focus": "M26 portfolio history deepening is active: close/reduction attribution now flows through the paper ledger, portfolio overview, Portfolio Book, and Trade Journal. Next focus is cost-basis storytelling and realized-vs-open drilldowns while continuing M28 workstation chrome/density cleanup and host verification of installer PostgreSQL interactive flows."
  }
}


---

## 📄 MASTER_SYSTEM_PROMPT.md
# MASTER SYSTEM PROMPT: CANDLE COMPASS (SINGULARITY + MARKET INTELLIGENCE TIER)

## 1. Identity & Mission
You are the Chief Trading Systems Architect and Principal UX/UI Designer for Candle Compass.

You are also a seasoned trading-systems engineer and quantitative product designer with strong working knowledge of:
- equities, ETFs, options, futures, and digital assets
- market microstructure, order types, liquidity, venues, and execution quality
- algorithmic trading, backtesting, optimization, and risk management
- modern React/Next.js application architecture and high-performance Python services

### Mission
Build and continuously refine the world's most advanced, aesthetically stunning, modular, and customizable trading terminal for research, simulation, and operator-guided execution.

### Core Philosophy
"Speed is life. Clarity is profit. Aesthetics are functional. Domain expertise is power."

### Visual Language
Cyber-Futurist Glassmorphism:
- deep-space backgrounds (`#0a0b1e` family)
- neon data accents (bull/bear/neutral/premium)
- frosted glass panels with strict Z-index layering
- dense but readable information surfaces for serious trading workflows

## 2. Domain Expertise (Required Operating Context)

### Markets & Trading
- Understand market microstructure, bid/ask spread dynamics, liquidity holes, slippage, and execution routing implications.
- Distinguish spot vs derivatives behavior and data requirements.
- Design features with realistic market assumptions (latency, partial fills, stale quotes, outages, fees).
- Treat crypto, stocks, and derivatives as related but operationally different domains.

### Algo Trading & Research Engineering
- Design deterministic, testable, reproducible strategy pipelines.
- Support momentum, trend, mean reversion, stat-arb, sentiment, regime-aware systems, and ML/RL-assisted strategies.
- Prefer measurable diagnostics (Sharpe, drawdown, hit rate, expectancy, turnover, slippage-adjusted returns).
- Build systems that can operate in research mode, paper mode, and guarded live mode.

### Portfolio & Risk
- Enforce position sizing, exposure caps, drawdown controls, circuit breakers, and slippage/latency assumptions.
- Integrate risk controls into strategy output, execution routing, and UI guardrails.
- Surface risk status clearly in UI (not hidden in logs).

### Product / UX for Traders
- Design modular dashboards with pluggable/removable widgets (chart, order book, blotter, risk, news, sentiment, scanners, backtests, labs).
- Prefer fast operator workflows: hotkeys, clear affordances, stable layouts, minimal modal friction.
- Support customization (themes, widget layout, defaults, risk profiles, watchlists) without editing code.
- Prioritize usability under stress (volatile markets, partial data, degraded services).

## 3. Prime Directives (Non-Negotiable)

- **NO PLACEHOLDERS:** Never output `// ... rest of code`. Provide complete files/patches.
- **ZERO HALLUCINATION:** If a file/import/capability is missing, create it or explicitly mark it unsupported.
- **TYPE SAFETY:** Python uses type hints (and pydantic for contracts where appropriate). TypeScript stays strict.
- **CONTEXT PRESERVATION:** Before coding, read `assistant/TODO.md` and `assistant/context/universal_manifest.json`. After coding, update context.
- **UNIVERSAL COMPATIBILITY:** Outputs must work for human copy/paste and AI agent injection workflows.
- **MARKET REALISM:** Do not fake real trading capability or claim real execution/data accuracy when unavailable. Use explicit mock/degraded states.
- **RISK CONTROLS FIRST:** New trading/execution features must include safety checks, defaults, and user-visible warnings/limits.
- **REGULATORY AWARENESS:** Flag compliance and operational risks (auth, auditability, custody, logging, user consent) for execution features.
- **MODULAR DESIGN:** Build composable modules with stable interfaces. Avoid hard-coding single-provider assumptions.
- **TEST & VERIFY:** Provide validation steps; add or update tests for non-trivial logic changes (especially API, execution, backtesting, and widgets).

## 4. Architectural Standards

### Frontend (Next.js App Router, Tailwind, Framer Motion, Lightweight Charts)
- Use `ReactDOM.createPortal` for tooltips/popovers/modals that may clip.
- Wrap widgets consistently (`DashboardWidget` or equivalent shell) for glass styling and layout controls.
- Maintain strict layering with CSS variables (`--z-*`) and avoid accidental stacking-context regressions.
- Prefer resilient empty/loading/error states; widgets should not crash the dashboard if data is missing.
- Expose configuration and customization via UI controls (settings panels, module registry, theme studio, layout controls).

### Backend (Python 3.12, FastAPI, async services, Redis, SQL/SQLite/Postgres)
- API endpoints should be async when appropriate and explicit about degraded modes.
- Heavy math / scans should use `numpy`, `numba`, or parallel execution where justified.
- Treat data contracts as first-class: artifact shape compatibility, freshness metadata, and schema validation.
- Separate concerns: ingestion, analysis, execution, risk, notifications, optimization, and UI bundling.
- Register agent/tool actions explicitly (ActionRegistry / tool registry pattern).

### Installer / Ops / Distribution
- Installer should favor one-click reliability with safe defaults.
- Detect and provision required dependencies when possible; clearly explain interactive steps when not.
- Prefer local-first defaults (SQLite + optional Postgres/Redis enhancement) with graceful fallback behavior.
- Desktop launchers and service scripts must be diagnosable (clear logs, actionable failures).

## 5. Coding Protocol
1. **Analyze** request against `assistant/ARCHITECTURE.md`, `assistant/TODO.md`, and current runtime constraints.
2. **Design** the smallest robust change that advances the roadmap without breaking existing modules.
3. **Implement** full files/patches with production-grade error handling and sensible defaults.
4. **Verify** with concrete commands (lint/tests/build/smoke checks) and report actual results.
5. **Record** changes in context files (`TODO`, `WHERE_WE_LEFT_OFF`, session update, manifest) before finalizing.

## 6. Memory Recall / Recovery
If you are uncertain, context seems stale, or a new AI session starts:
- Read `assistant/context/universal_manifest.json` (state + focus)
- Read `assistant/ROADMAP.md` (strategic program)
- Read `assistant/TODO.md` (active execution backlog)
- Read `assistant/FIXME.md` (known issues / pending hardening)
- Read `assistant/HANDSHAKE.md` (entry protocol)
- Read `assistant/AGENTS_AND_SYSTEM.md` (multi-agent coordination and boundaries)

## 7. Output Behavior Expectations
- Be precise, not theatrical.
- Prefer operational truth over aspirational claims.
- Distinguish:
  - implemented vs planned
  - live vs mock/degraded
  - research-only vs execution-capable
- When proposing roadmap phases, include:
  - why it matters
  - dependencies
  - validation criteria
  - operator UX impact


---

## 📄 TODO.md
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


---

## 📄 ROADMAP.md
# Candle Compass: The Singularity Roadmap

## Strategic Program (Report-Aligned Upgrade)

### Phase A: Domain Expertise & Prompt/System Alignment
- [x] Upgrade `MASTER_SYSTEM_PROMPT.md` with explicit trading-domain expertise, risk controls, regulatory awareness, and modular UI/UX requirements
- [ ] Align prompt templates / agent rules with the upgraded master prompt language
- [ ] Add explicit market realism + compliance checklist to coding workflows

### Phase B: GUI Modularity & Customization (World-Class Terminal UX)
- [ ] Complete drag/drop + resize dashboard persistence for all production widgets
- [ ] Expand widget interaction controls (buttons, dropdowns, tooltips, settings) across all modules
- [ ] Finish theme system consolidation (single canonical theme source)
- [ ] Add accessibility + responsive QA pass across dashboard, popouts, settings, and command surfaces

### Phase C: Trading Engine & Algorithmic Tooling
- [ ] Strategy framework formalization (clear lifecycle hooks + parameter contracts)
- [ ] Interactive backtest API + UI controls (repeatable, deterministic)
- [ ] Parameter optimization UX + result visualization (grid/Bayesian search reporting)
- [ ] Execution abstraction expansion (crypto + stock broker connectors, sandbox/live guardrails)
- [ ] Portfolio/risk dashboard with unified limits, regime, and exposure monitoring

### Phase D: Data Ingestion, Reliability & Scale
- [ ] Unified multi-asset data normalization layer (stocks/crypto/derivatives shape contracts)
- [ ] Live data scalability/load testing (WebSocket fan-out, queueing, backpressure)
- [ ] Provider health surfacing in UI (feed status, stale data indicators, degraded mode banners)
- [ ] Caching/event-stream hardening (Redis Streams/Kafka evaluation if needed)

### Phase E: Security, Compliance, Documentation & Launch Readiness
- [ ] API auth/RBAC hardening for execution and admin routes
- [ ] Audit logging and security review for trading-sensitive flows
- [ ] README/onboarding documentation refresh (installation, config, extension guides)
- [ ] Alpha-user feedback loop + usability refinements
- [ ] Feature expansion prioritization (options analytics, journaling, social/copy-trade safeguards)

## UIA Blueprint Milestones (PRD/MVP Execution Track)

Reference: `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`

- [ ] M1 Dashboard Framework (grid-based drag/resize builder + persisted layouts) [NEXT EXECUTION TARGET]
- [ ] M2 Widget Library v1 (chart, positions/P&L, news + data subscriptions)
- [ ] M3 Strategy Framework & Backtesting Engine (lifecycle hooks + API + deterministic execution)
- [ ] M4 User Auth & Persistence (JWT + Postgres models/migrations for layouts/strategies)
- [ ] M5 Risk Management Module (real-time risk metrics + guard integration + user limits)
- [ ] M6 Strategy Builder UI (node-based builder -> executable strategy flow)
- [ ] M7 Multi-Asset Data Ingestion (equities/options/futures connectors + normalization)
- [ ] M8 Widget Library v2 & Risk Dashboard (DOM/blotter + dedicated risk surfaces)
- [ ] M9 Parameter Optimization & Strategy Analytics (optimization jobs + visualization)
- [ ] M10 Security & Compliance Hardening (rate limits, audit logs, secrets, validation)
- [ ] M11 Documentation & Onboarding (developer/operator/user docs + diagrams + setup guides)

### UIA Milestone Validation Principle
- Every M# milestone must define: inputs, outputs, done criteria, validation steps, and rollback notes in the implementing PR/session update.

## UIA Addendum Milestones (Contextual UI + Solo-Dev Workflow)

Reference: `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT_ADDENDUM.md`

- [ ] M12 Navigation & Menu System (global menus/submenus + dashboard toolbar)
- [x] M13 Theme & Skin Manager (multi-skin themes + custom backgrounds + persistence)
- [ ] M14 Beginner Mode & Guided Tour (simplified mode + onboarding overlays/tooltips)
- [x] M15 Branch & Artifact Management (main/backup/design-tools workflow safeguards + automation)
- [x] M16 Multi-Tool Prompt Pack Extension (Cursor/Codex/Gemini/Windsurf/Windsor/Claude parity)

## Post‑2026‑02‑26 Expansion Milestones (Next Instruction Set)

Reference: `assistant/resources/docs/CANDLE_COMPASS_NEXT_INSTRUCTION_SET_POST_2026_02_26.md`

- [ ] M17 Installer & Platform Hardening (cross-distro installer support, preflight/dry-run, service/runtime polish)
- [ ] M18 Theme & Appearance Consolidation (single theme source, Theme Studio, contrast validation)
- [ ] M19 Signals & Indicators Expansion (unified signal APIs + widgets + outcome analytics)
- [ ] M20 Arbitrage & Spread Engine Expansion (Gap Hunter 2.0, scheduling, simulator, spread heatmap)
- [ ] M21 Lab, Simulation & Education Modules (Strategy Lab upgrades, Time Machine UX, beginner training)
- [ ] M22 Alerts, AI Assistance & Research Strategy Library (alert hub, Cortex expansion, macro digest)
- [ ] M23 Governance & Compliance Scaffolding (RBAC, audit logs, secure keys, research-only controls)

### Addendum Execution Notes
- Treat `M12-M14` as product UX/navigation enhancements layered onto UIA M1+ framework work.
- Treat `M15-M16` as workflow/tooling/system-surface milestones (`assistant/`, CI/scripts, branch safety).

## Tier 1: Foundation & Visuals (The Terminal)
- [x] Phase 1: Infrastructure Revival & Rebranding (Redis, Polygon, Global Rename)
- [x] Phase 2: Oracle-Killer Charting (Layered Signals, Pop-outs)
- [x] Phase 3: Modular Dashboard (Grid System, Drag-and-Drop)
- [x] Phase 20: The Chameleon (JSON-based Semantic Theming Engine)

## Tier 2: The Edge (Execution & Data)
- [x] Phase 6: Time & Mind Engine (Seasonality Heatmaps, Hype Scanner)
- [x] Phase 7: The Guardian & Sniper (Risk Gates, Smart Execution)
- [x] Phase 12: The Whale Hunter (Institutional Orderflow Visualization)
- [x] Phase 13: The Dimension Jumper (Spatial & Triangular Arbitrage)

## Tier 3: The Intelligence (AI & Evolution)
- [x] Phase 4: Accuracy Tracking Engine (Database Signal Recording)
- [x] Phase 10: The Cortex (AI Command & Control Chatbot)
- [x] Phase 11: Evolutionary Optimization (Genetic Algo for Parameters)
- [x] Phase 21: Alpha Zero (Deep Reinforcement Learning Agent)

## Tier 4: The Ecosystem (Speed & Community)
- [x] Phase 16: The Laboratory (Visual Strategy Builder)
- [x] Phase 17: The Time Machine (Market Replay Simulator)
- [x] Phase 18: The Newsroom (Narrative Intelligence)
- [x] Phase 19: Audio Interface (Voice Command)
- [x] Phase 22: The Flash (Numba JIT Acceleration)

## Phase Checklist (Auto-Managed)

- [ ] Phase 5: Notifications + AI Controller
- [ ] Phase 8: Adaptive Confidence + Scoreboard
- [ ] Phase 9: Ghost Protocol + Emergency Controls
- [ ] Phase 14: Flow State UX (Navigation & Gamification)
- [ ] Phase 15: Context Preservation Automation

## Milestone Outcomes (Definition of "World-Class" for Candle Compass)
- [ ] Modular customizable terminal layout (all core tools pluggable/removable/swappable)
- [ ] Reliable live-data population across widgets with freshness/degraded-state visibility
- [ ] Robust backtesting + optimization workflow exposed through GUI
- [ ] Installer one-click path with dependency detection/provisioning and strong diagnostics
- [ ] Security + risk guardrails enforced across execution-capable flows
- [ ] Documentation + onboarding sufficient for new developer/operator setup without tribal knowledge


---

## 📄 rules/PROJECT_RULES.md
# Project Rules

1. Keep all changes runnable from repo root with explicit commands.
2. Default to research or paper-trading assumptions unless user explicitly requests live execution behavior.
3. Do not commit or expose secrets; use `.env`, encrypted storage, and secret tooling.
4. Treat `runs/latest/*` as contract artifacts for UI/API consumers.
5. When schema fields change, update producers, consumers, and data contract docs in one pass.
6. Prefer deterministic scripts and idempotent operations for automation.
7. Include transaction costs, slippage, and risk constraints in any backtest logic.
8. Validate data ingestion paths (schema, timestamps, missing values) before downstream use.
9. Add or update tests for material behavior changes.
10. Use targeted checks first; run broader suites when risk warrants it.
11. Record significant changes in `assistant/context/CHANGELOG.md` and `assistant/context/WHERE_WE_LEFT_OFF.md`.
12. Capture unfinished work, misses, and follow-ups in `assistant/TODO.md`.
13. Maintain only one backup copy; when creating a backup, remove older backups so a single archive is retained.
14. Preserve git connectivity to `origin/main` as an operational guardrail.
15. After major phase work, sync `assistant/TODO.md`, `assistant/context/CURRENT_STATUS.md`, `assistant/context/WHERE_WE_LEFT_OFF.md`, and `assistant/context/CHANGELOG.md` in the same pass.
16. **NEVER use blocking browser dialogs** (`window.alert`, `window.confirm`, `window.prompt`). Always use React modal components (`ConfirmDialog`, `PromptDialog`, `ModalShell`) that support ESC key, click-outside dismissal, and proper close buttons. See `assistant/rules/NO_BLOCKING_DIALOGS.md`.


---

## 📄 context/WHERE_WE_LEFT_OFF.md
# Where We Left Off

- **M26 close attribution + trade-history slicing landed (2026-03-06, Codex)**:
  - Continued the portfolio deepening pass instead of switching to pure shell polish.
  - `app/src/portfolio/paper_book.py` now persists paper-lot attribution data:
    - `initial_qty`
    - `close_effect`
    - `parent_trade_id`
    - `parent_qty_before`
    - `parent_remaining_qty_after`
    - `holding_hours`
  - `app/src/api/routers/metrics.py` now exposes:
    - reduce/full-close/flip counts
    - average realized holding time
    - realized exit notional
    - richer recent-trade close-attribution fields
  - `app/ui-next/src/lib/backendCompatibility.ts` now emits the same portfolio history contract when the older live backend lacks `/api/candle_compass/portfolio/overview`.
  - GUI changes:
    - `PortfolioBookWidget.tsx`
      - now shows close mix, hold time, closed-vs-parent lot sizing, and exit notional inside the realized attribution rail
    - `TradeJournalWidget.tsx`
      - now supports `All` / `Closed` / `Partial` / `Open` slicing
      - selected trades now show a dedicated close-attribution panel
  - Validation completed:
    - targeted backend pytest ✅ (`tests/test_manual_execute.py`, `tests/test_portfolio_overview.py`)
    - targeted frontend Vitest ✅ (`PortfolioBookWidget`, `TradeJournalWidget`, `backendCompatibility`)
    - touched-file ESLint ✅
    - frontend build ✅ (`cd app/ui-next && npx next build`)
  - Next best tasks:
    - continue `M26` with cost-basis storytelling for remaining lots after partial reductions
    - add deeper realized-vs-open drilldowns beyond the recent-trades rail
    - then return to `M28` workstation chrome/header spacing polish

- **Runtime bootstrap + live surface stabilization landed (2026-03-06, Codex)**:
  - Fixed the launch-state regression the user reported:
    - the UI no longer relies on stale/cached `/api/candle_compass` service status
    - backend health now reads live and stays stable after restart
  - Key runtime changes:
    - new shared launcher env bootstrap: `app/scripts/runtime_env.sh`
    - local loopback runtime keys auto-generated into `app/.env.local`
    - memory server auto-start from the UI launch path
    - standalone Next runtime path resolution fixed via `app/ui-next/src/lib/runtimePaths.ts`
    - all `app/ui-next/src/app/api/candle_compass/**` route handlers now force dynamic/no-store behavior
    - `api/candle_compass/route.ts` service-status probe no longer self-probes the UI and now uses a realistic backend timeout
  - Tooling/runtime validation:
    - `score_assets.py` fixed for pandas compatibility and uneven cached-series alignment
    - `hydrate_all.sh` repaired and now completes successfully on this host
    - new `app/scripts/gui_surface_smoke.py` waits for UI/backend readiness and currently passes all major routes/APIs
  - Live state now:
    - UI: `127.0.0.1:3967`
    - backend: `127.0.0.1:8010`
    - memory: `127.0.0.1:8766`
    - backend/memory service status now reads healthy in repeated live calls
  - Remaining honest advisories:
    - `POLYGON_API_KEY` missing
    - social sentiment running in fallback mode
    - Google Trends unavailable
  - Remaining GUI debt from screenshot audit:
    - dashboard/workstation center canvas still feels too empty
    - loading states are visually raw and some panel headers appear crowded during first paint
    - next best GUI milestone is `M28` density/loading-state polish, not more raw feature sprawl
  - Saved screenshot references:
    - `app/runs/latest/gui_screens/dashboard.png`
    - `app/runs/latest/gui_screens/scanner.png`
    - `app/runs/latest/gui_screens/trade.png`
    - `app/runs/latest/gui_screens/portfolio.png`
  - Next best tasks:
    - continue `M26` with close/reduction attribution and richer trade-history slicing
    - then move directly into `M28` workstation density/loading-state cleanup

- **M26 position-action UX + portfolio analytics slice landed (2026-03-06, Codex)**:
  - Continued directly after the durable paper book / portfolio desk expansion and finished the next missing operator layer instead of stalling on passive summaries.
  - Portfolio contract is richer now:
    - `app/src/api/routers/metrics.py`
      - summary adds:
        - profitable vs losing positions
        - long vs short position counts
        - gross long / gross short marked value
        - concentration percentage
        - average open-position age
        - best / weakest symbol
      - position rows now include `holding_hours`
      - symbol rows now include `net_pnl` and `avg_holding_hours`
  - Portfolio workstation is more actionable:
    - `OpenPositionsWidget.tsx`
      - added `Trim 25%`, `Trim 50%`, and `Close`
      - actions prefill the Trade desk with the correct offsetting side and quantity instead of silently firing orders
      - holding age is shown inline with the position row
    - `CommandCenter.tsx`
      - added Trade ticket prefill flow from Portfolio-originated actions
      - paper positions now force paper mode when routed into the Trade desk
    - `AllocationCompassWidget.tsx`
      - now surfaces concentration, book balance, profitable vs losing positions, average hold, and best/weakest symbol
    - `PortfolioBookWidget.tsx`
      - now shows net P&L and average hold per symbol and exposes best/weakest symbol context
  - Validation completed:
    - targeted backend test ✅
    - targeted portfolio widget tests ✅
    - full backend pytest ✅ (`360 passed`)
    - full frontend vitest ✅ (`93 passed`)
    - frontend lint ✅
    - frontend build ✅
    - live runtime reloaded and `/portfolio` rechecked ✅
  - Current runtime:
    - UI detached active on `127.0.0.1:3967`
    - backend detached active on `127.0.0.1:8010`
  - Next best tasks:
    - continue `M26` with trade-history slicing, explicit close/reduction attribution, and deeper cost-basis narrative
    - then move into `M28` responsive workstation cleanup
  - Known cleanup:
    - `app/ui-next/src/components/layout/Navbar.tsx` still appears unused
    - Polygon stock warnings remain expected until `POLYGON_API_KEY` is configured
    - pre-existing `ccxt` unclosed-session warning on forced backend foreground shutdown still exists

- **M26 durable paper ledger + live Trade desk repair landed (2026-03-06, Codex)**:
  - Continued directly after the first Portfolio workstation slice and completed the missing paper-book substrate instead of stopping at summary widgets.
  - Backend substrate now exists:
    - new `app/src/portfolio/paper_book.py`
      - durable paper trade persistence
      - open-position reconstruction
      - mark-price resolution from cached quote/OHLCV sources
      - `paper_positions.json` snapshot generation
    - `app/src/api/routers/execution.py`
      - manual execution now accepts `paper_mode`
      - paper fills persist into `runs/latest/trades.json`
      - live intent remains explicitly simulated and unrecorded until a real broker adapter exists
    - `app/src/api/routers/metrics.py`
      - portfolio overview now returns:
        - positions
        - allocation slices
        - unrealized / net P&L
        - market value
        - margin used
        - richer recent-trade metadata
  - Found and fixed a real runtime defect while validating:
    - the Trade desk proxy called `/api/execute/manual`, but backend manual execution only existed under `/api/emergency/manual`
    - fixed by exposing the manual execution handler on both routes and including the proper router in `app/main.py`
    - live validation confirmed the real workstation proxy now works
  - GUI expansion landed on top of the durable book:
    - new widgets:
      - `OpenPositionsWidget.tsx`
      - `AllocationCompassWidget.tsx`
    - upgraded:
      - `PortfolioBookWidget.tsx`
      - `TradeJournalWidget.tsx`
    - `CommandCenter.tsx`:
      - Trade desk now forwards `paper_mode`
      - successful paper orders trigger immediate portfolio refresh
      - Trade desk now explains paper-persisted vs live-simulated execution clearly
      - `/portfolio` workstation now leads with marked positions + allocation posture
    - widget catalog expanded with:
      - `ALLOCATION_COMPASS`
      - `OPEN_POSITIONS_LEDGER`
  - Launcher/runtime improvement landed during the same pass:
    - `app/scripts/launch_backend_detached.sh --restart` now truly forces restart even if the backend is already healthy but the PID file is missing
    - it now reconstructs listener PID state and rewrites the PID file in healthy attach cases
  - Validation completed:
    - backend pytest ✅ (`359 passed`)
    - frontend vitest ✅ (`93 passed`)
    - frontend lint ✅
    - frontend build ✅
    - shell syntax ✅: `bash -n app/scripts/launch_backend_detached.sh`
    - live runtime ✅:
      - forced detached backend restart succeeded through the fixed launcher
      - `POST /api/candle_compass/execute/manual` returned `200`
      - paper fills persisted and immediately surfaced in `/api/candle_compass/portfolio/overview`
    - current runtime:
      - UI detached active on `127.0.0.1:3967`
      - backend detached active on `127.0.0.1:8010`
  - Next best tasks:
    - continue `M26`:
      - position reduction/close UX
      - cost-basis-aware portfolio analytics and richer trade history slicing
      - richer allocation / exposure visuals
    - then move into `M28` responsive workstation cleanup
  - Known cleanup:
    - `app/ui-next/src/components/layout/Navbar.tsx` still appears unused
    - pre-existing `ccxt` unclosed-session warning on forced backend foreground shutdown still exists

- **M26 portfolio workstation now has a real book/journal layer (2026-03-06, Codex)**:
  - Continued directly after the completed `M25` alert/symbol-control slice instead of stopping at documentation.
  - Landed a normalized portfolio contract:
    - `app/src/api/routers/metrics.py`
      - new `GET /api/candle_compass/portfolio/overview`
      - summarizes total trades, closed/open count, watchlist context, journal coverage, explicit realized P&L coverage, symbol rollups, and recent trades
      - keeps data honest:
        - only explicit numeric `pnl` contributes to realized P&L
        - `return_pct` remains separate and is not silently converted into dollars
        - empty trade ledgers still return a usable workstation payload
    - backend regression coverage added in `tests/test_portfolio_overview.py`
  - Frontend Portfolio desk is materially deeper now:
    - new Next proxy route:
      - `app/ui-next/src/app/api/candle_compass/portfolio/overview/route.ts`
    - new shared hook:
      - `app/ui-next/src/lib/portfolio/usePortfolioOverview.ts`
    - new widgets:
      - `PortfolioBookWidget.tsx`
      - `TradeJournalWidget.tsx`
    - `CommandCenter.tsx` now mounts both widgets on `/portfolio` and also supports them as dashboard modules:
      - `PORTFOLIO_BOOK`
      - `TRADE_JOURNAL`
    - journal note saves go through the existing `/api/candle_compass` mutation path and write into `runs/latest/trade_journal.json`
    - symbol actions can focus the current symbol or route directly into the Trade desk
  - Validation completed:
    - backend pytest ✅ (`358 passed`)
    - frontend vitest ✅ (`91 passed`)
    - frontend lint ✅
    - frontend build ✅
    - live host validation ✅:
      - backend portfolio overview route `200`
      - Next proxy portfolio overview route `200`
      - `/portfolio` workstation route `200`
    - current runtime:
      - UI detached active on `127.0.0.1:3967`
      - backend detached active on `127.0.0.1:8010`
  - Next best tasks:
    - continue `M26`:
      - add a durable positions ledger
      - split realized vs unrealized P&L
      - add allocation visualization once position/account state is available
    - keep `M25` open only for future sub-daily OHLCV ingestion; alert routing and symbol controls are already landed
  - Known cleanup:
    - `app/ui-next/src/components/layout/Navbar.tsx` still appears unused
    - pre-existing `ccxt` unclosed-session warning on forced backend foreground shutdown still exists

- **M25 scanner alignment is now wired into the scanner desk (2026-03-06, Codex)**:
  - Continued `M25` after the initial multi-timeframe widget slice and integrated it into scanner workflows:
    - `app/src/api/routers/scanners.py`
      - scanner routes now support `min_alignment_score`, `preferred_primary_action`, `sort_by=alignment`, and `sort_by=alignment_adjusted`
      - top-ranked scanner rows are enriched with:
        - `mtfPrimaryAction`
        - `mtfAlignmentScore`
        - `mtfConflictScore`
        - `mtfConfidence`
        - `mtfSummary`
        - `mtfSupportedTimeframes`
        - `alignmentAdjustedScore`
        - `alertEligible`
      - alignment sampling is intentionally bounded so live scanner endpoints stay responsive instead of attempting full-universe MTF scoring
    - `app/ui-next/src/components/widgets/OracleScannerWidget.tsx`
      - adds `MTF Bias` / `Align` columns
      - selected row is now highlighted
      - row selection is emitted upstream instead of staying internal-only
    - `app/ui-next/src/components/widgets/TradeOpportunityCard.tsx`
      - now renders real scanner-derived alignment and execution context
      - action buttons can execute real Trade/Cortex flows
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
      - scanner workstation opportunity card is now driven by the selected oracle row
      - execute action moves the user into the Trade desk focused on the selected setup
      - Ask Cortex action opens the copilot with a contextual prompt for the selected symbol/setup
  - Runtime fix landed during the same pass:
    - `app/scripts/launch_backend_detached.sh --restart` now waits for the old backend PID and port to clear before it evaluates health again
    - this fixes the false-positive restart path where the script could kill the old backend and then immediately treat the old transient health response as success
  - Validation completed:
    - frontend lint ✅
    - frontend vitest ✅ (`87 passed`)
    - frontend build ✅
    - backend pytest ✅ (`353 passed`)
    - live scanner validation ✅:
      - backend oracle scanner route
      - backend custom scanner route with `alignment_adjusted`
      - Next proxy oracle scanner route
    - current runtime:
      - UI detached active on `127.0.0.1:3967`
      - backend detached active on `127.0.0.1:8010`
  - Next best tasks:
    - continue `M25` phase 3:
      - route multi-timeframe alignment states into alert generation
      - add richer symbol/timeframe controls and comparisons to the new alignment surfaces
      - keep sub-daily support explicitly unavailable until real ingestion exists
    - then move to `M26` portfolio/P&L expansion
  - Known cleanup:
    - `app/ui-next/src/components/layout/Navbar.tsx` still appears unused
    - pre-existing `ccxt` unclosed-session warning on forced backend foreground shutdown still exists

- **M24 is functionally complete; M25 has started (2026-03-06, Codex)**:
  - Saved the master execution plan in-repo:
    - `assistant/resources/docs/CANDLE_COMPASS_ULTIMATE_ADVANCEMENT_PLAN_2026_03_06.md`
    - indexed in `assistant/FULL_CONTEXT_INDEX.md`
  - Closed the remaining `M24` gaps:
    - real Next notification API tree under `app/ui-next/src/app/api/candle_compass/notifications/**`
    - end-user notification settings in `NotificationPreferencesPanel.tsx`
    - settings integration in `/settings` and `SettingsModal`
    - dedicated `/alerts` workstation
    - notification history filters, search, mark-read, clear-all, and action routing
    - dispatcher routing policy now supports per-event channels, minimum severity, quiet hours, and event-level enable/disable
    - emitters now attach `action_url` metadata so alerts can deep-link into desks
    - admin control route now preserves the expanded notification preference structure
  - Started `M25` with a truthful first slice:
    - new backend endpoint: `/api/metrics/multi_timeframe_signal`
    - current supported frames: `1d`, `1w`, `1mo`
    - current unsupported frames are called out explicitly: `1m`, `5m`, `15m`, `1h`, `4h`
    - new frontend proxy route + `MultiTimeframeAlignmentWidget`
    - widget now appears in `Charts`, `Scanner`, and `Research`
  - Runtime/dev launcher parity also improved:
    - `launch_ui_detached.sh` now stays alive after the caller exits
    - `launch_backend_detached.sh --restart` now exists for code-refresh workflows
    - `memory_status.sh` clears stale PID files
  - Validation completed:
    - frontend lint ✅
    - frontend vitest ✅ (`87 passed`)
    - frontend build ✅
    - backend pytest ✅ (`351 passed`)
    - live validation ✅:
      - `/alerts`
      - notification preferences route
      - notification emit/list flow
      - multi-timeframe backend route
      - multi-timeframe UI proxy route
    - current live runtime:
      - UI detached active on `127.0.0.1:3967`
      - backend detached active on `127.0.0.1:8010`
  - Next best tasks:
    - continue `M25` phase 2:
      - integrate multi-timeframe alignment into scanner ranking
      - add multi-timeframe-driven alert triggers
      - expose symbol/timeframe controls and richer comparisons in the new widget
      - prepare the path for sub-daily ingestion without faking intraday intelligence
    - then move to `M26` portfolio/P&L expansion
  - Known cleanup:
    - `app/ui-next/src/components/layout/Navbar.tsx` still appears unused
    - pre-existing `ccxt` unclosed-session warning on forced backend foreground shutdown still exists

- **Runtime orchestration + routed workstation shell slice completed (2026-03-06, Codex)**:
  - Implemented the first large execution slice from the new master plan instead of another planning-only pass.
  - Runtime/launcher work:
    - `app/scripts/launch_ui.sh` now checks backend state, auto-attempts backend startup, and clearly reports full-mode vs degraded-mode startup
    - `app/scripts/launch_ui_detached.sh` now follows the same backend-aware startup contract
    - `app/scripts/launch_backend_detached.sh` now uses `setsid` + stdin isolation for more reliable detachment on this host
    - new backend startup policy env/CLI behavior:
      - `CANDLE_COMPASS_BACKEND_POLICY=auto|required|degraded|skip`
  - Backend proxy hardening:
    - added `app/ui-next/src/lib/api/backendProxy.ts`
    - the backend-bound Next proxy routes now return structured degraded `503` responses when backend is offline instead of dumping repeated raw `ECONNREFUSED` errors
    - validated explicitly on:
      - `GET /api/candle_compass/metrics/signal_blend`
      - `POST /api/candle_compass/alerts/dispatch`
  - App-shell/workstation progress:
    - added canonical workstation registry in `app/ui-next/src/lib/workstations.ts`
    - created real routes for:
      - `/charts`
      - `/scanner`
      - `/trade`
      - `/risk`
      - `/research`
      - `/portfolio`
      - `/strategy-lab`
      - `/emergency`
    - `CommandCenter` is now route-backed via `initialView` + `routeForView(...)`
  - Workstation implementation landed:
    - `Charts`: main chart desk + signal summary + regime + multi-chart/options context
    - `Scanner`: oracle scanner + category scanner + arbitrage + opportunity snapshot
    - `Trade`: real quick-order rail using `/api/candle_compass/execute/manual` + bracket builder + execution intelligence panel
    - `Risk`: Risk Guardian + Risk Dashboard + Notification Center + System Operations
    - `Research`: newsroom + sentiment + whale vault + correlation + seasonality
    - `Portfolio`: portfolio radar + P&L + risk overlay + notifications
    - `Strategy Lab` and `Emergency` now have clearer dedicated workstation layouts
  - Dashboard/shell polish included:
    - layout undo/redo is now real through `DashboardManager.tsx`
    - `DashboardToolbar` reflects actual undo/redo availability
    - feedback is now a prompt-backed capture flow stored in localStorage instead of a toast-only placeholder
    - API module-status fallback no longer lies that backend/memory are healthy when fetch fails
  - Validation completed:
    - frontend lint ✅
    - frontend vitest ✅ (`85 passed`)
    - frontend build ✅
    - backend pytest ✅ (`346 passed`)
    - live launcher-path validation ✅:
      - stopped detached UI/backend
      - launched via `bash app/scripts/launch_ui.sh app --no-open`
      - confirmed UI route responses on `/`, `/charts`, `/trade`, `/risk`, `/research`
      - confirmed backend health in full mode
      - then stopped backend and verified structured degraded `503` proxy responses instead of raw spam
      - confirmed detached backend relaunch is healthy after the `setsid` hardening
  - Important remaining follow-up:
    - finish `M24` properly:
      - per-event routing policy
      - end-user notification settings surface
      - notification history / action workflows
    - then begin and complete `M25`
    - clean up unused `app/ui-next/src/components/layout/Navbar.tsx`
    - investigate the pre-existing `ccxt` unclosed client-session warning on forced backend foreground shutdown

- **M24 notification delivery slice 1 completed (2026-03-06, Codex)**:
  - Resumed after loading:
    - `assistant/MASTER_SYSTEM_PROMPT.md`
    - `assistant/ASSISTANT_LOADOUT.md`
    - `assistant/FULL_CONTEXT_INDEX.md`
    - `assistant/context/CURRENT_STATUS.md`
    - `assistant/context/WHERE_WE_LEFT_OFF.md`
    - `assistant/TODO.md`
    - `assistant/ROADMAP.md`
  - Implemented the first real `M24` delivery pass:
    - `app/src/notifications/dispatcher.py`
      - added `push` and `webhook` delivery support
      - Telegram is now normalized as the user-facing `push` channel
      - webhook delivery reads per-user webhook URL/secret preferences
      - added `send_notification_event(...)` helper for non-trade backend events
    - `app/src/monitoring/notification_emitters.py`
      - scanner, whale, risk, and accuracy notifications now fan out to remote delivery channels as well as the local Notification Center
      - remote delivery now has cooldown throttling to reduce alert storms
    - `app/src/execution/orchestrator.py`
      - Risk Guardian threshold breaches now emit a real risk alert
    - `app/ui-next/src/app/api/candle_compass/admin/control/route.ts`
      - notification preference normalization now supports `push` and `webhook`
    - `app/ui-next/src/components/admin/AdminControlPanel.tsx`
      - admin UI now supports push destination plus webhook URL/secret editing per user
  - Fixed one audit-found bug while doing M24:
    - `app/main.py` whale fan-out was passing `size_usd`, but the actual payload field is `notional`
  - Added/updated tests:
    - `tests/test_notification_dispatcher.py`
    - `tests/test_notification_emitters.py`
    - `app/ui-next/src/app/api/candle_compass/admin/control.notifications.test.ts`
  - Validation:
    - `./.venv/bin/python -m pytest -q` ✅ (`346 passed`)
    - `cd app/ui-next && npm run lint` ✅
    - `cd app/ui-next && npm run test` ✅ (`85 passed`)
    - `cd app/ui-next && npm run build` ✅
  - Next step:
    - finish `M24` with per-event routing policy and a broader end-user-facing notification settings surface
    - then continue `M25 -> M26 -> M28 -> M27`

- **Runtime workspace hygiene cleanup completed (2026-03-06, Codex)**:
  - `app/runs/` is no longer treated as a committed artifact store.
  - Implemented:
    - broad `app/runs/**` ignore policy in `.gitignore`
    - placeholder directory tracking via `.gitkeep`
    - `app/runs/README.md` explaining that runtime artifacts are generated local state
    - removal of tracked runtime outputs from the git index while leaving files on disk locally
  - Intended outcome:
    - future installs, launches, hydration runs, and smoke checks should stop dirtying the worktree with `app/runs/*`
  - Validation:
    - regenerated `app/runs/latest/app_settings.json`
    - `git status` remained clean
  - Next step:
    - return to roadmap work at `M24`

- **Night-stop state captured (2026-03-06, Codex)**:
  - After reinstall, render validation, smoke checks, lint/tests/build, and git save, Candle Compass services were intentionally stopped for the night.
  - Confirmed stopped state:
    - UI service inactive
    - backend service inactive
    - memory server stopped
  - Next-session restart options:
    - `systemctl --user start candle_compass-backend.service candle_compass.service`
    - or `/opt/CandleCompass/scripts/launch_ui_detached.sh`
  - Current dirty worktree state after shutdown is still only generated `app/runs/` artifacts.

- **Installed UI render defect is fixed (2026-03-06, Codex)**:
  - Reproduced the user-reported white/plain UI with real screenshots from `~/Pictures` and fresh Chromium captures.
  - Confirmed root cause:
    - live UI HTML returned `200`
    - installed `/_next/static/*` bundle URLs returned `404`
    - the standalone Next runtime was missing synced `.next/static` assets inside `.next/standalone/.next/static`
  - Fixed in:
    - `app/scripts/install_candle_compass.sh`
    - `app/scripts/launch_ui.sh`
    - `app/scripts/launch_ui_detached.sh`
    - `app/scripts/e2e_smoke.py`
  - Reran full fresh host reinstall successfully:
    - `bash app/scripts/install_candle_compass.sh --non-interactive --action fresh --pg-policy keep --system-deps reuse --user-services install`
  - Revalidated installed copy:
    - all discovered Next static assets now return `200`
    - installed UI/backend user services are active on `3967/8010`
    - strict installed-copy smoke with UI-root/static-asset coverage passed
    - real Chromium screenshot `~/Pictures/CandleCompass_render_check_20260306_fixed.png` confirms the themed UI now renders correctly
  - Full validation after fix:
    - `343` backend tests passed
    - frontend lint passed
    - frontend vitest passed (`83`)
    - frontend build passed
    - installer smoke passed
  - Remaining meaningful issues:
    - Postgres service auto-start still requires host sudo credentials, so install falls back to SQLite on this machine
    - `app/runs/` tracked runtime artifacts still dirty git after every real validation pass
  - Best next move:
    - clean up runtime-artifact git tracking
    - then resume roadmap work from `M24`

- **Stabilization Pass: Realtime Noise Cleanup + Fresh Install + Installed-Copy HTTP Validation (2026-03-06, Codex)**:
  - `app/ui-next/src/lib/runtimeDebug.ts`
    - added centralized runtime logging controls so websocket diagnostics stay available in live use but do not flood test/build output
  - `app/ui-next/src/hooks/useStream.ts`
    - disabled auto-connect churn in `NODE_ENV=test`
    - reconnect timers now stop cleanly on unmount instead of retrying after the component is gone
  - `app/ui-next/src/context/LiveMarketContext.tsx`
    - same realtime/test cleanup as `useStream`, plus safer reconnect lifecycle
  - `app/ui-next/src/components/widgets/RiskGuardianWidget.tsx`
    - removed the Recharts width/height warnings from Vitest and Next static build by avoiding SSR/test-time gauge container rendering
  - `app/scripts/hydrate_all.sh`
    - hydration now writes step logs to `runs/logs/hydrate`
    - successful runs stay concise; failures print the last log lines for the failing step
  - `app/scripts/ui_status.sh`
    - now honors an explicit root path instead of always inspecting `$(pwd)`
  - `.gitignore`
    - added root `node_modules/` ignore so accidental top-level installs stop polluting status
  - Validation completed:
    - `./.venv/bin/python -m pytest -q` ✅ (`343 passed`)
    - `cd app/ui-next && npm run lint` ✅
    - `cd app/ui-next && npm run test` ✅ (`83 passed`)
    - `cd app/ui-next && npm run build` ✅
    - `bash app/scripts/installer_smoke.sh` ✅
    - `HYDRATE_SKIP_FETCH=1 bash app/scripts/hydrate_all.sh` ✅
    - `bash app/scripts/install_candle_compass.sh --non-interactive --action fresh --pg-policy keep --system-deps reuse` ✅
    - installed-copy live validation on default ports:
      - `curl http://127.0.0.1:8010/api/health` ✅
      - `curl -I http://127.0.0.1:3967/` ✅
      - `/opt/CandleCompass/.venv/bin/python /opt/CandleCompass/scripts/e2e_smoke.py --runs /opt/CandleCompass/runs/latest --out /opt/CandleCompass/runs/latest/e2e_installed_default_http.json --strict --check-http` ✅
  - Important findings:
    - Postgres service auto-start is still blocked on this host by `sudo` password requirements, so installer correctly continues with SQLite
    - runtime artifacts under `app/runs/` remain tracked and are the biggest remaining git hygiene problem
  - Recommended next actions:
    - if Fedora/Arch hosts are available, finish real-host `M17`
    - otherwise move into `M24`

- **M17 Cross-Distro Validation + Bootstrap Hardening (2026-03-06, Codex)**:
  - `app/scripts/install_candle_compass.sh`
    - added `--system-deps reuse|refresh`
    - preflight/runtime now report shared dependency status for Node, npm, PostgreSQL, Redis/Valkey, and detected service state
    - corrected Fedora `dnf` packages to `postgresql-server-devel` + `valkey-compat-redis`
    - corrected Arch `pacman` package to `valkey`
    - added Valkey-aware detection and `dnf`/`yum` PostgreSQL direct-`initdb` fallback when `postgresql-setup` cannot initialize the cluster
  - `app/scripts/installer_smoke.sh`
    - expanded to cover `--system-deps`, new preflight status text, and env-driven refresh override
  - `app/scripts/installer_host_matrix_smoke.sh`
    - added containerized Fedora/Arch package-unit-bootstrap validation
  - Validation completed:
    - `bash -n app/scripts/install_candle_compass.sh app/scripts/installer_smoke.sh app/scripts/installer_host_matrix_smoke.sh` ✅
    - `bash app/scripts/installer_smoke.sh` ✅
    - `bash app/scripts/installer_host_matrix_smoke.sh all` ✅
    - `bash app/scripts/install_candle_compass.sh --non-interactive --action fresh --pg-policy keep --system-deps reuse` ✅
    - installed-copy HTTP smoke rerun on `3969/8012` ✅
  - Real issues found and fixed:
    - Fedora package assumptions were wrong (`postgresql-devel`, `redis`)
    - Arch package assumption was wrong (`redis`)
    - Fedora container path proved `postgresql-setup` can require host/systemd context, so the installer now falls back to direct `initdb`
  - Remaining `M17` work:
    - full Fedora host/systemd service-start validation on a real machine
    - full Arch host/systemd service-start validation on a real machine
  - Recommended next actions:
    - if a real Fedora/Arch host is available, finish the remaining host-systemd `M17` pass
    - otherwise move into `M24` notification delivery

- **M16 Multi-Tool Prompt Pack Extension Completion (2026-03-06, Codex)**:
  - `assistant/prompts/M17_M23_EXPANSION_PROMPT_PACK.md`
    - added executable prompt variants for Cursor, Codex, Gemini, Windsurf/Windsor, and Claude across the `M17-M23` milestone track
  - `app/scripts/validate_prompt_packs.py`
    - added parity validation so prompt-pack coverage is mechanically checkable instead of manual only
  - Updated supporting docs/index/CI:
    - `assistant/FULL_CONTEXT_INDEX.md`
    - `assistant/prompts/M12_M16_ADDENDUM_PROMPT_PACK.md`
    - `assistant/resources/docs/CANDLE_COMPASS_NEXT_INSTRUCTION_SET_POST_2026_02_26.md`
    - `assistant/resources/docs/QUALITY_GATES.md`
    - `.github/workflows/ci.yml`
  - Validation completed:
    - `python3 app/scripts/validate_prompt_packs.py` ✅
  - Recommended next actions:
    - continue remaining `M17` real-host validation that requires Fedora/Arch coverage
    - then move into `M24` notification delivery

- **M15 Branch & Artifact Management Completion (2026-03-06, Codex)**:
  - `app/scripts/git_sync_backup_branch.sh`
    - formalized `main/HEAD -> backup/*` branch mirroring with dry-run support
  - `app/scripts/git_sync_design_branch.sh`
    - publishes only the manifest-defined design/system surface to `design/*`
  - `assistant/resources/design_tools_manifest.txt`
    - defines the exported non-runtime surface (`assistant/`, `.githooks/`, optional `AGENTS.md`)
  - `app/scripts/branch_sync_smoke.sh`
    - proves both sync paths against a temporary git repo without touching the real remote
  - `.github/workflows/ci.yml`
    - fixed stale installer smoke usage and added branch-sync smoke coverage
  - Validation completed:
    - `bash -n app/scripts/git_sync_backup_branch.sh app/scripts/git_sync_design_branch.sh app/scripts/branch_sync_smoke.sh app/scripts/git_backup_branch.sh .githooks/pre-push app/scripts/install_git_hooks.sh` ✅
    - `bash app/scripts/branch_sync_smoke.sh` ✅
  - Recommended next actions:
    - continue remaining `M17` host-validation work that requires real Fedora/Arch coverage
    - then move directly into `M24`

- **M17 Installer Dependency Reuse UX Hardening (2026-03-06, Codex)**:
  - `app/scripts/install_candle_compass.sh`
    - normalized dependency install behavior across `apt`, `dnf`, `yum`, and `pacman` so already-installed packages are detected and reused instead of being reinstalled blindly
    - preflight/purge output now states the real safety policy explicitly: Candle Compass removes only its own files and launchers; shared Node/Postgres/Redis dependencies remain installed for reuse
  - `app/scripts/installer_smoke.sh`
    - now checks for the shared-dependency policy text in preflight output
  - Validation completed:
    - `bash -n app/scripts/install_candle_compass.sh app/scripts/installer_smoke.sh` ✅
    - `bash app/scripts/installer_smoke.sh` ✅
  - Remaining `M17` work:
    - validate Fedora (`dnf`) package/service mappings on a real host
    - validate Arch (`pacman`) package/service mappings on a real host
    - add even richer install-time reuse/status prompts around detected Node/Postgres/Redis binaries and services

- **M13 Theme & Skin Manager Completion (2026-03-06, Codex)**:
  - `app/ui-next/src/lib/theme.ts`
    - added a real custom-theme library contract: normalization, delete/import/export helpers, storage update events, selection keys, and custom-theme runtime token generation
    - tightened theme import validation so arbitrary JSON is rejected instead of silently becoming a blank draft
  - `app/ui-next/src/components/ThemeContext.tsx`
    - custom skins are now first-class theme selections
    - provider syncs custom theme library changes and reapplies UI preferences after theme switches, fixing accent/background override drift
  - `app/ui-next/src/components/settings/AppearancePanel.tsx`
    - added a persistent custom skin library with import/export/edit/delete/apply flows
    - built-in skins and saved custom skins are now separated cleanly in the settings UI
  - `app/ui-next/src/components/settings/ThemeEditor.tsx`
    - preview is now scoped to the editor instead of mutating the entire document while typing
    - save is blocked when WCAG contrast checks fail
    - supports draft export, reset, and editing existing saved skins
  - Added tests:
    - `app/ui-next/src/lib/theme.test.ts`
  - Validation completed:
    - `cd app/ui-next && npm run lint` ✅
    - `cd app/ui-next && npm run test` ✅ (`83 passed`)
    - `cd app/ui-next && npm run build` ✅
    - `.venv/bin/python -m pytest -q` ✅ (`343 passed`)
  - Recommended next milestone order:
    - `M17` installer cross-distro validation + dependency reuse UX
    - `M16` multi-tool prompt parity
    - then `M24 -> M25 -> M26 -> M28 -> M27`

- **Fresh Install Rerun, M12 Navigation Polish, and Installer Preserve Fix (2026-03-06, Codex)**:
  - Reconfirmed workspace MCP alignment: `.cursor/mcp.json` points to Candle Compass memory MCP on `http://127.0.0.1:8766/mcp`.
  - Completed a full fresh install at `/opt/CandleCompass`, then reran it after subsequent fixes.
  - Found and fixed a real installer defect during the rerun:
    - state-preserving fresh installs used `mktemp -d` in `/tmp`
    - preserving `.venv` that way turned `mv` into a cross-filesystem copy and exhausted tmpfs (`No space left on device`)
    - installer now keeps preserved state on the install filesystem itself (sibling stash when possible, hidden in-target stash when `/opt` parent is not writable)
  - Final installer status:
    - `bash app/scripts/install_candle_compass.sh --non-interactive --action fresh --pg-policy keep` -> success
    - desktop launcher created at `~/Desktop/CandleCompass.desktop`
    - app-menu launcher created at `~/.local/share/applications/CandleCompass.desktop`
    - installed copy bootstrapped SQLite at `/opt/CandleCompass/runs/candle_compass.db`
  - Installed-copy runtime validation:
    - backend launched on `127.0.0.1:8012`
    - UI launched on `127.0.0.1:3969`
    - `/opt/CandleCompass/.venv/bin/python /opt/CandleCompass/scripts/e2e_smoke.py --runs /opt/CandleCompass/runs/latest --out /opt/CandleCompass/runs/latest/e2e_installed_http_final.json --strict --check-http --ui-api-url http://127.0.0.1:3969/api/candle_compass --backend-health-url http://127.0.0.1:8012/api/health` -> `status=ok`
  - M12 navigation/menu implementation advanced:
    - `app/ui-next/src/components/layout/NavMenuBar.tsx`
      - menus reorganized around real surfaces: Dashboard / Data / Trade / Risk / Settings / Help
      - now uses actual `view` and `widget` dispatch paths instead of mostly action placeholders
      - added `aria-haspopup="menu"`, submenu `aria-orientation`, submenu `aria-current`, and close-on-`Tab`
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
      - help actions now trigger the real onboarding tour and keyboard-shortcuts overlay
    - `app/ui-next/src/components/dashboard/DashboardToolbar.tsx`
      - theme action now exposes the live onboarding target via `data-tour="theme-selector"`
    - `app/ui-next/src/components/onboarding/OnboardingTour.tsx`
      - added event-based restart hook so Help menu and future surfaces can reopen the guided tour
    - `app/ui-next/src/components/layout/NavMenuBar.test.tsx`
      - expanded coverage for view/widget/help dispatch and keyboard close behavior
  - Hydration/install warning cleanup:
    - removed `datetime.utcnow()` usage from:
      - `app/scripts/run_whale_watcher.py`
      - `app/scripts/run_accuracy_auditor_snapshot.py`
      - `app/scripts/run_cross_asset_intel.py`
      - `app/src/analytics/auditor.py`
      - `app/src/analytics/models.py`
    - verified the install-time scripts with `-W error::DeprecationWarning`
  - Validation completed:
    - `.venv/bin/python -m pytest -q` -> `343 passed`
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run test` -> `78 passed`
    - `cd app/ui-next && npm run build` -> pass
    - `bash app/scripts/installer_smoke.sh` -> pass
  - Important remaining oddities:
    - `app/ui-next/src/components/layout/Navbar.tsx` appears unused in the active UI shell and is likely dead code
    - Next.js build still emits chart container size warnings from the Risk widget/chart stack
    - hydration/bundle scripts still dump very large JSON payloads to stdout
    - backend Ctrl-C shutdown exposed an unclosed `ccxt` connector warning

- **Host Validation, MCP Alignment, and Ops Drift Fix (2026-03-06, Codex)**:
  - Confirmed workspace MCP config is Candle Compass-specific (`.cursor/mcp.json` -> `http://127.0.0.1:8766/mcp`), not Ledger Loop.
  - Verified direct SQLite bootstrap path: `.venv/bin/python app/scripts/ensure_data_lake.py --postgres-optional` completed successfully with no hang.
  - Verified current dirty tree with:
    - `.venv/bin/python -m pytest -q` -> `343 passed`
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run test` -> `76 passed`
    - `cd app/ui-next && npm run build` -> pass
    - `bash app/scripts/installer_smoke.sh` -> pass
  - Verified live host services and smoke path:
    - `systemctl --user start candle_compass-backend.service candle_compass.service`
    - backend health `127.0.0.1:8010` -> `200`
    - UI `127.0.0.1:3967` -> `200`
    - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke_default_http.json --strict --check-http` -> `status=ok`
  - Started and verified memory MCP:
    - `bash app/scripts/launch_memory_server.sh app`
    - `curl http://127.0.0.1:8766/health` -> `{"status":"ok"}`
    - `POST /mcp` `list_memories` succeeded
  - Fixed stale ops defaults:
    - `app/scripts/ui_status.sh` now defaults to `3967`
    - `app/scripts/e2e_smoke.py` now defaults to UI `3967` and backend/WebSocket `8010`
    - `app/scripts/install_candle_compass.sh` now supports `--pg-policy keep|reinitialize|fresh|skip`, so `--non-interactive` installs do not block on PostgreSQL prompts
  - Continuity note: root handoff references `.claude/plans/groovy-enchanting-locket.md`, but the file is absent from the repo. Use the code diff plus `WHERE_WE_LEFT_OFF.md` as the actual plan record.

- M18 Theme & Appearance Consolidation (partial) (2026-02-26):
  - Created canonical typed theme registry adapter:
    - `app/ui-next/src/themes/index.ts`
    - unifies access to both dynamic skin themes (`themes.json`) and legacy progression themes (`themeConfig.ts`) behind one module API
    - exports normalized dynamic themes with merged CSS vars + preview metadata
    - exports legacy theme config/entries for legacy `lib/theme` compatibility
  - Refactored current UI consumers to import from the registry (instead of raw config files):
    - `app/ui-next/src/components/ThemeContext.tsx`
    - `app/ui-next/src/components/settings/AppearancePanel.tsx`
    - `app/ui-next/src/lib/theme.ts`
  - Added registry validation tests:
    - `app/ui-next/src/themes/index.test.ts`
  - Added initial M18 contrast validation guardrails:
    - `app/ui-next/src/lib/colorContrast.ts` + `app/ui-next/src/lib/colorContrast.test.ts`
    - `app/ui-next/src/components/settings/ThemeEditor.tsx` now renders live WCAG-style contrast checks/warnings during custom theme editing
  - Validation completed:
    - targeted ESLint on theme registry + touched UI consumers ✅
    - Vitest: `src/themes/index.test.ts` + `src/lib/uiPreferences.test.ts` + `src/lib/colorContrast.test.ts` ✅
  - Remaining M18 work:
    - migrate remaining theme/editor surfaces to the registry (`ThemeEditor`, `ThemeSelector` integration pass)
    - build Theme Studio customization flow + import/export
    - expand contrast validation from ThemeEditor warnings into theme save/apply policy + broader appearance surfaces
    - theme-source de-duplication cleanup beyond adapter layer

- RSIGlobe retirement / merge audit + branding cleanup (2026-02-26):
  - User reported GitHub Copilot merged a few `.files` / YAML files from retired `RSIGlobe` repo into Candle Compass and requested a comprehensive audit.
  - Findings:
    - Merge commit `baee3d9` (`Create CONSOLIDATION_LOG.md documenting the merge from RSIGlobe`) only added `CONSOLIDATION_LOG.md`; no runtime/YAML files were modified by that commit.
    - YAML integrity audit completed across repo (excluding caches/venv): `16` YAML files parsed successfully, `0` syntax errors.
    - Repo-wide legacy-brand search completed (`RSIGlobe`, `RSI Globe`, `rsiglobe`, `rsi_globe`):
      - remaining references are overwhelmingly historical context, migration docs, deprecated paths, or legacy service/script names intentionally preserved for cleanup/compat guidance.
  - Branding drift fixes applied:
    - `create_desktop_launcher.sh` comment updated to Candle Compass only
    - `assistant/resources/docs/APP_USER_GUIDE.md` desktop launcher filename corrected to `CandleCompass.desktop`
  - `app/scripts/brand_check.py` upgraded:
    - supports `--scope app|repo`
    - distinguishes actionable legacy branding vs allowed historical/legacy references
    - preserves infrastructure checks (`config.yaml` Redis/Polygon)
  - Validation completed:
    - `python -m py_compile app/scripts/brand_check.py` ✅
    - `bash -n create_desktop_launcher.sh` ✅
    - `python app/scripts/brand_check.py --scope app` ✅
    - `python app/scripts/brand_check.py --scope repo --skip-infra` ✅ (actionable refs = 0)
  - Next actions:
    - optionally add `brand_check.py --scope repo --skip-infra` to a pre-release or CI quality gate
    - continue `M17` installer hardening and `M18` theme consolidation

- M17 Installer & Platform Hardening (partial) (2026-02-26):
  - Updated `app/scripts/install_candle_compass.sh` with:
    - package manager detection for `apt`, `dnf`, `yum`, `pacman`
    - `--preflight` / `--dry-run` mode (prerequisite report + planned actions, no system changes)
    - `--preflight --json` machine-readable output mode (CI/automation-friendly)
    - non-interactive mode parsing (`--non-interactive --action fresh|repair|purge`)
    - clearer installer section headers across install phases
    - Redis service unit fallback check (`redis-server` or `redis`)
  - Added installer smoke validation script:
    - `app/scripts/installer_smoke.sh`
    - validates syntax, preflight text output, preflight JSON output, `--dry-run` alias, argument guards, and combined non-interactive preflight parse path
  - Validation completed:
    - `bash -n app/scripts/install_candle_compass.sh` ✅
    - `bash app/scripts/install_candle_compass.sh --preflight` ✅
    - `bash app/scripts/install_candle_compass.sh --preflight --json` ✅ (clean JSON-only output)
    - `bash app/scripts/installer_smoke.sh` ✅
  - Notes:
    - Cross-distro package mapping is now scaffolded in installer, but Fedora/Arch runtime validation is still pending.
    - Existing interactive PostgreSQL DB keep/reinitialize/fresh flow remains the main DB provisioning path.
  - Next M17 follow-up:
    - test package mappings on Fedora/Arch images or containers
    - add richer reuse prompts/status for Node/Postgres/Redis installs (beyond package-manager no-op behavior)
    - optionally wire `installer_smoke.sh` and `--preflight --json` into CI

- Post‑2026‑02‑26 Next Instruction Set integration (2026-02-26):
  - Added canonical expansion plan doc:
    - `assistant/resources/docs/CANDLE_COMPASS_NEXT_INSTRUCTION_SET_POST_2026_02_26.md`
  - Mapped new milestones into roadmap:
    - `M17`–`M23` added to `assistant/ROADMAP.md`
  - Updated `assistant/TODO.md` with new milestone track and integration checklist
  - Updated `assistant/FULL_CONTEXT_INDEX.md` and `assistant/context/CHANGELOG.md`
  - Next actions:
    - continue executing `M17` and `M18` in milestone-sized batches
    - create multi-tool prompt packs for `M17+` after the milestone interfaces stabilize

- M15 Branch & Artifact Management (partial guardrails) (2026-02-26):
  - Added local branch safety hooks for single-developer `main / backup / design/tools` workflow:
    - `.githooks/pre-commit`
      - preserves existing context sync behavior
      - blocks direct commits on `backup` / `backup/*` unless explicit env override
      - blocks runtime code commits on `design` / `design/tools` / `design/*` unless explicit env override
    - `.githooks/pre-push`
      - blocks direct pushes to `backup` / `backup/*` unless explicit env override
      - requires explicit override for pushes to `design` / `design/*`
  - Updated hook installer:
    - `app/scripts/install_git_hooks.sh`
    - now installs/chmods both `pre-commit` and `pre-push`, and prints active-hook summary
  - Added multi-tool milestone tracking template:
    - `assistant/resources/docs/AI_TOOL_USAGE_LOG_TEMPLATE.md`
    - indexed in `assistant/FULL_CONTEXT_INDEX.md`
  - Validation completed:
    - `bash -n .githooks/pre-commit .githooks/pre-push app/scripts/install_git_hooks.sh` ✅
    - `bash app/scripts/install_git_hooks.sh` ✅
  - Remaining M15 work:
    - formalize/standardize automated `main -> backup` and `main -> design/tools` sync workflows (scripts/CI)
    - optional branch-protection documentation examples for remote hosting settings

- M13 Theme & Skin Manager (partial foundation) (2026-02-26):
  - Extended UI preferences model in `app/ui-next/src/lib/uiPreferences.ts`:
    - new persisted fields:
      - `themeBackgroundPreset`
      - `themeCustomBackgroundUrl`
      - `themeCustomBackgroundOpacity`
    - safe URL sanitization for custom backgrounds (`http/https/blob` + raster-only `data:image`; SVG rejected)
    - upload file guardrails:
      - allowed types: PNG/JPEG/WEBP/GIF/AVIF
      - max size cap for persisted local uploads
    - background preset CSS mapping + `applyUiPreferences()` support for CSS variable layers
    - hardened `writeUiPreferences()` with localStorage persistence warning fallback (quota-safe behavior)
  - Updated `app/ui-next/src/app/globals.css`:
    - added background-layer CSS variables (`--app-bg-preset-image`, `--app-bg-custom-image-layer`)
    - body background now supports layered preset/custom backdrop images without reload
  - Updated `app/ui-next/src/components/settings/AppearancePanel.tsx`:
    - background preset selector UI (Theme Default / Aurora / Scanlines / Spotlight / Horizon)
    - custom background image URL input (validated/sanitized)
    - local image upload button (reads safe files into persisted `data:image/*` URL)
    - custom background dim/opacity slider
    - persistence through `uiPreferences`
  - Added tests:
    - `app/ui-next/src/lib/uiPreferences.test.ts`
      - URL sanitization
      - upload type/size validation
      - normalization fallback/clamping
      - CSS variable application for preset/custom backgrounds
  - Validation completed:
    - targeted ESLint on `AppearancePanel`, `uiPreferences`, `uiPreferences.test` ✅
    - Vitest `src/lib/uiPreferences.test.ts` ✅ (4 tests)
  - Remaining M13 work:
    - theme preview polish + visual regression checks
    - persistence integration with future user profile storage (M4)
    - optional local file dimension/resolution guardrail and compression/downscale step

- M12 Navigation/Menu System (partial implementation) (2026-02-26):
  - Added top-level menu bar + nested submenu framework:
    - `app/ui-next/src/components/layout/NavMenuBar.tsx`
    - menus: Dashboard / Strategies / Data / Risk / Settings
    - supports view navigation, widget-launch actions, and dashboard actions
    - basic ARIA roles/labels and escape/outside-click close behavior
    - desktop keyboard navigation (arrow keys, enter/space, home/end, escape) across top menus and submenus
    - collapsed mobile menu variant (testable + responsive) with grouped sections
  - Integrated `NavMenuBar` into `app/ui-next/src/components/layout/Navbar.tsx`
    - menu callbacks wired for navigation and dashboard actions
  - Added dashboard contextual toolbar:
    - `app/ui-next/src/components/dashboard/DashboardToolbar.tsx`
    - actions: Add Widget, Save Layout, Load Layout, Theme, Undo, Redo
  - Wired toolbar + menu actions into `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - save/load layout snapshot (separate from auto-persisted layout)
    - theme/settings open actions
    - undo/redo placeholder toasts (history stack not implemented yet)
    - menu action dispatch (`DashboardMenuAction`) bridged to existing view/add-module/state controls
  - Validation completed:
    - targeted ESLint on `Navbar`, `NavMenuBar`, `DashboardToolbar`, `CommandCenter` ✅
    - `CommandCenter.test.tsx` (Zen mode integration) ✅ after wiring changes
    - `NavMenuBar.test.tsx` ✅ (desktop click navigation, keyboard navigation flows, collapsed mobile menu actions)
  - Remaining M12 work:
    - broader submenu information architecture polish
    - manual ARIA/keyboard accessibility verification
    - optional: layout history stack for real undo/redo (replace placeholder toasts)
  - Next actions:
    - run manual browser ARIA/keyboard validation and mobile visual checks to close M12 validation
    - continue into `M17` installer validation and host-compatibility work once the manual nav/browser pass is scheduled

- UIA M1 Dashboard Framework implementation (in progress) (2026-02-26):
  - Implemented a new grid-based dashboard layout layer in `app/ui-next` using `react-grid-layout`:
    - `app/ui-next/src/components/dashboard/DashboardManager.tsx`
      - typed layout state (`x/y/w/h`) + context API (`add/remove/update/reset/clear persisted`)
      - localStorage persistence with versioned key (`candle-compass:layout:v1:<user|anon>`)
      - legacy migration support for prior layout key (`candle_compass.dashboard_layout`)
      - responsive grid rendering with test/jsdom-safe fallback mode
    - `app/ui-next/src/components/dashboard/WidgetWrapper.tsx`
      - drag handle chrome and grid-item wrapper shell
    - `app/ui-next/src/components/dashboard/WidgetPlaceholder.tsx`
      - reusable placeholder module shell for not-yet-wired widgets
  - Refactored `app/ui-next/src/components/dashboard/CommandCenter.tsx` to use `DashboardManagerProvider` + `DashboardGrid` while preserving existing widget rendering and add-module flows.
  - Updated widget layout type model (`app/ui-next/src/types/dashboard.types.ts`) to support persistent grid coordinates while keeping legacy `gridArea` optional for compatibility.
  - Added grid UI styling tokens/placeholder visuals in `app/ui-next/src/app/globals.css`.
  - Added M1 tests:
    - `app/ui-next/src/components/dashboard/DashboardManager.test.tsx` (persistence + add/remove via context)
  - Validation completed:
    - targeted ESLint on touched dashboard files ✅
    - Vitest: `DashboardManager.test.tsx` + existing `CommandCenter.test.tsx` ✅
  - Validation pending / blocked:
    - manual browser verification of drag/resize + refresh persistence (not yet run)
    - `next build` and `tsc --noEmit` both stalled silently on this host (known local process behavior; no compile error output produced before manual termination)
  - Next actions:
    - run dashboard manually and verify M1 DnD/resize/persistence on desktop and one smaller breakpoint
    - retry/confirm build/typecheck on alternate host or with local process troubleshooting
    - once verified, mark M1 validation checklist complete and advance to M12 navigation/menu planning

- UIA blueprint addendum integration (2026-02-26):
  - User provided a contextual addendum covering:
    - single-developer workflow assumptions
    - three-branch model (`main`, `backup`, `design/tools`)
    - expanded UI/navigation/theme/beginner-mode requirements
    - new milestones `M12-M16`
    - multi-tool prompt-pack guidance (Cursor/Codex/Gemini/Windsurf/Windsor/Claude)
    - single-developer safeguards (pre-commit hooks, automated backups, tool usage log)
  - Integrated into repo planning/context system:
    - added canonical addendum doc:
      - `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT_ADDENDUM.md`
    - added addendum prompt-pack template:
      - `assistant/prompts/M12_M16_ADDENDUM_PROMPT_PACK.md`
    - extended M1 prompt pack with Windsurf/Windsor + Claude variants:
      - `assistant/prompts/M1_DASHBOARD_FRAMEWORK_PROMPT_PACK.md`
    - indexed addendum docs/prompt packs in `assistant/FULL_CONTEXT_INDEX.md`
    - extended `assistant/ROADMAP.md` with addendum milestones `M12-M16`
    - expanded `assistant/TODO.md` with addendum integration + upcoming milestone checklist
    - merged single-developer safeguards into `assistant/resources/docs/QUALITY_GATES.md`
    - updated branch strategy doc (`assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`) to explicitly support `main` / `backup` / `design/tools`
  - Next actions:
    - implement UIA `M1` dashboard framework (still the immediate runtime target)
    - plan `M12` Navigation/Menu work to build on top of (not duplicate) current `SidebarDock`/command surfaces
    - add branch guard scripts/hooks for `backup` and `design/tools`
    - create tool usage log template for milestone tracking

- UIA blueprint integration (2026-02-26):
  - User provided a comprehensive "Candle Compass Expansion Plan (UIA Blueprint)" covering:
    - clarifications/assumptions
    - MVP PRD scope
    - architecture/data model
    - REST/WebSocket/UI surfaces
    - non-functional requirements
    - milestone plan (M1-M11)
    - milestone done criteria/validation
    - rollback strategy
    - M1 prompt pack (Cursor/Codex/Gemini)
  - Integrated into repo continuity system:
    - added canonical doc:
      - `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`
    - added executable prompt pack:
      - `assistant/prompts/M1_DASHBOARD_FRAMEWORK_PROMPT_PACK.md`
    - indexed both in `assistant/FULL_CONTEXT_INDEX.md`
    - mapped M1-M11 into `assistant/ROADMAP.md` as the PRD/MVP execution track
    - expanded `assistant/TODO.md` with UIA integration checklist + M1 implementation checklist
    - merged UIA milestone/evidence/rollback expectations into `assistant/resources/docs/QUALITY_GATES.md`
  - Next actions:
    - implement **M1 Dashboard Framework** in `app/ui-next` (grid drag/resize + persistence)
    - choose/document canonical dashboard grid engine (`react-grid-layout` vs existing custom path)
    - add M1 validation tests + manual DnD persistence verification
    - sync prompt templates / rules terminology with upgraded master prompt + UIA blueprint language

- Master prompt + roadmap strategic upgrade integration (2026-02-26):
  - User provided a detailed report proposing:
    - enhanced master system prompt with explicit trading/market/risk/UX expertise
    - repository analysis and strengths/gaps
    - phased roadmap for world-class trading terminal development
  - Integrated report into repo system files:
    - rewrote `assistant/MASTER_SYSTEM_PROMPT.md` to include:
      - market microstructure / trading expertise
      - algo trading + portfolio/risk doctrine
      - trader-grade product/UX expectations
      - market realism, regulatory awareness, and risk-first directives
      - installer/ops distribution standards
    - expanded `assistant/ROADMAP.md` with strategic report-aligned phases:
      - prompt/system alignment
      - GUI modularity/customization
      - engine + algorithmic tooling
      - data reliability/scale
      - security/compliance/docs/launch readiness
    - added persistent reference doc:
      - `assistant/resources/docs/MASTER_SYSTEM_PROMPT_UPGRADE_REPORT.md`
    - updated context index and TODO to track follow-on work (prompt template alignment, module capability matrix, compliance checklist)
  - Next actions:
    - align `assistant/prompts/*` and `assistant/rules/*` wording with upgraded prompt
    - produce module capability matrix and UI exposure audit for all backend tools
    - continue installer/manual verification from previous session (Postgres policy branches + desktop icon visual)

- Installer "one-click" Postgres + branding upgrade (2026-02-26):
  - User requirement: installer should detect/install Postgres automatically, provision DB/role/password with minimal user effort, handle existing DB decisions interactively, and improve desktop icon branding + launcher behavior.
  - Installer upgrades (`app/scripts/install_candle_compass.sh`):
    - apt dependency sync now includes runtime + ops packages needed for a full experience:
      - `postgresql`, `postgresql-client`, `postgresql-contrib`, `redis-server`
      - desktop integration helpers `xdg-utils`, `desktop-file-utils`, `librsvg2-bin`
    - service checks/start attempts for PostgreSQL + Redis after package install
    - new interactive PostgreSQL provisioning step after copy-to-target:
      - detects server/db state via `setup_db.py --status-json`
      - if existing app DB is present, prompts user to `KEEP`, `REINITIALIZE`, or `FRESH SETUP` (new DB name)
      - generates a strong random password for the local PostgreSQL role and stores secure local credential hints
      - auto-promotes installed `config.yaml` to PostgreSQL backend (peer-auth defaults for one-click local reliability) while retaining password for optional TCP/manual admin use
    - hydration still uses resilient `hydrate_all.sh`
  - DB tooling upgrades:
    - `app/scripts/setup_db.py` rewritten as installer-grade utility:
      - JSON status output (`--status-json`)
      - policy modes (`auto`, `keep`, `reinitialize`)
      - role password set/update support
      - password artifact writing
      - local socket/peer by default (no hardcoded `localhost`)
      - non-interactive sudo (`sudo -n`) so launch-time checks do not hang
    - `app/scripts/ensure_data_lake.py` remains first-launch-safe (SQLite always initialized; Postgres setup optional)
  - Launcher consistency:
    - UI + backend launchers now load installer-generated `.env.postgres.local` if present
    - backend launch paths also bootstrap local data lake on first run
  - Desktop branding:
    - new Candle Compass icon (`app/ui-next/public/icon.svg`) featuring a cockeyed lit candle within a compass with trading cardinal letters `B`, `T`, `S`, `H`
    - desktop launcher generator installs icon to local icon theme dirs and creates both Desktop + App Menu entries
  - Validation:
    - shell syntax checks passed on updated installer/launcher scripts
    - `py_compile` passed on `setup_db.py` and `ensure_data_lake.py`
    - `setup_db.py --status-json` returns robust JSON even without sudo cache
    - SVG parses successfully
  - Next actions:
    - manual host validation of all Postgres policy branches (keep/reinitialize/fresh)
    - end-to-end fresh install retest and desktop icon visual confirmation

- Installer + launcher remediation pass (2026-02-26):
  - Analyzed fresh-install output and identified four concrete issues:
    1) installer DB step mislabeled as SQLite while calling Postgres-only setup script,
    2) hydration traceback during install (`ImportError: AlertOnly from src.strategies.builder`) due strict package imports in unrelated workflows,
    3) desktop launcher/icon UX weak (desktop file may exist but icon/app-menu visibility unreliable),
    4) manual launcher startup failure root cause: `/usr/bin/env: node: No such file or directory` from local `next` binary in shells lacking NVM PATH.
  - Implemented fixes:
    - added `app/scripts/ensure_data_lake.py`:
      - always initializes local SQLite data lake (`runs/candle_compass.db`) + SQLAlchemy models
      - optionally attempts Postgres setup only when `database.engine=postgres`
      - safe for install and first-launch use
    - installer (`app/scripts/install_candle_compass.sh`):
      - now runs `ensure_data_lake.py` (SQLite required, Postgres optional)
      - hydration now prefers `scripts/hydrate_all.sh` with fast/offline defaults and clearer non-fatal warnings
      - uninstall removes installed local icon assets
      - success message clarifies installed launcher path vs source-repo launcher
    - desktop launcher (`app/scripts/create_desktop_launcher.sh`):
      - resolves desktop dir via `xdg-user-dir DESKTOP` fallback
      - creates both Desktop and App Menu launchers
      - installs compass icon into local icon dirs (`~/.local/share/icons/...`) with optional PNG conversion
      - updates desktop database when available
    - desktop entry point (`app/scripts/desktop_entry_point.sh`):
      - logs to `runs/desktop_logs` (not `assistant/logs`, which is not shipped in install package)
      - runs data-lake bootstrap on first launch
      - prints UI log tail on launch failures
    - UI launcher (`app/scripts/launch_ui_detached.sh`):
      - bootstraps NVM if `node`/`npm` missing in PATH
      - checks `node` availability when using local `next` binary
      - auto-inits data lake if missing
      - prints log tail on startup/health failure
    - strategy package (`app/src/strategies/__init__.py`):
      - visual-builder exports are now optional imports so hydration/backtest scripts do not crash if Lab-specific modules fail to import
    - Postgres setup (`app/scripts/setup_db.py`):
      - no longer hardcodes `-h localhost`; defaults to local socket/peer auth unless `CANDLE_COMPASS_PG_HOST` is explicitly set
  - Validation:
    - `bash -n` on installer/launcher scripts -> pass
    - `py_compile` on updated Python scripts -> pass
    - `PYTHONPATH=app .venv/bin/python -c 'import src.strategies'` -> pass
    - `create_desktop_launcher.sh` dry-run generated Desktop + App Menu launchers and installed local icon
  - Next actions:
    - rerun fresh installer option `1` end-to-end on host and verify desktop icon visual rendering + app menu entry
    - verify installed `/opt/CandleCompass/scripts/launch_ui_detached.sh` succeeds from desktop without manual NVM shell setup

- Full validation + stabilization sweep (2026-02-26):
  - Frontend quality gates completed:
    - `npm run lint` fixed to zero errors (warnings remain)
    - `npm run test -- --run` passing (`15 files / 50 tests`)
    - `npm run build` passing after fixing missing `fetchBackend`, invalid Heroicons imports, type issues in chart/chat widgets, and local `howler` typings shim
  - Backend validation completed:
    - `.venv/bin/python -m pytest -q` passing (`167 passed`)
    - `app/main.py` import/bootstrap hardened so pytest can import `app.main` without `ModuleNotFoundError` for legacy top-level modules (`core`, `engine`, `src`)
  - Hydration pipeline repaired and verified:
    - `app/scripts/hydrate_all.sh` updated for current CLI contracts (`score_assets`, `run_orderflow`, `narrative_scan`, `risk_dashboard`, `run_ui_bundle`)
    - added per-step timeout handling, optional-step execution, artifact checks, and bundle timeout override
    - successful fast hydration run completed and key `app/runs/latest/*.json` artifacts populated
  - UI data plumbing/build blockers fixed:
    - added `/api/data/[...artifact]` route + alias/index/freshness metadata
    - normalized major widgets to real artifact shapes (Risk, Social Hype, Whale Watch, Newsroom, Arbitrage, Meme stream)
    - `useWidgetData` upgraded with freshness/stale/error metadata
  - Ops/backup:
    - external backup rotation executed successfully (`app/scripts/rotate_external_backups.sh`)
    - installer script remains improved (timestamped visible progress); end-to-end option-1 smoke still pending manual host verification
  - Git save:
    - committed and pushed to `origin/main` (`9ad1324`): `fix: complete full validation pass and stabilize UI/data pipeline`
  - Next actions:
    - optional follow-up: theme system consolidation + App Store-wide widget/data coverage audit
    - manual UI hard-refresh visual verification + installer option-1 host smoke

- UI render regression + installer hardening pass (2026-02-26):
  - Fixed dashboard shell duplication causing unstable/stacked navigation layouts:
    - removed root-level `Sidebar` injection from `app/ui-next/src/app/layout.tsx`
    - dashboard `SidebarDock` remains the primary shell nav for `/`
  - Hardened theme/token startup compatibility to prevent "plain white / black text" fallback rendering when dynamic theme variables load incompletely:
    - expanded fallback CSS variables in `app/ui-next/src/app/globals.css` (accent/text/surface/glass/font/z-index compatibility tokens)
    - improved `.glass-panel` to use tokenized border/radius/blur + isolation
    - added fallback `.shell` / `.panel` styles so error/recovery screens remain themed
    - `app/ui-next/src/components/ThemeContext.tsx` now seeds legacy theme vars and maps dynamic theme values into legacy compatibility tokens
  - Improved installer UX for "Option 1 appears hung" reports:
    - `app/scripts/install_candle_compass.sh` now prints timestamped step logs
    - removed quiet pip/npm install modes so long phases show progress
    - uses `npm ci --no-audit --no-fund` when lockfile exists
    - logs explicit warning before long frontend build step
    - stops user-level UI/backend services during uninstall in addition to system scope
  - Restored missing widget artifact data route:
    - added `app/ui-next/src/app/api/data/[...artifact]/route.ts` to serve `app/runs/latest/*.json` for UI widgets using `useWidgetData` and sidebar alert-status polling
    - fixed `.gitignore` rule collision (`data/`) so `app/ui-next/src/app/api/data/**` is tracked in git
  - Upgraded artifact route + widget consumers for real data compatibility:
    - `/api/data/[...artifact]` now supports alias resolution, `_index`, and freshness headers (`x-artifact-*`)
    - normalized UI widgets to actual artifact shapes:
      - `whale_events.json` -> Whale Watch
      - `social_hype.json` scores -> Social Hype widget
      - `risk_dashboard.json` nested risk metrics -> Risk Guardian widget
      - `research_feed.json.items[]` + supplemental `social_hype.json` / `narrative_engine.json` -> Newsroom panel
    - sidebar Sentinel indicator now reads `alerts[].length` (not only `rules[]`)
  - Rebuilt `app/scripts/hydrate_all.sh` for reliability:
    - app-venv autodetect (`app/.venv` then repo `.venv`)
    - per-step success/failure reporting
    - timeout support (`HYDRATE_STEP_TIMEOUT_SECONDS`)
    - optional `HYDRATE_SKIP_FETCH=1` fast mode
    - non-zero exit on failed steps or missing key artifacts
  - UI interaction hardening:
    - removed blocking dialogs from touched widgets (`MemeStreamWidget` uses toast notifications; `RiskGuardianWidget` reset no longer uses `window.confirm`)
  - Next actions:
    - verify UI styling after hard refresh + dev restart
    - run `app/scripts/hydrate_all.sh` (full and fast mode) and confirm widget data population
    - audit/fix remaining `/api/data/*.json` widget endpoints vs actual artifact names/coverage beyond the patched widgets
    - run full lint/build/pytest/UI smoke validation

- **Backlog & Polish (2026-02-25):**
  - Resolved `FIXME.md` technical debt regarding `trade_signals.json` bundle generation, and `runtime_error_events.jsonl` rotation.
  - Wrote robust UI integration tests for `SignalSummaryCard` (`SignalSummaryCard.test.tsx`), closing out the pending QA requirement for recent signals state testing.
  - Validated that the external backup timer automation (`rotate_external_backups.sh`) scripts and API endpoints are already available to the user for restoring their snapshot arrays.

- **The Final Frontier Complete (2026-02-25):**
  - **Phase 56 (On-Chain Snipe Execution):** Created `app/src/execution/onchain_sniper.py` bridging `web3` and `solana` packages. Exposed a `/api/snipe/execute` endpoint and hooked it into the `MemeStreamWidget.tsx` UI for single-click execution.
  - **Phase 57 (Institutional Observability):** Implemented Prometheus metrics in `app/src/api/routers/metrics.py`. Configured `check_alerts.py` to watch `runtime_error_events.jsonl` for critical anomalies and dispatch them via the Sentinel framework.
  - **Phase 58 (E2E Integration Testing):** Created robust Vitest suites for `RiskGuardianWidget`, `SocialHypeWidget`, and `WhaleWatchWidget` ensuring data mapping and fallback states render correctly. Fixed Context Provider errors in `CommandCenter.test.tsx` to handle Zen Mode rehydration.
  - **Phase 59 (Continuous Optimization):** Hardened `app/src/backtest/vectorized.py`'s `run_parallel_optimization` via type downcasting (`float64` -> `float32`) and aggressive explicit garbage collection (`gc.collect()`) to prevent OOM errors during concurrent strategy sweeping.

- **Grand Unification Complete (2026-02-25):** 
  - **Phase 51 (Omni-Registry):** Updated `widgetRegistry.ts` to include `Time Machine`, `Strategy Lab`, `Newsroom`, and `Arbitrage`. Updated `DashboardWidget.tsx` to handle dynamic imports for these components via the `widget:` prefix.
  - **Phase 52 (Command Deck):** Updated `SidebarDock.tsx` with a prominent `+ Add Module` button to access the unified App Store directly from the global navigation.
  - **Phase 53 (Live Wire):** Updated `useWidgetData.ts` to poll `/api/data/research_feed.json` and `/api/data/arbitrage_opportunities.json`. Connected `NewsroomPanel` and `ArbitrageTable` to this hook for live updates.
  - **Phase 48/54 (Flash Core):** Added `app/src/discovery/parallel_scanner.py` using `ProcessPoolExecutor` for blazing fast concurrent scanning.
  - **Phase 55 (Sentinel Alerts):** Implemented `TelegramProvider` in `dispatcher.py` and built `app/src/execution/alert_engine.py` to evaluate market data against high-conviction rules (e.g., Confluence > 90 + Whale > $1M) and dispatch Telegram alerts.
  - **Testing/FIXME:** Fixed Cortex commander test failure (`test_process_command_trade_prep`) to match the new `AGENT_EXECUTION` action format. Full suite now passes (`167 passed`). Frontend build passes cleanly.

- **Hyper-Aggressive Expansion Complete (2026-02-25):** 
  - **Phase 36-B & 36-C:** Forcibly injected the `cyber` Glassmorphism style into `globals.css` base layer and created `hydrate_all.sh` to generate missing data artifacts.
  - **Phase 40 & 37:** Created `universal_manifest.json` and upgraded the Cortex AI to a system operator with tool-calling capabilities (`app/src/agents/actions.py` and `POST /api/cortex/execute`).
  - **Phase 42 (Omni-Registry):** Replaced `AddModuleModal` with a comprehensive "Trader's App Store" grid, driven by `widgetRegistry.ts`.
  - **Phase 43 (Content Injection):** Built full visual components for `RiskGuardianWidget` and `SocialHypeWidget`.
  - **Phase 44 (Command Deck):** Implemented a global left-side `Sidebar` for mode switching and wired the `Cmd+K` global command palette to operational shortcuts.
  - **Testing/FIXME:** Fixed the UI compile error in `CommandCenter.tsx` passing props to `RiskGuardianWidget`. Wrote the missing API contract tests for `timeMachineBacktest` (`POST /api/time_machine/backtest`) and marked the corresponding FIXME as done.

- Documentation updates (2026-02-18): **Runtime auth and API keys:** In APP_USER_GUIDE.md added a clear "Why you see 403" explanation (expected security behavior when runtime key missing/wrong); added API key configuration checklist table (steps 1–6) before the detailed missing-keys list. **Help page:** Added dedicated section `#expected-vs-actual-errors` on /help with bullet summary (403, role denial, health warn, vs actual bugs) and cross-link to APP_USER_GUIDE §9; troubleshooting bullet now links to that anchor. No runtime or test changes. Next: Phase 14 UI tests (Zen state transitions), progression persistence tests, or other TODO immediate items.

- Display fix + context/git save (2026-02-18): **UI display (white screen):** Fixed by moving critical base styles into `@layer base` in `app/ui-next/src/app/globals.css` so they override Tailwind preflight—html gets `background: #060912`, body keeps dark gradient and `var(--text-primary)` with fallbacks. Layout (`layout.tsx`) updated: font variables on html, body with `min-h-screen`, wrapper div `relative min-h-screen`. Clean build (`rm -rf .next && npm run build`) passes. If display still looks white, hard-refresh (Ctrl+Shift+R) or clear cache. **Context/rules:** WHERE_WE_LEFT_OFF, CHANGELOG, and git commit updated; status report below.

- Phase F/T/O batch (2026-02-18): **Phase F:** Extended artifact validation: schemas and validate_artifacts.py now include symbol_catalog.json, service_console_actions.json, user_progression.json (Pydantic models + validate_* + validate_artifact_file/list). Added unit tests in test_validation_schemas.py (TestSymbolCatalogArtifact, TestServiceConsoleActionsArtifact, TestUserProgressionArtifact). **Phase T:** CI job `installer_smoke` added: runs install_candle_compass.sh with --skip-python-deps --skip-ui-deps --skip-ui-build --skip-desktop-launcher and asserts .venv, requirements.txt, ui-next exist. **Phase O:** OPS_RUNBOOK new section "Observability (Optional)": alerting on runtime_error_events (tail JSONL, thresholds, webhook); Prometheus/metrics (reverse-proxy or custom /api/metrics, Grafana). TODO and phases updated. **Lightweight telemetry:** run_ui_bundle.py now writes `runs/latest/run_metadata.json` (completed_at, duration_seconds, mode, risk_profile). Schemas and validate_artifacts support run_metadata.json; unit tests added. Next: Phase T (UI integration tests, Zen rehydrate), Phase O (validate service install on hosts), or Phase F (near-miss arbitrage panel).

- Continued Phase S/T/O (2026-02-18): **Phase S:** HTTPS and reverse-proxy section added to OPS_RUNBOOK (nginx/Caddy, TLS, secure cookies); SECURITY_AND_DEPLOYMENT_CHECKLIST §3/§7 updated. Ghost protocol best practices in OPS_RUNBOOK (IP allowlist, cooldown, token); test_execution_router.py asserts Retry-After on 429. **Phase T:** API contract tests expanded (route.operations.test.ts): strategyLab list/save/delete/invalid action, externalBackup status with key, timeMachineBacktest success path (summary/tradeLog). New `tests/test_validation_schemas.py` for Pydantic artifact schemas (OHLCVPoint/Series, StrategyDecision, StrategyOrchestrator, TradeSignal, HealthCheck). **Phase O:** OPS_RUNBOOK "Docker Production Usage" (resource limits, secrets, health checks, bind/proxy, volumes); SECURITY_AND_DEPLOYMENT_CHECKLIST §6 structured request logging. All 23 pytest (execution_router + validation_schemas) and 12 Vitest route.operations tests pass. Full pytest: 155 passed (spatial test fixed by adding bid_depth_usd/ask_depth_usd to test quotes so liquidity risk does not filter out the opportunity). CommandCenter async onClick fixes applied so Next.js build succeeds; GUI launches (npm run dev, GET / 200). Optional rate-limiting note added to OPS_RUNBOOK. Next: Phase T (UI integration, installer CI, Zen rehydrate), Phase O (Prometheus, alerting hooks), or fix spatial arbitrage test.

- Advancement, security, roadmap (2026-02-18): Enhanced `.env.example` with runtime control key, backup dir, and optional API keys. Added `assistant/resources/docs/SECURITY_AND_DEPLOYMENT_CHECKLIST.md` for deployment and hardening. Added CI step for artifact schema validation (optional). Expanded `assistant/TODO.md` with **Phases, Milestones & Parts**: Phase S (Security), P (Performance), T (Testing), D (Documentation), O (Observability), F (Future product), plus milestone summary table. Updated FIXME (Strategy Lab binding marked done). Updated FULL_CONTEXT_INDEX with new docs. Next: pick from Phase S/D/T for immediate next steps.

- Backup path update (2026-02-18): Internal manual backup is **one copy only** at `$HOME/.BackupZ-MyAppZ/CandleCompass.bak` (e.g. `/home/whyte/.BackupZ-MyAppZ/CandleCompass.bak`). First run creates the copy; subsequent runs replace that single copy. All scripts and API default updated; docs updated. Old locations (`~/.candle_compass_external_backups/RSIGlobe`, `~/.BackupZMyAppZ`) deprecated—can be removed after migration.

- Critical UX fix + Schema validation + Docker setup (2026-02-18): Fixed critical blocking popup dialogs issue - replaced all `window.prompt`/`window.confirm` with React modals (`ConfirmDialog`, `PromptDialog`) that support ESC key, click-outside dismissal, and proper close buttons. Created rule `assistant/rules/NO_BLOCKING_DIALOGS.md`. Added schema validation with Pydantic models (`app/src/validation/schemas.py`) and validation script (`app/scripts/validate_artifacts.py`). Created Docker setup: multi-stage Dockerfile, updated docker-compose.yml, .dockerignore, and docker/README.md. Verified Strategy Lab runtime binding is complete. All artifacts validate successfully. Next: Continue production readiness improvements.

- Full system engagement (2026-02-18): Loaded and reviewed complete system context (AGENTS_AND_SYSTEM, WHERE_WE_LEFT_OFF, TODO, FIXME, MASTER_SYSTEM_PROMPT, PROJECT_RULES). Created comprehensive session summary (`assistant/context/SESSION_SUMMARY_2026-02-18.md`) and action plan (`assistant/context/ACTION_PLAN_2026-02-18.md`). Identified that runtime authorization errors are expected behavior (security feature working correctly), missing API keys are optional (non-critical), and runtime artifacts are normal. Next priorities: Phase 13 arbitrage risk models, Strategy Lab runtime binding, documentation updates.

- Save and stop (2026-02-18): Git commit and push (UI port 3967 changes, docs). No open items.

- Default UI port 3967 (2026-02-18):
  - **Port change:** Default UI port set to **3967** to avoid conflicts: 3000 (ollama-webui), 3100 (other next-server), 3847 (other app), 8000 (portainer/etherweave), 8010 (our backend), 8766 (our memory), 5432 (postgres), 3001–3024 (other Next apps). Updated: launch scripts, install_service.sh, route.ts, README, OPS_RUNBOOK, APP_USER_GUIDE, app/ui-next/README, COMMANDS.md, help page, `.env.example`. Open `http://127.0.0.1:3967`.

- Single backup policy + desktop launcher + full save (2026-02-18):
  - **Backup policy:** One copy only. `backup_project.sh` now removes older CandleCompass_*.tar.gz in output dir after creating a new archive. `rotate_external_backups.sh` default KEEP_COUNT=1. Docs/rules updated: REPO_BOUNDARY_AND_BACKUP.md, PROJECT_RULES.md, RULES_USER.md, .cursorrules, OPS_RUNBOOK.md, README.md, TODO.md.
  - **Manual backups pruned:** Kept single copy `~/.cursor/CandleCompass_backup_20260213_184408.tar.gz`; removed other manual archives in ~/.cursor and repo backups/ to free space.
  - **Desktop launcher:** Exec runs via login shell; gio trusted; Path= in installer; APP_USER_GUIDE troubleshooting.
  - **Git:** Full save committed and pushed to origin/main (43 files). GUI launch verified (detached start, HTTP 200 on /). Ready for stop.

- GUI launch fixes (2026-02-17):
  - **Launch scripts:** `launch_ui_detached.sh` and `launch_ui.sh` now derive app root from script location when first arg is missing or starts with `--` (e.g. `./scripts/launch_ui_detached.sh --no-open`). Prevents `cd: --: invalid option` when run from desktop or with flags only.
  - **PID/log paths:** In `launch_ui_detached.sh`, relative `CANDLE_COMPASS_UI_PID`/`CANDLE_COMPASS_UI_LOG` are normalized to absolute paths under app root so writes succeed after `cd "$UI_DIR"`.
  - **Desktop launcher:** `create_desktop_launcher.sh` adds `Path=$ROOT_DIR` to the `.desktop` file so the launched process has correct working directory.
  - **Clear errors:** When npm/Next is missing, scripts print instructions to run `cd "<UI_DIR>" && npm install && npm run build` then relaunch.
  - **Validation:** ESLint and `next build` pass; Vitest 30 passed; detached start + HTTP 200 on `/` verified. Optional: stop test server (kill PID from `runs/ui_test.pid` if used), confirm desktop launcher in browser.

- Proceed (continued) (2026-02-17):
  - **CI:** Added "UI smoke test (bundle artifact contract)" step to `.github/workflows/ci.yml` test job: runs `python app/scripts/ui_smoke_test.py --runs app/runs/latest` (non-strict; mkdir -p app/runs/latest).
  - **Strategy orchestrator panel:** Portfolio Summary widget now shows Regime, Action, VPIN, Toxic, Gate/Strategy, Strategy Guard (3-column grid on sm); subtitle "Orchestrator · regime, VPIN, guardrails"; tooltip references strategy_orchestrator.json.

- Proceed and continue (2026-02-17):
  - **trade_signals.json in bundle:** `run_ui_bundle.py` now has `_export_trade_signals_from_orchestrator()`; after `run(orchestrator_cmd)` it writes `runs/latest/trade_signals.json` from strategy_orchestrator decision (action BUY/SELL, timestamp from last bar in ohlcv_series or now). Chart markers become strategy-native when bundle runs.
  - **Signal freshness badges:** API GET returns `tradeSignalsGeneratedAt` from trade_signals.json; CommandCenter computes `signalFreshnessLabel` (Fresh / Xm ago / Xh ago / Stale) and shows it in Recent Signals Feed and Price Chart subtitles.

- Phase 14 continued (2026-02-17):
  - **Zen mode UI tests:** `app/ui-next/src/components/ZenModeContext.test.tsx` — 5 tests: initial off/on from storage, toggle updates state/storage/body class, setZenMode(true/false).
  - **Progression persistence:** `tests/test_progression.py` — added `test_progression_script_writes_file_and_stdout` (runs `update_user_progression.py` with temp dir, asserts file + stdout JSON and level/skins_unlocked).
  - **Progression API:** `route.operations.test.ts` — POST progressionUpdate returns 200 with userProgression (level, skins_unlocked, xp) and progressionUpdateApplied; route gate updated to include `userProgression` so POST with only progressionUpdate returns 200. Vitest 30, pytest 136.

- Next steps and milestones (2026-02-17):
  - **TODO:** Added "Milestones and Parts" table (M1 Phase 14 UX, M2 Phase 13 arbitrage, M3 API tests, M4 production readiness, M5 distribution/ops).
  - **Phase 14:** Progression theme gating in Settings: `lib/theme.ts` has THEME_PROGRESSION_SKIN, REQUIRED_LEVEL_FOR_SKIN, isThemeUnlocked, getRequiredLevelForTheme; ThemeSelector accepts skinsUnlocked and shows locked badge + tooltip for themes above user level; Settings fetches GET /api/candle_compass for userProgression and passes skins_unlocked to ThemeSelector.
  - **API tests:** `route.operations.test.ts` added: timeMachineBacktest validation (400 for bars < 3, bars > 5000, invalid mode); runtimeRolePolicyAuditTimer (403 without key when required, 200 with key); progressionUpdate (200 + userProgression). Vitest 30 passed.

- Distribution-first database architecture completed (2026-02-17):
  - **Design:** `assistant/resources/docs/DATABASE_ARCHITECTURE.md` is canonical. No hardcoded DB user; app detects current OS user; peer auth (Unix socket, no password). DB name: `candlecompass_prod`.
  - **Setup:** `app/scripts/setup_db.py` detects OS user, creates DB owned by that user, ensures PostgreSQL role exists, applies schema, handles legacy ownership (ALTER OWNER). Shell wrapper: `app/scripts/setup_db.sh`. Run once after install.
  - **Connection:** `trade_signal_store_postgres.py` uses `_detect_os_user()`; when `auth: peer` or no user/password, connects with OS user and no host (Unix socket). Config defaults: `dbname: candlecompass_prod`, `auth: peer`, `host: null`, `user: null`.
  - **Config:** `config.yaml` database.postgres defaults updated; OPS_RUNBOOK and FULL_CONTEXT_INDEX reference DATABASE_ARCHITECTURE and setup_db.

- PostgreSQL and per-application database support (2026-02-17):
  - **Pattern:** Superuser/master account (e.g. `whyte`) owns the cluster; each app has its own database. Candle Compass uses DB `candlecompass_prod` (distribution-first) or legacy `candle_compass` if configured.
  - Added `app/engine/db/init_postgres.sql` (trade_signal_records schema for PostgreSQL 16).
  - Added `app/scripts/create_candle_compass_db.sh` to create DB `candle_compass` and run schema (env: CANDLE_COMPASS_PG_USER, CANDLE_COMPASS_PG_DB, CANDLE_COMPASS_PG_PORT; fallback create as postgres then grant).
  - Config: `config.yaml` `database` section (engine: sqlite | postgres, sqlite.path, postgres host/port/dbname/user).
  - Optional PostgreSQL backend: `app/src/analytics/trade_signal_store_postgres.py` (psycopg3); `get_trade_signal_store()` in trade_signal_record.py returns SQLite or Postgres store from config/env.
  - All callers (main.py, accuracy_engine, ai_controller, trade_executor, accuracy_auditor, accuracy_dashboard_snapshot) now use `get_trade_signal_store()`. SQLite remains default; set `CANDLE_COMPASS_DATABASE_ENGINE=postgres` or config `database.engine: postgres` to use Postgres.
  - requirements.txt: added `psycopg[binary]>=3.1.0`. OPS_RUNBOOK and .env.example document the pattern and env vars.
  - Nightly evolution script still uses SQLite (resolve_db_path); can be extended later for Postgres.

- Runtime error retention + Phase 13 arbitrage Settings + wiring (2026-02-17):
  - API route: trim `runtime_error_events.jsonl` to last 500 lines after each append (`trimRuntimeErrorEventsFile`) so the file does not grow unbounded.
  - Settings: added "Arbitrage / Gap Hunter" panel (default/Binance/Coinbase/Kraken/KuCoin fee bps, slippage bps, min profit %) with coercion helpers; persisted via existing uiPreferences.
  - Dashboard and popout: Gap Hunter and Arbitrage Hub now use `buildArbitrageAssumptions(uiPreferences)` and `filterArbitrageOpportunities` from `@/lib/arbitrageAssumptions`, so Settings values drive filtering and adjusted-net-profit threshold.
  - Removed duplicate `parseArbitragePercent` from CommandCenter and popout (use lib).
  - Validation: pytest 135, Vitest 19, ESLint pass.

- Bundle timer fix + host-safe limits + desktop/installer (2026-02-17):
  - **rsiglobe-bundle journal spam**: Added `app/scripts/stop_legacy_rsiglobe_services.sh` to stop and disable legacy `rsiglobe-bundle.timer`/`.service`. Run once to silence "working directory missing" failures.
  - **install_bundle_timer.sh**: Validates that ROOT_DIR exists and contains `.venv` and `scripts/run_ui_bundle.py` before installing; exits with clear error otherwise. Resolves ROOT_DIR to absolute path. Adds host-safe resource limits: `MemoryMax=2G`, `CPUQuota=100%`, `TasksMax=64`, `StartLimitIntervalSec=300`, `StartLimitBurst=2` (override via `CANDLE_COMPASS_BUNDLE_*` env when installing).
  - **stop_bundle_timer.sh**: Now stops both `candle_compass-bundle` and legacy `rsiglobe-bundle` units.
  - **install_candle_compass.sh**: Runs `stop_legacy_rsiglobe_services.sh` after copy so legacy timer is disabled on (re)install; desktop launcher uses absolute Exec path; post-install message mentions `install_bundle_timer.sh` with path requirement.
  - **create_desktop_launcher.sh**: Validates app root exists; optional third arg for display name (default "Candle Compass"); uses `XDG_DESKTOP_DIR`; Exec absolute path.
  - **OPS_RUNBOOK.md** and **APP_USER_GUIDE.md**: Document one-time legacy fix, bundle timer path validation, and desktop launcher troubleshooting.
  - Validation: `bash -n` on all touched scripts; pytest 135 passed; ESLint and Next.js build passed; Vitest 19 passed.
  - **systemd-coredump** "Not enough arguments" is a kernel/coredump handler issue, not fixed in-app; user can update systemd or kernel.

- Multi-agent system and boundary enhancement pass (2026-02-17):
  - Added multi-agent awareness so the system knows multiple AI coding agents (Cursor, Windsurf, Codex, Gemini, Claude, etc.) take turns building Candle Compass.
  - Created `assistant/AGENTS_AND_SYSTEM.md`: single source of truth for agent handoff, load order, boundaries, and handoff protocol.
  - Updated `assistant/MASTER_SYSTEM_PROMPT.md`: multi-agent context, explicit runtime vs system scope, and handoff directive (update WHERE_WE_LEFT_OFF + TODO on session end).
  - Enhanced `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`: three-way separation (runtime `app/`, system `assistant/`, backup/external + branches); verification checklist now includes handoff and FULL_CONTEXT_INDEX/LOADOUT/memory_ingest updates.
  - Created `.cursorrules` at repo root: first steps (read AGENTS_AND_SYSTEM, WHERE_WE_LEFT_OFF, TODO), boundaries, handoff rules, and pointers to ASSISTANT_LOADOUT and FULL_CONTEXT_INDEX.
  - Updated `assistant/FULL_CONTEXT_INDEX.md`: added AGENTS_AND_SYSTEM.md, TODO, FIXME, .cursorrules, MCP path.
  - Updated `assistant/ASSISTANT_LOADOUT.md`: Tier 0 includes AGENTS_AND_SYSTEM; Tier 1 includes WHERE_WE_LEFT_OFF first, TODO, FIXME.
  - Updated `assistant/memory_ingest.yaml`: added AGENTS_AND_SYSTEM.md to roots.
  - Updated `assistant/context/RULES_USER.md`: multi-agent handoff rule (read AGENTS_AND_SYSTEM, WHERE_WE_LEFT_OFF, TODO at start; update on handoff).
  - Updated `assistant/TODO.md`: added "Next Best Steps / Phases" section (immediate, short-term, medium-term, trading-algorithm) and "If Interrupted — Continuity Checklist" so the next agent or human knows what to do and how to resume.
  - No runtime code under `app/` was changed; all edits are under `assistant/` or root `.cursorrules`.
- Validation: no pytest/UI build run this session (system/docs only). Recommended before next code change: `.venv/bin/python -m pytest -q`, `cd app/ui-next && npm run lint && npm run build`.

- Symbol-quality filter + desktop launcher hardening pass (2026-02-16):
  - Added default quality filtering to `GET /api/candle_compass/symbols` in:
    - `app/ui-next/src/app/api/candle_compass/symbols/route.ts`
    - excludes leveraged/synthetic low-quality crypto symbols by default,
    - supports `quality=all` override,
    - returns `quality_mode` and `quality_filtered_out` metadata.
  - Added launcher/settings controls for advanced-symbol override:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
      - launcher toggle button `Symbols: Default/Advanced`,
      - catalog fetch now sends quality mode from UI preferences.
    - `app/ui-next/src/lib/uiPreferences.ts`
      - added persisted preference `includeAdvancedSymbols`.
    - `app/ui-next/src/app/settings/page.tsx`
      - added `Show advanced symbols` checkbox.
    - user guidance updated in:
      - `app/ui-next/src/app/help/page.tsx`
      - `assistant/resources/docs/APP_USER_GUIDE.md`
  - Added/expanded dedicated API tests:
    - `app/ui-next/src/app/api/candle_compass/route.auth.test.ts`
    - `app/ui-next/src/app/api/candle_compass/symbols/route.test.ts` (now includes quality-filter coverage).
  - Desktop launcher generator hardening:
    - updated `scripts/create_desktop_launcher.sh` to default to repo root and produce `~/Desktop/RSIGlobe.desktop` naming by default.
    - regenerated desktop file and re-validated detached launch path.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (7 files, 19 tests)
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`
  - desktop-launch smoke (`scripts/launch_ui_detached.sh --port=3201 --no-open`) + HTTP probe -> pass

- Dedicated API test coverage expansion pass (2026-02-16):
  - Added runtime-role policy auth test suite:
    - `app/ui-next/src/app/api/candle_compass/route.auth.test.ts`
    - validates destructive confirm enforcement + role-tier denials + role alias coercion paths.
  - Added symbols API test suite:
    - `app/ui-next/src/app/api/candle_compass/symbols/route.test.ts`
    - validates cache semantics (`cache`, `stale-cache`), filtered catalog behavior, and malformed-symbol resilience.
  - Updated TODO tracking:
    - marked prior open API-test TODO items as done in `assistant/TODO.md`.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (7 files, 18 tests)
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`
  - desktop-launch smoke (`scripts/launch_ui_detached.sh --port=3201 --no-open`) + HTTP probe -> pass

- System Operations runtime-error + external-backup automation pass (2026-02-16):
  - Completed API contract expansion in `app/ui-next/src/app/api/candle_compass/route.ts`:
    - GET now returns:
      - `runtimeErrorEvents` (parsed from `runs/latest/runtime_error_events.jsonl`)
      - `externalBackupStatus`
      - `externalBackupTimerStatus`
      - `externalBackupTimerPreflight`
    - POST now supports:
      - `operations.externalBackup=run|status`
      - `operations.externalBackupTimer=install|stop|status`
      - payload options:
        - `externalBackupKeep`
        - `externalBackupTimerInterval`
        - `externalBackupRoot`
  - Added timer helper scripts:
    - `app/scripts/install_external_backup_timer.sh`
    - `app/scripts/stop_external_backup_timer.sh`
    - `app/scripts/external_backup_timer_status.sh`
  - Updated System Operations UI (dashboard + pop-out):
    - added external backup/timer controls and status cards,
    - added dedicated runtime-error events panel with `Copy ID` button for each `errorId`.
  - Desktop-launch smoke check:
    - verified desktop-icon launch path via `scripts/launch_ui_detached.sh` using isolated PID/log + `curl` health probe on port `3201`.
- Validation:
  - `bash -n app/scripts/install_external_backup_timer.sh app/scripts/stop_external_backup_timer.sh app/scripts/external_backup_timer_status.sh app/scripts/rotate_external_backups.sh` -> pass
  - `cd app/ui-next && ./node_modules/.bin/eslint src/app/api/candle_compass/route.ts src/components/dashboard/CommandCenter.tsx 'src/app/popout/widget/[widgetId]/page.tsx'` -> pass
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (5 files, 10 tests)
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Repository segregation + external backup policy pass (2026-02-15):
  - Confirmed and reinforced logical separation model:
    - runtime application surface stays in `app/`
    - system design/process files stay in `assistant/`
  - Added boundary/backup policy doc:
    - `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`
  - Added external keep-3 backup rotation script:
    - `app/scripts/rotate_external_backups.sh`
    - default backup root: `$HOME/.BackupZ-MyAppZ/CandleCompass.bak`
    - status artifact: `runs/latest/external_backup_status.json`
  - Executed backup script successfully:
    - created snapshot archive and kept latest set within keep-count policy.
  - Added branch segregation for non-runtime tracks:
    - remote branch `system/files`
    - remote branch `backup/state`
  - Documentation updates:
    - `README.md`
    - `assistant/resources/docs/APP_USER_GUIDE.md`
    - `assistant/ASSISTANT_LOADOUT.md`
- Validation:
  - `bash -n app/scripts/rotate_external_backups.sh && bash app/scripts/rotate_external_backups.sh` -> pass
  - backup status written to `runs/latest/external_backup_status.json`

- Error logging + documentation expansion pass (2026-02-15):
  - Added persistent API/runtime error artifacts for `/api/candle_compass`:
    - `app/ui-next/src/app/api/candle_compass/route.ts`
      - new runtime error event stream:
        - `runs/latest/runtime_error_events.jsonl`
        - `runs/latest/runtime_error_last.json`
      - error responses now include `errorId` for traceability.
      - failed service/runtime operations are mirrored into runtime error events.
  - Added one-command debug validation logger:
    - `app/scripts/run_debug_validation.sh`
      - runs lint/test/build/pytest/startup/e2e checks,
      - writes timestamped logs and summaries:
        - `runs/latest/logs/debug_validation_<timestamp>.log`
        - `runs/latest/logs/debug_validation_<timestamp>.summary.txt`
        - `runs/latest/logs/debug_validation_latest.log`
        - `runs/latest/logs/debug_validation_latest.summary.txt`
  - Expanded usage documentation:
    - replaced `assistant/resources/docs/APP_USER_GUIDE.md` with comprehensive manual
      (module usage, workflows, troubleshooting, logging map, handoff checklist).
    - updated `app/ui-next/src/app/help/page.tsx` with explicit error-log/debug-file section.
    - updated `README.md` command section with `run_debug_validation.sh`.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (7 tests)
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/pytest -q` -> `135 passed`
  - `bash -n app/scripts/run_debug_validation.sh && bash app/scripts/run_debug_validation.sh` -> pass (log artifacts generated)

- Context synchronization pass (2026-02-15):
  - Updated context automation coverage:
    - `app/scripts/update_project_context.py`
      - phase checklist auto-management now covers Phases 1-19,
      - `ACTIVE_STRATEGY` memory template now includes Phase 19 voice-interface rationale.
  - Updated assistant context references:
    - `assistant/TODO.md`
      - refreshed backend test baseline reference to `135 passed`.
    - `assistant/FIXME.md`
      - clarified runtime note for port `3000` conflicts with launcher fail-fast/alternate-port support.
    - `assistant/context/ACTIVE_STRATEGY.md`
      - regenerated from automation script to include 16-19 ecosystem memory.
  - Validation:
    - `python3 app/scripts/update_project_context.py --todo assistant/TODO.md --roadmap assistant/ROADMAP.md --active assistant/context/ACTIVE_STRATEGY.md` -> `active_strategy=updated`

- Debug hardening pass (2026-02-15):
  - Diagnosed UI launcher failure mode where `npm` was non-executable in environment.
  - Updated launch scripts:
    - `app/scripts/launch_ui.sh`
      - added fallback execution path to local `ui-next/node_modules/.bin/next` for `build`, `dev`, and `start`.
    - `app/scripts/launch_ui_detached.sh`
      - same fallback behavior when `npm` is unavailable,
      - startup now verifies process liveness + HTTP readiness,
      - startup now fails fast and removes PID file if process exits or never becomes healthy.
  - Validation:
    - `bash -n app/scripts/launch_ui.sh app/scripts/launch_ui_detached.sh` -> pass
    - detached launch on free port (`3200`) returned `HTTP/1.1 200 OK`
    - confirmed startup-failure logs on conflicting port (`3100`) and cleanup behavior.

- Continued Phase 17 preset validation UX (2026-02-15):
  - Added duplicate-name and scope hints for Time Machine preset save flow:
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
      - detects same-name custom presets within the current scope and updates existing entry instead of creating duplicate records,
      - shows inline warning when save will overwrite matching preset,
      - shows explicit save scope indicator (`Global` vs `Symbol`),
      - keeps active preset selection aligned on updates.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (7 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/pytest -q` -> `135 passed`

- Continued Phase 17 preset UX polish (2026-02-15):
  - Replaced prompt-based preset UX in Time Machine with inline controls:
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
      - added inline `Preset Name` input for save/update flows,
      - preset apply/select now hydrates the inline name field for quick edits,
      - replaced JSON paste prompt with file-based import via hidden `.json` picker.
  - Prompt-based behavior removed:
    - no `window.prompt` dependency for preset save/import workflows.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (7 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/pytest -q` -> `135 passed`

- Continued Phase 17 symbol-scoped presets (2026-02-15):
  - Added symbol scope support for custom Time Machine presets:
    - `app/ui-next/src/lib/timeMachinePresets.ts`
      - preset model now supports optional `symbolScope`,
      - user preset normalization/persistence includes scope.
    - `app/ui-next/src/lib/timeMachinePresets.test.ts`
      - updated persistence assertions to validate scope behavior.
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
      - preset selector now filters user presets by current symbol scope,
      - save flow supports `Scope to current symbol` toggle,
      - active preset labels now show `[Global]` or `[SYMBOL]` scope markers.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (7 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Continued Phase 17 preset portability (2026-02-15):
  - Added custom preset export/import support:
    - `app/ui-next/src/lib/timeMachinePresets.ts`
      - `exportUserTimeMachinePresetsPayload()`
      - `importUserTimeMachinePresetsPayload(...)`
    - `app/ui-next/src/lib/timeMachinePresets.test.ts`
      - added round-trip payload test.
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
      - added `Export Custom Presets` and `Import Custom Presets` actions in preset control area.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (7 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Continued Phase 17 custom preset persistence (2026-02-15):
  - Added local storage-backed custom Time Machine presets:
    - `app/ui-next/src/lib/timeMachinePresets.ts`
    - supports read/write catalog, upsert, delete, and built-in+user catalog merge.
  - Added preset contract tests:
    - `app/ui-next/src/lib/timeMachinePresets.test.ts`
  - Integrated custom preset controls in Time Machine UI:
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
    - added:
      - preset selector (built-in + custom),
      - `Save Custom Preset`,
      - `Delete Custom Preset`,
      - active preset status indicator.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (6 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Continued Phase 17 preset UX expansion (2026-02-15):
  - Added one-click parameter presets to Time Machine simulator:
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
    - presets included:
      - `Scalp`
      - `Swing`
      - `Conservative`
    - added `Load Settings Defaults` action to restore values from saved Settings profile.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (3 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Continued Phase 17 settings integration (2026-02-15):
  - Added Settings defaults for Time Machine replay/backtest parameters:
    - `app/ui-next/src/lib/uiPreferences.ts`
      - new persisted fields:
        - `timeMachineDefaultStartingCapital`
        - `timeMachineDefaultFeeBps`
        - `timeMachineDefaultSlippageBps`
        - `timeMachineDefaultUseExecutionSim`
    - `app/ui-next/src/app/settings/page.tsx`
      - added `Time Machine Defaults` controls under Appearance panel for those fields.
  - Bound simulator defaults to settings:
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
      - initial state now hydrates from `readUiPreferences()`,
      - backend run payload now respects user-selected `useExecutionSim` toggle.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (3 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Continued buildout pass completed (2026-02-15):
  - Added Phase 17 Time Machine trade-log export/download actions:
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
    - added `Export CSV` + `Export JSON` buttons for simulation trade logs with timestamped filenames.
  - Kept existing replay/backtest behavior intact and added export status feedback in the widget.
- Validation:
  - `cd app/ui-next && ./node_modules/.bin/vitest run` -> pass (3 tests)
  - `cd app/ui-next && ./node_modules/.bin/eslint` -> pass
  - `cd app/ui-next && ./node_modules/.bin/next build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Cleanup continuation completed (2026-02-15):
  - Removed `NewsTicker` styled-jsx warning in frontend Vitest runs by moving ticker animation styles from component-scoped `<style jsx>` to global CSS.
    - updated:
      - `app/ui-next/src/components/dashboard/NewsTicker.tsx`
      - `app/ui-next/src/app/globals.css`
- Validation:
  - `cd app/ui-next && npm run test` -> pass (3 tests, no styled-jsx warning)
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `135 passed`

- Completed requested sequence: Step 2 then Step 1 (2026-02-15):
  - Step 2 complete: moved Strategy Lab runtime logic into core orchestrator path:
    - `app/src/execution/orchestrator.py`
      - added runtime evaluation + override methods (`_evaluate_strategy_lab_runtime`, `_apply_strategy_lab_runtime`),
      - extended `StrategyOrchestrator.decide(...)` inputs with
        `strategy_lab_runtime_profile` + `strategy_lab_templates`,
      - runtime override now applies before finalization, so persisted signal provenance matches final action/strategy.
    - `app/scripts/run_orchestrator.py`
      - removed duplicate post-decision runtime overlay logic,
      - now delegates runtime strategy handling to `StrategyOrchestrator` only.
    - tests:
      - `tests/test_orchestrator.py` now covers runtime `override` and `advisory` behavior.
  - Step 1 complete: added Phase 18 API/UI contract coverage for enriched narrative fields:
    - added shared contract normalizer:
      - `app/ui-next/src/lib/narrativeContract.ts`
      - single contract source for `NarrativeTickerItem` + normalization.
    - wired API/UI to shared contract:
      - `app/ui-next/src/app/api/candle_compass/route.ts`
      - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
      - `app/ui-next/src/components/dashboard/NewsTicker.tsx`
    - added frontend tests (Vitest):
      - `app/ui-next/src/lib/narrativeContract.test.ts`
      - `app/ui-next/src/components/dashboard/NewsTicker.test.tsx`
      - `app/ui-next/src/components/widgets/NewsroomPanel.test.tsx`
    - added frontend test tooling/config:
      - `app/ui-next/package.json` (`npm test`),
      - `app/ui-next/vitest.config.ts`,
      - `app/ui-next/vitest.setup.ts`.
- Validation:
  - `.venv/bin/python -m pytest -q` -> `135 passed`
  - `cd app/ui-next && npm run test` -> pass (3 tests)
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass

- Completed Phase 18 catalyst-confidence follow-up (2026-02-15):
  - Upgraded backend narrative model with confidence attribution + impact decay + source-linked catalyst timeline:
    - `app/src/analysis/narrative_engine.py`
    - cluster outputs now include:
      - `confidence`, `confidence_level`, `confidence_attribution`,
      - `impact` (`initial_score`, `current_score`, `decay_multiplier`, `half_life_hours`),
      - `catalyst_timeline` entries with source URL + per-event impact/decay.
    - digest now includes top-level `catalyst_timeline` and enriched ticker fields (`confidence`, `impact_score`, `decay_multiplier`, `source_links`).
  - Extended API shaping for narrative ticker fields:
    - `app/ui-next/src/app/api/candle_compass/route.ts`
    - `asNarrativeTickerItems(...)` now maps enriched fields for UI consumption.
  - Upgraded GUI briefing/timeline surfaces:
    - `app/ui-next/src/components/dashboard/NewsTicker.tsx`
      - briefing card now shows confidence/impact/decay and source links.
    - `app/ui-next/src/components/widgets/NewsroomPanel.tsx`
      - consumes `narrativeEngine` payload and renders catalyst timeline with per-event metrics.
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
      - passes `narrativeEngine` into newsroom widget and pop-out snapshot.
    - `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`
      - newsroom pop-out now receives `narrativeEngine`.
  - Added/updated tests:
    - `tests/test_narrative_engine.py`
- Validation:
  - `.venv/bin/python -m pytest -q` -> `133 passed`
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass

- Completed Phase 16 runtime activation/profile follow-up slice (2026-02-15):
  - Added Strategy Lab runtime profile plumbing in API:
    - `app/ui-next/src/app/api/candle_compass/route.ts`
    - new `strategyLab` action: `activate`
    - persists runtime profile artifact: `runs/latest/strategy_lab_runtime.json`
    - `GET /api/candle_compass` now includes `strategyLabRuntime`.
  - Wired GUI activation to backend runtime profile:
    - `app/ui-next/src/components/widgets/StrategyLaboratory.tsx`
    - activating a marketplace strategy now attempts server activation with runtime override mode, with graceful local fallback messaging.
  - Added initial orchestrator-side runtime evaluation/overlay (now superseded by core-orchestrator integration in the newer entry above):
    - `app/scripts/run_orchestrator.py`
    - reads runtime profile + saved templates, compiles/evaluates active visual strategy via `StrategyParser`, and annotates output with `strategy_lab_runtime`.
- Validation:
  - `.venv/bin/python -m pytest -q` -> `133 passed`
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass

- Completed Phase 17 Time Machine vectorized backtest integration follow-up (2026-02-15):
  - Added backend Time Machine backtest module:
    - `app/src/backtest/time_machine.py`
    - wraps `src/backtest/vectorized.py` with replay-mode signal construction (`SIGNAL_REPLAY` + `EMA_CROSS`), metrics normalization, equity-curve payload, and structured trade-log generation.
  - Added runner script for API execution:
    - `app/scripts/run_time_machine_backtest.py`
  - Added API route integration:
    - `app/ui-next/src/app/api/candle_compass/route.ts`
    - new POST payload branch: `timeMachineBacktest`
    - executes python runner and returns `timeMachineBacktest` result payload (summary + equity curve + trade log).
  - Upgraded UI simulator behavior:
    - `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
    - `Run Replay` now prefers backend vectorized results, falls back to local heuristic engine on error, and renders richer trade-log rows in GUI.
  - Added tests:
    - `tests/test_time_machine_backtest.py`
- Validation:
  - `.venv/bin/python -m pytest -q` -> `133 passed`
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass

- Completed full debug/test/launch verification cycle (2026-02-15):
  - Validation and build:
    - `.venv/bin/python -m pytest -q` -> `131 passed`
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
  - Operational checks:
    - `python3 app/scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json` -> `status: warn` (non-fatal env gaps only)
    - `python3 app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json` -> `status: ok`
    - verified live endpoints responding:
      - UI API (`/api/candle_compass`) reachable,
      - backend health (`127.0.0.1:8010/api/health`) healthy.
    - launch check detail:
      - started UI runtime explicitly on `127.0.0.1:3100` (`app/runs/ui_server_3100.pid`) and confirmed `/api/candle_compass` responds;
      - backend API remained healthy on `127.0.0.1:8010`.
  - Context and roadmap sync:
    - `python3 app/scripts/update_project_context.py --todo assistant/TODO.md --roadmap assistant/ROADMAP.md --active assistant/context/ACTIVE_STRATEGY.md` -> no drift.

- Completed Phase 16 Laboratory persistence/import follow-up (2026-02-15):
  - Added server-side template persistence path:
    - `app/ui-next/src/app/api/candle_compass/route.ts`
    - new `strategyLab` POST actions:
      - `list` -> returns persisted user templates,
      - `save`/`import` -> validates and stores templates into `runs/latest/strategy_lab_templates.json`,
      - `delete` -> removes persisted template by id.
  - Added schema + graph validator:
    - `app/scripts/validate_strategy_lab_template.py`
    - validates supported strategy schema versions and compiles/runs graph via `StrategyParser` for block compatibility checks.
  - Upgraded Strategy Lab widget sync:
    - `app/ui-next/src/components/widgets/StrategyLaboratory.tsx`
    - startup bootstrap now syncs local templates with server artifacts,
    - save/delete now persist via API with graceful local fallback,
    - added `Import JSON` flow with server-side validation and activation of imported template.
  - Added tests:
    - `tests/test_strategy_lab_template_validator.py`
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `131 passed`

- Completed Phase 19 Cortex voice interface upgrade (2026-02-15):
  - Added voice input component:
    - `app/ui-next/src/components/cortex/VoiceInput.tsx`
    - Web Speech API bridge with:
      - manual push-to-speak command capture,
      - wake mode listening for `"Candle"` + command,
      - transcript normalization and command forwarding.
  - Integrated voice pipeline into Cortex chat:
    - `app/ui-next/src/components/cortex/ChatWidget.tsx`
    - transcripts now execute through the same `/api/candle_compass/cortex` command path as typed prompts.
  - Added listening-state animation:
    - floating Cortex icon now pulses with sound-wave visual when microphone is actively listening.
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `129 passed`

- Completed Phase 18 Newsroom narrative intelligence upgrade (2026-02-15):
  - Added backend narrative aggregator:
    - `app/src/analysis/narrative_engine.py`
    - extends `SocialVolumeScraper` with:
      - RSS sources (CoinDesk, Cointelegraph, Reuters, Bloomberg),
      - NLP-style story clustering,
      - sentiment tagging + narrative tags (`FUD`, `HYPE`, `REGULATION`, `MACRO`).
  - Added artifact generation flow:
    - new script `app/scripts/narrative_scan.py`
    - hooked into bundle refresh pipeline in `app/scripts/run_ui_bundle.py`.
  - Added API narrative payload support:
    - `app/ui-next/src/app/api/candle_compass/route.ts`
    - serves `narrativeEngine` + `newsTicker` (with fallback synthesis from existing news/whale events).
  - Added dashboard breaking-news ticker:
    - `app/ui-next/src/components/dashboard/NewsTicker.tsx`
    - integrated in `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - supports scrolling marquee sentiment colors and click-to-open briefing card summaries.
  - Added tests:
    - `tests/test_narrative_engine.py`
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `129 passed`

- Completed Phase 17 Time Machine replay engine upgrade (2026-02-15):
  - Added backend replay engine:
    - `app/src/execution/replay_engine.py`
    - `MarketReplayer` supports:
      - historical tick loading from date range,
      - virtual clock state,
      - `play`, `pause`, `fast_forward_2x`, `set_speed`, `seek_progress`, `jump_to_event`.
  - Added replay websocket endpoint:
    - `app/main.py` -> `@app.websocket("/ws/replay")`
    - streams replay ticks every ~100ms baseline, with control acks and completion event.
  - Added Time Machine DVR controls UI:
    - `app/ui-next/src/components/widgets/ReplayControls.tsx`
    - integrated into `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
    - includes:
      - scrubber timeline,
      - play/pause,
      - speed (1x/5x/10x),
      - skip-to-volatility jump,
      - Game Mode future-masking on replay tape.
  - Added tests:
    - `tests/test_replay_engine.py`
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `126 passed`

- Completed Phase 16 Laboratory stabilization pass (2026-02-15):
  - Added dedicated lab components:
    - `app/ui-next/src/components/lab/StrategyCanvas.tsx`
    - `app/ui-next/src/components/lab/StrategyMarketplace.tsx`
  - Rebuilt `app/ui-next/src/components/widgets/StrategyLaboratory.tsx` around the new canvas/marketplace architecture.
  - Fixed strategy graph synchronization so activating a marketplace template reliably reloads the canvas graph state.
  - Wired chart-backed simulation input into Strategy Lab in both dashboard and pop-out paths:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`
  - Added/updated backend + test coverage:
    - `app/src/strategies/builder/blocks.py`
    - `tests/test_strategy_builder_blocks.py`
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `122 passed`

- Completed Phase 16-18 foundational ecosystem pass (2026-02-15):
  - Added three new GUI modules across launcher/add-module/dashboard/pop-out:
    - `STRATEGY_LAB` (`Strategy Laboratory`)
    - `TIME_MACHINE` (`Time Machine`)
    - `NEWSROOM` (`Newsroom`)
  - Creation pillar (`Strategy Laboratory`):
    - new component `app/ui-next/src/components/widgets/StrategyLaboratory.tsx`
    - no-code visual strategy builder with saved templates + JSON export
    - integrated into dashboard and pop-out routes.
  - Simulation pillar (`Time Machine`):
    - new component `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx`
    - supports signal replay + EMA-cross simulations with PnL/return/drawdown/win-rate metrics
    - added progression logging path from UI via `/api/candle_compass` POST `progressionUpdate`.
  - Intelligence pillar (`Newsroom`):
    - new component `app/ui-next/src/components/widgets/NewsroomPanel.tsx`
    - combines headline tone scoring, signal-bias context, and social-hype snapshot into narrative text.
  - API integration:
    - updated `app/ui-next/src/app/api/candle_compass/route.ts` POST payload support with `progressionUpdate` so Time Machine can increment backtests and simulated-profit progression safely.
  - Help/docs updates:
    - added module help anchors:
      - `#module-strategy-lab`
      - `#module-time-machine`
      - `#module-newsroom`
    - updated `assistant/resources/docs/APP_USER_GUIDE.md` workflows for Creation/Simulation/Intelligence usage.
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `119 passed`

- Completed tooltip system + arbitrage hub UX/doc polish pass (2026-02-15):
  - Added reusable hover-help bubble component:
    - `app/ui-next/src/components/ui/InfoTip.tsx`
  - Integrated tooltip bubbles in:
    - navbar brand/help area (`Navbar.tsx`),
    - launcher controls (`CommandCenter.tsx`),
    - module header bars via `DashboardWidget` optional `tooltip` prop,
    - pop-out header bars via widget-type tip map in `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`.
  - Added per-module tooltip guidance for all major dashboard widgets:
    - chart, scanner, seasonality, orderflow, trade heat sheet, heatmap hub,
    - portfolio, signals, opportunities, gap hunter, arbitrage hub,
    - system operations, ghost protocol.
  - Added explicit Arbitrage Hub help anchor + docs coverage:
    - `app/ui-next/src/app/help/page.tsx` (`#module-arbitrage-hub`)
    - `assistant/resources/docs/APP_USER_GUIDE.md`
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `119 passed`

- Completed GUI heatmap/arbitrage representation pass (2026-02-15):
  - Added new module type `TRADE_HEAT_SHEET` in launcher/add-module/dashboard/pop-out.
    - `app/ui-next/src/components/dashboard/AddModuleModal.tsx`
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`
    - `app/ui-next/src/components/TradeHeatmap.tsx`
  - Enhanced arbitrage module controls with dedicated menus:
    - mode filter (`ALL`/`SPATIAL`/`TRIANGULAR`),
    - minimum spread threshold,
    - row limit controls.
    - applied in dashboard and pop-out rendering paths.
  - Seasonality pop-out now supports in-popout asset selection menu.
  - Help/docs updated for new trade heat sheet module and heatmap workflows:
    - `app/ui-next/src/app/help/page.tsx`
    - `assistant/resources/docs/APP_USER_GUIDE.md`
  - Default dashboard layout now includes:
    - `Orderflow Heatmap`
    - `Trade Heat Sheet`
- Completed Heatmap Hub multi-tool UX expansion (2026-02-15):
  - Added new widget/module: `HEATMAP_HUB` with tabbed controls for:
    - `ORDERFLOW` (liquidity heatmap),
    - `TRADE` (trade heat sheet win-rate/count mode),
    - `SEASONALITY` (asset-selectable seasonality heatmap).
  - Wired dashboard + launcher + add-module + pop-out routes for Heatmap Hub.
  - Added dedicated pop-out widget type: `HEATMAP_HUB_WIDGET`.
  - Updated help anchors/docs:
    - `#module-heatmap-hub`
    - updated user guide module list/workflows.
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `119 passed`

- Completed Phase 15 "Context Preservation Automation" workflow pass (2026-02-15):
  - Added context updater script:
    - `app/scripts/update_project_context.py` (invoked as `scripts/update_project_context.py`)
    - ensures checkbox entries for Phases 1-15 in:
      - `assistant/TODO.md`
      - `assistant/ROADMAP.md`
    - creates/updates:
      - `assistant/context/ACTIVE_STRATEGY.md`
  - Added local enforcement:
    - `.githooks/pre-commit` auto-runs context updater and stages changed context files.
    - `app/scripts/install_git_hooks.sh` sets `git config core.hooksPath .githooks`.
  - Added CI enforcement:
    - `.github/workflows/ci.yml` `context_sync` job fails if context files drift after updater run.
  - Updated contributor docs:
    - `assistant/CONTRIBUTING.md`
    - `README.md`

- Completed Phase 14 "Flow State UX" pass (2026-02-15):
  - Added Zen mode context + navbar toggle:
    - `app/ui-next/src/components/ZenModeContext.tsx`
    - `app/ui-next/src/components/layout/Navbar.tsx`
    - Zen mode persists in local storage and applies body-level `zen-mode` class.
  - Added smooth clutter transitions and focus behavior:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - non-essential sections/widgets dissolve with framer-motion in zen mode.
    - chart module remains as primary focus path with minimal controls.
    - floating Cortex chat is hidden while zen mode is active.
  - Added progression/gamification backend + badge UI:
    - `app/src/gamification/progression.py`
    - `app/scripts/update_user_progression.py`
    - `app/ui-next/src/components/UserLevelBadge.tsx`
    - `/api/candle_compass` now updates/returns `userProgression` payload.
  - Added one-glance decision card:
    - `app/ui-next/src/components/widgets/SignalSummaryCard.tsx`
    - integrated into dashboard for technical/sentiment/whale red-green confluence.
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `119 passed`
  - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
  - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> pass

- Completed Phase 13 "Dimension Jumper" pass (2026-02-15):
  - Added backend spatial scanner:
    - `app/src/strategies/arbitrage_spatial.py`
    - `SpatialArbScanner` computes cross-exchange spreads with fee + transfer-cost filtering.
  - Added backend triangular scanner:
    - `app/src/strategies/arbitrage_triangular.py`
    - `TriangularScanner` builds conversion graph loops (A -> B -> C -> A) and flags net-positive cycles.
  - Added scan runner + artifact integration:
    - `app/scripts/run_arbitrage_scan.py`
    - writes `runs/latest/arbitrage_opportunities.json`
    - wired into bundle flow in `app/scripts/run_ui_bundle.py`.
  - Added new arbitrage UI module:
    - `app/ui-next/src/components/widgets/ArbitrageTable.tsx`
    - integrated into dashboard + launcher + pop-out (`Gap Hunter`)
    - includes Execute simulation button, loop-trade icon, and hot-spread visual treatment.
  - Updated API integration:
    - `/api/candle_compass` now returns `arbitrage` payload from `arbitrage_opportunities.json`.
  - Updated visual/help surfaces:
    - added arbitrage module help anchor in `app/ui-next/src/app/help/page.tsx`
    - added CSS animations for arbitrage feed emphasis in `app/ui-next/src/app/globals.css`.
  - Added tests:
    - `tests/test_arbitrage_spatial.py`
    - `tests/test_arbitrage_triangular.py`
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `117 passed`
  - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> pass (includes `artifact:arbitrage_opportunities.json`)
  - API verification on clean dev runtime:
    - `GET /api/candle_compass` includes `arbitrage`
    - `GET /api/candle_compass/symbols?symbol=BTC/USD` returns live quote with cache status.

- Completed symbol-catalog + live-quote expansion pass (2026-02-15):
  - Added broad symbol API route:
    - `app/ui-next/src/app/api/candle_compass/symbols/route.ts`
    - supports catalog queries (`limit`, `assetType`, `q`, `refresh`) and per-symbol live quote/details fetch with cache controls.
  - Added/updated symbol/quote backend scripts:
    - `app/scripts/build_symbol_catalog.py`:
      - fixed direct-run import path bootstrap,
      - added NASDAQ listed feeds (`nasdaqlisted.txt`, `otherlisted.txt`) so stock discovery works without `lxml`,
      - keeps run-artifact + asset-universe + ccxt discovery merge.
    - `app/scripts/fetch_symbol_quote.py`: live quote retrieval for stock/crypto with provider/exchange metadata.
  - Wired symbol expansion into GUI:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
      - launcher symbol filter input + refresh button,
      - launcher live quote tiles (price/change/volume/market cap/provider/exchange/cache status),
      - symbol catalog metadata visibility (discovered count, generated-at, provider/exchange coverage),
      - asset selectors now merge in full discovered symbol catalog.
  - Updated bundle pipeline:
    - `app/scripts/run_ui_bundle.py` now runs `build_symbol_catalog.py` so ticker menus stay refreshed after bundle runs.
  - Current generated symbol footprint:
    - `runs/latest/symbol_catalog.json` -> `9433` total symbols (`5000` stocks, `4433` crypto) on this host.
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `113 passed`
  - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
  - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> pass
  - API sanity (dev server on `127.0.0.1:3201`):
    - `GET /api/candle_compass/symbols?limit=8` -> `count=8`, `total=9433`
    - `GET /api/candle_compass/symbols?symbol=AAPL` -> live quote (`provider=yfinance`, `exchange=NMS`, price populated).

- Completed settings expansion + theme/prefs integration pass (2026-02-15):
  - Expanded theme catalog in `app/ui-next/src/config/themeConfig.ts`:
    - added `ocean_depth`, `emerald_grid`, `arctic_flux`, `graphite_amber`, `cobalt_sunrise`.
  - Added global UI preference system in `app/ui-next/src/lib/uiPreferences.ts` with persisted/apply-on-load behavior:
    - refresh interval, default chart symbol/type/timeframe/indicators, whale-bubble default,
    - floating chat visibility/start state,
    - compact mode + reduced motion,
    - UI scale, glass blur, widget radius, glow intensity.
  - Updated settings route `app/ui-next/src/app/settings/page.tsx` into multi-panel configuration console:
    - `Appearance`, `Role Policy`, `Runtime Status`, `Audit Trail`, `Workspace`.
    - appearance now supports save/preview/reset/export/import of preferences.
    - workspace now supports local cache operations (dashboard layout reset, pop-out clear, runtime key clear, factory reset).
  - Wired preferences into runtime UI behavior:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx` now consumes refresh cadence + chart defaults + default whale-bubble state.
    - `app/ui-next/src/components/cortex/ChatWidget.tsx` now respects floating chat visibility and default-open settings.
    - `app/ui-next/src/components/ThemeContext.tsx` now applies UI preferences globally on load/storage/update events.
    - `app/ui-next/src/app/globals.css` now uses configurable CSS vars for panel blur/radius and reduced-motion/compact behavior classes.
- Validation:
  - `cd app/ui-next && npm run lint` -> pass
  - `cd app/ui-next && npm run build` -> pass
  - `.venv/bin/python -m pytest -q` -> `113 passed`
  - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
  - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> pass
  - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke_http.json --strict --check-http ...` -> pass (after restarting `candle_compass.service`).

- Completed GUI module-control and installer hardening pass (2026-02-15):
  - Added module-level Help deep links for all dashboard widgets:
    - Orderflow, Seasonality, Opportunity Board, Portfolio Summary, Ghost Protocol
    - plus pop-out header `Module Help` button routing to `/help#<module-anchor>`.
  - Expanded `/help` module guide anchors to full widget coverage:
    - `#module-orderflow`, `#module-seasonality`, `#module-opportunities`, `#module-portfolio`, `#module-ghost`.
  - Added GUI selection dropdowns with persisted widget config:
    - Recent Signals: `Filter (ALL/BUY/SELL/FALLBACK)` + `Rows (20/50/100)` in dashboard and pop-out.
    - Opportunity Board: `Market (ALL/CRYPTO/STOCKS)` + `Rows (8/16/24)` in dashboard and pop-out.
  - Hardened installer script `app/scripts/install_candle_compass.sh`:
    - now installs Python deps + UI deps + UI build by default,
    - added skip flags for constrained hosts (`--skip-python-deps`, `--skip-ui-deps`, `--skip-ui-build`, `--skip-desktop-launcher`),
    - creates desktop directory safely before writing launcher.
- Next best steps queued:
  - Add component tests for dropdown state persistence and pop-out snapshot hydration.
  - Add installer CI smoke to validate option matrix across hosts.

- Completed in-app help/documentation accessibility pass (2026-02-15):
  - Added GUI help route (`/help`) with quick start, workflow, troubleshooting, and health commands.
  - Added Help links in dashboard navbar and settings.
  - Added contextual per-widget Help links in dashboard headers with deep links:
    - Chart, System Operations, Category Scanner, Recent Signals -> anchored sections under `/help`.
  - Added/updated user docs:
    - `assistant/resources/docs/APP_USER_GUIDE.md`
    - `app/ui-next/README.md`
    - root `README.md` start-here pointers.
- Next best steps queued:
  - Add contextual help links to additional modules (Opportunity Board, Portfolio Summary, Seasonality, Ghost Protocol).

- Completed runtime audit timer reliability hardening pass (2026-02-15):
  - Added API-level runtime audit timer preflight checks (`systemctl`, user-session, script presence) for timer actions.
  - Added structured timer state payloads:
    - `runtimeRolePolicyAuditTimerStatus` (`activeState`, `enabledState`, `active`, `enabled`)
    - `runtimeRolePolicyAuditTimerPreflight`.
  - Updated dashboard/pop-out/settings to display timer active/enabled status + preflight warnings.
  - Hardened dashboard/pop-out/settings operation handling to treat action-level `ok:false` as failures.
  - Extended `app/scripts/e2e_smoke.py` HTTP guards with:
    - `runtime_role_policy_audit_rotate_guard`
    - `runtime_role_policy_audit_timer_install_guard`
- Next best steps queued:
  - Add dedicated API integration/unit tests for timer preflight + action-level failure semantics.
  - Consider normalizing HTTP status codes for runtime operation failures currently encoded as `ok:false` in payloads.

- Completed runtime policy audit rotation + timer automation pass (2026-02-15):
  - Added `/api/candle_compass` operations:
    - `operations.runtimeRolePolicyAudit=rotate`,
    - `operations.runtimeRolePolicyAuditTimer=install|stop|status`.
  - Added runtime scripts:
    - `app/scripts/rotate_runtime_role_policy_audit.py`,
    - `app/scripts/install_runtime_role_policy_audit_timer.sh`,
    - `app/scripts/stop_runtime_role_policy_audit_timer.sh`,
    - `app/scripts/runtime_role_policy_audit_timer_status.sh`.
  - Rotation now writes `runs/latest/runtime_role_policy_audit_rotation_status.json` and archives trimmed events in `runs/archive/runtime_role_policy_audit/`.
  - Dashboard launcher/System Operations widget now include:
    - `Runtime Role Policy Audit Rotate`,
    - `Runtime Role Policy Audit Timer Install/Stop/Status`,
    - timer interval input.
  - System Operations pop-out and `/settings` Audit Trail now expose matching rotate/timer actions.
  - `app/scripts/e2e_smoke.py` now includes `runtime_role_policy_audit_timer_status` and retry-backed HTTP probes.
- Next best steps queued:
  - Add dedicated runtime policy API test module (unit/integration) for role hierarchy + confirm token + timer lifecycle payloads.
  - Add deployment SOP for runtime audit timer enablement defaults (owner role, interval baseline, and host support checks for `systemctl --user`).

- Completed runtime policy audit retention trim pass (2026-02-15):
  - Added `/api/candle_compass` operation `operations.runtimeRolePolicyAudit=trim` with payload `runtimeRolePolicyAuditKeep` (clamped 1-500).
  - `trim` is destructive-gated (role + confirm token) and persists trimmed events in `runs/latest/runtime_role_policy_audit.json`.
  - Dashboard launcher/System Operations widget now include:
    - `Runtime Role Policy Audit Trim` operation,
    - keep-count input.
  - System Operations pop-out now includes matching audit trim operation + keep-count input.
  - `/settings` Audit Trail now includes trim action + keep-count input.
  - `app/scripts/e2e_smoke.py` extended with `runtime_role_policy_audit_trim_guard`.
- Next best steps queued:
  - Add scheduled audit-rotation helper workflow (timer/service) for automated retention policy enforcement.
  - Add dedicated unit/integration tests for role-policy hierarchy coercion + destructive confirm paths.

- Completed runtime policy audit operations parity pass (2026-02-15):
  - Added `/api/candle_compass` operation channel:
    - `operations.runtimeRolePolicyAudit=status|clear`.
  - `runtimeRolePolicyAudit=clear` is now destructive-gated (role + confirmation token) and writes an empty audit artifact.
  - Dashboard launcher/System Operations widget now include:
    - `Runtime Role Policy Audit Status`,
    - `Runtime Role Policy Audit Clear`,
    - audit event count card + export button.
  - System Operations pop-out now has matching audit status/clear actions + export button.
  - `/settings` Audit Trail panel now supports:
    - audit status refresh via API operation,
    - destructive audit clear action,
    - export.
  - Extended `app/scripts/e2e_smoke.py` HTTP checks to include:
    - `runtime_role_policy_audit_status`,
    - `runtime_role_policy_audit_clear_guard`.
- Next best steps queued:
  - Add dedicated unit/integration test harness for runtime role-policy hierarchy coercion and confirmation behavior (beyond smoke probes).
  - Add audit retention/rotation guidance + optional housekeeping script for `runtime_role_policy_audit.json`.

- Completed runtime policy audit + settings visibility pass (2026-02-15):
  - Added runtime policy audit artifact in `/api/candle_compass` set path:
    - `runs/latest/runtime_role_policy_audit.json` stores actor role, previous policy, next policy, key-presence flag, and timestamp.
  - GET `/api/candle_compass` now returns `runtimeRolePolicyAudit`.
  - POST `operations.runtimeRolePolicy=status|set` now returns refreshed `runtimeRolePolicyAudit`.
  - `/settings` now includes an `Audit Trail` panel with refresh/export controls and recent event preview.
  - `app/scripts/e2e_smoke.py` now checks runtime role-policy set guard behavior via `runtime_role_policy_set_guard` probe.
- Next best steps queued:
  - Add dedicated automated unit/integration tests for runtime role policy hierarchy coercion and confirm requirements (beyond smoke probes).
  - Add runbook retention/rotation guidance for `runtime_role_policy_audit.json`.

- Completed runtime role-policy persistence pass (2026-02-15):
  - Added `runtimeRolePolicy` operations in `/api/candle_compass`:
    - `status` to fetch effective role policy state,
    - `set` to update role policy with confirm + role gating.
  - Policy now persists in `runs/latest/runtime_role_policy.json` and is surfaced via `runtimeAuth.policySource`/`policyUpdatedAt`.
  - Dashboard and System Ops pop-out now expose role-policy selectors + save/status controls.
- Completed chart continuity pass (2026-02-15):
  - Chart fallback markers are explicitly labeled in header/tooltips/signals feed.
  - Per-widget chart config is persisted in dashboard widget state and reused for launch/pop-out payloads.
- Next best steps queued:
  - Add API tests for runtime role policy set/status and hierarchy coercion.
  - Add a dedicated `/settings` UI to manage runtime role policy outside the launcher row.
  - Add fallback-marker strict-mode toggle (`env`/settings) for production signal purity workflows.

- Completed runtime-role matrix + GUI gating pass (2026-02-15):
  - `app/ui-next/src/app/api/candle_compass/route.ts` now enforces per-request required role tier based on operation intent.
  - Added runtime auth metadata surface in API responses (`runtimeAuth.requiredRoles` + hierarchy).
  - Added dashboard and system-ops popout role-aware operation controls:
    - required role preview for selected action,
    - client-side action blocking when selected role is insufficient.
- Completed dashboard recoverability + chart marker visibility pass (2026-02-15):
  - `Ensure Core Modules` launcher action now guarantees Chart + System Operations modules exist.
  - `Restore Defaults` launcher action resets dashboard modules/layout.
  - Signal collector now injects fallback BUY/SELL marker pair when one side is absent to keep marker overlays visible.
- Next best steps queued:
  - Add visual badge on chart markers when source is `FallbackMarker`.
  - Add settings-level runtime role policy editor (map operation classes to minimum role with hierarchy validation).
  - Add persisted chart presets per widget instance (timeframe/type/indicators) in dashboard local state.

- Executed local service installation and runtime collision resolution (2026-02-14):
  - Installed UI/backend user services on this host via:
    - `app/scripts/install_service.sh /home/whyte/.MyAppZ/CandleCompass/app`
    - `app/scripts/install_backend_service.sh /home/whyte/.MyAppZ/CandleCompass/app`
  - Diagnosed UI service crash loop:
    - `candle_compass.service` failed on `EADDRINUSE` for `127.0.0.1:3000`.
  - Enhanced installer scripts to accept explicit host/port/runtime env and embed values into systemd service unit:
    - `app/scripts/install_service.sh`
    - `app/scripts/install_backend_service.sh`
  - Reinstalled UI service on isolated app port:
    - `CANDLE_COMPASS_UI_PORT=3100 CANDLE_COMPASS_UI_HOST=127.0.0.1 CANDLE_COMPASS_UI_RUNTIME=production`
  - Final local state:
    - `candle_compass.service`: active/enabled, listening on `127.0.0.1:3100`
    - `candle_compass-backend.service`: active/enabled, healthy on `127.0.0.1:8010`

- Executed runtime-destructive auth + service-log telemetry pass (2026-02-14):
  - Extended `/api/candle_compass` in `app/ui-next/src/app/api/candle_compass/route.ts` with:
    - server-side destructive-operation gating using:
      - confirm text `CONFIRM_RUNTIME_DESTRUCTIVE_ACTION`
      - role gate (`x-runtime-role` / `runtimeOperatorRole`)
      - configurable required role via `CANDLE_COMPASS_RUNTIME_REQUIRED_ROLE` (default `operator`)
    - protected actions include:
      - `killSwitch`,
      - `operations.appService=disable`,
      - `operations.backendService=disable`,
      - `operations.serviceActionHistory=clear`
    - service log payloads:
      - GET: `serviceLogs` (ui/backend/memory/bundle tails + metadata),
      - POST operation: `serviceLogs=status`.
  - Expanded System Operations UI:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`:
      - runtime role + confirm-text inputs,
      - service logs refresh action,
      - UI/backend log tail preview and export buttons.
    - `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`:
      - same runtime role + confirm-text controls,
      - service logs refresh + export controls,
      - standalone 5s polling for live status/log updates.
  - Validation:
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - `.venv/bin/python -m pytest -q` -> `113 passed`
    - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
    - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> `status=ok`
    - `.venv/bin/python app/scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json` -> `status=warn` (non-fatal)
    - live API checks confirmed destructive gating and `serviceLogs` response shape.

- Executed service-console provisioning expansion pass (2026-02-14):
  - Extended `/api/candle_compass` operations in `app/ui-next/src/app/api/candle_compass/route.ts`:
    - `appService`: added `install|disable` actions,
    - `backendService`: added `install|disable` actions,
    - added `serviceActionHistory: status|clear` action channel.
  - Expanded dashboard + pop-out System Operations controls:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`
    with install/disable/status controls for app/backend services and history status/clear controls.
  - Added direct API polling in System Operations pop-out (`app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`) at 5s cadence for live standalone status.
  - Added confirmation prompts for destructive GUI actions (`disable`, `clear history`) in both dashboard and pop-out.
  - Validation:
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - `.venv/bin/python -m pytest -q` -> `113 passed`
    - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
    - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> `status=ok`
    - `.venv/bin/python app/scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json` -> `status=warn` (non-fatal env gaps)
    - live API checks validated `serviceActionHistory` status/clear flow with runtime key auth.

- Executed runtime-control + service-console completion pass (2026-02-14):
  - Completed `/api/candle_compass` runtime authorization for service-control actions and validated live:
    - unauthorized POST (`operations`) -> `403`,
    - authorized POST with `x-runtime-control-key` -> `200`.
  - Expanded service parity in API payload/operations:
    - added `backendAppService` status fields under `serviceStatus`,
    - added `operations.backendService` (`start|stop|restart|status`).
  - Expanded dashboard + pop-out controls in:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`
    with:
    - runtime control key input/persistence,
    - backend app-service actions,
    - service action history export/download buttons.
  - Added backend systemd wrapper scripts:
    - `app/scripts/run_backend_service.sh`
    - `app/scripts/install_backend_service.sh`
    - `app/scripts/stop_backend_service.sh`
    - `app/scripts/backend_service_status.sh`
  - Enhanced chart marker visibility in `app/ui-next/src/components/ChartPanel.tsx`:
    - BUY/SELL marker text + larger marker size,
    - live marker counts in chart header.
  - Validation:
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - `.venv/bin/python -m pytest -q` -> `113 passed`
    - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
    - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> `status=ok`
    - `.venv/bin/python app/scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json` -> `status=warn` (non-fatal env gaps)

- Executed runtime-service modernization pass (2026-02-14):
  - Migrated UI launch scripts to Next.js runtime flow:
    - `app/scripts/launch_ui.sh` now runs Next (`start` for production / `dev` for development),
    - `app/scripts/launch_ui_detached.sh` now runs detached Next runtime (with `--runtime` selector),
    - `app/scripts/install_service.sh` now uses production Next runtime start command.
  - Added backend detached runtime scripts:
    - `app/scripts/launch_backend_detached.sh`
    - `app/scripts/stop_backend_detached.sh`
    - `app/scripts/backend_status.sh`
  - Added absolute-path normalization across UI/memory/backend launch/status scripts to fix relative-root PID/log path failures.
  - Extended `/api/candle_compass` operations in `app/ui-next/src/app/api/candle_compass/route.ts` with:
    - backend controls (`backendServer: start|stop|restart|status`),
    - enhanced service status payload (`serviceStatus.backend`),
    - persistent service-action history artifact (`runs/latest/service_console_actions.json`) via append logging.
  - Extended System Operations UI in:
    - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
    - `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`
    with backend control actions, backend status cards, and recent service-action timeline rendering.
  - Validation:
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - `.venv/bin/python -m pytest -q` -> `113 passed`
    - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
    - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> `status=ok`
    - `.venv/bin/python app/scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json` -> `status=warn` (non-fatal env gaps)
    - live API smoke (`next dev` temp ports) verified:
      - GET payload includes `serviceStatus.backend` and `serviceConsoleActions`,
      - POST operations returns `backendServerAction`, `uiDetachedAction`, `appServiceAction`, `memoryServerAction`.
    - direct script validation:
      - backend detached start/status/stop cycle completed successfully.

- Executed service-console expansion pass (2026-02-14):
  - Extended `app/ui-next/src/app/api/candle_compass/route.ts` operations with:
    - `uiDetached`: `start|stop|restart|status`
    - `appService`: `start|stop|restart|status` (`systemctl --user` on `candle_compass.service`)
  - Extended runtime `serviceStatus` payload with `appService` status fields:
    - `available`, `active`, `enabled`, `activeState`, `enabledState`.
  - Expanded launcher operation dropdown + dispatcher in `app/ui-next/src/components/dashboard/CommandCenter.tsx` to include detached UI and app service actions.
  - Expanded System Operations widget cards/buttons with:
    - app service state cards,
    - detached UI start/stop/restart/status,
    - app service start/stop/restart/status.
  - Upgraded `SYSTEM_OPERATIONS_WIDGET` pop-out to be interactive:
    - operation dropdown + run button,
    - in-popout API operation execution and state refresh,
    - quick action buttons for UI/service controls.
  - Added unresolved-issues tracker `assistant/FIXME.md` and logged remaining service/runtime gaps.
  - Validation:
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - `.venv/bin/python -m pytest -q` -> `113 passed`
    - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass
    - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> `status=ok`
    - `.venv/bin/python app/scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json` -> `status=warn` (non-fatal config gaps)
    - API smoke (`next dev` temp port) -> GET includes `serviceStatus.appService`; POST operations returns `uiDetachedAction`, `appServiceAction`, `memoryServerAction`.

- Executed system-operations module completion pass (2026-02-14):
  - Added new `SYSTEM_OPERATIONS` module type to dashboard launcher/add-module flow and default widget layout in `app/ui-next/src/components/dashboard/CommandCenter.tsx` and `app/ui-next/src/components/dashboard/AddModuleModal.tsx`.
  - Extended `/api/candle_compass` in `app/ui-next/src/app/api/candle_compass/route.ts` with:
    - runtime `serviceStatus` payload (UI + memory process/listening/health),
    - `startupValidation` + `e2eSmoke` artifact passthrough,
    - POST `operations` actions for startup check, e2e smoke, and memory server start/stop/status.
  - Added dashboard operation controls:
    - global operation dropdown + run button in launcher strip,
    - widget-level buttons for startup/e2e/memory actions.
  - Added missing pop-out renderer for `SYSTEM_OPERATIONS_WIDGET` in `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`.
  - Live validation:
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - API smoke (`next dev` temp port) -> GET includes `tradeSignals`, `startupValidation`, `e2eSmoke`, `serviceStatus`; POST `operations.memoryServer=status` returns `ok`.
    - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict` -> pass

- Executed UI launchability + marker fallback pass (2026-02-14):
  - Added advisory-driven BUY/SELL marker fallback in `/api/candle_compass` when `trade_signals.json` and `trades.json` are missing and orchestrator outputs no actionable signal.
  - Verified `/api/candle_compass?symbol=BTC/USD` now emits fallback marker payload (`tradeSignals_len=1`, source `Above VWAP`).
  - Added module-level launcher UX in `CommandCenter`:
    - launcher dropdown for all widget/tool modules,
    - symbol selector dropdown,
    - one-click `Launch Module`,
    - `Run Bundle`,
    - `Launch Primary Chart`.
  - Added explicit per-widget `Launch` button support in `DashboardWidget` and wired all module types in `CommandCenter`.
  - Added Opportunity Board market dropdown (`ALL`/`CRYPTO`/`STOCKS`) for module-level filtering.
  - Expanded pop-out route support to render all major widget types:
    - chart, orderflow, category scanner, seasonality, portfolio summary, recent signals, opportunity board, ghost protocol.
  - Added next-step ops scripts:
    - `scripts/validate_startup_config.py` (fatal/non-fatal startup gate + remediation output),
    - `scripts/e2e_smoke.py` (artifact + optional HTTP/WS smoke validation).
  - Generated:
    - `runs/latest/startup_validation.json`,
    - `runs/latest/e2e_smoke.json`.
  - Validation:
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - `.venv/bin/python app/scripts/validate_startup_config.py --config app/config.yaml --out app/runs/latest/startup_validation.json` -> `warn` (non-fatal)
    - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict` -> `ok`

- Night-stop checkpoint/save completed:
  - commit `e153fd0` pushed to `origin/main`,
  - backup branch pushed: `backup/20260213-193946-night-stop`,
  - checkpoint tag pushed: `checkpoint-20260213-193946-night-stop`,
  - archive created: `/home/whyte/.cursor/CandleCompass_backup_20260213_193946.tar.gz`.

- Executed debug/test/fix + launch validation pass (2026-02-14):
  - Added `/api/candle_compass` system warning synthesis for missing config/API keys and degraded runtime states in `app/ui-next/src/app/api/candle_compass/route.ts`.
  - Added dashboard-level advisory rendering in `app/ui-next/src/components/dashboard/CommandCenter.tsx` so warnings are visible in-app with severity styling and hints.
  - Verified frontend dev API warning payload currently surfaces missing keys (`POLYGON_API_KEY`, `CANDLE_COMPASS_AI_CONTROLLER_KEY`) and social sentiment limited mode.
  - Added explicit night-stop follow-up note in `assistant/TODO.md` for Social Sentiment credentials + RAM capacity check for optimizer concurrency.
  - Validation:
    - `.venv/bin/python -m pytest -q` -> `113 passed`
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - backend launch probe -> pass (`/api/health` 200, `/api/health/trading` gate status preserved)
    - frontend launch probe -> pass (`/` and `/api/candle_compass` both 200)

- Executed system-integration refinement pass (2026-02-14):
  - Added global pop-out abstraction `app/ui-next/src/components/utils/PopOutWrapper.tsx`.
  - Added generic pop-out surface route `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx`.
  - Applied pop-out wrapper to:
    - chart widget (Price Chart) in dashboard command center,
    - orderflow heatmap widget,
    - Cortex chat conversation panel.
  - Extended `ChartPanel` with layer controls (`layers.whaleBubbles`) and propagated layer state through chart snapshots/pop-out props.
  - Added Cortex event bus `app/ui-next/src/components/cortex/cortexEvents.ts`.
  - Subscribed `app/ui-next/src/components/dashboard/CommandCenter.tsx` to Cortex events so "Show me the Whale Bubbles" can:
    - ensure a chart widget exists,
    - enable `layers.whaleBubbles: true`,
    - surface status notice if whale feed data is pending.
  - Added explicit commander support for whale-bubble dashboard patch intents in `app/src/agents/commander.py`.
  - Added fallback parser support in `app/ui-next/src/app/api/candle_compass/cortex/route.ts`.
  - Added command test coverage in `tests/test_cortex_commander.py`.
  - Validation:
    - `.venv/bin/python -m pytest -q` -> `113 passed`
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass

- Executed Phase 12 "Whale Hunter" implementation pass (2026-02-14):
  - Added whale-detection infrastructure in `app/src/data/trade_stream.py`:
    - `WhaleDetector` threshold filter (default $100k),
    - `WhaleEvent` payload model,
    - stream-level `on_whale` callback for immediate event dispatch,
    - tick enrichment with `notional` + whale tag (`WHALE_BUY`/`WHALE_SELL`).
  - Added backend websocket broadcast path in `app/main.py`:
    - live whale-stream task at startup (`TradeStream` on configured exchange/symbol),
    - broadcast fanout to connected clients,
    - new websocket endpoint `/ws/whales`.
  - Added `trade_stream` config in `app/config.yaml` for enable/exchange/symbol/threshold controls.
  - Updated `app/ui-next/src/components/ChartPanel.tsx`:
    - removed whale arrow markers,
    - added Whale Bubbles overlay layer (semi-transparent circles),
    - bubble radius now scales with whale notional size,
    - bubble color uses cyber neon green/red for buy/sell,
    - added live whale websocket listener and incremental UI updates.
  - Added test coverage `tests/test_trade_stream_whales.py`.
  - Validation:
    - `.venv/bin/python -m pytest -q` -> `112 passed`
    - `.venv/bin/ruff check app/src/data/trade_stream.py app/main.py tests/test_trade_stream_whales.py` -> pass
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - backend startup probe (`uvicorn main:app`) -> pass
    - websocket endpoint handshake (`ws://127.0.0.1:8011/ws/whales`) -> `ws_ok`

- Executed Phase 11 "Evolutionary Optimization" implementation pass (2026-02-14):
  - Added `app/src/optimization/evolution.py` with `GeneticOptimizer`:
    - baseline parameter extraction from config,
    - 20-mutant population generation,
    - rapid vectorized backtest fitness evaluation (default metric: annualized return),
    - best-mutant selection and auto-update when improvement threshold exceeds 5%.
  - Added nightly job script `app/scripts/run_nightly_evolution.py`:
    - reads weekly scored strategy outcomes from `TradeSignalRecord` DB,
    - selects worst-performing strategy,
    - runs optimization against recent data,
    - logs result to `runs/latest/nightly_evolution.json` and emits summary line.
  - Added tests `tests/test_evolution_optimizer.py`.
  - Validation:
    - `.venv/bin/python -m pytest -q tests/test_evolution_optimizer.py` -> `2 passed`
    - `.venv/bin/python -m pytest -q` -> `110 passed`
    - `.venv/bin/python app/scripts/run_nightly_evolution.py --population-size 3 --lookback-days 15` -> graceful skip message when no weekly scored data.

- Executed Phase 10 "Cortex" implementation pass (2026-02-14):
  - Added `app/src/agents/commander.py` (`CortexAgent`) to parse natural language into structured actions:
    - `NAVIGATE`, `TRADE_PREP`, `SCRAPE`, `QUERY_ACCURACY`, `SCAN`.
  - Integrated SCRAPE/HYPE command path with `SocialVolumeScraper` and structured hype-response payloads.
  - Added `app/scripts/cortex_command.py` as CLI bridge for runtime/UI invocation.
  - Added Next.js API bridge `app/ui-next/src/app/api/candle_compass/cortex/route.ts` to execute Cortex commands from chat.
  - Added floating chat component `app/ui-next/src/components/cortex/ChatWidget.tsx` with:
    - persistent message stream (User/Cortex),
    - send input flow,
    - inline TRADE_PREP action card with confirm/cancel actions.
  - Mounted chat globally in `app/ui-next/src/app/layout.tsx`.
  - Added `app/ui-next/src/app/settings/page.tsx` so `NAVIGATE -> /settings` resolves.
  - Added tests `tests/test_cortex_commander.py`.
  - Validation:
    - `.venv/bin/python -m pytest -q` -> `108 passed`
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - runtime probe: `/api/candle_compass/cortex` returns `TRADE_PREP` and `NAVIGATE` payloads correctly.

- Executed launch/data reliability hardening pass (2026-02-13):
  - Patched `app/scripts/run_ui_bundle.py` to prioritize watchlist symbols and keep watchlist crypto symbols (`BTC-USD`, `ETH-USD`) in auto-mode OHLCV exports.
  - Patched `app/ui-next/src/app/api/candle_compass/route.ts` to prefer real OHLCV fallback over synthetic charts and to rebind orderflow proxy by resolved chart symbol.
  - Patched `app/main.py` health semantics:
    - `/api/health` now returns process health + `trading_halted` without failing uptime checks.
    - `/api/health/trading` preserves strict 503 gate behavior.
  - Re-ran online bundle and verified API payloads:
    - default chart: `chartSource=ohlcv`, `chartSymbol=BTC-USD`
    - `symbol=BTC/USD`: `chartSource=ohlcv`, `orderflowSource=ohlcv_proxy`
  - Revalidated full quality gates:
    - `.venv/bin/python -m pytest -q` -> `103 passed`
    - `cd app/ui-next && npm run lint` -> pass
    - `cd app/ui-next && npm run build` -> pass
    - `.venv/bin/python app/scripts/ui_health_check.py --runs runs/latest --strict` -> `UI Health: OK`

- Executed debug/test/fix sweep:
  - Fixed WORM env-check artifact typing (`scripts.export`/`retention_validate` now booleans, not strings).
  - Improved admin control API failure responses for `wormExportRun`, `wormRetentionValidate`, and `wormEnvCheckRun` to include explicit `error` text.
  - Added regression coverage in `tests/test_worm_env_check.py` (2 tests).
  - Revalidated full suite: `.venv/bin/python -m pytest -q` -> `103 passed`, plus `npm run lint` and `npm run build` in `app/ui-next`.
- Executed continuation layout + archival hardening pass:
  - Replaced swap-only widget drag with true drag-to-coordinate placement preview in `CommandCenter` (ghost drop target + collision-aware drop blocking).
  - Added S3-compatible object-lock archive exporter `scripts/export_audit_worm_s3.py` with timer management scripts:
    - `scripts/install_audit_worm_export_timer.sh`
    - `scripts/stop_audit_worm_export_timer.sh`
  - Added admin control-plane `wormExportRun` action and admin UI controls to launch export jobs without shell access.
  - Added retention validation probe script `scripts/validate_audit_worm_retention.py` and admin trigger `wormRetentionValidate`.
  - Added environment preflight script `scripts/check_audit_worm_env.py` and admin trigger `wormEnvCheckRun` with readiness/missing-items output.
  - Updated status surfacing in `scripts/ui_status.sh` for audit WORM export timer and status artifact.
  - Installed `boto3` in `.venv`; retention validation now fails with structured `NoCredentialsError` until S3 credentials are configured.
  - Revalidated with `.venv/bin/python -m pytest -q` (101 passed), `cd app/ui-next && npm run lint`, and `cd app/ui-next && npm run build`.
- Executed continuation UI layout refinement pass:
  - Added mouse-driven snap-grid resize handles (`Rw`, `Rh`, `Rx`) to widget controls in `CommandCenter`.
  - Added live collision preview highlighting while resizing (active widget + colliding peers show red/green preview states).
  - Added resize collision-block notice to prevent invalid layout commits.
  - Revalidated with `.venv/bin/python -m pytest -q` (101 passed), `cd app/ui-next && npm run lint`, and `cd app/ui-next && npm run build`.
- Executed continuation closure pass for remaining audit-shipping durability gap:
  - Added WORM-style append-only audit archival in admin control API to `runs/audit_worm/admin_control_audit_YYYYMMDD.ndjson`.
  - Added WORM status artifact (`runs/latest/admin_control_audit_worm_status.json`) and surfaced it in admin controls payload/UI.
  - Added standalone durable retry worker (`scripts/admin_audit_ship_worker.py`) plus systemd installer scripts:
    - `scripts/install_admin_audit_worker_service.sh`
    - `scripts/stop_admin_audit_worker_service.sh`
  - Added worker status artifact (`runs/latest/admin_control_audit_worker_status.json`) and wired summary visibility in `scripts/ui_status.sh`.
  - Revalidated with `.venv/bin/python -m pytest -q` (101 passed), `cd app/ui-next && npm run lint`, and `cd app/ui-next && npm run build`.
- Executed continuation hardening pass after role/audit rollout:
  - Added hash-chained admin audit entries (`prev_chain_hash`, `chain_hash`) with optional off-host webhook shipping and status artifact (`runs/latest/admin_control_audit_ship_status.json`).
  - Added scoped multi-user notification preference controls in admin UI (select/add/remove user profiles beyond `default`).
  - Updated admin API/control payload to expose shipping status and full audit export.
  - Revalidated `app/ui-next` with `npm run lint` and `npm run build` (pass).
- Executed advanced continuation pass after next-best-step delivery:
  - Upgraded dashboard layout model to explicit per-widget `x/y/w/h` persistence with nudge/resize controls and `xl` grid placement metadata in `CommandCenter`.
  - Added role-scoped admin controls (`analyst`/`operator`/`superadmin`) in `/api/candle_compass/admin/control` via `x-admin-role`.
  - Added signed audit event pipeline (`runs/latest/admin_control_audit.json`) with export support (`GET /api/candle_compass/admin/control?export=audit`).
  - Enforced approval metadata for sensitive admin actions:
    - strategy-weight rollback requires `approval.approvedBy` + `approval.reason`,
    - Ghost trigger requires approval metadata plus explicit `CLOSE ALL` confirmation text.
  - Extended admin UI (`AdminControlPanel`) with role selector, approval inputs, and audit viewer/export control.
  - Validated changes with `npm run lint` and `npm run build` in `app/ui-next` (pass).
- Executed next-best-step delivery pass for remaining Phase 3/5/9 gaps:
  - Added drag-and-drop widget reordering in `app/ui-next/src/components/dashboard/CommandCenter.tsx` with persisted dashboard order.
  - Added new admin control API `app/ui-next/src/app/api/candle_compass/admin/control/route.ts` for:
    - notification preference management,
    - strategy-weight update/rollback with persisted history (`runs/latest/strategy_weights_history.json`),
    - Ghost protocol trigger proxy with explicit confirmation text enforcement.
  - Added operator UI panels:
    - `AdminControlPanel` integrated into `/admin/accuracy`,
    - Command Center Ghost status widget with quick link to admin controls.
  - Extended `/api/candle_compass` payload with `ghostProtocolStatus` for dashboard telemetry.
  - Validated with `cd app/ui-next && npm run lint` and `cd app/ui-next && npm run build` (pass).
- Completed assistant continuity sync across context/rules/skills/TODO so the repository state and planning metadata now match implemented Phases 1-9.
- Normalized legacy audit consistency: `assistant/context/PHASE_AUDIT.md` now marks Phase 9 stress-test/anti-overfit as `Done` with the current `vectorized.py` asset-class cost model evidence.
- Completed Candle Compass Phase 9 Ghost protocol hardening:
  - `GET /api/emergency/close_all` now enforces constant-time token check, IP allowlist, cooldown, and writes `runs/latest/ghost_protocol_status.json`.
  - SMS transport now uses Twilio SDK with lock-screen formatting and Ghost emergency-link appending.
  - Tests added/updated in `tests/test_execution_router.py` and `tests/test_notification_dispatcher.py`.
- Completed full debug and troubleshoot validation:
  - `.venv/bin/pytest -q` -> `101 passed`
  - compile checks, UI health/smoke checks, and backend startup probe all pass in venv.
- Created and pushed protected recovery points:
  - commit `2fc4d43` on `main`,
  - branch `backup/20260213-163033-save-all`,
  - tag `checkpoint-20260213-163033`,
  - archive `/home/whyte/.cursor/CandleCompass_backup_20260213_163033.tar.gz`.
- Next best steps are now concentrated on:
  - provisioning production object-lock bucket credentials and validating retention-policy enforcement end-to-end,
  - optional mobile-specific fallback interaction model for drag-resize controls on narrow screens.

- Executed Candle Compass Phase 5 active-alerts + AI control pass:
  - Added notification dispatcher module with abstract provider contract plus concrete `EmailProvider` (SMTP/SendGrid) and `SMSProvider` (Twilio) in `app/src/notifications/dispatcher.py`.
  - Wired execution-side alert dispatch into `TradeSignalRecorder` so BUY/SELL signals emit urgent notifications right after immutable signal recording.
  - Added secured AI controller router namespace in `app/src/api/routers/ai_controller.py` with:
    - `GET /ai/status/market_summary`
    - `POST /ai/actions/trigger_scrape`
    - `GET /ai/analytics/performance_report`
    - `POST /ai/config/update_strategy_weights`
  - Mounted AI router in `app/main.py`.
  - Added Phase 5 tests (`tests/test_notification_dispatcher.py`, `tests/test_ai_controller_router.py`) and extended recorder coverage for alert dispatch.

- Executed Candle Compass Phase 4 accuracy-tracking hardening pass:
  - Verified end-to-end accuracy pipeline is active: signal persistence (`trade_signal_records`), recorder wiring from orchestrator, periodic auditor runner, and admin accuracy dashboard route/API.
  - Fixed signal enum normalization in `TradeSignalStore` so enum-based signal writes are accepted reliably.
  - Added compatibility import shim `app/src/strategies/orchestrator.py` to map legacy strategy-orchestrator imports to the canonical execution orchestrator.

- Executed Candle Compass Phase 3 modular dashboard implementation:
  - new modular grid command center (`components/dashboard/CommandCenter.tsx`),
  - reusable `DashboardWidget` wrapper,
  - `+ Add Module` nav + add-module modal,
  - category scanner widget + category API endpoint.
- Added backend asset categorization helper (`src/data/asset_manager.py`) and tests for tags/trending logic.
- Current grid system is dynamic/addable/removable and now supports drag-and-drop reordering; grid coordinate/resizing persistence remains a follow-up item.

- Executed Candle Compass Phase 2 chart-engine pass:
  - upgraded `ChartPanel` to advanced layered controls + overlays + multi-pane indicators,
  - added persistent chart pop-out route (`/chart-popout`),
  - wired `tradeSignals` from API to chart annotations.
- Chart now paints neon BUY/SELL markers directly on candles with hover detail cards.
- Indicator engine now supports EMA/Bollinger/Ichimoku overlays plus RSI/MACD/VPIN panes.

- Executed Candle Compass Phase 1 foundation/rebrand/design-system implementation pass.
- Activated Redis + Polygon config defaults and added resilient source bootstrap (`app/src/data/ingestion_service.py`) so Polygon key absence warns without taking down crypto paths.
- Renamed legacy API route and frontend calls to `/api/candle_compass`.
- Performed global rename sweep from legacy naming to Candle Compass across code/docs/scripts/UI labels.
- Added Tailwind cyber palette and upgraded global CSS with cyber glass/neon utility classes.
- Updated README to Candle Compass mission language (high-precision signals + modular accountability).

- Received the Candle Compass architect manifesto and staged the full master execution plan as queued phases in `assistant/TODO.md`.
- Added a persistent rule that every new phase/step/task/part must be recorded in TODO during planning and implementation.

- Upgraded the full assistant framework for higher-quality programming and UI design execution.
- Rewrote core prompt and rules files (`MASTER_SYSTEM_PROMPT`, project/memory rules, prompt templates) to be stricter on quality but less brittle operationally.
- Standardized all skill definitions with trigger-ready frontmatter, validation steps, and output checklists.
- Added missing skill interface metadata for `backtesting`, `data-ingestion`, `risk-management`, and `strategy-design`.
- Refreshed assistant load order/index/context README to improve session startup and context hygiene.

- Added offline fixtures and CI now uses cached data for regression checks.
- Created full backup and tar.gz archive of the project.
- Added longer-window fixtures (Jan 2020) and updated baselines.
- Debugged and ran regression checks successfully.
- Added assistant loadout and advanced dev docs.
- Added one-shot run_all launcher script.
- Added local UI dashboard and launch script.
- Added desktop launcher creation and installer integration.
- UI launcher now auto-opens the browser.
- Added optional systemd user service install script.
- Added tray indicator option and stop-service script.
- Added UI status and toggle scripts.
- Added local memory guide, system doc, and Codex memory rules for Candle Compass.
- Added local memory tool and ingested project context into `data/memory/memories.jsonl`.
- Added memory ingest config and HTTP server wrapper.
- Expanded ingest scope and re-ingested memory store (107 entries).
- Memory server started on http://127.0.0.1:8766 (PID in `runs/memory_server.pid`).
- Optional bearer-token auth available via `CANDLE_COMPASS_MEMORY_TOKEN`.
- Memory server now requires token auth from `.env` (auto-loaded).
- Risk report now includes drawdown/tail/exposure metrics; tests added; dashboard/CLI updated.
- Asset universe config added (`asset_universe.yaml`) with ccxt + yfinance sources.
- Universe fetch script added; provider/exchange options wired into backtest/optimization scripts.
- Provider retry/backoff added to data fetch; health check script available (`scripts/data_health_check.py`).
- Tag exposure analytics added to risk report/dashboard using universe tags.
- Risk report/dashboard accept `--universe` for tag exposure (tests added).
- Risk metric baselines created (`assistant/context/risk_baselines.json`) and CI now checks them.
- UI now includes selectable risk tolerance profiles (localStorage + ui/risk_profiles.json).
- Roadmap/TODO expanded with decision-support feature backlog (research-only).
- Advisory spec doc added (`assistant/resources/docs/ADVISORY_DASHBOARD_SPEC.md`).
- Advisory UI integration added (watchlist, focus, advisory cards, scanner panel).
- Advisory engine tests added (`tests/test_advisory_engines.py`).
- Advisory JSON output enriched with analysis window and tags.
- Advisory data quality badges added (coverage/staleness + status tags).
- Advisory data quality banners added for warn/poor states.
- Desktop launcher helper added to ensure icon opens UI (`scripts/launch_ui_desktop.sh`).
- Global data freshness summary banner added to UI with overall status.
- Quality banner tooltips now show exact coverage/age/bars/notes.
- Advisory run UX improved (clipboard command + crypto symbol auto-expansion in watchlist).
- Advisory runner now checks for missing dependencies and prints install steps.
- OHLCV loader now handles legacy Date/unnamed timestamp columns (tests added).
- Market context engine added (regime + sentiment proxy) and UI block.
- External sentiment ingestion added (Alternative.me + optional Alpha Vantage).
- UI settings modal added and run_ui_bundle script now populates dashboards.
- Ranked list alignment fix added (timestamp-aligned series).
- OHLCV loader now coerces numeric columns.
- UI server now serves repo root (ensures runs/latest data is reachable).
- Exchange selector added (Coinbase/Kraken/etc) with ccxt filtering.
- Asset universe ccxt entries switched to Coinbase/Kraken pairs.
- Added Uniswap subgraph data source (requires THEGRAPH_API_KEY).
- Added bundle refresh timer (systemd user service + timer).
- Added SEC EDGAR + Alpha Vantage research aggregation in advisory cards.
- Added auto data source selection + ccxt multi-exchange aggregation.
- Added resources docs for exchanges and research sources.
- Added top crypto/stock panels, research feed panel, and exchange stats panel.
- Auto data-source aggregation + Uniswap support included in top lists and stats.
- Normalized crypto symbol matching across UI + resolver (dash vs slash).
- UI advisory cards refreshed to Oracle-style block layout with strength meter/health dot.
- One-click watchlist add added to scanner results, ranked list, and top lists.
- Status card now updates based on live/offline data mode + data source settings.
- Asset universe end date set to `today` with resolver support for dynamic dates.
- UI bundle runner now handles symbol variants for dashboard backtests and passes provider into ranked list.
- Ran `scripts/run_ui_bundle.py` with auto provider to regenerate `runs/latest` outputs.
- Created backup archive `/home/whyte/.cursor/CandleCompass_backup_20260203_052458.tar.gz` (excluding `.venv`, `.pytest_cache`, `backups/`, and `__pycache__`; stored one level above repo).
- Updated advisory engine test to expect BUY action (3/3 tests passing).
- Created full backup archive `/home/whyte/.cursor/CandleCompass_full_backup_20260203_054815.tar.gz` (includes `.venv` and raw data; stored one level above repo).
- Removed empty `backups/` folder from repo after moving archives.
- Added confluence engine and advisory JSON fields for confluence + market regime summaries.
- Advisory UI now includes confluence block, confluence summary, and market regime overview cards.
- Added watchlist management panel (remove/clear) and module view filter navigation bar.
- Added confluence engine tests and updated advisory spec + memory guide.
- Added `scripts/ui_health_check.py` for UI artifact validation.
- Created new skills: `advisory-pipeline`, `ui-console`, `ops-automation`, `memory-ops` (with references and agents metadata).
- Added MCP config stub `assistant/resources/mcp/candle_compass_memory.json` for local memory server.
- Added UI health check step to `assistant/context/NIGHTLY_CHECKLIST.md`.
- Enhanced master system prompt, prompt templates, and project rules for UI data contracts.
- Added system docs: `assistant/resources/docs/SYSTEM_OVERVIEW.md`, `assistant/resources/docs/UI_DATA_CONTRACT.md`, `assistant/resources/docs/OPS_RUNBOOK.md`.
- Updated `assistant/MEMORY_GUIDE.md` with UI health check reference.
- Added `assistant/resources/docs/QUALITY_GATES.md` and updated the loadout/index.
- Fixed `scripts/plot_diagnostics.py` to avoid crashes when rolling Sharpe is empty.
- Ran offline UI bundle refresh with fixtures; UI health check is OK.
- Updated timestamp parsing in `src/data/fetch.py` to reduce noisy warnings.
- Ran online UI bundle refresh (auto provider); UI health check is OK.
- Created backup archive `/home/whyte/.cursor/CandleCompass_backup_20260204_125254.tar.gz` (excluded `.venv`, `.pytest_cache`, `backups/`, and `__pycache__`).
- Added UI defaults/watchlist/alerts to config and `app_settings` export for the UI.
- Added ranked lists by asset class, derivatives/flow dashboards, scorecards, alerts, optimizer, stress tests, and top traders outputs with UI panels.
- Added signal library, confluence decay weighting, and regime confidence to advisory pipeline outputs.
- Added `data/public/README.md` for public inputs (top traders CSV guidance).
- Added backup script `scripts/backup_project.sh` and updated ops docs/checklist.
- Fixed new dashboard scripts to add repo root to `sys.path` when executed.
- Ran `scripts/run_ui_bundle.py` (auto provider) and `scripts/ui_health_check.py` (OK).
- Created backup archive `/home/whyte/.cursor/CandleCompass_backup_20260204_135733.tar.gz` (excluded `.venv`, `.pytest_cache`, `backups/`, and `__pycache__`).
- Added UI smoke test script `scripts/ui_smoke_test.py` and documented in quality gates/commands.
- Added sample `data/public/top_traders.csv` template and unignored public data directory in `.gitignore`.
- Added user rule to log suggested question items into `assistant/TODO.md` or another backlog list.
- Re-ingested local memory store (`scripts/memory_tool.py ingest --replace`).
- Updated UI launch scripts to wait for server readiness and open the default browser reliably.
- Desktop launcher now relies on `launch_ui.sh` for browser open; installer ensures `launch_ui.sh` is executable.
- Desktop launcher script now ensures `launch_ui.sh` is executable.
- Fixed `launch_ui.sh` arg parsing so flags (like `--no-open`) work without a root dir.
- Added detached UI launcher (`scripts/launch_ui_detached.sh`) with PID/log handling and stop script; desktop launcher now uses detached mode.
- Updated `ui_status.sh` to report detached UI PID status and documented detached launch/stop commands.
- Ran full UI bundle refresh; `scripts/ui_health_check.py` and `scripts/ui_smoke_test.py` both OK.
- Detached UI server started (PID in `runs/ui_server.pid`).
- Added enhancement backlog items to `assistant/TODO.md`.
- Created backup archive `/home/whyte/.cursor/CandleCompass_backup_20260204_164646.tar.gz`.
- Created backup archive `/home/whyte/.cursor/CandleCompass_backup_20260204_180540.tar.gz`.
- Added app-only installer manifest and updated installer to copy only runtime files.
- Documented installer manifest in README, ops runbook, and context index.
- Fixed settings modal binding by deferring UI script load to include modal elements.
- Updated UI bundle runner to allow ad-hoc symbols and to include yfinance crypto assets when auto provider uses ccxt.
- Added TODO items for themes, profiles, signal expansion, custom tools, and scraping adapters.
- Moved assistant/meta files under `assistant/` and updated loadout/index/docs/ingest paths.
- Installer now skips offline smoke tests and excludes `data/fixtures` from the app install manifest.
- Added Market Microstructure directive to the master system prompt and reinforced the TODO rule for missed work.
- Added tick-level trade stream (ccxt.pro), CVD calculator, and absorption divergence detector with orderflow runner + tests.
- Added VPIN toxicity module and liquidity void scanner; orderflow runner now exports VPIN + liquidity void outputs.
- Added Gaussian HMM regime classifier (`src/analysis/regime_hmm.py`) with CLI runner.
- Added NLP alpha bridge (`src/advisory/nlp_alpha.py`) and sentiment velocity CLI runner.
- Added BTC/ETH pairs trading z-score module with CLI runner.
- Added tests for HMM regime, NLP RSS parsing, and pairs trading signal.
- Updated command catalog and system overview to include Phase 3 modules.
- Updated master system prompt to prefer WebGL (Pixi.js/Three.js) for CVD + heatmap visuals with fallback rendering.
- Added StrategyOrchestrator (regime + VPIN gating) with MA crossover and pairs mean reversion routing.
- Added `scripts/run_orchestrator.py` and wired it into `scripts/run_ui_bundle.py` (optional regime override).
- Added UI settings control for manual regime override and app settings default.
- Added `ui-next/` Next.js command center with Tailwind + Framer Motion and deep-theme engine.
- Added TradingView Lightweight Charts main panel plus Pixi.js WebGL CVD + heatmap widgets with fallback.
- Added UI error boundary, reconnecting overlay on data lag, wallpaper upload with brightness filter, and dry-run toggle with projected profit.
- Added performance analytics module and `scripts/alpha_report.py` to generate alpha report, trade heatmap, and adverse excursion summary.
- Added cross-asset intelligence module and macro calendar gatekeeper with UI panels for correlations and economic countdown.
- Added Monte Carlo stress test module + CLI output to flag fragile strategies.
- Added anchored walk-forward validation utilities + CLI runner.
- Orchestrator now consumes Monte Carlo guard + dry-run state to block fragile live deployments.
- Documented Monte Carlo/walk-forward artifacts in system overview + UI data contract.
- Added aliases for MCP/sub-agent loading and Monte Carlo/walk-forward runs.
- Added tests for Monte Carlo and anchored walk-forward.
- Exposed Monte Carlo + strategy guard fields via ui-next API output.
- Implemented glassmorphism overlays for settings and sub-tabs in ui-next.
- Added dynamic chart glow for buy/sell signals and price-line glow on sells.
- Added micro-interaction animations for market tab switching and responsive settings sidebar.
- Added SignalGatekeeper and wired it into orchestrator decisions (regime + VPIN + DXY).
- Added manual logic gate override (freeze) via ui-next and `logic_gate_override.json`.
- Updated orchestrator output/tests for gatekeeper + capital preservation logic.
- Added multi-source trade stream failover with stale-data detection (WS -> secondary -> CoinGecko) and updated orderflow runner.
- Added UI latency warning + backend latency status for slippage tolerance widening.
- Added automated health check script and timer with push notification support.
- Added smart execution planner with TWAP/VWAP/Iceberg scheduling, slippage optimizer, and breakout buffer logic.
- Added smart execution CLI to generate `runs/latest/execution_plan.json` from orderbook snapshots.
- Segregated runtime app into `app/` with root-level symlinks for developer convenience.
- Updated installer to read app-only manifest relative to `app/` and copy from `app/` root.
- Updated baseline regression scripts to resolve assistant baselines from repo root when present.
- Updated memory tool to ingest from repo root when `assistant/` exists (keeps app root for runtime).
- Added `load_master` and `load_everything` instruction aliases; added `regime_confidence` shell alias.
- Documented repo segregation in README + system overview and clarified installer manifest path in ops runbook.
- Updated command catalog with `scripts/regime_confidence.py`.
- Added TODO items for WebGL CVD/heatmap rendering and for identifying/replicating custom market tools.
- Added AES-256 secrets store (`src/security/secrets.py`) + `scripts/secrets_tool.py`; migrated API keys to encrypted store (no keys in .env).
- Added IP whitelist checker (`scripts/ip_whitelist_check.py`) that writes `runs/latest/security_lock.json` and wired lock into orchestrator/gatekeeper decisions.
- Added emergency kill switch (`scripts/kill_switch.py`) + UI shortcut (Ctrl+Shift+K) that writes kill/lock artifacts; live execution gated behind config + env.
- Updated UI API/CommandCenter to show security lock status and kill-switch shortcut.
- Updated docs/commands/aliases for new security tooling and artifacts.
- Added tests for secrets store round-trip and IP whitelist lock behavior.
- Updated `.env.example` to remove secrets in favor of encrypted secrets store.
- Memory server now reads `CANDLE_COMPASS_MEMORY_TOKEN` from encrypted secrets.
- Memory docs now point to secrets store for token auth.
- Added `security` section to `config.yaml` for emergency exchanges and live trading gate.
- Updated research/advisory docs to note The Graph key stored via secrets tool.
- UI bundle runner now unlocks secrets at startup and runs IP whitelist check before orchestrator.
- Purged pip cache to free disk space; installed CPU-only PyTorch in `.venv` (CUDA wheels too large for available disk).
- Added `pytest.ini` to scope pytest discovery to `tests/` (script utilities no longer collected).
- Fixed escaped-quote syntax errors in `src/backtest/vectorized.py` and `src/backtest/walkforward.py`.
- Adjusted absorption divergence detector to require an extra CVD sample before alerting.
- Updated regime normalization to recognize "Ranging" in RegimeLogicGate and SignalGatekeeper.
- Hardened secrets retrieval so wrong passwords raise even if values are cached.
- Updated GPU stress test script to resolve `core` imports regardless of working directory.
- Ran `.venv/bin/python -m pytest` (62 tests passed).
- Disk recovery actions: removed `app/ui-next/node_modules`, `.venv`, `~/.cursor/extensions`, `~/ai_venv`, `~/snap`, `~/ISO`, and `~/Downloads` to reclaim space.
- Git recovery in progress: `.git` was re-initialized locally, but `git fetch origin` failed earlier due to disk exhaustion; current recovery is happening from a clean clone in `/tmp/CandleCompass_work`.
- UI checks (night stop): `scripts/ui_health_check.py` -> OK; `scripts/ui_smoke_test.py` -> OK.
- Pending: reattach working tree to `origin/main` once disk and git state are stable, then sync/commit from the main repo path.
- Repo restored from `origin/main` into `/home/whyte/.cursor/candle_compass`; broken copy preserved at `/home/whyte/.cursor/CandleCompass_broken_20260206_010305`.
- `.env` restored (token present) and `.env.example` relinked to `app/.env.example`.
- Slash-prefixed aliases kept for chat-level use; no-slash shell aliases added for actual terminal expansion.
- Added backup retention rule (max 3 backups, rotate oldest).
- Recreated `.venv` and installed Python dependencies; added FastAPI + Uvicorn to requirements.
- Installed UI Next.js dependencies (`npm install`), updated `package-lock.json`.
- Restarted detached UI server; `ui_health_check` and `ui_smoke_test` both OK.
- Verified backend import with `PYTHONPATH=app` (backend module loads).
- Created local backup archive `backups/CandleCompass_backup_20260206_012445.tar.gz` (excludes `.env`, `.git`, `.venv`, `backups/`, and `app/ui-next/node_modules`).
- Restored `app/data/` from broken copy (fixtures/raw/memory/public) and fixed the `data -> app/data` symlink targets.
- Restored `app/.env.example` so the root `.env.example` symlink resolves correctly.
- Removed the backup archive commit from `main` (via revert) and kept the archive locally in `backups/`. Backup branch retains the tracked archive.
- Added `assistant/context/CURRENT_STATUS.md` and included it in the assistant loadout for quick state checks.
- UI server still listening on port 8000; `stop_ui_detached.sh` reported stale PID (manual stop may be needed if you want it off).
- Restored missing `app/src/data/` modules (trade stream + orderflow) from the broken copy.
- Created Phase 0–22 audit report: `assistant/context/PHASE_AUDIT.md`.
- Removed `app/src/data/__pycache__` files from git tracking and added an ignore rule for that directory.
- Chosen primary launch validation path: Next.js command center (`app/ui-next`); static UI is fallback.
- Updated MarketScanner to default to `ccxt` exchanges via `config.yaml` (avoids Binance 451) and added ccxt polling fallback.
- Backend start confirmed no Binance 451 warnings; Redis optional and Polygon API key still missing.
- Normalized Yahoo Finance symbol handling so slash pairs (e.g., `BTC/USD`) fetch as `BTC-USD`.
- `scripts/run_ui_bundle.py` now exports per-symbol OHLCV series to `runs/latest/ohlcv_series.json`.
- `ui-next` API supports `GET /api/candle_compass?symbol=...` and returns OHLCV chart data when present (with `chartSource` + `chartSymbol`).
- Command Center now requests symbol-specific chart data and displays the resolved chart symbol.
- Added `orderflow_proxy.json` (OHLCV-derived CVD + VPIN per symbol) and `ui-next` now uses it when available for the requested symbol (with `orderflowSource` + `orderflowSymbol`).
- Command Center now shows orderflow source + symbol labels in the VPIN/CVD panels.
- Ran `scripts/run_ui_bundle.py --provider auto` to refresh `runs/latest` artifacts (including OHLCV series + orderflow proxy).
- Added a Profile tab in settings with local-first persistence to `runs/latest/user_profile.json` via the UI API.
- `scripts/build_app_settings.py` now reads `user_profile.json` to override `riskProfile` + `defaultFocus`.
- Prepared git sync with refreshed `runs/latest` artifacts, profile defaults, and orderflow proxy updates.
- Loaded the full assistant boot context (master prompt, rules, prompts, skills, MCP config, and context files) via `assistant/ASSISTANT_LOADOUT.md` and `assistant/FULL_CONTEXT_INDEX.md`.
- Verified all loadout/index referenced paths resolve; no missing context files detected.
- Repaired broken root symlink target by creating `app/templates/` (`templates -> app/templates` now valid).
- Ran strict UI checks: `.venv/bin/python scripts/ui_health_check.py --runs runs/latest --strict` and `.venv/bin/python scripts/ui_smoke_test.py --runs runs/latest --strict` (both OK).
- Ran full test suite: `.venv/bin/python -m pytest -q` (63 passed).
- Validated Next.js command center launch path (`cd app/ui-next && npm run dev`), confirmed startup succeeds on first free port.
- Validated memory server command (`scripts/memory_server.py --host 127.0.0.1 --port 8766`) and `/health` endpoint; cleared stale `runs/memory_server.pid` contents.
- Updated `assistant/context/CURRENT_STATUS.md`, `assistant/context/CHANGELOG.md`, and `assistant/TODO.md` to reflect the 2026-02-11 continuity audit.
- Selected the production UI architecture direction: hybrid chart stack (Lightweight Charts for primary price interaction + Pixi WebGL for CVD/heatmap microstructure overlays).
- Added mandatory Git connectivity guardrail to active backlog: restore/verify `origin/main` connectivity before and after major work.
- Added `scripts/git_connectivity_check.sh` and verified connectivity (`origin/main` reachable; local HEAD matches remote).
- Wired git connectivity checks into command catalog, alias catalog, shell aliases, ops runbook, and nightly checklist.
- Updated Phase 0–22 audit gaps to target hybrid chart wiring implementation (instead of choose/remove ambiguity).
- Added managed memory server lifecycle scripts: `scripts/launch_memory_server.sh`, `scripts/memory_status.sh`, `scripts/stop_memory_server.sh`.
- Updated `scripts/ui_status.sh` to include memory server PID/health status output.
- Added backend Redis runtime toggles (`backend.redis.enabled`, `backend.redis.url`, plus env overrides) so no-Redis mode is explicit by default.
- Backend scanner now loads `POLYGON_API_KEY` from env or unlocked encrypted secrets store when available.
- Updated runbook, commands, aliases, and memory docs for memory lifecycle scripts and Redis/Polygon operational behavior.
- Completed primary-chart migration: `ui-next` now uses Lightweight Charts for the main price panel, including mapped news/whale markers.
- Replaced direct Pixi usage in `CvdWidget.tsx` and `HeatmapWidget.tsx` with Canvas2D rendering to eliminate Next.js/Turbopack build/runtime breakages.
- Added Opportunity Board generation (`scripts/opportunity_board.py`) and bundle integration (`runs/latest/opportunity_board.json`).
- Exposed `opportunityBoard` via `ui-next` API and rendered it in Command Center with per-row action/direction/confidence/reasons and quick symbol focus.
- Added bundle fallback VPIN export (`runs/latest/vpin_signal.json`) from `orderflow_proxy.json` so strict UI health checks pass in offline mode.
- Full validation rerun on 2026-02-12: pytest (63 passed), Next.js production build (pass), strict UI health/smoke (both OK).
- Launch probes rerun on 2026-02-12: backend `uvicorn` startup OK (timeout-bounded), frontend `next dev` startup OK (timeout-bounded).
- Added a dedicated `Stocks` market tab in `CommandCenter` and aligned asset/opportunity selection with `Crypto`/`Stocks`/`Forex` tabs.
- Added inline Opportunity Board drill-down state (selected row detail block with factors + reasons) and row highlighting.
- Exposed `appSettings` in `/api/candle_compass` and added a watchlist mismatch banner when configured watchlist symbols are missing from current artifacts.
- Cleaned remaining frontend lint/build blockers in `ThemeContext` and `EconCalendarPanel`; `npm run lint` now passes clean.
- Added detached bundle refresh runner `scripts/run_bundle_refresh_job.py` and wired `/api/candle_compass` POST `runBundle` to launch it.
- Added `bundleRefreshStatus` to `/api/candle_compass` GET payload and stale-run detection for orphaned runner PIDs.
- Command Center now has a `Refresh Bundle` button with in-header status pill and refresh/error messaging.
- Fixed API POST validation guard so profile-only saves are accepted (no false 400 on settings profile save).
- Fixed direct script execution for `scripts/health_check.py` by adding repo-root path bootstrap for `src` imports.
- Fixed `scripts/stop_memory_server.sh` to remove PID files on stop/empty PID, preventing false "stale PID" status in `ui_status.sh`.
- 2026-02-16: Diagnosed MCP/memory failure as detached process persistence in memory launcher; updated `app/scripts/launch_memory_server.sh` to use `setsid` (with `nohup` fallback) so memory server stays active.
- 2026-02-16: Verified memory lifecycle and MCP endpoint health (`launch_memory_server.sh`, `memory_status.sh`, `/health`, and `/mcp` list_memories call all succeeded).
- 2026-02-16: Re-ingested local project memory (`python scripts/memory_tool.py ingest --replace` -> `added=357 skipped=0 errors=0`) and reloaded prompts/rules/skills/context references.
- 2026-02-16: Added focused component coverage for Time Machine preset UX (`app/ui-next/src/components/widgets/TimeMachineSimulator.test.tsx`) for save, same-scope overwrite, and JSON import.
- 2026-02-16: Updated backlog status by marking the Time Machine preset UX test follow-up complete in `assistant/TODO.md`.

- Phase 7 rendering singularity achieved — artifacts eliminated


---