# TODO

This is the active execution queue. Keep it tight, factual, and ordered.
Use priority signals: **CRITICAL**, **HIGH**, **MEDIUM**, **LOW** (see
`_system/HANDOFF_PROTOCOL.md` for definitions).

## Bootstrap

- [ ] HIGH: Fill in `_system/PROJECT_PROFILE.md`
- [ ] HIGH: Refine `PRODUCT_BRIEF.md` for core-service so the product frame and first build shape are explicit
- [x] HIGH: Reviewed and explicitly applied the starter blueprint: FASTAPI_API
- [ ] MEDIUM: Confirm runtime roots, validation commands, packaging targets, and deployment surfaces
- [ ] MEDIUM: Confirm MCP server set and scope
- [x] MEDIUM: Established the first real milestone in `PLAN.md`
- [ ] MEDIUM: Review and refine the seeded first-pass risks in `RISK_REGISTER.md`

## Current Priority

- [ ] HIGH: Build the first blueprint-aligned vertical slice for core-service

## Immediate Queue

Use short, reviewable tasks with priority signals.

- [ ] HIGH: Prove the initial validation focus recorded in `PRODUCT_BRIEF.md` and `TEST_STRATEGY.md`

## Next Queue

- [ ] MEDIUM: Keep `PRODUCT_BRIEF.md`, `PLAN.md`, `TEST_STRATEGY.md`, and `WHERE_LEFT_OFF.md` aligned as the first slice lands

## Validation Debt

- [ ] MEDIUM: Record the repo's real validation lane in `TEST_STRATEGY.md` after the first successful repo-local check

## Documentation Debt

- [ ] LOW: Keep design, architecture, research, risk, and release surfaces aligned with repo reality

## Completed

Move completed items here at session end.

## Usage rules

- Keep this file current enough that another tool can pick up immediately.
- Use priority signals so the next agent knows what to work on first:
  - **CRITICAL**: blocks users, breaks production, or creates security exposure
  - **HIGH**: blocks the current milestone or other high-priority work
  - **MEDIUM**: planned work that should happen this milestone
  - **LOW**: improvement or cleanup that can wait
- Mark items `[x]` only when fully done, not "mostly done."
- Add discovered work before handoff even if it is low priority.
- Keep product framing in `PRODUCT_BRIEF.md`, product sequencing in `ROADMAP.md`, and active execution structure in `PLAN.md`.
- In the AIAST source repo, maintainer-only template-planning state belongs in the master-repo-only meta workspace instead of this installable file.
