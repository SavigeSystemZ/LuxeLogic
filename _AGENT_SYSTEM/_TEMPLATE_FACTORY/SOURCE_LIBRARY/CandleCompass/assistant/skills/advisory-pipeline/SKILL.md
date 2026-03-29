---
name: advisory-pipeline
description: Build, extend, or debug the Candle Compass advisory pipeline across technical, fundamental, sentiment, scanner, context, and confluence engines. Use when changing advisory scoring logic, output schemas, dashboard payload fields, or advisory-related UI bindings/tests.
---

# Advisory Pipeline

## Workflow
1. Identify the advisory layer and target artifact fields.
2. Update engine logic under `app/src/advisory/`.
3. Keep model contracts aligned in `app/src/advisory/core_models.py`.
4. Update emitters (`app/scripts/run_advisory.py`, `app/scripts/run_ui_bundle.py`) for new/changed fields.
5. Update UI/API consumers that read advisory payloads.
6. Add or update tests in `tests/`.
7. Regenerate artifacts and validate UI health checks.

## Validation
- `python scripts/run_advisory.py`
- `python scripts/run_ui_bundle.py`
- `python scripts/ui_health_check.py`
- `python -m pytest -q tests/test_advisory_engines.py`

## Output Checklist
- Advisory schema is internally consistent.
- Producers and consumers agree on field names/types.
- Tests cover added decision logic.

## References
- `references/paths.md`
- `references/json_schema.md`
