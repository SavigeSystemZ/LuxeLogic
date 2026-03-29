# Session Update (2026-02-26) — UI/Installer Stabilization

## What Was Done
- Reviewed assistant system files (`HANDSHAKE`, `MASTER_SYSTEM_PROMPT`, `TODO`, `CURRENT_STATUS`, `WHERE_WE_LEFT_OFF`, `universal_manifest`) and confirmed context drift:
  - roadmap/TODO claims many phases completed
  - `universal_manifest.json` still reported phase 36 recovery
- Reviewed UI foundation files and dashboard shell:
  - `app/ui-next/src/app/layout.tsx`
  - `app/ui-next/src/app/globals.css`
  - `app/ui-next/src/components/ThemeContext.tsx`
  - `app/ui-next/src/components/dashboard/CommandCenter.tsx`
- Reviewed installer scripts and identified poor observability during long steps:
  - `app/scripts/install_candle_compass.sh`

## Issues Identified
- UI can degrade to plain/default browser styling after reload if compatibility CSS vars are not seeded (many widgets rely on legacy tokens not guaranteed by dynamic theme JSON).
- Duplicate shell/navigation composition:
  - root layout rendered `Sidebar`
  - dashboard view rendered `SidebarDock`
  - caused stacked/competing navigation shell layers on `/`
- Installer option `1` (fresh install) looked "hung" because pip/npm/build steps were quiet and long-running.

## Fixes Applied
- `app/ui-next/src/app/globals.css`
  - Added comprehensive fallback tokens for legacy + dynamic theme compatibility:
    - accent, surface, text-muted, glass-border, glass-blur, font sizes, modal limits, sell glow, etc.
  - Improved `body` background fallback so UI remains themed even before full theme hydration.
  - Hardened `.glass-panel` with tokenized blur/radius/border + `isolation`.
  - Added `.shell` / `.panel` fallback classes to keep error/recovery views styled.
- `app/ui-next/src/components/ThemeContext.tsx`
  - Added compatibility token seeding and dynamic-theme-to-legacy token mapping.
  - Seeds legacy theme variables before applying `themes.json` dynamic theme values.
  - Fills missing tokens used by older widgets/components.
- `app/ui-next/src/app/layout.tsx`
  - Removed root `Sidebar` injection to avoid duplicate shell nav (dashboard keeps `SidebarDock`).
- `app/ui-next/src/app/api/data/[...artifact]/route.ts`
  - Added safe Node runtime route to serve `app/runs/latest/*.json` artifacts for widget polling (`useWidgetData`, `SidebarDock` alert status)
  - Extended route with:
    - alias support (`whale_stream.json` -> `whale_events.json`)
    - artifact freshness headers (`x-artifact-*`)
    - `/api/data/_index` for artifact listing/debugging
- `.gitignore`
  - Added exceptions for `app/ui-next/src/app/api/data/**` so the new route is not ignored by the broad `data/` rule
- `app/ui-next/src/hooks/useWidgetData.ts`
  - Added structured error payloads, artifact freshness metadata, and stale detection
- Widget schema normalization (real artifact compatibility)
  - `WhaleWatchWidget.tsx` now supports `whale_events.json` (`events[]`, `amount_usd`)
  - `SocialHypeWidget.tsx` now derives display values from `social_hype.json` (`scores[]`)
  - `RiskGuardianWidget.tsx` now derives display values from nested `risk_dashboard.json`
  - `NewsroomPanel.tsx` now accepts `research_feed.json.items[]` and supplements with `social_hype.json` + `narrative_engine.json`
  - `ArbitrageTable.tsx` / `MemeStreamWidget.tsx` now display data-source freshness/error status
  - `SidebarDock.tsx` sentinel count now supports `alerts[]` payloads
- `app/scripts/install_candle_compass.sh`
  - Added timestamped step logging helpers.
  - Made apt/pip/npm phases visible (removed quiet modes for key long steps).
  - Uses `npm ci --no-audit --no-fund` when lockfile exists.
  - Added explicit messaging for long frontend build phase.
  - Stops user-level UI/backend services during uninstall in addition to system-level unit attempts.
- `app/scripts/hydrate_all.sh`
  - Rewritten for reliability:
    - auto-detects app/repo virtualenv Python
    - per-step reporting + failure accumulation
    - per-step timeouts (`HYDRATE_STEP_TIMEOUT_SECONDS`)
    - fast mode (`HYDRATE_SKIP_FETCH=1`)
    - non-zero exit on failed steps / missing key artifacts
- UI interaction hardening
  - removed blocking dialogs from touched widgets:
    - `RiskGuardianWidget` (`window.confirm` removed)
    - `MemeStreamWidget` (`alert()` replaced with toast notifications)

## Context Updates Applied
- `assistant/TODO.md` — added completed stabilization items + new "Reality Check / Integration Verification" section.
- `assistant/context/WHERE_WE_LEFT_OFF.md` — added 2026-02-26 stabilization entry and next steps.
- `assistant/context/universal_manifest.json` — updated status/active focus.
- `assistant/FIXME.md` — added current integration regression items.

## Next Verification Steps (Important)
1. Run UI again and confirm styling persists after:
   - app load
   - hard refresh
   - dev server restart
2. Run hydration script and verify widgets populate:
   - `./app/scripts/hydrate_all.sh`
3. Audit widget data routes:
   - `useWidgetData.ts` `/api/data/*.json` calls vs actual artifact filenames in `app/runs/latest/`
4. Run validation:
   - `cd app/ui-next && npm run lint`
   - `cd app/ui-next && npm run build`
   - `.venv/bin/python -m pytest -q`
   - `.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict`
