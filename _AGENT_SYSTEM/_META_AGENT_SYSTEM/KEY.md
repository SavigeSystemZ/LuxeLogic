# Meta System Key

This file is the maintainer-facing key for every file inside `_META_AGENT_SYSTEM/`.

Use it when you need to orient quickly, confirm where maintainer-only truth
belongs, or ensure no continuity surface is being ignored while evolving AIAST
itself.

## File Catalog

- `.meta-only` - Boundary marker proving this workspace is master-repo-only and must never ship into installed repos. Check it when validating separation from `TEMPLATE/` and `MOS_TEMPLATE/`.
- `AGENTS.md` - Local rules for how to use the maintainer workspace. Read it before editing maintainer-only planning or design state.
- `AIAST_SYSTEM_REVIEW_2026-03-22.md` - Historical maintainer review artifact from the earlier system audit. Use it only when that review evidence is relevant to later comparisons or continuity.
- `COMPLETION_SHEET.md` - Canonical finish-line tracker for remaining work, deferred work, testing phases, and closure criteria. Read it when deciding what is still left before calling a slice complete.
- `KEY.md` - Exhaustive key for the maintainer workspace itself. Use it when you need the full file-by-file map instead of the shorter summaries.
- `PLAN.md` - Current maintainer execution slice and ordered next actions. Update it when the active maintainer work changes.
- `PLANNED_FILES.md` - Tracker for which maintainer-only surfaces exist, why they exist, and what future additions are justified. Read it before adding new workspace files.
- `README.md` - Overview of the maintainer workspace purpose, boundary, and current state. Read it for first orientation to `_META_AGENT_SYSTEM/`.
- `TEST_APP_CAMPAIGN.md` - Launch sheet for the downstream test-app matrix and associated exit criteria. Use it when preparing or executing the next test-app campaign.
- `TODO.md` - Maintainer action queue and completion log. Update it as maintainer tasks land or new follow-up work is discovered.
- `WHERE_LEFT_OFF.md` - Primary resume packet for the next maintainer session. Update it at the end of each meaningful maintainer slice.
- `context/CURRENT_STATUS.md` - Compact maintainer-status snapshot and next-best-step record. Use it for quick state recovery.
- `context/DECISIONS.md` - Durable log of maintainer decisions and their reasoning. Update it when a meaningful maintainer choice becomes the new operating truth.
- `context/README.md` - Guide to what belongs under the maintainer context directory. Read it before adding or reshaping maintainer context files.

## Adjacent Validation Surfaces

These files are not part of `_META_AGENT_SYSTEM/` itself, but they are the
canonical ways to validate and enforce this workspace:

- `_TEMPLATE_FACTORY/validate-meta-workspace.sh` - structural continuity validator for the maintainer packet
- `_TEMPLATE_FACTORY/run-maintainer-lane.sh` - wrapper lane that runs the maintainer validator plus `git diff --check`
