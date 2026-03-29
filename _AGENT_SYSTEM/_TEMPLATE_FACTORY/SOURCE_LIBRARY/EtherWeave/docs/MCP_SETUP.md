# MCP Setup (Etherweave)

Workspace MCP servers are configured in **`.cursor/mcp.json`**. They extend the agent with security scanning, dependency analysis, documentation search, and (optionally) version control.

**When MCPs error:** See **docs/ENVIRONMENT_AND_MCP_MODEL.md** for how agents should behave (note once, continue with in-repo context). Per-server fixes: **docs/MCP_TROUBLESHOOTING.md**.

## Configured servers (workspace)

| Server | Purpose | Config |
|--------|---------|--------|
| **semgrep** | Scan code for security vulnerabilities; custom rules and AST. | **Local** `command`: `semgrep`, `args`: `["mcp"]` (remote deprecated) |
| **sentry** | Error tracking and performance monitoring context. | `streamable-http` → https://mcp.sentry.dev/mcp (OAuth in Cursor) |
| **socket-mcp** | Analyze and secure dependencies (supply chain). | `http` → https://mcp.socket.dev/ (key must be `socket-mcp`) |
| **ref** | Token-efficient documentation search. | `streamable-http` → https://api.staging-ref.tools/mcp (or api.ref.tools) |
| **jam** | Screen recorder with auto context for debugging and docs. | `streamable-http` → https://mcp.jam.dev/mcp |

- **Semgrep**: Use **local** MCP (`semgrep mcp`). Install: `pip install semgrep` or `brew install semgrep` (≥1.146.0). See `.cursor/rules/semgrep.mdc` and **docs/MCP_TROUBLESHOOTING.md**.
- **Sentry**: Requires **OAuth** in Cursor. If Sentry shows "errored" or 0 tools: Cursor Settings → MCP → Sentry → complete sign-in with your Sentry org.
- **Socket**: Key must be **`socket-mcp`**, type **`http`**, URL `https://mcp.socket.dev/`. Remove any old "socket" entry from Cursor MCP; reload Cursor. Tools/prompts/resources and auth links: **docs/SOCKET_MCP_CONFIG.md**.
- **Ref**: Staging URL in use; re-auth if you get 401, or try production URL (see **docs/MCP_TROUBLESHOOTING.md**).

## Optional: GitHub MCP

For PR/issue/codebase context inside Cursor:

1. **Requires**: Docker, `GITHUB_PERSONAL_ACCESS_TOKEN` (repo scope).
2. **Install**: [Cursor MCP Directory — GitHub](https://cursor.com/docs/context/mcp/directory) → Add GitHub → follow the install (Docker + env).
3. **Config** (add to `.cursor/mcp.json` or global Cursor MCP config):
   - Command: `docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server`
   - Set `GITHUB_PERSONAL_ACCESS_TOKEN` in env (never commit the token).

If you add GitHub at **user level** (Cursor Settings → MCP), it applies to all projects; workspace `.cursor/mcp.json` only lists project-specific servers.

## User-level MCPs (not in workspace mcp.json)

These are typically configured in **Cursor Settings → MCP** or **~/.cursor/mcp.json** (e.g. after installers). When they error, agents should continue with in-repo docs and context (see docs/ENVIRONMENT_AND_MCP_MODEL.md).

| Server                                               | Purpose                                | Setup                                                  |
| ---------------------------------------------------- | -------------------------------------- | ------------------------------------------------------ |
| **OpenMemory**                                       | Memory (search/add/list/update/delete) | docs/OPENMEMORY_SETUP.md — run installer with API key. |
| **Context7** (user-context7)                         | Up-to-date library docs                | User-level; may need sign-in/API key.                  |
| **OpenAI Developer Docs** (user-openaiDeveloperDocs) | OpenAI API docs                        | User-level; public docs usually need no key.           |

## Conflicts and precedence

- **Semgrep**: Project rule says "Always look first to any semgrep MCP servers for code security needs." Keep Semgrep; do not replace with another scanner for that role.
- **Context7**: You may have `user-context7` for up-to-date docs; **Ref** adds token-efficient doc search—use both when available.
- **Browser**: `cursor-ide-browser` and `cursor-browser-extension` are separate; no change needed.

## After adding or changing MCPs

1. Reload Cursor window (or restart Cursor) so MCP config is picked up.
2. Confirm in Cursor: Settings → Features → MCP → servers listed and enabled.
3. In chat, you can ask the agent to use a specific MCP (e.g. "run a Semgrep security check" or "search docs via Ref").

## Considered MCPs (analysis)

Full analysis: **docs/MCP_ANALYSIS.md**. Skipped (do not add): Browserbase, CodeSherlock, Corridor, Fluid Attacks, You.com.

- **Configured now:** Semgrep, Sentry, Socket, Ref, Jam. (Vale removed—CLI doesn’t speak MCP; see docs/MCP_LATER_INSTALLS.md for npx-based Vale if needed.)
- **Later installs (TODO + configs):** **docs/MCP_LATER_INSTALLS.md** — Bitrise, Browser Use, DBHub, Firecrawl, Harness, Playwright, Replicate, Zapier, Vault. Use the checklist and config snippets when you start mobile app, web app, non-SQLite DB, Harness, or Vault.

## References

- [Cursor MCP Directory](https://cursor.com/docs/context/mcp/directory)
- [Cursor MCP Overview](https://cursor.com/docs/context/mcp)
- **Analysis:** docs/MCP_ANALYSIS.md
- **Socket MCP (tools, auth, rules):** docs/SOCKET_MCP_CONFIG.md
- **Later installs (TODO + configs):** docs/MCP_LATER_INSTALLS.md
- Project rules: `.cursorrules`, `.cursor/rules/semgrep.mdc`, `AGENTS.md`

**Sentry (errored / 0 tools):** Complete OAuth in Cursor: Settings → MCP → Sentry → sign in with your Sentry organization. Until then, listOfferings may show 0 tools and "fetch failed".

**Socket (0 tools / not configured):** In `mcp.json` use key **`socket-mcp`** (not `socket`), `"type": "http"`, URL `https://mcp.socket.dev/`. Reload Cursor. See **docs/MCP_TROUBLESHOOTING.md** for full fixes.

**All MCP errors:** See **docs/MCP_TROUBLESHOOTING.md** for per-server resolution (Semgrep local, Sentry OAuth, Ref 401, etc.).
