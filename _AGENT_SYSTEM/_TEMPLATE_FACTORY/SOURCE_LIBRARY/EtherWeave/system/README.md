# System Directory — Build System (Separate from Application)

This directory holds **everything that defines how we design, architect, program, and build** the application. It is **logically separate** from the application code that actually runs (which lives in `etherweave/`, `tools/`, `scripts/`, `tests/`, launchers, etc.).

## Purpose

- **Application code** (outside this directory): runs the app — GUI, CLI, API, lib, tests, install, launch.
- **System content** (this directory): used by humans and agents (Cursor/Codex) for context, load order, rules, prompts, and governance. The app does **not** import or read these at runtime.

## Layout

| Path | Contents |
|------|----------|
| **system/prompts/** | Master system prompt, context guides, prompt packs, subagent prompts. |
| **system/docs/** | Governance and context: load order index, kernel contract, debug playbook, phase checkpoint, architecture boundaries/fitness, Cursor nexus, subagent protocol/registry, environment and MCP model, context documents, changelog. |

## Root Entry Points (unchanged for compatibility)

These remain at **repo root** so tools and agents that expect them still work:

- **AGENTS.md** — Load order and agent contract (points to system/prompts/ and system/docs/ in the list).
- **PROJECT_RULES.md** — Project rules.
- **MASTER_AI_REFERENCE.md** — Architecture reference.
- **.cursor/** — Cursor rules, skills, commands, agents (IDE reads from root).

## Load Order

When loading full context, use **AGENTS.md** at repo root; its load order references:

- `system/prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md`
- `system/docs/AI_CONTEXT_INDEX.md`
- `system/docs/KERNEL_CONTRACT.md`
- … (see AGENTS.md for the full list)

## See Also

- **docs/APP_VS_SYSTEM_FILES.md** — App payload vs system files; installer and app bundle.
- **docs/BACKUP_BRANCHES.md** — Backup and system-files branches (do not merge into main).
