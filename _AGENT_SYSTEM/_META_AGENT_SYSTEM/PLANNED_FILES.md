# Planned Files

Use this file to track the future file set for the master-repo-only meta-system workspace.

## Current status

- The installable MOS product has been implemented outside this workspace.
- This workspace now serves as the canonical maintainer continuity packet for the master repo.
- The first maintainer-only review artifact now exists as `_META_AGENT_SYSTEM/AIAST_SYSTEM_REVIEW_2026-03-22.md`.
- The maintainer continuity packet now has an executable validator in `_TEMPLATE_FACTORY/validate-meta-workspace.sh`.
- The maintainer continuity packet now also has a dedicated wrapper lane in `_TEMPLATE_FACTORY/run-maintainer-lane.sh`.
- The requested finish-line tracker now exists as `_META_AGENT_SYSTEM/COMPLETION_SHEET.md` because the remaining work, deferred work, and testing phases had outgrown what `TODO.md` showed cleanly at a glance.
- The requested exhaustive maintainer workspace map now exists as `_META_AGENT_SYSTEM/KEY.md` so another agent can see the whole meta-system surface and when each file matters without reconstructing it from directory listings.
- The scripted next-phase launch sheet now exists as `_META_AGENT_SYSTEM/TEST_APP_CAMPAIGN.md` because the next work is no longer "decide what to test," but "run the prepared test-app matrix."
- Add new files only when they will carry real maintainer state, findings, or backlog value.

## Candidate categories

- agent-behavior and collaboration contracts
- user-preference and interaction-shaping surfaces
- app-build workflow and planning surfaces
- prompt, model-shaping, and context-pack surfaces
- validation and audit surfaces for the system itself
- handoff and continuity surfaces for future AIAST-maintainer sessions

## Next likely additions when justified by real content

- research notes if system-design experiments or comparisons start accumulating evidence that should survive outages

## Rule

- Only add files here after the user defines the intended role of that surface or the file is clearly needed to hold active maintainer state.
- Do not duplicate installable MOS contracts here unless the surface is explicitly maintainer-only.
