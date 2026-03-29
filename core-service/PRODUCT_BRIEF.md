# Product Brief

Use this file to capture the product idea, intended user value, and chosen build shape for this repo.

## Product frame

- Product name: core-service
- Product category: set once the product shape is specific enough to exclude lookalikes
- One-line summary: build core-service as a repo shaped intentionally around the selected starter blueprint
- Why it should exist: capture the user pain, operator leverage, or market opportunity this app resolves
- Primary users: name the real people or operators who should benefit first
- Primary workflows: list the core flows the first milestone must prove
- Success indicators: record the measurable signal that shows the app is genuinely useful
- Non-goals: state what this repo should not try to solve in the first phase

## Experience bar

- Visual direction: deliberate, differentiated, and product-specific rather than template-generic
- Interaction bar: fast, clear, low-friction flows with designed states from the first milestone
- Performance bar: snappy enough that the first slice feels trustworthy under normal use
- Reliability bar: clear degraded states, explicit error handling, and no fake capability claims
- Trust and safety bar: security-conscious defaults, honest validation claims, and explicit handling of risky actions

## Build shape

- Recommended starter blueprint: FASTAPI_API - FastAPI API Blueprint
- Recommendation confidence: confirmed
- Recommendation rationale: Explicit blueprint selection confirmed this build shape for the current product.
- Selected starter blueprint: FASTAPI_API - FastAPI API Blueprint
- Why this blueprint fits: Use this for Python API services that need clean contracts, testable routes, and explicit validation.
- Planned repo shape: app/, tests/, pyproject.toml       project metadata and dependencies, uv.lock              lock file (or requirements.txt)
- First milestone: Ship `/health` endpoint returning `{"status": "ok"}` and one real resource route with CRUD.; Confirm `PYTHONPATH=. pytest -q` passes with route tests covering happy path and error cases.; Confirm `python3 -m compileall app` passes with zero errors.; Confirm dev server starts and responds to `curl http://127.0.0.1:8000/health`.; Record API contract assumptions, versioning strategy, and data model decisions in `ARCHITECTURE_NOTES.md`.
- Initial validation focus: Unit tests: `PYTHONPATH=. pytest -q` | Build check: `python3 -m compileall app` | Lint: `ruff check .` (if configured) | Format: `ruff format .` (if configured) | Typecheck: `mypy app/` (if configured) | Dev server: `uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload`
- Next decision gates: auth model, persistence boundary, migration discipline, background work, and deployment shape

## Usage rules

- Keep this aligned with `_system/PROJECT_PROFILE.md`, `PLAN.md`, `ROADMAP.md`, `DESIGN_NOTES.md`, and `ARCHITECTURE_NOTES.md`.
- If the repo is greenfield, use `bootstrap/recommend-starter-blueprint.sh` first, then use `bootstrap/apply-starter-blueprint.sh` to stamp the explicitly chosen starter blueprint into the first operating surfaces.
- Keep this factual and product-specific; do not turn it into vague aspiration or marketing filler.
