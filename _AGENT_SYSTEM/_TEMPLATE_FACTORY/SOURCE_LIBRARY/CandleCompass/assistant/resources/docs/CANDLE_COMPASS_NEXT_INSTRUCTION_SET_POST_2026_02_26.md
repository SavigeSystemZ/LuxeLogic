# Candle Compass — Next Instruction Set (Post‑2026‑02‑26)

This document captures the post‑2026‑02‑26 expansion instructions for Candle Compass after the installer automation, UI stabilization, theme fixes, and continuity improvements landed.

It assumes the current foundation is verified using the **Reality Check / Integration Verification** items in `assistant/TODO.md` before major new feature work begins.

Executable prompt pack for this track:
- `assistant/prompts/M17_M23_EXPANSION_PROMPT_PACK.md`

## Execution Principles

- Verify before expanding (lint/build/tests/hydration/UI smoke).
- Keep one canonical prompt-pack set in `assistant/prompts/`.
- Maintain `main / backup / design-tools` discipline and update context files after each milestone.
- Treat all market outputs as **research/education only** unless/until explicit live execution safeguards are enabled.

## Milestone Track (M17–M23)

### M17 — Installer & Platform Hardening
- Cross-platform package manager detection (`apt`, `dnf`, `yum`, `pacman`)
- Preflight / dry-run prerequisite checks
- Better service detection/reuse prompts (Postgres/Redis/Node)
- Improved logging section headers and success guidance
- Desktop/service registration reliability checks
- Cross-distro test notes captured in `assistant/FIXME.md`

### M18 — Theme & Appearance Consolidation
- Consolidate dual theme sources into a single canonical theme registry
- Build a richer Theme Studio (base theme + user customization)
- Background/skin library (bundled assets + URL/upload support)
- Accessibility contrast validation for user-selected colors

### M19 — Signal & Indicator Expansion
- Add additional signal engines (MACD, Stochastic, Ichimoku, VWAP, ATR, OBV, etc.)
- Unified signals API and cached signal computation
- Signal summary/analytics widgets + historical outcome surfaces

### M20 — Arbitrage & Spread Engine Expansion
- Gap Hunter 2.0 (more exchanges, stablecoins, depth/slippage/staleness guards)
- Scheduling + notifications for arbitrage opportunities
- Research-only execution simulator and spread heatmap widget

### M21 — Lab, Simulation & Education Modules
- Strategy Lab conditional logic and reusable templates
- Time Machine UI upgrades (vectorized backtest + replay controls)
- Beginner mode, guided tours, glossary/tooltips, training surfaces

### M22 — Alerts, AI Assistance & Research Strategy Library
- Unified alert hub (price, indicators, arbitrage, whales, sentiment)
- Cortex expansion for natural-language queries and safe tool actions
- Macro narrative digest (news + hype + whales + technicals)
- Curated research-grade strategy library with limitations/risk notes

### M23 — Governance & Compliance Scaffolding
- RBAC scaffolding and endpoint role enforcement design
- Secure API key storage patterns and encryption guidance
- Structured audit logging / telemetry / retention policies
- Research-only banners, confirmations, and future execution kill-switch scaffolding

## Continuous Verification (Required after each milestone)

- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run build`
- `.venv/bin/python -m pytest -q`
- `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict`
- `./app/scripts/hydrate_all.sh` (or `HYDRATE_SKIP_FETCH=1`)

## Current Mapping to Existing Work (as of 2026-02-26)

- `M12` partial done with keyboard/mobile menu coverage
- `M13` partial done with background presets, custom URL backgrounds, and safe local uploads
- `M15` partial done with local branch guard hooks + tool usage log template
- `M17` partial now in progress via installer preflight/dry-run and package manager detection hardening
