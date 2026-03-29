# Session Update — 2026-02-26 — M13 Theme Upload Guardrails

## Summary

Extended the M13 theme/skin work to support local custom background image uploads with explicit safety guardrails (file type + size) and persistence through `uiPreferences`.

## Implemented

- `app/ui-next/src/lib/uiPreferences.ts`
  - Added upload safety constants:
    - `CUSTOM_BACKGROUND_ALLOWED_MIME_TYPES`
    - `CUSTOM_BACKGROUND_MAX_BYTES`
  - Tightened `sanitizeBackgroundImageUrl()`:
    - allows only raster `data:image/*` types (PNG/JPEG/WEBP/GIF/AVIF)
    - rejects `data:image/svg+xml` for safety
  - Added `validateCustomBackgroundFile(file)` helper for UI upload validation

- `app/ui-next/src/components/settings/AppearancePanel.tsx`
  - Added local image upload button + hidden file input
  - Upload pipeline:
    - validates file type + size
    - reads file as `data:image/*` URL
    - re-sanitizes generated data URL
    - persists to UI preferences and applies immediately
  - Added user-facing safety/help text and upload error handling

- `app/ui-next/src/lib/uiPreferences.test.ts`
  - Added coverage for:
    - SVG data URL rejection
    - raster data URL acceptance
    - upload file type/size validation helper

## Validation

- ESLint (targeted) ✅
- Vitest `src/lib/uiPreferences.test.ts` ✅ (4 tests)

## Remaining M13 Follow-up

- Theme preview polish and visual regression checks
- Optional client-side dimension/downscale/compression step for large images
- Future server-side persistence integration (M4 user accounts)
