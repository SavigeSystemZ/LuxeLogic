# Context Guide

This repository carries project-specific operating rules and safety constraints.
Load these first in any new session:

1) Context index: `docs/AI_CONTEXT_INDEX.md`
2) Master prompt: `prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md`
3) Refactor log: `docs/CHANGELOG_REFAC.md`
4) Architecture rules: `docs/ARCHITECTURE_BOUNDARIES.md`, `docs/ARCHITECTURE_FITNESS_FUNCTIONS.md`
5) Test strategy: `docs/TEST_STRATEGY.md`
6) Subagent protocol: `docs/SUBAGENT_PROTOCOL.md`
7) Subagent registry: `docs/SUBAGENT_REGISTRY.md`
8) Session state: `docs/SESSION_STATE.md`
9) Cursor reload notes: `prompts/CURSOR_CONTEXT_GUIDE.md`
10) Cursor infrastructure guide: `docs/CURSOR_INFRASTRUCTURE_GUIDE.md`
11) AGENTS rules: `AGENTS.md`
12) World-class backlog: `WIRELESS_PLATFORM_WORLDCLASS_ENHANCEMENTS.md`

Safety constraints summary:
- Defensive, authorized security assessment only.
- No automated exploitation, credential attacks, or traffic disruption.
- Preserve CoreController entrypoint and thread-safe UI requirements.

Workflow contract: Questions (only as many as needed) → Prereqs → ONE step.
Auto-execute safe in-repo prereqs when possible; log actions.
Operator approval: in-repo edits are pre-approved; do not request confirmation for normal changes.
Atomic task discipline: single-outcome tasks, split multi-verb steps, explicit dependencies.

Command set: "load master architectural systems now!" triggers the full load order; log actions and confirm readiness. If the load risks context overflow, split into step parts and continue on request.
Context safety: if the context window is at risk, stop before overflow, state the cutoff, and request continuation with the next step part.
