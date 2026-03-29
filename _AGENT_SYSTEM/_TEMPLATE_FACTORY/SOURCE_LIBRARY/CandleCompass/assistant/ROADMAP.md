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
