---
name: ui-console
description: Build, redesign, or debug Candle Compass user interfaces and dashboard bindings. Use when changing `app/ui-next` or legacy `app/ui` layouts, visual systems, component behavior, or data wiring from `runs/latest` artifacts.
---

# UI Console

## Workflow
1. Identify target surface (`app/ui-next` primary, `app/ui` fallback).
2. Map UI components to required artifact fields in `runs/latest/`.
3. Implement layout/style/interaction changes with responsive behavior.
4. Update API routes or transformation layers when payload shape changes.
5. Keep visual hierarchy intentional; avoid generic defaults.
6. Run bundle refresh and UI checks.

## Validation
- `python scripts/run_ui_bundle.py`
- `python scripts/ui_health_check.py --runs runs/latest`
- `python scripts/ui_smoke_test.py --runs runs/latest`
- `cd app/ui-next && npm run lint && npm run build`

## Output Checklist
- New UI modules have stable IDs and data bindings.
- Mobile and desktop rendering remain usable.
- Schema changes are reflected in UI contract docs.

## References
- `references/ui-data.md`
- `references/layout-map.md`
