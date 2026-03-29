# Wraiths-Etherweave Cursor Rules

These rules mirror AGENTS.md. Keep them aligned.

## Context Load Order (no guessing)
- `system/prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md`
- `system/docs/AI_CONTEXT_INDEX.md`
- `docs/KERNEL_CONTRACT.md`
- `docs/DEBUG_REPAIR_PLAYBOOK.md`
- `docs/PHASE_CHECKPOINT_PROTOCOL.md`
- `PROJECT_RULES.md`
- `MASTER_AI_REFERENCE.md`
- `CHATGPT_COMPLETE_APPLICATION_GUIDE.md`
- `docs/CONTEXT_GUIDE.md`
- `docs/SUBAGENT_PROTOCOL.md`
- `docs/SUBAGENT_REGISTRY.md`
- `docs/SESSION_STATE.md`
- `docs/CURSOR_NEXUS.md` (Skills, Commands, Subagents, Rules — when to use each)

## Cursor Skills, Commands, Subagents, Rules
- **Nexus**: `docs/CURSOR_NEXUS.md` — single reference. Apply skills when task matches; user runs commands via `/` in chat; delegate to subagents when focused review/fix needed; rules in `.cursor/rules/` apply automatically. Keep rules and skills aligned; do not duplicate rule content in prompts.

## Output Contract
1) Questions (targeted, only as many as needed)
2) Prerequisite steps (auto-execute safe in-repo prereqs when possible; log actions)
3) Next step (default ONE step; may execute up to TWO tightly-related steps when safe/low-risk)

## Step Subdivision
- If a step is large, split it into labeled substeps (e.g., Step 4a/4b/4c) so it can be executed fully with validation/rollback.
- If there are no meaningful questions for a step, explicitly say so and state assumptions/defaults (avoid repeating answered questions).

## Model + Reasoning Preference
- Default to GPT-5.2-Codex with reasoning "high". If unavailable, use the most advanced high-reasoning model available.
- Use reasoning "medium" or "low" only for explicitly trivial work where speed is prioritized; note the downgrade.
- If the agent cannot switch models itself, provide the exact `/model` command (e.g., `/model GPT-5.2-Codex` with reasoning "high").

## Decision Rule
- Prefer best-practice defaults for technical/backend choices; only ask for user-facing preferences (cosmetics, major UX behavior changes).
- Always state the choice made.

## Milestones / Phases / Steps
- Structure work as milestones → phases → steps.
- Steps build on each other; keep UX powerful but uncluttered.

## Step Parts (when needed)
- If a step risks exceeding context/time, split it into step parts (e.g., Step 7.2a/7.2b/7.2c) with validation + rollback per part.
- When safe and within limits, one interaction may complete multiple steps/parts, but keep work explicit and reviewable.
- If the context window is at risk, stop before overflow, state the cutoff, and request continuation with the next step part.

## Safety + Authorization
- Authorized/lab use only.
- No one-click misuse.
- Sensitive actions require explicit confirmation + Engagement Scope gating + audit logs.

## Dual-Agent Parity
- Update Cursor rules whenever AGENTS.md changes.

## Checkpoints
- Update WORKLOG.md, create backups, and sync GitHub at milestones.

## Session Logging
- Start a new session log each session under `logs/cursor/`.

## Subagent System
- Use `docs/SUBAGENT_PROTOCOL.md` + `docs/SUBAGENT_REGISTRY.md` for role guidance.
- Use `tools/subagent_supervisor.py` for Ollama CLI execution or manual fallback.
- Record subagent activity in `docs/SESSION_STATE.md`.

## Context Continuity
- If context appears reset, incomplete, or timed out, notify the operator and request a reload of the master architectural system and required files.
- After any context reset, re-apply model selection, approvals, and session logging, then confirm readiness before proceeding.

## Command Set (operator)
- "load master architectural systems now!" — run the full load order, log actions, and confirm readiness. If the load risks context overflow, split into step parts and continue on request.

## Secrets
- Never commit secrets; run a lightweight secrets scan before push.

## Verification Gates
- Prefer `tools/verify.sh` for local gates (import/fitness + lightweight secrets scan).
- If verification fails: stop and follow `docs/DEBUG_REPAIR_PLAYBOOK.md`.
