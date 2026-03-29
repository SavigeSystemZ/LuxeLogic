# Architecture Notes

Use this file for durable architecture direction, not one-off implementation chatter.

## Current shape

- system boundaries: app/, tests/, pyproject.toml       project metadata and dependencies, uv.lock              lock file (or requirements.txt)
- major modules: app/, tests/, pyproject.toml       project metadata and dependencies, uv.lock              lock file (or requirements.txt)
- highest-value seams: auth model, persistence boundary, migration discipline, background work, and deployment shape
- primary data flows: Ship `/health` endpoint returning `{"status": "ok"}` and one real resource route with CRUD.; Confirm `PYTHONPATH=. pytest -q` passes with route tests covering happy path and error cases.; Confirm `python3 -m compileall app` passes with zero errors.; Confirm dev server starts and responds to `curl http://127.0.0.1:8000/health`.; Record API contract assumptions, versioning strategy, and data model decisions in `ARCHITECTURE_NOTES.md`.

## Boundary rules

- protected boundaries: FastAPI | Python 3.11+ | Pydantic v2 for request/response models | pytest for testing
- modules that may change together: the modules participating in the first proven vertical slice
- modules that should stay independent: runtime modules, ops or packaging scaffolds, and `_system/` governance surfaces

## Interface contracts

- internal contracts that must remain stable: auth model, persistence boundary, migration discipline, background work, and deployment shape
- external contracts that need migration discipline: Unit tests: `PYTHONPATH=. pytest -q` | Build check: `python3 -m compileall app` | Lint: `ruff check .` (if configured) | Format: `ruff format .` (if configured) | Typecheck: `mypy app/` (if configured) | Dev server: `uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload`

## Change pressure points

- likely refactor zones: the seams touched by the first blueprint-aligned slice until patterns stabilize
- fragile coupling to watch: shape drift that collapses runtime, domain, delivery, or packaging boundaries together
- scaling or reliability pressure points: Explicit 4xx and 5xx behavior — every error has a typed response model, not raw exceptions. | Typed request and response models (Pydantic) for every route. No raw dicts in or out. | In AIAST scaffolded repos, use a `src/` layout or explicit package settings in | Proper HTTP status codes: 201 for creates, 204 for deletes, 422 for validation errors.

## Migration watchpoints

- migrations likely to be needed later: auth model, persistence boundary, migration discipline, background work, and deployment shape
- compatibility concerns: expand the selected blueprint without breaking the first proven slice or stable contracts
- rollback concerns: fall back to the smallest demonstrable slice and preserve stable interfaces while reshaping

## Review prompts

- Does the proposed change improve or worsen separation of concerns?
- Does it create hidden coupling?
- Does it preserve a clear runtime-vs-system boundary?
