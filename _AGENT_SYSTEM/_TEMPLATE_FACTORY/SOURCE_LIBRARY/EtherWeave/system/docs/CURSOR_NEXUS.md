# Cursor Nexus — Skills, Commands, Subagents, Rules

Single reference for Cursor Agent context: **Skills**, **Commands**, **Subagents**, and **Rules**. Use this so the agent applies the right asset automatically and persistently.

## How Cursor applies these

| Asset | Location | When applied |
|-------|----------|--------------|
| **Rules** | `.cursor/rules/*.mdc` (and `.md`) | Always Apply, or when file matches globs, or when agent decides from description. |
| **Skills** | `.cursor/skills/<name>/SKILL.md` | When agent decides from description; or when user types `/skill-name` in chat. |
| **Commands** | `.cursor/commands/*.md` | When user types `/command-name` in chat (filename without .md = command). |
| **Subagents** | `.cursor/agents/*.md` | When user asks to "use X subagent" or agent delegates; each runs in isolated context. |

**Precedence**: Rules are always-on (or file-scoped). Skills and commands extend behavior; use them when the task matches. Subagents are invoked explicitly or by delegation for focused tasks.

---

## Skills (`.cursor/skills/`)

Apply when the task matches; or invoke via `/skill-name` in chat if Cursor supports it.

| Skill | Use when |
|-------|----------|
| etherweave-load-context | "Load master architectural systems now!", new session, context reset. |
| etherweave-code-review | Code review, PR review, compliance with PROJECT_RULES and architecture. |
| etherweave-checkpoint | End of phase/milestone; user says checkpoint. |
| etherweave-commit-messages | Generate conventional commit message for staged/unstaged changes. |
| etherweave-debug-playbook | Build/crash/regression/test failure; follow DEBUG_REPAIR_PLAYBOOK. |
| etherweave-pyqt6-rules | Adding or changing GUI widgets, tabs, dialogs, workers. |
| etherweave-verify-gate | Before push or checkpoint; run tools/verify.sh. |
| cursor-task-scoping | User wants one step per response; scope work into atomic steps. |
| cursor-decision-helper | Uncertain which asset to use; decision tree for skill/command/subagent/rule. |

See `.cursor/skills/README.md` for full list and trigger terms.

---

## Commands (`.cursor/commands/`)

User types `/` in Agent chat and selects a command. Content of the command file is sent as context.

| Command | Purpose |
|---------|--------|
| /load-master | Full load order (AGENTS.md 1–18). Same as "load master architectural systems now!". |
| /load-sys | Same as /load-master (system files, context, rules, master prompt). |
| /load-context | Load master prompt and rules in order. |
| /load-rules | Load CURSOR_NEXUS + rules index only (lighter). |
| /code-review | Review code against PROJECT_RULES and architecture. |
| /checkpoint | Run phase checkpoint protocol. |
| /verify | Run tools/verify.sh before push/checkpoint. |
| /commit-message | Generate conventional commit message. |
| /debug | Follow DEBUG_REPAIR_PLAYBOOK for current failure. |
| /pyqt6-rules | Apply PyQt6 rules to current/specified GUI code. |
| /one-step | Scope next response to one step. |
| /run-tests | Run tests and report output. |
| /security-check | Check ValidationLayer, SudoCache, LootManager, secrets. |
| /architecture-review | Check Clean Architecture and boundaries. |
| /use-subagent | Delegate to best-fit or named subagent. |
| /apply-skill | Apply best-fit or named skill. |
| /create-commands | How to create new slash commands. |
| /session-start | Start new session: load context, confirm Rules/Skills/Commands/Subagents ready. |

See `.cursor/commands/README.md` for full list. **Aliases:** `docs/ALIASES.md` — short names for "load master", "load sys", "load context", "load rules".

---

## Subagents (`.cursor/agents/`)

Invoke by asking the agent to "use the etherweave-X subagent to …". Each has a focused system prompt and output format (Summary, Findings, Proposed Changes, Tests/Verification, Risks + Rollback, Open Questions).

| Subagent | Use when |
|----------|----------|
| etherweave-code-reviewer | Code review, compliance check. |
| etherweave-debugger | Build/crash/regression/test failure. |
| etherweave-gui-ux | UI design, PyQt6 layouts, CLI parity. |
| etherweave-wireless | Scan workflows, capture, SSID/BSSID. |
| etherweave-security | ValidationLayer, SudoCache, LootManager, auth. |
| etherweave-architecture | Refactors, ports/adapters, fitness functions. |
| etherweave-checkpoint | Run phase checkpoint. |
| etherweave-orchestrator | Task decomposition and subagent assignment. |

See `.cursor/agents/README.md` and `docs/SUBAGENT_REGISTRY.md`.

---

## Rules (`.cursor/rules/`)

Always-apply and file-scoped rules. No manual invocation; Cursor includes them in context per configuration.

**Always-apply**: cursor-output-and-steps, cursor-definition-of-done, cursor-architecture-boundaries, cursor-design-before-code, cursor-debug-repair, cursor-decision-and-safety, etherweave-security-auth, etherweave-verification-gate, etherweave-context-load, etherweave-single-instance-parity, etherweave-checkpoint-protocol, etherweave-environment-mcp, openmemory.mdc, semgrep.mdc.

**File-specific**: python-standards (`**/*.py`), etherweave-pyqt6 (`**/gui/**/*.py`, `etherweave/gui/**/*.py`).

See `.cursor/rules/README.md` for full list and globs.

---

## MCP (Model Context Protocol)

**Model and behavior when MCPs error:** **docs/ENVIRONMENT_AND_MCP_MODEL.md** — note once, continue with in-repo context; never block on MCP availability. Rule: **etherweave-environment-mcp**.

Workspace MCP servers (`.cursor/mcp.json`): **Semgrep** (security — use first), **Sentry**, **Socket**, **Ref**, **Jam**. User-level (Cursor Settings / ~/.cursor/mcp.json): **OpenMemory**, **Context7**, **OpenAI Developer Docs** — see docs/OPENMEMORY_SETUP.md and docs/MCP_TROUBLESHOOTING.md. Full setup: **docs/MCP_SETUP.md**. Later installs: **docs/MCP_LATER_INSTALLS.md**.

---

## When to use what

- **Need a checklist or procedure?** → Use the matching **skill** (e.g. code-review, checkpoint, verify-gate) or run the **command** (e.g. /code-review, /checkpoint, /verify).
- **Need a focused review or fix in isolation?** → Invoke a **subagent** (e.g. etherweave-debugger, etherweave-code-reviewer).
- **Need persistent behavior every session?** → That behavior should be in **rules** (already in .cursor/rules). Do not duplicate rule content in skills/commands; reference the rule or doc instead.
- **Conflict?** Rules take precedence for always-on behavior. Skills and commands add on top; subagents run in isolated context. Keep rules and skills aligned (e.g. checkpoint protocol in both rules and etherweave-checkpoint skill) so behavior is consistent.

---

## Load order and this nexus

When loading master context (e.g. "load master architectural systems now!" or new session):

1. Follow the load order in `docs/AI_CONTEXT_INDEX.md` (or `AGENTS.md`).
2. After loading prompts and docs, the agent should be aware of this nexus: **docs/CURSOR_NEXUS.md** — and thus of Skills, Commands, Subagents, and Rules and when to use them.
3. Optionally load this file explicitly in the load order for Cursor-only sessions so the agent always has the map.

---

## Context documents

- **Load order and checklist**: `system/docs/CONTEXT_DOCUMENTS.md` — key docs to load and "do not ignore" list for `.cursorignore`.
- **Rule**: `.cursor/rules/cursor-context-documents.mdc` — always-apply; references CONTEXT_DOCUMENTS and load order.

## Setup and conflicts

- **Setup**: See `docs/CURSOR_SETUP.md` for recommended extensions, settings, session start, and how to ensure Rules/Skills/Commands/Subagents work without conflict. If `.vscode/extensions.json` or `.vscode/settings.json` exist, keep them aligned (one Python extension; no conflicting rules).
- **Conflicts**: Rules are complementary; do not add a rule that contradicts an always-apply rule. Keep skills and rules aligned (e.g. checkpoint, verify, code-review). Use one primary Python extension (Cursor Python or Pylance), not both if they conflict.

## Dual-agent parity

When you change AGENTS.md, project rules, or the load order:

- Keep `.cursor/rules/` and AGENTS.md semantically aligned.
- Update this nexus if you add/remove skills, commands, or subagents.
- Update `.cursor/skills/README.md`, `.cursor/commands/README.md`, `.cursor/agents/README.md`, and `docs/SUBAGENT_REGISTRY.md` so they stay in sync with this document.
