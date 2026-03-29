# TODO

This is the active execution queue. Keep it tight, factual, and ordered.
Use priority signals: **CRITICAL**, **HIGH**, **MEDIUM**, **LOW** (see
`_system/HANDOFF_PROTOCOL.md` for definitions).

## Bootstrap

- [ ] HIGH: Fill in `_system/PROJECT_PROFILE.md`
- [ ] HIGH: Turn `PRODUCT_BRIEF.md` into repo-specific truth
- [ ] HIGH: Review the recommended starter blueprint and explicitly apply it if the repo is still greenfield
- [ ] MEDIUM: Confirm runtime roots, validation commands, packaging targets, and deployment surfaces
- [ ] MEDIUM: Confirm MCP server set and scope
- [ ] MEDIUM: Establish the first real milestone in `PLAN.md`
- [ ] MEDIUM: Record initial risks in `RISK_REGISTER.md`

## Current Priority

- [ ] HIGH: Define the repo's next concrete outcome

## Immediate Queue

Use short, reviewable tasks with priority signals.

- [ ] MEDIUM: Replace remaining neutral prompts with repo-specific truth after install

## Next Queue

- [ ] LOW: Keep working files current as the repo evolves

## Validation Debt

- [ ] MEDIUM: Record the repo's real validation lane in `TEST_STRATEGY.md`

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
