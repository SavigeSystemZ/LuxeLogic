# Etherweave Cursor Subagents

Project-scoped subagents for Cursor. Each runs in an isolated context with a focused system prompt. Invoke by asking the main agent to use a subagent, e.g. "Use the etherweave-debugger subagent to …".

| Subagent | Use when |
|----------|----------|
| **etherweave-code-reviewer** | After code changes; PR review; compliance with PROJECT_RULES and architecture. |
| **etherweave-debugger** | Build/import errors, runtime crashes, wrong output, UI regressions, test failures. Follows DEBUG_REPAIR_PLAYBOOK. |
| **etherweave-gui-ux** | UI design, PyQt6 layouts, thread safety, 10-button rule, CLI parity. |
| **etherweave-wireless** | Scan workflows, handshake capture, SSID/BSSID selection, wireless adapter integration. |
| **etherweave-security** | ValidationLayer, SudoCache, LootManager, input validation, auth, encryption. |
| **etherweave-architecture** | Refactors, ports/adapters, dependency rule, fitness functions. |
| **etherweave-checkpoint** | End of phase/milestone; run verify, commit, backup, WORKLOG, CONTEXT_PACK. |
| **etherweave-orchestrator** | Multi-step work; task decomposition and subagent assignment (no direct code edits). |

## Relation to repo prompts

These Cursor subagents align with the role prompts in `prompts/subagents/` (SUBAGENT_DEBUG_TEST, SUBAGENT_GUI_CLI_UX, SUBAGENT_WIRELESS_CAPTURE, SUBAGENT_ORCHESTRATOR, etc.). The Cursor agents use the same output format (Summary, Findings, Proposed Changes, Tests/Verification, Risks + Rollback, Open Questions) and reference the same docs (PROJECT_RULES, DEBUG_REPAIR_PLAYBOOK, ARCHITECTURE_BOUNDARIES, etc.).

## Skills (companion)

See `.cursor/skills/` for skills: **etherweave-load-context**, **etherweave-code-review**, **etherweave-checkpoint** (workflow guidance; subagents run the actual work in isolated context).
