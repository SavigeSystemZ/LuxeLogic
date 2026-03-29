---
name: cursor-task-scoping
description: Scopes Cursor Agent work into one clear step per response and clear outcomes. Use when planning work, starting a complex task, or when the user wants smaller steps.
---

# Cursor Task Scoping

Use when the user wants focused steps or when work is complex.

## One step per response (default)

- Default: **one** step per response for large or risky work.
- Medium tasks: up to two tightly-related steps when safe and reviewable.
- Small tasks: multiple tiny actions in one response when bounded and safe.

## Atomic task discipline

- **One outcome per task** — Avoid "and" in task titles; split multi-verb tasks.
- **Verb-noun naming** — e.g. "validate-input", "save-settings".
- **Testable in isolation** — No circular dependencies between steps.

## Step subdivision

- If a step is large, split into labeled substeps (Step 4a, 4b, 4c).
- If context or time is at risk, split into step parts and complete with validation and rollback per part.

## Output contract

1. **Questions** — Only as many as needed.
2. **Prerequisites** — Auto-run safe in-repo prereqs when possible; log actions.
3. **Next step** — Usually one; at most two when tightly related and low risk.

Reference: AGENTS.md, prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md.
