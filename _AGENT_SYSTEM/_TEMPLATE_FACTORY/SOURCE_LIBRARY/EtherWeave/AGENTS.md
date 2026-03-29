# AGENTS.md — Repo Binding Rules (All AI Coding Tools)

These rules are binding for **all agents and AI coding tools** operating in this repository. Multiple tools (Cursor, Codex, Gemini, Claude, Windsurf, and others) may configure, build, and design this app **in turn**; each must follow the same load order, output contract, and checkpoint protocol. See **system/docs/MULTI_AGENT_AND_TOOL_AWARENESS.md**.

## Load Order (no guessing)

System assets (prompts, governance docs) live under **system/**; application code stays at repo root. See system/README.md.

1) system/prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md
2) system/docs/AI_CONTEXT_INDEX.md
3) system/docs/KERNEL_CONTRACT.md
4) system/docs/DEBUG_REPAIR_PLAYBOOK.md
5) system/docs/PHASE_CHECKPOINT_PROTOCOL.md
6) PROJECT_RULES.md
7) MASTER_AI_REFERENCE.md
8) CHATGPT_COMPLETE_APPLICATION_GUIDE.md
9) system/docs/CONTEXT_GUIDE.md
10) system/docs/CHANGELOG_REFAC.md
11) system/docs/ARCHITECTURE_BOUNDARIES.md
12) system/docs/ARCHITECTURE_FITNESS_FUNCTIONS.md
13) system/prompts/CURSOR_CONTEXT_GUIDE.md
14) system/docs/CURSOR_NEXUS.md (Skills, Commands, Subagents, Rules)
15) CURSOR_SYSTEM_PROMPT.md
16) system/docs/SUBAGENT_PROTOCOL.md
17) system/docs/SUBAGENT_REGISTRY.md
18) docs/SESSION_STATE.md
19) system/docs/ENVIRONMENT_AND_MCP_MODEL.md

## Output Contract (every response)
1) Questions (targeted, only as many as needed)
2) Prerequisite steps (auto-execute safe in-repo prereqs when possible; log actions)
3) Next step (default ONE step; may execute up to TWO tightly-related steps when safe/low-risk)

## Step Subdivision
- If a step is large, split it into labeled substeps (e.g., Step 4a/4b/4c) to keep execution complete, validated, and easy to review.
- If there are no meaningful questions for a step, state “No questions” and list assumptions/defaults (do not re-ask already-answered items).

## Safety + Authorization
- Authorized/lab use only.
- No one-click misuse. Sensitive actions require explicit confirmation + Engagement Scope gating + audit logging.
- Default to Engagement Scope; Privileged Ops requires cached sudo.

## Multi-Tool Parity (Cursor, Codex, Gemini, Claude, Windsurf, etc.)
- **Multiple AI coding tools take turns** on this repo. Governance is tool-agnostic; see system/docs/MULTI_AGENT_AND_TOOL_AWARENESS.md.
- Keep Codex and Cursor rules semantically aligned. If you update AGENTS.md, update Cursor rules under `.cursor/rules/` and prompt packs.
- Any tool continuing work must load the same context (load order), update WHERE_WE_LEFT_OFF and SESSION_STATE on handoff, and run verification before handoff when code changed.

## Checkpoints (required)
Trigger a checkpoint when:
- A major UX layout or workflow change lands, OR
- A major refactor lands, OR
- Tests/fitness checks pass for a milestone.

At each checkpoint:
- Update WORKLOG.md (what/why/validate/rollback/next)
- Create backups (archive + git bundle + hashes)
- GitHub sync (fetch/pull → commit → push)
- Append a summary to the session log

## Verification Gates
- Prefer `tools/verify.sh` for local parity gates (import/fitness + lightweight secrets scan).
- If verification fails: follow `system/docs/DEBUG_REPAIR_PLAYBOOK.md` and do not proceed until resolved or recorded in `docs/KNOWN_ISSUES.md`.

## Session Logging
- Start a new session log when a session starts (Codex: `logs/codex/`, Cursor: `logs/cursor/`; other tools may use the same or a similar path).
- Log format includes timestamp, user input, agent output, files changed, commands run.
- **Handoff:** When your turn ends, update WHERE_WE_LEFT_OFF.md, SESSION_STATE.md, and optionally CONTEXT_PACK.md so the next tool (any of Cursor, Codex, Gemini, Claude, Windsurf, etc.) can continue without your in-session context.

## Subagent System
- Use `system/docs/SUBAGENT_PROTOCOL.md` + `system/docs/SUBAGENT_REGISTRY.md` for role guidance.
- Use `tools/subagent_supervisor.py` for Ollama CLI execution or manual fallback.
- Record subagent activity in `docs/SESSION_STATE.md`.
- **Cursor subagents**: `.cursor/agents/` (etherweave-code-reviewer, etherweave-debugger, etherweave-gui-ux, etc.). Invoke via "use X subagent" or delegation. See `system/docs/SUBAGENT_REGISTRY.md` and `system/docs/CURSOR_NEXUS.md`.

## Cursor Skills, Commands, Rules
- **Nexus**: `system/docs/CURSOR_NEXUS.md` — single reference for when to use Skills, Commands, Subagents, Rules.
- **Skills**: `.cursor/skills/` — apply when task matches (e.g. code review → etherweave-code-review; checkpoint → etherweave-checkpoint) or user invokes via /skill-name.
- **Commands**: `.cursor/commands/` — user types `/` in chat and selects command (e.g. /code-review, /verify, /load-context). Content of the command file is the instruction.
- **Rules**: `.cursor/rules/` — always-apply and file-scoped; Cursor includes them in context. Keep aligned with AGENTS.md. See `.cursor/rules/README.md`.

## Context Continuity
- If context appears reset, incomplete, or timed out, immediately notify the operator and request a reload of the master architectural system and required files.
- After any context reset, re-apply model selection, approvals, and session logging, then confirm readiness before proceeding.

## Environment and MCP
- **system/docs/ENVIRONMENT_AND_MCP_MODEL.md** defines environment (session/repo/MCP), workspace vs user-level MCPs (OpenMemory, Context7, OpenAI Developer Docs), and agent behavior when MCPs error: note once, continue with in-repo context; never block on MCP availability.
- When MCPs keep erroring, direct operator to that doc and docs/MCP_TROUBLESHOOTING.md and docs/OPENMEMORY_SETUP.md; then proceed using the repo.

## Command Set (operator)
- "load master architectural systems now!" — run the full load order, log actions, and confirm readiness. If the load risks context overflow, split into step parts and continue on request.

## Model + Reasoning Preference
- Default to GPT-5.2-Codex with reasoning "high". If unavailable, use the most advanced high-reasoning model available.
- Use reasoning "medium" or "low" only for explicitly trivial work where speed is prioritized; note the downgrade.
- If the agent cannot switch models itself, it must provide the exact `/model` command (e.g., `/model GPT-5.2-Codex` with reasoning "high").

## Decision Rule (operator)
- Prefer best-practice defaults for technical/backend choices; only ask for user-facing preferences (cosmetics, major UX behavior changes).
- Always state what choice was made.

## Milestones / Phases / Steps
- Structure work as milestones → phases → steps that build on each other.
- Steps may be small, medium, or large depending on the work; keep them integrated, reversible, and logged.

## Step Parts (when needed)
- If a step (or multi-step execution) risks exceeding context/time, split it into step parts (e.g., Step 7.2a/7.2b/7.2c) and ensure each part has validation + rollback.
- When safe and within limits, a single interaction may complete multiple steps/parts; always keep the work complete, explicit, and reviewable.
- If context size is at risk, stop before overflow, state the cutoff, and request continuation with the next step part.

## Secrets + Security
- Never commit secrets.
- Run a lightweight secrets scan before push.

## Notes
- If required files are missing, ask for location or propose creating them.
