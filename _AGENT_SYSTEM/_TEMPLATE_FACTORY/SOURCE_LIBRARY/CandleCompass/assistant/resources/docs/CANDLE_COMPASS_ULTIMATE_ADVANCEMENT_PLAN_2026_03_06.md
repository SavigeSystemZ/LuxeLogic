# Candle Compass Ultimate Advancement Plan

## Purpose
Transform Candle Compass into a reliable, workstation-grade trading platform with:
- deterministic install and launch behavior
- dashboard-first but workstation-based information architecture
- complete, non-dead menus and tool surfaces
- honest data-state handling
- premium visual polish
- maintainable architecture, observability, and continuity

## Execution Order
1. Runtime, install, and degraded-mode reliability
2. App shell and workstation route architecture
3. Dashboard workspace completion
4. Menu and command completion
5. Module audit, data honesty, and broken-surface remediation
6. M24 notification platform completion
7. M25 multi-timeframe analysis completion
8. Trade, risk, portfolio, and research workstation deepening
9. Visual system and premium design pass
10. Performance, state, and frontend architecture cleanup
11. Observability, QA, and acceptance automation
12. Repo governance, continuity, and multi-agent operability

## Phase 1: Runtime, Install, Launch, and Health Contract
- Make launchers backend-aware and health-gated
- Support `full`, `degraded`, and recovery states explicitly
- Unify desktop, detached, installed, and local launch behavior
- Add runtime diagnostics and repair tooling
- Installer success requires startup verification, not just file copy success

## Phase 2: Core App Shell and Information Architecture
- Dashboard remains landing page
- Dedicated workstation routes:
  - `/`
  - `/charts`
  - `/scanner`
  - `/trade`
  - `/risk`
  - `/alerts`
  - `/research`
  - `/portfolio`
  - `/strategy-lab`
  - `/settings`
  - `/help`
  - `/emergency`
- Canonical workstation registry and module registry
- Top bar, dock, command palette, menus, and onboarding must reference the same route model

## Phase 3: Dashboard 2.0 Workspace System
- Complete drag, resize, replace, remove, duplicate, pin, and focus behaviors
- Add named workspaces, autosave, explicit saves, import/export, presets, and history
- Make modules visibly movable and resizable with clear affordances
- Keep dashboard optimized for overview and orchestration, not every heavy workflow

## Phase 4: Menus, Commands, and Dead Surface Elimination
- Audit every visible button and menu action
- Remove or replace toast-only placeholders
- Make Undo/Redo, Panel Manager, Quick Order, Bracket Builder, Alerts Console, Feedback, and Docs real
- Keep action semantics consistent across menus, shortcuts, and command palette

## Phase 5: Module Audit and Data Integrity
- Classify each module as green, yellow, or red
- Do not present mock or stale data as live data
- Standardize states:
  - live
  - delayed
  - cached
  - simulated
  - setup required
  - offline
  - error
- Normalize backend and artifact contracts with freshness and source metadata

## Phase 6: M24 Notification Platform
- Per-event routing policy
- End-user notification settings surface
- Notification history, search, filtering, read state, and clear workflows
- Actionable notifications that jump users into the correct desk
- Delivery channels:
  - in-app
  - email
  - SMS
  - push
  - webhook
- Quiet hours, severity thresholds, and deduping
- Delivery diagnostics and audit trail

## Phase 7: M25 Multi-Timeframe Analysis
- Multi-timeframe engine across 1m, 5m, 15m, 1h, 4h, 1d
- Alignment scoring, conflict scoring, and narrative summaries
- Surface M25 in Charts, Scanner, Research, and dashboard summaries
- Integrate M25 into alerts and trade context

## Phase 8: Workstation Deepening
- Trade: better execution rail, bracket builder, confirmations, paper/live clarity
- Risk: guardian, exposure, drawdown, kill-switch, runtime controls, alert state
- Portfolio: realized/unrealized P&L, allocation, fills, journal, account snapshots
- Research: whales, news, sentiment, correlation, macro, filings, provenance

## Phase 9: Visual and Interaction Upgrade
- Institutional-pro visual direction
- Stronger spacing, hierarchy, density, and panel depth
- Better loading, empty, error, and degraded states
- Controlled motion and higher perceived performance
- More impressive chart and status presentation without visual noise

## Phase 10: Performance and Architecture Cleanup
- Centralize resilient frontend data access
- Reduce redundant polling and repeated fetches
- Add route-level data ownership and lazy loading
- Improve client state separation:
  - shell state
  - workspace state
  - route state
  - runtime state
  - data query state

## Phase 11: Observability and QA
- Structured diagnostics for startup, backend failures, module failures, and routing issues
- Acceptance packs for install, degraded mode, workspace flows, notifications, and M25
- Visual regression references and screenshot baselines
- Health and module audit reporting

## Phase 12: Governance and Continuity
- Keep CURRENT_STATUS, WHERE_WE_LEFT_OFF, CHANGELOG, and TODO authoritative
- Maintain workstation map, module registry map, and decision ledger
- Record deferred or removed surfaces explicitly
- Make resumption easy for Codex, Claude, Cursor, and human maintainers

## Immediate Active Focus
- Complete M24 end-to-end
- Complete M25 on top of the routed workstation foundation
- Continue eliminating dead controls and misleading data states
- Keep runtime, installer, and installed-host behavior trustworthy
