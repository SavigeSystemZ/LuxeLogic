# Test Strategy

Use this file to define the repo's confidence model, validation lanes, and known coverage gaps.

## Confidence model

- required confidence for local changes: run the smallest impacted validation lane plus any touched bootstrap or system checks
- required confidence for risky changes: run unit, integration, and any relevant smoke, build, packaging, or security lanes before handoff
- required confidence for release candidates: run every defined lane in this file and record exact outcomes in release-facing notes or handoff

## Validation lanes

- format or lint: Lint: `ruff check .` (if configured) | Format: `ruff format .` (if configured)
- typecheck: Typecheck: `mypy app/` (if configured)
- unit tests: npm run test
- integration tests: no integration-test command inferred yet; confirm manually
- end-to-end or smoke: Dev server: `uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload`
- build or packaging checks: Build check: `python3 -m compileall app`
- security or policy checks: bootstrap/scan-security.sh /home/whyte/.MyAppZ/LuxeLogic/core-service

## Coverage expectations

- critical flows that must be proven: Ship `/health` endpoint returning `{"status": "ok"}` and one real resource route with CRUD.; Confirm `PYTHONPATH=. pytest -q` passes with route tests covering happy path and error cases.; Confirm `python3 -m compileall app` passes with zero errors.; Confirm dev server starts and responds to `curl http://127.0.0.1:8000/health`.; Record API contract assumptions, versioning strategy, and data model decisions in `ARCHITECTURE_NOTES.md`.
- areas allowed to rely on lighter validation: docs, prompt wording, and low-risk content-only changes after targeted checks
- expected evidence for high-risk changes: Unit tests: `PYTHONPATH=. pytest -q` | Build check: `python3 -m compileall app` | Lint: `ruff check .` (if configured) | Format: `ruff format .` (if configured) | Typecheck: `mypy app/` (if configured) | Dev server: `uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload` | exact commands run and pass or fail outcomes for the first proven slice

## Known gaps

- Confirm the blueprint-aligned validation lanes against the first real repo-local run and record any missing coverage explicitly.

## Usage rules

- Keep this aligned with `RISK_REGISTER.md` and `RELEASE_NOTES.md`.
- Record what confidence is required, not just what happens to exist today.
