# Cursor Commands (Etherweave)

Custom slash commands for Cursor. Type **`/`** in Agent chat to see and run them. Anything you type after the command name is passed as additional context to the agent.

## Commands

### Alias shortcuts (short names)

| Alias | Same as | Purpose |
|-------|--------|--------|
| **/ctx** | /load-context | Load master prompt, context, and rules. |
| **/sys** | — | Load system prompt + core files only (MASTER_SYSTEM_PROMPT, AGENTS, KERNEL_CONTRACT, PROJECT_RULES, ENVIRONMENT_AND_MCP). |
| **/rules** | — | Load CURSOR_NEXUS and rules (Skills, Commands, Subagents, Rules). |
| **/session** | /session-start | New session: load context, confirm readiness. |

### Full commands

| Command | Purpose |
|--------|--------|
| **/load-master** | Full load order (AGENTS.md 1–18). Same as "load master architectural systems now!". |
| **/load-sys** | Same as /load-master: system files, context, rules, master prompt. |
| **/load-context** | Load master prompt and rules in canonical order (AGENTS.md / AI_CONTEXT_INDEX). |
| **/load-rules** | Load CURSOR_NEXUS + rules index only (lighter; no full doc set). |
| **/code-review** | Review code against PROJECT_RULES and architecture; report Critical/Suggestion/Nice to have. |
| **/checkpoint** | Run phase checkpoint: verify, commit, push, backup, CONTEXT_PACK, session log. |
| **/verify** | Run tools/verify.sh (and secrets scan if available) before push or checkpoint. |
| **/commit-message** | Generate conventional commit message for staged (or unstaged) changes. |
| **/debug** | Follow DEBUG_REPAIR_PLAYBOOK for current failure or error. |
| **/pyqt6-rules** | Apply PyQt6 layout and threading rules to current/specified GUI code. |
| **/one-step** | Scope next response to a single step (or two tightly-related steps). |
| **/run-tests** | Run project tests and report exact command and output. |
| **/security-check** | Check code for ValidationLayer, SudoCache, LootManager, secrets, auth. |
| **/architecture-review** | Check code for Clean Architecture and boundary compliance. |
| **/use-subagent** | Delegate to the best-fit Etherweave subagent (or named subagent). |
| **/apply-skill** | Apply the best-fit Etherweave or Cursor skill (or named skill). |
| **/create-commands** | Instructions for creating new slash commands in this project. |
| **/session-start** | Start new session: load context, confirm Rules/Skills/Commands/Subagents ready. |

## Aliases

**docs/ALIASES.md** — Table of slash commands and chat aliases (e.g. "load master", "load sys", "load context", "load rules") so you can use short names for commonly run instructions.

## Reference

- **projectcommand.md** — Long list of @-style project commands (copy into Cursor Settings → Features → Project Commands if used there).
- **projectsystemprompt.md** — Project system prompt (use `/projectsystemprompt` if configured in Settings).
- **Skills** — `.cursor/skills/` (e.g. etherweave-load-context, etherweave-code-review).
- **Subagents** — `.cursor/agents/` (e.g. etherweave-code-reviewer, etherweave-debugger).
- **Rules** — `.cursor/rules/` (always-apply and file-scoped rules).

## Adding commands

1. Create a new `.md` file in `.cursor/commands/`.
2. The **filename** (without .md) becomes the slash command (e.g. `my-command.md` → `/my-command`).
3. The **content** is the instruction/prompt sent to the agent when the command is run.
4. Commands appear automatically when you type `/` in chat (project and global `~/.cursor/commands/`).
