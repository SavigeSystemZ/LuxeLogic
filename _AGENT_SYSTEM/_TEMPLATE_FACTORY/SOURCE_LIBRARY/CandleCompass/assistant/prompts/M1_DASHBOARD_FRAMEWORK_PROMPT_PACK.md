# Milestone 1 Prompt Pack: Dashboard Framework

Canonical references before use:
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`
- `assistant/MASTER_SYSTEM_PROMPT.md`
- `assistant/ROADMAP.md`
- `assistant/resources/docs/QUALITY_GATES.md`

Use this pack to implement UIA Blueprint **M1: Dashboard Framework** in the current Candle Compass frontend.

## Milestone Goal (M1)

Implement a grid-based dashboard framework that supports:
- add / remove placeholder widgets
- drag and resize
- persisted layout state (local storage fallback; user-specific key when available)

Done criteria:
- widgets can be added, moved, resized, and deleted
- layout persists after refresh
- no console errors during manual verification

Validation:
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run test` (if tests are added/updated)
- manual DnD/resize verification in browser

## Cursor Prompt (M1)

### Context

You are working on the Candle Compass project. Refer to the **UIA Blueprint** (`assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`), the **master system prompt**, and the **roadmap**. Implement **Milestone 1 (Dashboard Framework)**.

### Task

1. Create `DashboardManager.tsx` in `app/ui-next/src/components/dashboard` that:
   - uses `react-grid-layout` (or equivalent already used in the repo) for a responsive grid,
   - manages widget layout state (position, size, type, id),
   - exposes a React context + hooks for add/remove/update widgets,
   - persists layout to `localStorage` using a user-specific key (fallback to anonymous key).
2. Create `WidgetWrapper.tsx` that wraps each widget with drag/resize chrome and a remove action.
3. Create `WidgetPlaceholder.tsx` for placeholder widgets used in M1 (actual widget implementations come in M2).
4. Wire the dashboard into the primary dashboard page/entry so M1 is visible and testable.
5. Keep styling aligned with Candle Compass glassmorphism and z-index rules.

### Constraints

- TypeScript only; functional React components and hooks.
- Follow project directives: type safety, no placeholder comments in final code, keep data/layout contracts explicit.
- Do not implement real widget business logic yet (M2+).

### Deliverables

- `app/ui-next/src/components/dashboard/DashboardManager.tsx`
- `app/ui-next/src/components/dashboard/WidgetWrapper.tsx`
- `app/ui-next/src/components/dashboard/WidgetPlaceholder.tsx`
- any required route/page integration changes
- tests if practical for layout state/persistence

### Verification

- Run lint/tests/build for touched frontend files
- Manual browser validation: add/move/resize/remove widgets, refresh page, confirm persistence

## Codex Prompt (M1)

You are ChatGPT-Codex working inside the Candle Compass repository. Follow the UIA Blueprint (`assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`) and master prompt standards. Implement **M1: Dashboard Framework**.

Requirements:
- Create `DashboardManager.tsx`, `WidgetWrapper.tsx`, and `WidgetPlaceholder.tsx` in `app/ui-next/src/components/dashboard`.
- Use `react-grid-layout` for a responsive drag/resize grid (breakpoints for desktop/tablet/mobile).
- Provide a typed React context so child widgets/components can add, remove, move, and resize widgets.
- Persist layout in `localStorage` using a user-specific key (accept user id via props/context; fallback anonymous).
- Style with existing Tailwind/Candle Compass glass-panel utilities and respect z-index layering conventions.
- Integrate the dashboard manager into the app route/page so the framework is visible.
- Add light tests for local storage persistence / layout state if project test setup already supports it.

Return code only for new/modified files. Ensure imports compile. No markdown wrappers.

## Gemini Prompt (M1)

Context:
You are Gemini integrated with the Candle Compass codebase. Use the UIA Blueprint and current architecture docs to implement **Milestone 1 (Dashboard Framework)**.

Task:
- Build a dashboard manager using a drag-and-drop grid library (`react-grid-layout` preferred).
- Manage widget state (id, type, position, size, settings stub) and persist it to local storage.
- Expose a typed context/provider and hooks for widget management.
- Implement `WidgetWrapper` and `WidgetPlaceholder`.
- Render the dashboard in the main UI so M1 can be manually tested.

Constraints:
- React + TypeScript functional components only.
- Maintain Candle Compass glassmorphism styling and z-index conventions.
- Only implement placeholders for widget content in M1.

Expected output:
- Compilable code for the three dashboard components plus any route integration.
- Brief verification commands and manual test checklist.

## Windsor / Windsurf Prompt (M1)

Context:
You are implementing Candle Compass UIA Blueprint **M1: Dashboard Framework**. Use the canonical docs and keep the change scoped to production runtime code in the current working branch (runtime path: `app/ui-next`).

Task:
- Build a typed `DashboardManager` using a responsive drag/resize grid (`react-grid-layout` preferred).
- Add `WidgetWrapper` and `WidgetPlaceholder`.
- Persist layout state to local storage with a user-aware key (anonymous fallback).
- Integrate with the existing dashboard route without breaking the current widget registry architecture.

Constraints:
- TypeScript + React hooks only
- Glassmorphism styling and z-index consistency
- Placeholder widgets only (no real widget logic)
- Return exact file changes and verification steps

Deliverables:
- `app/ui-next/src/components/dashboard/DashboardManager.tsx`
- `app/ui-next/src/components/dashboard/WidgetWrapper.tsx`
- `app/ui-next/src/components/dashboard/WidgetPlaceholder.tsx`
- route/page integration changes

Verification:
- `cd app/ui-next && npm run lint`
- `cd app/ui-next && npm run build` (if feasible)
- manual drag/resize/remove/refresh persistence check

## Claude Prompt (M1)

You are working in the Candle Compass repo. Follow:
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`
- `assistant/MASTER_SYSTEM_PROMPT.md`
- `assistant/resources/docs/QUALITY_GATES.md`

Implement **M1: Dashboard Framework** with minimal disruption to existing modules.

Requirements:
1. Add a typed dashboard layout manager (`DashboardManager.tsx`) with context/hooks for widget state.
2. Use a drag/resize grid library (`react-grid-layout` preferred) and responsive breakpoints.
3. Add `WidgetWrapper.tsx` (controls/chrome/remove action) and `WidgetPlaceholder.tsx`.
4. Persist layouts to local storage using a versioned key scheme (`candle-compass:layout:v1:<user|anon>`).
5. Wire the dashboard manager into the main dashboard page for manual testing.

Important:
- Do not implement actual widget business logic yet.
- Preserve existing styling conventions (glass panels, dark terminal theme).
- Include any dependency additions and exact validation commands.

## M1 Implementation Notes (Project-Specific)

- Prefer compatibility with the existing `CommandCenter` / `DashboardWidget` ecosystem; do not break existing widget registry wiring if coexisting during migration.
- If `react-grid-layout` is not installed, add dependency changes and note them in validation.
- Ensure SSR safety when reading `localStorage` (client-only guards).
- Use deterministic widget ids and stable serialization format for future user-account persistence (M4).
