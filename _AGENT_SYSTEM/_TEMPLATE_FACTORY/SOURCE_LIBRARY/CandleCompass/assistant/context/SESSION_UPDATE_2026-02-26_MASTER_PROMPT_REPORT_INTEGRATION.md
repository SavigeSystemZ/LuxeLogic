# Session Update — 2026-02-26 (Master Prompt Report Integration)

## Trigger
User supplied a comprehensive report proposing:
- a stronger Candle Compass master system prompt with deep trading expertise,
- repository analysis (strengths/gaps),
- and a phased roadmap for a world-class customizable trading terminal.

## Implemented
- Rewrote `assistant/MASTER_SYSTEM_PROMPT.md` to explicitly encode:
  - market/trading expertise (microstructure, venues, execution realism)
  - algo trading + backtesting/optimization rigor
  - portfolio/risk doctrine
  - trader-grade product/UX principles
  - market realism / regulatory awareness / risk-first directives
  - installer/ops/distribution expectations
- Expanded `assistant/ROADMAP.md` with report-aligned strategic phases (A–E) while preserving existing Singularity roadmap context.
- Added persistent reference doc:
  - `assistant/resources/docs/MASTER_SYSTEM_PROMPT_UPGRADE_REPORT.md`
- Updated:
  - `assistant/FULL_CONTEXT_INDEX.md`
  - `assistant/TODO.md`
  - `assistant/context/WHERE_WE_LEFT_OFF.md`
  - `assistant/context/universal_manifest.json`

## Why This Matters
This upgrades the AI coding system from "strong engineer persona" to "trading systems + product doctrine" so future agent output is more aligned with:
- realistic market behavior,
- risk-aware feature design,
- modular terminal UX,
- and secure/distribution-minded implementation decisions.

## Follow-On Work
1. Sync prompt templates / project rules with the new master prompt wording.
2. Build a backend-capability -> UI-widget module matrix and identify missing interactive controls/data contracts.
3. Continue manual installer validation (Postgres policy branches + icon visual confirmation) from prior installer upgrade work.
