# Ledger Loop — MCP (Model Context Protocol) Config Reference

**Purpose:** MCP setup used for LedgerLoop development, while keeping compatibility with other apps that share the same global AI tooling.

---

## Multi-app strategy

Use **two layers**:

1. **Global MCP config** (`~/.cursor/mcp.json`, `~/.codex/config.toml`) for shared servers across apps.
2. **Project MCP config** (`LedgerLoop/.cursor/mcp.json`) for LedgerLoop-only servers.

This prevents cross-app breakage and allows LedgerLoop-specific servers to be namespaced.

---

## Current LedgerLoop MCP entries

### 1) Project-level Cursor MCP (LedgerLoop only)

File: `LedgerLoop/.cursor/mcp.json`

```json
{
  "mcpServers": {
    "ledgerloop-filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/whyte/.MyAppZ/LedgerLoop"]
    }
  }
}
```

### 2) Global Cursor MCP (shared + namespaced LedgerLoop)

File: `~/.cursor/mcp.json`

- Keep shared servers (`openaiDeveloperDocs`, `context7`, etc.).
- Add a **namespaced** LedgerLoop server (`ledgerloop-filesystem`) so other apps are unaffected.

### 3) Codex MCP config

File: `~/.codex/config.toml`

- Project trust entry:
  - `[projects."/home/whyte/.MyAppZ/LedgerLoop"]`
- MCP server entry:
  - `[mcp_servers.ledgerloop_filesystem]`

---

## Recommended MCP capabilities for LedgerLoop

| MCP / capability | Purpose | Priority |
|------------------|---------|----------|
| Filesystem (`ledgerloop-filesystem`) | Safe project-scoped file access | High |
| Web docs (`openaiDeveloperDocs`, `context7`) | Up-to-date docs lookup | High |
| PostgreSQL (optional) | Schema/data diagnostics | Medium |
| Git (optional) | History/status tooling via MCP | Medium |

---

## Validation commands

Use these after MCP edits:

```bash
jq -e . ~/.cursor/mcp.json
jq -e . /home/whyte/.MyAppZ/LedgerLoop/.cursor/mcp.json
python3 - <<'PY'
import tomllib, pathlib
tomllib.loads(pathlib.Path('/home/whyte/.codex/config.toml').read_text())
print('codex toml ok')
PY
```

---

## Troubleshooting

- If MCP tools do not appear in-session, restart the IDE/agent session after config updates.
- If a global MCP fails, disable only that server entry; keep project-level LedgerLoop server intact.
- Avoid embedding secrets in repo files. Keep API keys in user-level config or env vars.

---

*MCP config reference is in `_system/MCP_CONFIG.md`. Application code is in `src/`.*
