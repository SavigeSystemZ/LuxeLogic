---
name: etherweave-load-context
description: Load Etherweave master system prompt, prompts, and rules in canonical order. Use when the user says "load master architectural systems now!", starts a new session, or when context appears reset, incomplete, or timed out.
---

# Etherweave Load Context

## When to Use

- User says **"load master architectural systems now!"**
- New Cursor session or context appears reset/incomplete/timed out
- User asks to apply master prompt, load rules, or reload context

## Load Order (binding)

Read and apply these files in order. If context overflow is at risk, load in step parts and confirm readiness after each part.

**Part A — Core prompt and index**
1. `prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md`
2. `docs/AI_CONTEXT_INDEX.md`
3. `docs/KERNEL_CONTRACT.md`
4. `docs/DEBUG_REPAIR_PLAYBOOK.md`
5. `docs/PHASE_CHECKPOINT_PROTOCOL.md`

**Part B — Rules and reference**
6. `PROJECT_RULES.md` (or repo root `.cursorrules` if PROJECT_RULES.md missing)
7. `MASTER_AI_REFERENCE.md`
8. `docs/CONTEXT_GUIDE.md`
9. `docs/ARCHITECTURE_BOUNDARIES.md`
10. `docs/ARCHITECTURE_FITNESS_FUNCTIONS.md`

**Part C — Cursor and agents**
11. `prompts/CURSOR_CONTEXT_GUIDE.md`
12. `docs/CURSOR_NEXUS.md` (Skills, Commands, Subagents, Rules — when to use each)
13. `AGENTS.md`
14. `CURSOR_SYSTEM_PROMPT.md` (if present)
15. `docs/SUBAGENT_PROTOCOL.md`
16. `docs/SUBAGENT_REGISTRY.md`
17. `docs/SESSION_STATE.md`

## Execution

1. **Single run**: If context allows, read Part A → Part B → Part C in sequence.
2. **Split run**: If context is tight, run Part A only, confirm readiness, then request continuation for Part B, then Part C.
3. **Confirm**: After load, state briefly what was loaded and that the agent is ready to proceed under master prompt and rules.
4. **Log**: If session logging is used, append "Loaded master architectural context (load order)." to the session log.

## Related

- **Nexus**: `docs/CURSOR_NEXUS.md` — Skills, Commands, Subagents, Rules (when to use each).
- Project system prompt: `.cursor/commands/projectsystemprompt.md` (use `/projectsystemprompt` in chat)
- Project commands: `.cursor/commands/projectcommand.md` (use `/projectcommand` in chat)
- Shorter reload list: `prompts/CURSOR_CONTEXT_GUIDE.md`

## Safety Baseline (reminder after load)

- Authorized/lab use only. No automated exploitation or traffic disruption.
- Privileged Ops requires sudo cache + explicit confirmation.
- Verification gate: prefer `tools/verify.sh` before proceeding after changes.
