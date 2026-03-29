# Addendum: Contextual Adjustments for Candle Compass Development

This addendum extends the UIA Blueprint with project-specific workflow realities:
- single-developer execution
- three-branch repository organization (`main`, `backup`, `design/tools`)
- multiple AI coding tools (Gemini, Windsurf/Windsor, Cursor, Codex, Claude)
- expanded UI requirements (menus, submenus, skins/themes, onboarding, beginner mode)

It is designed to remain compatible with the current Candle Compass architecture:
- frontend: Next.js + Tailwind + glassmorphism UI system
- backend: FastAPI + async services + WebSocket streams

Primary companion docs:
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`
- `assistant/MASTER_SYSTEM_PROMPT.md`
- `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`
- `assistant/resources/docs/QUALITY_GATES.md`

## 1. Additional Clarifications

### Single Builder / Single Operator Workflow
- No complex internal permission model is required for development operations.
- Documentation, tests, and reproducible scripts remain mandatory to support future contributors and AI handoffs.
- Changes should be milestone-scoped and evidence-backed (lint/tests/build/manual verification notes).

### Branch Organization (Three-Branch Workflow)
- `main`
  - Production/runtime development branch.
  - Source of truth for deployable application code.
- `backup`
  - Redundant backup branch mirroring `main` at controlled checkpoints.
  - Must not be directly edited except by explicit recovery/backup procedures.
- `design/tools`
  - Stores prompt packs, architectures, templates, design notes, AI workflow artifacts.
  - No runtime application code should live here.

### Multi-Tool AI Coding Workflow
Supported tool ecosystem (current):
- Gemini
- Cursor
- Codex
- Claude
- Windsurf / Windsor (naming variance acknowledged; prompts should be labeled clearly)

Prompting guidance:
- Write tool-agnostic milestone requirements first.
- Add tool-specific formatting/constraints second.
- Always reference canonical docs explicitly.
- Define exact file paths, deliverables, validations, and non-goals.

## 2. UI Enhancements & Navigation Structure (Addendum Scope)

### Comprehensive Menus & Submenus
Introduce a unified global navigation shell with top-level menus:
- Dashboard
- Strategies
- Data
- Risk
- Settings

Requirements:
- Keyboard-accessible dropdowns/submenus (Headless UI or equivalent)
- ARIA roles/labels
- Mobile-collapse behavior
- clear mapping from menus to blueprint modules/widgets/pages

### Dashboard Toolbar + Contextual Menus
Within dashboard surfaces, add a contextual toolbar with actions such as:
- Add Widget
- Save Layout
- Load Layout
- Change Theme
- Undo / Redo

Widget-level right-click/context menus should support:
- settings/configuration
- duplicate (optional future enhancement)
- remove

### Theme & Skin Management (Expanded)
- Multi-skin color schemes via CSS variables + Tailwind token bridge
- User-selectable backgrounds (built-in + uploaded images)
- Persist theme/skin/background preferences per user
- Security requirement: validate uploads / safe storage paths / no executable content

### Beginner-Friendly Mode
- Guided tour / onboarding overlays
- Tooltips for major actions
- Optional simplified mode that hides advanced features until enabled
- Persist preference per user (or local fallback)

### Responsive & Accessible Navigation
- Desktop: full menu + toolbar
- Mobile/tablet: collapsed menus/drawers with preserved functionality
- Accessibility targets remain WCAG 2.1 AA-compatible across all skins/themes

## 3. Extended Milestone Plan (M12-M16)

These milestones extend the UIA Blueprint’s M1-M11 plan.

### M12: Navigation & Menu System
Scope:
- Global navigation bar with top-level menus + nested submenus
- Dashboard toolbar for context-sensitive actions

Done criteria:
- Users can navigate to core modules from menus
- Submenus render correctly and are keyboard accessible
- Toolbar actions dispatch wired events (even if some actions are placeholders in early phase)

Validation:
- UI snapshot and interaction tests
- manual desktop/mobile validation
- ARIA/keyboard navigation check

### M13: Theme & Skin Manager
Scope:
- Theme context/provider enhancements
- multiple color schemes
- custom background support
- persisted preferences

Done criteria:
- theme/skin/background changes apply live without reload
- preferences persist
- uploads are stored/validated safely

Validation:
- theme-switch tests
- manual visual QA across skins
- security review for upload handling

### M14: Beginner Mode & Guided Tour
Scope:
- guided tour overlays
- simplified/advanced UI mode toggle
- contextual tooltips

Done criteria:
- first-time users can run a guided tour
- simplified mode hides advanced surfaces
- preference persists and does not break normal interactions

Validation:
- manual tour flow checks across primary pages
- interaction regression checks

### M15: Branch & Artifact Management
Scope:
- scripts/docs/CI conventions for `main`, `backup`, `design/tools`
- automated backup mirroring and branch safety

Done criteria:
- documented branch usage and protection rules
- backup sync process reproducible
- accidental direct edits/pushes to backup/design are guarded where practical

Validation:
- CI or scripted dry-run for branch sync
- manual branch workflow review

### M16: Multi-Tool Prompt Pack Extension
Scope:
- extend milestone prompt packs with Windsor/Windsurf and Claude variants
- standardize template structure across all tool variants

Done criteria:
- prompt packs exist for all supported tools for active milestones
- prompts reference canonical PRD/architecture/milestone docs
- formatting expectations documented per tool

Validation:
- prompt review
- dry-run generation checks across tools (where available)

## 4. Additional Prompt Pack Guidance (Multi-Tool)

For each milestone prompt pack:

### Self-Contained Tasks
- State exact files/paths to modify
- State functionality to implement
- State constraints and non-goals
- Reference canonical docs (PRD/architecture/data model/milestone)

### Branch Awareness
- Specify target branch/surface:
  - runtime code -> `main`
  - prompts/templates/architectures -> `design/tools` (or current `assistant/` path in the working branch)
- Explicitly prohibit modifying backup branch content directly

### Tool Variants
Provide sections for:
- Cursor
- Codex
- Gemini
- Windsurf/Windsor
- Claude

Include tool-specific output constraints (e.g., code-only, patch-oriented, stepwise plan, verification commands).

### Modularity & Reusability
- Prefer reusable components and shared contexts
- Avoid hard-coded themes/values
- Reference canonical theme tokens / config abstractions

## 5. Single-Developer Review & Rollback Safeguards (Addendum)

### Pre-Commit Hooks
Recommended local hooks:
- lint checks (frontend/backend)
- targeted tests for changed modules
- secret scan / grep guard for obvious keys
- branch guard (block direct commits to `backup`, optionally warn on `design/tools`)

### Automated Backups
- Continue external single-copy backup rotation for local disaster recovery
- Add CI or scripted mirror path from `main` -> `backup` after successful validation checkpoints
- Document restore drills and cadence

### Changelog & Versioning
- Maintain milestone-based changelog entries
- Tag milestone completions (e.g., `v1.0.0-m12`)
- Keep rollback notes for high-risk milestones

### Tool Usage Log
Track per milestone:
- AI tool used
- prompt pack version
- special constraints/issues encountered
- validation outcomes

This improves future prompt tuning and reduces repeated tool-specific failures.

## 6. Integration Notes

This addendum does not replace the original UIA Blueprint. It extends it with:
- workflow/branch realities
- stronger UI navigation/theming/onboarding requirements
- multi-tool prompting standards
- solo-developer operational safeguards

Implementation planning should treat:
- `M1-M11` (UIA Blueprint) as core product build milestones
- `M12-M16` (this addendum) as contextual UI/workflow acceleration milestones layered on top
