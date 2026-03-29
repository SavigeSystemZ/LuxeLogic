# Post-2026-02-26 Expansion Prompt Pack (M17-M23)

Canonical references before use:
- `assistant/resources/docs/CANDLE_COMPASS_NEXT_INSTRUCTION_SET_POST_2026_02_26.md`
- `assistant/MASTER_SYSTEM_PROMPT.md`
- `assistant/ROADMAP.md`
- `assistant/TODO.md`
- `assistant/resources/docs/QUALITY_GATES.md`
- `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`

Purpose:
- Provide executable multi-tool prompt variants for the current post-addendum milestone track:
  - `M17` Installer & Platform Hardening
  - `M18` Theme & Appearance Consolidation
  - `M19` Signals & Indicators Expansion
  - `M20` Arbitrage & Spread Engine Expansion
  - `M21` Lab, Simulation & Education Modules
  - `M22` Alerts, AI Assistance & Research Strategy Library
  - `M23` Governance & Compliance Scaffolding

## Standard Usage

1. Choose the milestone block below.
2. Copy the tool-specific variant for the coding tool you are using.
3. Keep the canonical references in scope while executing.
4. Update continuity docs after the milestone batch lands.

## Branch / Surface Language (Reusable)

Use this in all prompt variants:

"Target surface:
- Runtime product code belongs on `main` under `app/`.
- Prompt packs, docs, and design-only artifacts belong under `assistant/` and publish to `design/tools` via the documented sync workflow.
- Do not edit backup branches directly; use `app/scripts/git_sync_backup_branch.sh` after validation checkpoints."

## M17 — Installer & Platform Hardening

### Shared Milestone Brief

Scope:
- cross-distro package manager support and service/runtime polish
- preflight / dry-run support and dependency reuse/status messaging
- installer validation notes for supported hosts

Done criteria:
- installer behavior is explicit and reproducible
- dependency/service detection is clear
- validation notes are captured when host-specific behavior is verified

Validation:
- `bash app/scripts/installer_smoke.sh`
- `bash -n app/scripts/install_candle_compass.sh`
- additional manual or host-specific checks as applicable

### Cursor Prompt (M17)

Implement `M17 Installer & Platform Hardening` in the Candle Compass repo using the shared milestone brief above. Focus on `app/scripts/install_candle_compass.sh`, adjacent installer scripts, and the continuity/docs surfaces that record host validation. Keep the change scoped, reuse-aware, and safe for systems that also host other apps. Deliver exact file changes, validation run, and any host assumptions that still remain unverified.

### Codex Prompt (M17)

Implement `M17` in the Candle Compass repository. Use the shared milestone brief above plus the canonical docs. Prioritize explicit installer behavior, compileable/shell-safe script changes, and reproducible validation. Touch only installer/runtime ops files and the minimum continuity docs needed. Return concrete file changes and exact validation commands.

### Gemini Prompt (M17)

Use the shared `M17` brief above to implement the next installer/platform hardening slice in Candle Compass. Work in phased form: inspect current installer behavior, make the smallest reliable hardening change, then update docs with what is still host-specific and unverified. Include validation commands and assumptions.

### Windsurf / Windsor Prompt (M17)

Implement `M17 Installer & Platform Hardening` using the shared brief above. Scope the work to installer/runtime scripts and related docs only. Do not touch unrelated product surfaces. Preserve dependency reuse behavior and produce a short touched-files list plus validation evidence.

### Claude Prompt (M17)

Implement the next `M17` slice for Candle Compass using the shared brief above and the canonical docs. Emphasize installer safety, cross-distro clarity, host-state reuse, rollback awareness, and explicit notes for any Fedora/Arch behavior that cannot be validated in-session. Include exact validation commands and continuity updates.

## M18 — Theme & Appearance Consolidation

### Shared Milestone Brief

Scope:
- canonical theme registry and Theme Studio improvements
- bundled/user skin library behavior
- accessibility contrast validation and appearance consistency

Done criteria:
- one canonical theme source drives the app
- theme customization remains coherent and accessible
- appearance settings persist without drift

Validation:
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run test`
- `cd app/ui-next && npm run build`

### Cursor Prompt (M18)

Implement `M18 Theme & Appearance Consolidation` in Candle Compass using the shared milestone brief above. Work inside `app/ui-next` and any required supporting docs. Keep theme state typed, centralized, SSR-safe, and WCAG-aware. Provide exact file changes and validation results.

### Codex Prompt (M18)

Implement `M18` in the Candle Compass repository. Use the shared brief above. Prioritize a single theme source, type safety, SSR safety, and contrast-aware UI behavior. Limit changes to the theme/appearance surfaces and return exact validation commands.

### Gemini Prompt (M18)

Use the shared `M18` brief above to implement the next theme/appearance consolidation slice in Candle Compass. Call out any migration assumptions and ensure persistence and accessibility remain stable. Include verification steps.

### Windsurf / Windsor Prompt (M18)

Implement `M18 Theme & Appearance Consolidation` using the shared brief above. Scope changes to `app/ui-next` theme/appearance files and related docs only. Preserve compileability and document the touched files and checks run.

### Claude Prompt (M18)

Implement `M18` with emphasis on canonical theme ownership, WCAG contrast, SSR-safe appearance state, and minimal regressions. Use the shared brief above and return implementation details, validation commands, and any residual risks.

## M19 — Signals & Indicators Expansion

### Shared Milestone Brief

Scope:
- additional signal engines and indicator coverage
- unified signal APIs and cached computation
- signal summary and historical outcome surfaces

Done criteria:
- new indicator/signal logic is integrated behind clear contracts
- frontend surfaces consume the unified output shape
- outcome or analytics coverage is updated where required

Validation:
- `.venv/bin/python -m pytest -q`
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run test`
- `cd app/ui-next && npm run build`

### Cursor Prompt (M19)

Implement `M19 Signals & Indicators Expansion` in Candle Compass using the shared milestone brief above. Work across backend signal computation, API contracts, and any UI consumers that need to render the expanded outputs. Keep contracts typed and add deterministic tests.

### Codex Prompt (M19)

Implement `M19` in the Candle Compass repository. Use the shared brief above. Prioritize explicit backend contracts, deterministic tests, typed frontend consumption, and minimal drift between API and widget surfaces. Return exact file changes and validation commands.

### Gemini Prompt (M19)

Use the shared `M19` brief above to implement the next signal/indicator expansion slice in Candle Compass. Keep the work contract-first, note any schema changes clearly, and include backend/frontend verification steps.

### Windsurf / Windsor Prompt (M19)

Implement `M19 Signals & Indicators Expansion` using the shared brief above. Scope work to signal engines, API wiring, and direct consumers only. Add targeted tests and provide touched files plus validation output.

### Claude Prompt (M19)

Implement `M19` with emphasis on contract clarity, analytics correctness, and UI/API consistency. Use the shared brief above, add deterministic validation, and document any remaining follow-up needed for other signal consumers.

## M20 — Arbitrage & Spread Engine Expansion

### Shared Milestone Brief

Scope:
- Gap Hunter 2.0 and exchange/depth/slippage/staleness guards
- scheduling or notification improvements for arbitrage opportunities
- research-only simulator and spread visualization surfaces

Done criteria:
- arbitrage computations are more realistic and bounded by safety guards
- UI/API surfaces reflect the expanded model cleanly
- execution remains research-only unless explicitly guarded elsewhere

Validation:
- `.venv/bin/python -m pytest -q`
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run test`
- `cd app/ui-next && npm run build`

### Cursor Prompt (M20)

Implement `M20 Arbitrage & Spread Engine Expansion` in Candle Compass using the shared milestone brief above. Keep the work research-only, add realistic depth/slippage/staleness handling, and wire the necessary API/UI surfaces with tests.

### Codex Prompt (M20)

Implement `M20` in the Candle Compass repository. Use the shared brief above. Prioritize realistic arbitrage guards, typed data contracts, and research-only UX. Return exact file changes and validation commands.

### Gemini Prompt (M20)

Use the shared `M20` brief above to implement the next arbitrage/spread slice in Candle Compass. Keep assumptions explicit, preserve research-only framing, and include backend/frontend validation.

### Windsurf / Windsor Prompt (M20)

Implement `M20 Arbitrage & Spread Engine Expansion` using the shared brief above. Scope the work to arbitrage engine, scheduling/notifications, and immediate UI consumers. Do not broaden into unrelated execution features.

### Claude Prompt (M20)

Implement `M20` with emphasis on realism, safety guards, and research-only messaging. Use the shared brief above and return implementation details, validation commands, and any follow-on contract work needed.

## M21 — Lab, Simulation & Education Modules

### Shared Milestone Brief

Scope:
- Strategy Lab upgrades and reusable templates
- Time Machine UI/simulation upgrades
- beginner training surfaces, glossary/tooltips, or guided educational helpers

Done criteria:
- lab/simulation flows are more usable and better structured
- educational helpers do not disrupt advanced workflows
- persistence and interaction flows remain stable

Validation:
- `.venv/bin/python -m pytest -q`
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run test`
- `cd app/ui-next && npm run build`
- manual flow check where UI interaction is central

### Cursor Prompt (M21)

Implement `M21 Lab, Simulation & Education Modules` in Candle Compass using the shared milestone brief above. Focus on usable lab/simulation workflows, typed state/contracts, and non-disruptive educational helpers. Add tests where logic changes and include manual validation notes.

### Codex Prompt (M21)

Implement `M21` in the Candle Compass repository. Use the shared brief above. Prioritize typed lab/simulation contracts, clean UI flow, persistence stability, and minimal regression risk. Return exact file changes and validation commands.

### Gemini Prompt (M21)

Use the shared `M21` brief above to implement the next lab/simulation/education slice in Candle Compass. Call out assumptions, note manual flow checks, and keep the educational layer non-disruptive.

### Windsurf / Windsor Prompt (M21)

Implement `M21 Lab, Simulation & Education Modules` using the shared brief above. Scope the change to Strategy Lab, Time Machine, and immediate educational helpers. Provide touched files and validation evidence.

### Claude Prompt (M21)

Implement `M21` with emphasis on usable workflows, stable persistence, and educational helpers that do not degrade the advanced operator experience. Use the shared brief above and include validation plus any rollback notes.

## M22 — Alerts, AI Assistance & Research Strategy Library

### Shared Milestone Brief

Scope:
- unified alert hub and alert categories
- Cortex or AI-assistance expansion with safe tool actions
- research strategy library and macro digest surfaces

Done criteria:
- alerts and AI-assistance surfaces are coherent and typed
- strategy library content is clearly research-grade and limitation-aware
- safe-action boundaries remain explicit

Validation:
- `.venv/bin/python -m pytest -q`
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run test`
- `cd app/ui-next && npm run build`

### Cursor Prompt (M22)

Implement `M22 Alerts, AI Assistance & Research Strategy Library` in Candle Compass using the shared milestone brief above. Focus on safe typed tool actions, coherent alert surfaces, and research-grade library UX with limitations/risk notes.

### Codex Prompt (M22)

Implement `M22` in the Candle Compass repository. Use the shared brief above. Prioritize alert contract clarity, safe AI-action boundaries, and explicit research-only UX. Return exact file changes and validation commands.

### Gemini Prompt (M22)

Use the shared `M22` brief above to implement the next alerts/AI/research-library slice in Candle Compass. Make safe-action assumptions explicit and include backend/frontend validation.

### Windsurf / Windsor Prompt (M22)

Implement `M22 Alerts, AI Assistance & Research Strategy Library` using the shared brief above. Keep the change scoped to alerting, Cortex-adjacent flows, and direct library surfaces. Do not widen into unrelated execution control work.

### Claude Prompt (M22)

Implement `M22` with emphasis on safe AI tooling, well-scoped alerts, and clear research-only guidance in the strategy library. Use the shared brief above and return implementation details plus validation evidence.

## M23 — Governance & Compliance Scaffolding

### Shared Milestone Brief

Scope:
- RBAC scaffolding and endpoint role design
- secure API key storage patterns and audit logging
- research-only banners, confirmations, and future kill-switch scaffolding

Done criteria:
- sensitive surfaces have clearer role/auth scaffolding
- auditability and secure-key guidance are improved
- research-only limitations remain explicit in UX and docs

Validation:
- `.venv/bin/python -m pytest -q`
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run test`
- `cd app/ui-next && npm run build`
- security/compliance notes updated when contracts shift

### Cursor Prompt (M23)

Implement `M23 Governance & Compliance Scaffolding` in Candle Compass using the shared milestone brief above. Focus on RBAC scaffolding, auditability, and research-only safety surfaces without overclaiming production compliance that does not yet exist.

### Codex Prompt (M23)

Implement `M23` in the Candle Compass repository. Use the shared brief above. Prioritize explicit role boundaries, secure storage guidance, typed sensitive-route contracts, and reversible scaffolding. Return exact file changes and validation commands.

### Gemini Prompt (M23)

Use the shared `M23` brief above to implement the next governance/compliance scaffolding slice in Candle Compass. Keep the work concrete, clearly limited to scaffolding, and include verification plus documented follow-up gaps.

### Windsurf / Windsor Prompt (M23)

Implement `M23 Governance & Compliance Scaffolding` using the shared brief above. Scope changes to auth/role/audit/research-only safety surfaces and the required docs. Avoid speculative enterprise compliance claims.

### Claude Prompt (M23)

Implement `M23` with emphasis on explicit scaffolding, safe defaults, auditability, and clear research-only boundaries. Use the shared brief above and include validation, residual risks, and rollback notes.
