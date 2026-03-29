# Plan

Use this file as the current implementation plan for the active repo milestone or problem set.

## Objective

- Current target outcome: Deliver the first blueprint-aligned vertical slice for core-service
- Why it matters now: The selected starter blueprint gives the repo a concrete build shape; the next step is to prove it with one real slice instead of broad speculative setup.
- Deadline or forcing function: Prove the first blueprint-aligned slice before broadening scope or making release claims.

## Success criteria

- User or operator outcome: Ship `/health` endpoint returning `{"status": "ok"}` and one real resource route with CRUD.; Confirm `PYTHONPATH=. pytest -q` passes with route tests covering happy path and error cases.; Confirm `python3 -m compileall app` passes with zero errors.; Confirm dev server starts and responds to `curl http://127.0.0.1:8000/health`.; Record API contract assumptions, versioning strategy, and data model decisions in `ARCHITECTURE_NOTES.md`.
- Technical outcome: The repo shape and first runtime slice align with FASTAPI_API and are backed by real validation evidence.
- Design or product-quality outcome: Explicit 4xx and 5xx behavior — every error has a typed response model, not raw exceptions. | Typed request and response models (Pydantic) for every route. No raw dicts in or out. | In AIAST scaffolded repos, use a `src/` layout or explicit package settings in | Proper HTTP status codes: 201 for creates, 204 for deletes, 422 for validation errors.

## Scope lock

- In scope: selected starter blueprint, first vertical slice, repo-shape confirmation, and first real validation evidence
- Out of scope: secondary surfaces, broad polish, and expansion beyond the first proven slice
- Dependencies: PRODUCT_BRIEF.md, _system/PROJECT_PROFILE.md, the selected starter blueprint, and the repo toolchain
- Known unknowns: auth model, persistence boundary, migration discipline, background work, and deployment shape

## Assumptions

- Record only assumptions that materially affect current execution.

## Execution slices

1. Shape the repo around `FASTAPI_API` and confirm the first-slice boundaries.
2. Build the first milestone captured in `PRODUCT_BRIEF.md` with real runtime behavior.
3. Run blueprint-aligned validation, capture evidence, and set the next slice.

## Validation plan

- Commands to run: Unit tests: `PYTHONPATH=. pytest -q` | Build check: `python3 -m compileall app` | Lint: `ruff check .` (if configured) | Format: `ruff format .` (if configured) | Typecheck: `mypy app/` (if configured) | Dev server: `uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload`
- Evidence to capture: exact commands run, pass or fail outcomes, and proof that the first slice matches the chosen blueprint
- Stop conditions: stop if the selected blueprint conflicts with real product needs or if the first validation path cannot be proven
- Release-blocking checks: the blueprint-aligned validation minimum must be proven before release posture changes

## Risks

- Risks that could invalidate the plan: shape drift, overbuilding before proof, unvalidated contracts, or hidden runtime constraints
- Fallback path if the plan fails: reduce scope to the smallest demonstrable slice, update PRODUCT_BRIEF.md, and re-select the blueprint if needed

## Done definition

- Define what "done" means for this repo milestone: the selected blueprint is reflected in repo planning, one real vertical slice exists, and the first validation path is proven

## Master template note

- In the AIAST source repo, maintainer-only system-design planning belongs in the master-repo-only meta workspace, not in this installable file.

## Notes

- Use this file for current-plan structure, not long-term product vision.
- Move medium-term sequencing into `ROADMAP.md`.
