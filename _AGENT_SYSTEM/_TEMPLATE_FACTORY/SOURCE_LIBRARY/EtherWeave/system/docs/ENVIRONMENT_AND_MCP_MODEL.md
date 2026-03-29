# Environment and MCP Model (Etherweave)

Single source of truth for **environment**, **MCP (Model Context Protocol)**, and how agents and operators should behave when things error or are missing. Use this so MCP/context/OpenMemory issues don’t block progress and the system stays predictable.

---

## 1. What “environment” means here

| Layer | What it is | Where it’s defined / fixed |
|--------|------------|-----------------------------|
| **Cursor session** | DBUS, XDG_RUNTIME_DIR, keyring (KWallet), DISPLAY, sandbox | Terminal/shell that starts Cursor; `scripts/ensure_kde_env.sh` |
| **Repo / app** | Python venv, deps, DB path, config files | `requirements.txt`, `launch_app.sh`, `~/.etherweave/` |
| **MCP** | Servers (workspace + user-level) and their API keys / OAuth | `.cursor/mcp.json` (workspace), Cursor Settings → MCP (user), `~/.cursor/mcp.json` (user) |

- **Cursor “environment issues”** (keyring, DBUS, launch from `~`) → **docs/KDE_KEYRING_AND_ENVIRONMENT.md** and **scripts/ensure_kde_env.sh**.
- **App launch** (GUI / Pro API / CLI) → **docs/FRAMEWORK_AND_LAUNCH.md** and **launch_app.sh**.

---

## 2. MCP: workspace vs user-level

### Workspace (in `.cursor/mcp.json`)

Configured in this repo; Cursor merges with user-level config.

| Server | Purpose | If it errors |
|--------|---------|----------------|
| **semgrep** | Security scans (use first for code/commands) | Local: need `semgrep` on PATH. See docs/MCP_TROUBLESHOOTING.md. |
| **sentry** | Error/monitoring context | OAuth in Cursor Settings → MCP → Sentry. |
| **socket-mcp** | Dependencies / supply chain | Key must be `socket-mcp`, type `http`. Reload Cursor. |
| **ref** | Doc search | 401 → re-auth or try production URL. |
| **jam** | Debug context | Network/logs; disable if not needed. |

### User-level (not in workspace `mcp.json`)

Often configured in **Cursor Settings → MCP** or **~/.cursor/mcp.json** (e.g. after running an installer). They **often require API keys or OAuth**; when missing or wrong, they can show as “errored” or 0 tools.

| Server | Purpose | Setup / when it errors |
|--------|--------|-------------------------|
| **OpenMemory** | Memory (search/add/list/update/delete) | `npx @openmemory/install --client cursor --env OPENMEMORY_API_KEY=...`. See docs/OPENMEMORY_SETUP.md. |
| **Context7** (user-context7) | Up-to-date library docs and examples | User-level config; may need sign-in/API key depending on provider. |
| **OpenAI Developer Docs** (user-openaiDeveloperDocs) | Fetch OpenAI API docs | User-level; public docs usually need no key. |

**Important:** If OpenMemory, Context7, or OpenAI Developer Docs keep erroring, fix them at **user level** (Cursor Settings, `~/.cursor/mcp.json`, installers). Do **not** block repo work on them; see “Agent behavior when MCPs error” below.

---

## 3. Agent behavior when MCPs error

- **Use MCPs when they help** (Semgrep for security, Ref/Context7 for docs, OpenMemory for memory).
- **If an MCP call fails or a server shows “errored”:**
  - Note it **once** in the response (e.g. “OpenMemory/Ref returned an error; using in-repo docs and context instead”).
  - **Continue** with in-repo sources (docs/, code, MASTER_AI_REFERENCE, etc.). Do **not** retry repeatedly or block the task.
- **Never** make progress depend on a single MCP being available. Prefer in-repo docs and code when in doubt.
- **Session continuity:** If the user says “MCPs keep erroring”, point them to this doc and to **docs/MCP_TROUBLESHOOTING.md** and **docs/OPENMEMORY_SETUP.md** for setup; then proceed with the task using the repo.

---

## 4. Bootstrap and “fix environment” checklist

For **operators** (to reduce “environment issues” and MCP noise):

1. **Cursor session (KDE/keyring):**
   From a terminal in your KDE session:
   `cd ~ && source ~/.cursor/etherweave/scripts/ensure_kde_env.sh && cursor --no-sandbox`
   If keyring or MCP auth still fails, run
   `cursor --password-store="gnome-libsecret" --no-sandbox`. If that fixes it, persist: **Command Palette → Preferences: Configure Runtime Arguments** → add `"password-store": "gnome-libsecret"` to argv.json.
   (See docs/KDE_KEYRING_AND_ENVIRONMENT.md and [VS Code keychain troubleshooting](https://code.visualstudio.com/docs/configure/settings-sync#_troubleshooting-keychain-issues).)

2. **After changing MCP config:**
   Reload Cursor (Developer: Reload Window) so workspace and user MCPs are re-read.

3. **OpenMemory:**
   Run the installer with your API key; reload Cursor. If it still errors, use in-repo context and memory in openmemory.md.

4. **Context7 / OpenAI Developer Docs:**
   Configure at user level; if they error, use in-repo docs and MASTER_AI_REFERENCE.

5. **App launch:**
   Use `launch_app.sh api|gui|cli` from repo or `~/.cursor/etherweave/launch_app.sh` from anywhere.

6. **Mypy cache errors** (e.g. “No such file or directory … .mypy_cache/…”):
   Stale or corrupted cache. From repo root: `rm -rf .mypy_cache`. Re-run mypy; it will recreate the cache.

---

## 5. References (one place)

| Topic | Document |
|--------|----------|
| Keyring, DBUS, launch from ~, password-store, argv.json | docs/KDE_KEYRING_AND_ENVIRONMENT.md |
| PyQt6 vs FastAPI, launch app | docs/FRAMEWORK_AND_LAUNCH.md |
| MCP list and config | docs/MCP_SETUP.md |
| MCP errors (per server) | docs/MCP_TROUBLESHOOTING.md |
| OpenMemory setup | docs/OPENMEMORY_SETUP.md |
| Memory rules (Cursor) | .cursor/rules/openmemory.mdc |
| Project memory index | openmemory.md |

---

## 6. Goals this supports

- **Etherweave:** World-class wireless security assessment and monitoring platform (authorized use, clean architecture, PyQt6 + optional FastAPI).
- **Environment model:** Clear split between session, repo, and MCP; predictable behavior when something fails.
- **MCP:** Enhance when available; never block. Prefer in-repo context when MCPs error.

---

**Last updated:** 2026-02-05
