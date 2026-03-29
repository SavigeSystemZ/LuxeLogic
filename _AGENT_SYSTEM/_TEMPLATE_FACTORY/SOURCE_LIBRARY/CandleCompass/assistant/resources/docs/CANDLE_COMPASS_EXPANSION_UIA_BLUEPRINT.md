# Candle Compass Expansion Plan (UIA Blueprint)

## Purpose
This blueprint defines a structured expansion plan for Candle Compass to evolve into a world-class, customizable, multi-asset trading terminal. It complements the master system prompt and roadmap by specifying:
- MVP product requirements
- architecture and data model direction
- API and UI surfaces
- non-functional requirements
- milestone plan with done criteria and validation
- tool-ready prompt packs (Milestone 1)
- quality gates and rollback strategy

Companion extension:
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT_ADDENDUM.md` (single-developer workflow, three-branch model, UI/navigation/theme addendum, M12-M16)

## 1. Clarifications & Assumptions

### Existing Baseline
- Backend: FastAPI + market ingestion/scanning/risk gating + WebSockets
- Frontend: Next.js 14 + Tailwind + Framer Motion + cyber-futurist glassmorphism
- System docs: master prompt, roadmap, architecture, context continuity

### Domain Scope
Expansion targets:
- equities
- options
- futures
- crypto

Focus areas:
- modular dashboards
- algorithmic strategy creation
- risk management
- customizable trader UX

### Data Sources
- Existing references include CCXT and optional Polygon
- Additional connectors (e.g., equities/options/futures brokers) will be layered in as product scope expands

### User Management
- Auth, authorization, and persistence for user-specific dashboards/strategies/settings must be added as part of the expansion plan

## 2. Product Requirements (MVP Scope)

### Modular Dashboard System
- Users can create, drag, resize, remove, and arrange widgets on a dashboard grid
- Layouts persist per user (or local storage fallback when auth is absent)

### Widget Library (Core)
- Market Chart (candles/bars, overlays, timeframes)
- Order Book / DOM (L2 depth + quick actions)
- Positions & P&L (equity, margin, P&L, position list)
- News & Sentiment (news feed + NLP/sentiment summaries)
- Strategy Builder (node-based strategy assembly)
- Backtest Viewer (equity curve, drawdown, metrics)

### Algorithmic Strategy & Backtesting Engine
- Standardized strategy lifecycle hooks (e.g., initialize/on_tick/on_fill/on_exit)
- Pydantic-based parameter contracts
- High-speed backtesting (numpy/numba)
- Walk-forward and optimization support

### Risk Management Module
- Real-time portfolio risk metrics (exposure, drawdown, VaR where applicable)
- Integration with regime/risk gates
- User-configurable limits and visible alerts

### Multi-Asset Data Ingestion
- Unified normalized tick/bar format across asset classes
- Pluggable connectors and source enable/disable controls

### User Accounts & Persistence
- Secure auth and storage of:
  - dashboard layouts
  - widget settings
  - strategies
  - preferences
  - risk config

### API + WebSocket Surfaces
- REST CRUD for dashboards/widgets/strategies/settings
- WebSocket streams for market data, signals, whales, backtest progress, risk updates

### Security & Compliance
- Secrets management
- encryption in transit
- access controls and audit logging
- rate limiting
- compliance-aware design for execution-capable features

### Documentation & Onboarding
- Developer setup guide
- user onboarding guide
- API docs
- diagrams and architectural references

## 3. Architecture (Blueprint View)

### Frontend (Next.js 14)
- Dashboard Manager: grid state + widget orchestration + persistence
- Widget Components: self-contained modules with stable config and data contracts
- Strategy Builder UI: node-based editor emitting serialized strategy definitions
- Auth/Settings pages
- Global state management (Redux Toolkit or Zustand; choose one canonical path)

### Backend (FastAPI + Python)
- API layer for dashboards/widgets/strategies/backtest/risk/auth
- WebSocket layer for market/scanner/whales/backtest/risk
- Ingestion service with pluggable connectors and normalized events
- Strategy engine (research/paper/live-guarded)
- Risk service integrated with guardrails
- Persistence (Postgres + Redis cache/pubsub)

### Common Services
- Auth service
- Secret manager / env abstraction
- centralized configuration and feature flags

## 4. Data Model (High-Level)

Entities (proposed):
- `User` (identity, roles)
- `Dashboard` (user-owned layout shell)
- `Widget` (dashboard instance + widget config)
- `Strategy` (user-defined logic + params)
- `BackTest` (run settings + summary results)
- `MarketData` (normalized time-series/ticks)
- `RiskConfig` (user limits)
- `RiskStatus` (computed metrics snapshots)

Note: This is a planning model; exact schema should be refined during implementation milestones and migrations.

## 5. API / UI Surfaces (MVP Direction)

### REST Endpoints (Examples)
- `POST /api/dashboards`
- `GET /api/dashboards/{id}`
- `PUT /api/dashboards/{id}`
- `DELETE /api/dashboards/{id}`
- `POST /api/widgets`
- `PUT /api/widgets/{id}`
- `DELETE /api/widgets/{id}`
- `POST /api/strategies`
- `POST /api/backtest`
- `GET /api/risk/status`
- `POST /api/auth/login`
- `POST /api/auth/register`

### WebSocket Channels (Examples)
- `/ws/market`
- `/ws/scanner`
- `/ws/whales`
- `/ws/backtest/{backtest_id}`
- `/ws/risk`

### UI Pages / Surfaces
- Dashboard Builder
- Strategy Builder
- Backtest Results
- Risk Dashboard
- Account & Settings

## 6. Non-Functional Requirements

### Performance
- High tick throughput handling
- Smooth dashboard rendering (target 60fps interaction where possible)
- efficient backtesting performance targets and benchmarks

### Scalability
- Horizontal scale-ready API/websocket topology
- worker queues for heavy jobs (e.g., backtests/optimizations)

### Reliability
- retry policies
- circuit breakers
- degraded-mode behavior
- health checks and observability

### Security
- HTTPS
- rate limiting
- input validation
- secrets management
- auditability for sensitive actions

### Accessibility & UX
- WCAG 2.1 AA targets
- keyboard navigation
- responsive layouts
- clear contrast and labeling

## 7. Milestone Plan (Ordered by Risk/Dependency)

### M1: Dashboard Framework
- Build grid-based dashboard framework with drag/drop/resize and persisted layouts
- Done criteria:
  - add/remove/move/resize placeholder widgets
  - persistence after refresh
- Validation:
  - UI unit tests
  - manual DnD/browser verification
  - no console errors

### M2: Widget Library v1
- Core widgets: chart, positions/P&L, news
- Data subscription hooks to backend/websocket

### M3: Strategy Framework & Backtesting Engine
- Strategy base classes + backtest executor + API route

### M4: User Auth & Persistence
- JWT auth + database models/migrations for user-owned layouts/strategies

### M5: Risk Management Module
- Real-time risk metrics, settings, gate integration, alerts

### M6: Strategy Builder UI
- Node-based strategy builder -> compiled code -> backtest flow

### M7: Multi-Asset Data Ingestion
- Additional connectors + resilient ingestion/failover behavior

### M8: Widget Library v2 & Risk Dashboard
- Order book, blotter, dedicated risk views

### M9: Parameter Optimization & Strategy Analytics
- Optimization jobs + visualization

### M10: Security & Compliance Hardening
- encryption, rate limiting, audit logging, compliance checks

### M11: Documentation & Onboarding
- README, API docs, diagrams, user/dev guides

## 8. Prompt Pack (Milestone 1: Dashboard Framework)

This blueprint includes tool-ready prompt variants for Cursor, Codex, and Gemini for implementing M1.
For direct use, see:
- `assistant/prompts/M1_DASHBOARD_FRAMEWORK_PROMPT_PACK.md`

## 9. Quality Gates (Blueprint Additions)

Apply these in addition to existing project quality gates:
- milestone-level done criteria and validation commands must be captured in PR/session notes
- front-end widget milestones require UI interaction tests and manual console-error checks
- back-end strategy/backtest milestones require deterministic tests and performance benchmarks
- execution/risk milestones require explicit safety/risk-path validation
- security milestones require static scans + API security checks

## 10. Review & Rollback Strategy

### Review
- milestone PR review against PRD/architecture/style/risk/security expectations
- verify lint/tests/build and relevant smoke checks

### Regression Testing
- run full regression suite after merges
- watch staging/telemetry for anomalies

### Rollback
- tag releases
- deploy from versioned tags
- maintain reversible database migration strategy

### Evidence Collection
- capture logs, telemetry, benchmarks, and validation outputs
- document assumptions where live/production validation is not yet available

## 11. Implementation Notes for Future Agents
- Use this blueprint alongside:
  - `assistant/MASTER_SYSTEM_PROMPT.md`
  - `assistant/ROADMAP.md`
  - `assistant/TODO.md`
  - `assistant/resources/docs/QUALITY_GATES.md`
- Keep a clear separation between:
  - planned architecture
  - implemented modules
  - mocked/degraded features
  - live-data/live-execution features
