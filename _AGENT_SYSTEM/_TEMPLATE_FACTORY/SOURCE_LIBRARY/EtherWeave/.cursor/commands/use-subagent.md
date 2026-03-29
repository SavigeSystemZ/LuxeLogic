# Use Subagent

Delegate the current task to the most appropriate Etherweave subagent.

**Do this now:**
1. Determine the task type: **code review** → etherweave-code-reviewer | **debug/failure** → etherweave-debugger | **GUI/UX** → etherweave-gui-ux | **wireless/capture** → etherweave-wireless | **security/validation** → etherweave-security | **architecture/refactor** → etherweave-architecture | **checkpoint** → etherweave-checkpoint | **plan/decompose** → etherweave-orchestrator.
2. If the user named a subagent (e.g. "use etherweave-debugger"), apply that subagent's system prompt and output format (Summary, Findings, Proposed Changes, Tests/Verification, Risks + Rollback, Open Questions).
3. If no subagent was named, recommend the best-fit subagent and either apply its behavior or ask the user to confirm: "Use etherweave-X subagent to [task]?"

Subagents live in `.cursor/agents/`. Registry: `docs/SUBAGENT_REGISTRY.md`.
