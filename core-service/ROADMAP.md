# Roadmap

Use this file for medium-term and long-term sequencing.

## Current horizons

- Horizon 1: stabilize the current repo baseline
- Horizon 2: deliver the next meaningful product or platform milestone
- Horizon 3: improve scalability, polish, reliability, and release maturity

## Milestones

- Milestone 1: Prove the selected starter blueprint
  Outcome: Ship `/health` endpoint returning `{"status": "ok"}` and one real resource route with CRUD.; Confirm `PYTHONPATH=. pytest -q` passes with route tests covering happy path and error cases.; Confirm `python3 -m compileall app` passes with zero errors.; Confirm dev server starts and responds to `curl http://127.0.0.1:8000/health`.; Record API contract assumptions, versioning strategy, and data model decisions in `ARCHITECTURE_NOTES.md`.
  Dependencies: selected blueprint alignment, product-brief truth, and one real validation path
  Risks: overbuilding before the first slice is proven
- Milestone 2: Expand the core workflow set
  Outcome: add the next highest-value workflow on top of the proven blueprint without breaking the first slice
  Dependencies: stable contracts from milestone 1, clearer product truth, and validated runtime boundaries
  Risks: architecture drift, premature breadth, and inconsistent UX or operator flow
- Milestone 3: Hardening, packaging, and release readiness
  Outcome: raise validation depth, operational maturity, packaging quality, and release confidence for the chosen product shape
  Dependencies: milestone 1 and 2 proof, clearer deployment targets, and stronger security and observability posture
  Risks: release claims outrunning evidence, ops complexity, and performance regressions

## Notes

- Keep active execution detail in `PLAN.md`.
- Keep this file focused on sequencing, not task-level queue management.
