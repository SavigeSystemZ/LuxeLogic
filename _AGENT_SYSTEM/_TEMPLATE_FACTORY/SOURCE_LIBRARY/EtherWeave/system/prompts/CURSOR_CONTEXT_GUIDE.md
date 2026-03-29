Cursor Reload Guide (Etherweave)

Load these files at the start of any new Cursor session:
1) docs/AI_CONTEXT_INDEX.md
2) prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md
3) docs/CONTEXT_GUIDE.md
4) docs/CURSOR_NEXUS.md (Skills, Commands, Subagents, Rules — when to use each)
5) docs/CHANGELOG_REFAC.md
6) docs/ARCHITECTURE_BOUNDARIES.md
7) docs/ARCHITECTURE_FITNESS_FUNCTIONS.md
8) docs/SUBAGENT_PROTOCOL.md
9) docs/SUBAGENT_REGISTRY.md
10) docs/SESSION_STATE.md
11) AGENTS.md
12) CURSOR_SYSTEM_PROMPT.md
13) prompts/CODEX_CONTINUANCE_PROMPT_V2.md (for parity reference)

This project is defensive/authorized only. Engagement Scope default, Privileged Ops required for privileged actions.
Always keep a session log; append key actions and summaries to the active terminal log file when available.
Design target: world-class, modular, scalable, and AI-ready with strict safety constraints.
Workflow contract: Questions (only as many as needed) → Prereqs → one or two tightly-related steps when safe.
Auto-execute safe in-repo prereqs when possible; log actions.
Operator approval: in-repo edits are pre-approved; do not request confirmation for normal changes.
Atomic task discipline: single-outcome tasks, split multi-verb steps, explicit dependencies.
Codex model preference: GPT-5.2-Codex with reasoning "high" (or the most advanced high-reasoning model available); switch via `/model` before proceeding if needed.
If context appears reset, incomplete, or timed out, notify the operator and request a full reload before proceeding.
Command set: "load master architectural systems now!" triggers the full load order; log actions and confirm readiness. If the load risks context overflow, split into step parts and continue on request.
Context safety: if the context window is at risk, stop before overflow, state the cutoff, and request continuation with the next step part.

Cursor Skills, Commands, Subagents, Rules:
- Use docs/CURSOR_NEXUS.md as the single reference. Apply skills when the task matches (e.g. code review → etherweave-code-review; checkpoint → etherweave-checkpoint). User can run commands by typing / in chat (e.g. /code-review, /verify). Delegate to subagents when a focused review or fix in isolation is needed (e.g. etherweave-debugger, etherweave-code-reviewer). Rules in .cursor/rules/ are applied automatically; do not duplicate their content in prompts.

MCP tools:
- See docs/MCP_SETUP.md. Configured: Semgrep (security — use first), Sentry, Socket, Ref (doc search), Jam (debug context), Vale (doc linting). Leverage when the task fits. Later installs: docs/MCP_LATER_INSTALLS.md.
