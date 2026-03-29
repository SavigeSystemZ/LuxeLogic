# Design Notes

Use this file to capture durable design direction for the installed repo.

## Product feel

- tone: Explicit 4xx and 5xx behavior — every error has a typed response model, not raw exceptions. | Typed request and response models (Pydantic) for every route. No raw dicts in or out.
- density: focused on the first milestone, with enough context for the primary workflow and no clutter
- interaction style: Explicit 4xx and 5xx behavior — every error has a typed response model, not raw exceptions. | Typed request and response models (Pydantic) for every route. No raw dicts in or out. | In AIAST scaffolded repos, use a `src/` layout or explicit package settings in | Proper HTTP status codes: 201 for creates, 204 for deletes, 422 for validation errors.
- visual character: deliberate, product-specific, and shaped around the selected blueprint's primary workflow

## Experience goals

- first-impression goal: Ship `/health` endpoint returning `{"status": "ok"}` and one real resource route with CRUD.; Confirm `PYTHONPATH=. pytest -q` passes with route tests covering happy path and error cases.; Confirm `python3 -m compileall app` passes with zero errors.; Confirm dev server starts and responds to `curl http://127.0.0.1:8000/health`.; Record API contract assumptions, versioning strategy, and data model decisions in `ARCHITECTURE_NOTES.md`.
- trust signal: Unit tests: `PYTHONPATH=. pytest -q` | Build check: `python3 -m compileall app` | Lint: `ruff check .` (if configured) | Format: `ruff format .` (if configured) | Typecheck: `mypy app/` (if configured) | Dev server: `uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload`
- speed signal: fast feedback, stable layout, and obvious progress through the first proven workflow
- delight or memorability signal: cohesive product language across the blueprint's primary surfaces
- guidance signal: clear next actions, honest states, and no confusing dead ends in the first milestone

## Interface principles

- primary workflow clarity
- intentional hierarchy
- designed states
- consistency across related surfaces

## Layout and component language

- layout rhythm: organize surfaces around the first proven workflow for `FASTAPI_API`
- surface hierarchy: primary milestone flow first, supporting actions second, advanced or operational controls last
- navigation pattern: keep the first blueprint-aligned slice obvious and avoid burying the core path
- component reuse pattern: reuse primitives across the first milestone and only split variants when the surface genuinely diverges

## State design

- empty states: explain the next useful action and show the intended value of the first milestone
- loading states: keep progress visible and preserve layout stability for the primary flow
- error states: be explicit, actionable, and honest about recovery paths

## Usage rules

- Keep this durable and product-facing.
- Do not leave master-template maintenance design state here in the AIAST source repo.
