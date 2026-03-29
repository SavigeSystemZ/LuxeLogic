# Source Manifest

Factory-only asset. This manifest records provenance for template construction and is not part of installed AIAST operation inside application repos.

This manifest records the copied source material used to build the consolidated operating system.

## Source repos and copied scope

### CandleCompass

- Copied files: 118
- Copied scope:
  - `CLAUDE.md`
  - `.cursorrules`
  - `.cursor/mcp.json`
  - `assistant/` excluding `assistant/logs/`

### EtherWeave

- Copied files: 122
- Copied scope:
  - `AGENTS.md`
  - `AGENTS.override.md`
  - `.cursorrules`
  - `.cursor/`
  - `.cursor_context/mcp.json`
  - `CURSOR_SYSTEM_PROMPT.md`
  - `CURSOR_USER_RULE.md`
  - `CURSOR_CONTEXT_URLS.txt`
  - `GEMINI.md`
  - `.github/copilot-instructions.md`
  - `PROJECT_RULES.md`
  - `TODO.md`
  - `Cursor.todo`
  - `docs/CONTEXT_PACK.md`
  - `docs/CURSOR_AND_MCP_SETUP.md`
  - `docs/MCP_ANALYSIS.md`
  - `docs/MCP_LATER_INSTALLS.md`
  - `docs/MCP_SETUP.md`
  - `docs/MCP_TROUBLESHOOTING.md`
  - `docs/SOCKET_MCP_CONFIG.md`
  - `docs/TODO_TRACKING.md`
  - `system/`

### IdeaForge

- Copied files: 45
- Copied scope:
  - `AGENTS.md`
  - `.cursorrules`
  - `TODO.md`
  - `system/design-docs/AGENTS.md`
  - `system/ai-governance/`

### LedgerLoop

- Copied files: 21
- Copied scope:
  - `AGENT_CONTEXT.md`
  - `AI_AGENT_COORDINATION.md`
  - `.cursorrules`
  - `.cursor/mcp.json`
  - `PROMPT_PACK_GEMINI.md`
  - `TODO.md`
  - `_system/`

## Duplicate filename hotspots

The most meaningful duplicate names across source repos were:

- `AGENTS.md`
- `.cursorrules`
- `MASTER_SYSTEM_PROMPT.md`
- `PROJECT_RULES.md`
- `README.md`
- `TODO.md`
- `SKILL.md`
- `mcp.json`

These duplicates were merged into the canonical operating system under `TEMPLATE/`.

## Intentional exclusions

- Machine-local or permission-only files such as `CandleCompass/.claude/settings.local.json`
- User-level global configs with embedded secrets or tokens
- Log directories and generated runtime history that do not define agent behavior
- Application runtime code that implements AI features inside the app itself rather than governing how agents work on the repo

## Factory-only donor assessment

Additional donor assessment now lives under `_TEMPLATE_FACTORY/GOLDEN_EXAMPLES/`. That scorecard informs the neutral golden-example pack but does not change the copied-source inventory unless raw source material is explicitly imported into `SOURCE_LIBRARY/`.

## Totals

- Source files copied into `_TEMPLATE_FACTORY/SOURCE_LIBRARY/`: 306
- Canonical operating-system files created in `TEMPLATE/`: 264
