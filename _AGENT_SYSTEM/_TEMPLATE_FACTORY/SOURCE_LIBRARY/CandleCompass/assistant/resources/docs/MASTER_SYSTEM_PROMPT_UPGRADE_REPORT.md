# Master System Prompt Upgrade for Candle Compass (Report Integration)

## Purpose
This document captures the strategic upgrade direction for Candle Compass's AI operating system (master prompt + context rules), with emphasis on:
- deep trading-domain expertise
- risk-aware system design
- modular, customizable terminal UX
- scalable, secure, production-minded architecture

This is a persistent reference so future AI agents inherit the same product intent, design standards, and roadmap framing.

## Key Upgrade Thesis
The original master prompt established strong engineering discipline (no placeholders, type safety, context preservation, architectural constraints), but it did not explicitly require:
- market/trading expertise,
- regulatory awareness,
- risk-first execution behavior,
- trader-grade UX customization,
- or realistic handling of degraded/live data and execution constraints.

The upgraded prompt should operate as both:
1. an engineering standard, and
2. a trading-terminal product doctrine.

## Prompt Upgrade Requirements (Integrated into `assistant/MASTER_SYSTEM_PROMPT.md`)

### Identity & Mission
- Elevate assistant identity to a trading-systems architect with quant and UI/UX expertise.
- Keep Candle Compass mission centered on a high-performance, modular, beautiful trading terminal.

### Domain Expertise (Explicit)
- Markets/microstructure: venue behavior, liquidity, slippage, execution realism
- Algo trading/data science: strategy classes, backtesting rigor, optimization, ML/RL integration
- Portfolio/risk: position sizing, drawdown, exposure, circuit breakers, regime gating
- Product/UX for traders: pluggable modules, speed workflows, customization, resilient degraded states

### Extended Prime Directives
- Market realism (no fake execution/data claims)
- Regulatory awareness (auth, auditability, operator consent, compliance implications)
- Risk controls first (defaults + guardrails)
- Modular design (clear interfaces, swappable providers/modules)
- Testing + verification (especially for APIs, execution, analytics, and UI contracts)

## Repository Review Summary (High-Level)

### Strengths
- Modular FastAPI backend with WebSocket streaming and multiple analysis/execution engines
- Modern Next.js + Tailwind + Framer Motion frontend with glassmorphism patterns
- Existing context system (`assistant/`) with multi-agent continuity and project memory
- Strong foundations in risk gating, sentiment, seasonality, whales, and modular widget architecture

### Gaps / Opportunities
- Prompt did not explicitly encode trading expertise and regulatory/risk doctrine
- GUI still needs full module exposure + consistent interactive controls across all features
- Backtesting/optimization workflows need stronger first-class GUI integration
- Multi-asset coverage and connector abstractions need continued expansion
- Security/auth/RBAC/audit hardening should be part of the product core
- Documentation/onboarding remains weaker than the app's technical depth

## Strategic Roadmap (Report-Aligned)

### Phase A: Prompt/System Alignment
- Upgrade master prompt (done)
- Align prompt templates + rules
- Add market realism/compliance checks to execution workflows

### Phase B: GUI Modularity & Customization
- Complete drag/drop/resize persistence across all widgets
- Ensure every backend capability has a UI surface (or explicit placeholder with status)
- Consolidate theme systems and improve accessibility

### Phase C: Trading Engine & Research Tooling
- Formal strategy framework contracts
- Interactive backtesting + parameter optimization UI
- Execution abstraction for multiple brokers/exchanges + paper/live guardrails
- Unified portfolio/risk monitoring

### Phase D: Data Reliability & Scale
- Unified normalized data contracts across assets/providers
- Scalability and fan-out/load testing
- Feed health/degraded-state visibility in UI
- Cache/event-stream hardening

### Phase E: Security / Compliance / Documentation / Launch
- Auth/RBAC + audit logging for sensitive flows
- Security hardening and secrets handling improvements
- Documentation and operator onboarding refresh
- Alpha feedback cycles and polish

## Design Principles for the Terminal
- Aesthetics are functional: visual hierarchy must improve decision speed.
- Modular by default: all major tools should be pluggable/removable/swappable.
- Honest state reporting: live vs mock vs degraded must be visible to user.
- Risk is part of UX: warnings, limits, and guardrails are first-class interface elements.
- Operator speed matters: keyboard workflows, clear controls, predictable layouts.

## Implementation Guidance for Future Agents
- Use this report together with:
  - `assistant/MASTER_SYSTEM_PROMPT.md`
  - `assistant/ROADMAP.md`
  - `assistant/TODO.md`
  - `assistant/FIXME.md`
  - `assistant/context/WHERE_WE_LEFT_OFF.md`
- When proposing new features, explicitly state:
  - product value (trader impact)
  - data dependency
  - risk/compliance implications
  - validation strategy
  - UI integration plan
