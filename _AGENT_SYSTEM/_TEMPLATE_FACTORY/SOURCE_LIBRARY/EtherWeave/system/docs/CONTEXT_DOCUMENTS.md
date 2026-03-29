# Context Documents (All AI Coding Tools & Agents)

Key documents to load for full context. Multiple tools (Cursor, Codex, Gemini, Claude, Windsurf, etc.) may work on this repo in turn; each should use the same load order and handoff docs. Use these for IDE/agent context, @-mentions, or "load master architectural systems now!".

## Load order (binding)

When loading full context, use this order (see `system/docs/AI_CONTEXT_INDEX.md` and `AGENTS.md`). System assets under system/; see system/README.md.

1. **system/prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md** — Master prompt and constraints
2. **system/docs/AI_CONTEXT_INDEX.md** — Index and load order
3. **system/docs/KERNEL_CONTRACT.md** — Definition of done, WBS, verification
4. **system/docs/DEBUG_REPAIR_PLAYBOOK.md** — Failure triage and fix procedure
5. **system/docs/PHASE_CHECKPOINT_PROTOCOL.md** — Checkpoint steps
6. **PROJECT_RULES.md** — Project rules (or root **.cursorrules**)
7. **MASTER_AI_REFERENCE.md** — Architecture and patterns
8. **system/docs/CONTEXT_GUIDE.md** — Context guidance
9. **system/docs/ARCHITECTURE_BOUNDARIES.md** — Dependency rule and layers
10. **system/docs/ARCHITECTURE_FITNESS_FUNCTIONS.md** — Fitness checks
11. **system/prompts/CURSOR_CONTEXT_GUIDE.md** — Cursor reload guide
12. **system/docs/CURSOR_NEXUS.md** — Skills, Commands, Subagents, Rules
13. **AGENTS.md** — Agent contract and load order
14. **system/docs/SUBAGENT_PROTOCOL.md** — Subagent usage
15. **system/docs/SUBAGENT_REGISTRY.md** — Subagent list
16. **docs/SESSION_STATE.md** — Where we left off
17. **system/docs/ENVIRONMENT_AND_MCP_MODEL.md** — Environment vs MCP, graceful degradation when MCPs error

## Cursor-specific

- **docs/APP_VS_SYSTEM_FILES.md** — App payload vs model/cursor system files; installer and app bundle.
- **docs/ALIASES.md** — Alias reference: slash commands and chat phrases for load master, load sys, load context, load rules.
- **system/docs/CURSOR_NEXUS.md** — When to use Skills, Commands, Subagents, Rules
- **docs/CURSOR_SETUP.md** — Extensions, settings, conflicts
- **system/docs/ENVIRONMENT_AND_MCP_MODEL.md** — Environment and MCP model; behavior when MCPs error
- **docs/MCP_SETUP.md** — MCP servers; when to use each; conflicts
- **docs/MCP_ANALYSIS.md** — Analysis of candidate MCPs (use / add later / skip)
- **docs/MCP_LATER_INSTALLS.md** — TODO and config snippets for later installs (Bitrise, Playwright, DBHub, etc.)
- **QUICK_START_CURSOR.md** — 3-step Cursor quick start
- **.cursor/rules/README.md** — Rules index
- **.cursor/skills/README.md** — Skills index
- **.cursor/commands/README.md** — Commands index
- **.cursor/agents/README.md** — Subagents index

## Database and install
- **system/docs/DATABASE_AND_INSTALL_ARCHITECTURE.md** — Distribution-first DB and install (no hardcoded users; user data dir; setup_data; legacy handling). Use when changing DB paths, install, or adding PostgreSQL.

## Multi-tool awareness
- **system/docs/MULTI_AGENT_AND_TOOL_AWARENESS.md** — This repo is developed by multiple AI coding tools (Cursor, Codex, Gemini, Claude, Windsurf) that take turns. Shared rules, handoff protocol, and what to update when your turn ends so the next tool can continue.

## Do not ignore

Ensure these are **not** in `.cursorignore` so Cursor can index and use them:

- AGENTS.md, PROJECT_RULES.md, .cursorrules
- system/docs/AI_CONTEXT_INDEX.md, system/docs/CURSOR_NEXUS.md, system/docs/CONTEXT_DOCUMENTS.md, system/docs/DATABASE_AND_INSTALL_ARCHITECTURE.md, system/docs/MULTI_AGENT_AND_TOOL_AWARENESS.md, system/docs/ENVIRONMENT_AND_MCP_MODEL.md
- docs/MCP_SETUP.md, docs/MCP_ANALYSIS.md, docs/MCP_LATER_INSTALLS.md
- system/docs/KERNEL_CONTRACT.md, system/docs/DEBUG_REPAIR_PLAYBOOK.md, system/docs/PHASE_CHECKPOINT_PROTOCOL.md
- system/prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md, system/prompts/CURSOR_CONTEXT_GUIDE.md
- .cursor/rules/*.mdc, .cursor/skills/**/SKILL.md, .cursor/commands/*.md, .cursor/agents/*.md

## Adding to Cursor Settings

In **Cursor Settings → Rules**, ensure project rules are enabled so the agent gets `.cursor/rules/` (including `cursor-context-documents.mdc`, which references this file). The load order is in `AGENTS.md` and `system/docs/AI_CONTEXT_INDEX.md`; this file is a concise checklist and "do not ignore" reminder for `.cursorignore`.
