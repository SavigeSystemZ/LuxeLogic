# Cursor, Todo Tree, ShellCheck & MCP Setup

This doc describes how ShellCheck, Todo Tree, Cursor todo files, and MCP tools are configured and what (if any) login or setup you need.

---

## 1. ShellCheck (shell script static analysis)

- **What**: [ShellCheck](https://github.com/koalaman/shellcheck#installing) lints bash/sh scripts for common bugs and portability issues.
- **Install (Debian/Ubuntu/Kubuntu)**:
  ```bash
  sudo apt install shellcheck
  ```
  Other distros: see [Installing](https://github.com/koalaman/shellcheck#installing) (e.g. `dnf install ShellCheck`, `pacman -S shellcheck`, `brew install shellcheck`).
- **Usage**:
  - **CLI**: `shellcheck -s bash script.sh`
  - **Verify gate**: `./tools/verify.sh` runs ShellCheck on key scripts when `shellcheck` is in PATH (optional; verify still passes if ShellCheck is missing or reports issues). Fix ShellCheck warnings over time; `install.sh` is large and may have many reports.
  - **CI**: `.github/workflows/ci.yml` installs ShellCheck and runs it on `tools/verify.sh`, `tools/deps_check.sh`, `tools/secrets_scan.sh`, `tools/python_sanity.sh`, `install.sh`.
- **Editor**: Install the **ShellCheck** extension (`timonwong.shellcheck`) for inline feedback; `install_cursor_extensions.sh` installs it via Cursor CLI if available.
- **Login/setup**: None. ShellCheck and the extension work offline.

---

## 2. Todo Tree (TODO/FIXME/Markdown tasks)

- **What**: [Todo Tree](https://github.com/Gruntfuggly/todo-tree#markdown-support) uses ripgrep to find TODO/FIXME/BUG/etc. and Markdown task lists (`- [ ]`, `- [x]`), and shows them in a tree view.
- **Install (extension)**:
  - In Cursor: Extensions → search **Todo Tree** → Install, or
  - CLI: `cursor --install-extension gruntfuggly.todo-tree`
  - `install_cursor_extensions.sh` includes `gruntfuggly.todo-tree`.
- **Workspace config**: `.vscode/settings.json` (in repo) sets:
  - **Tags**: `BUG`, `HACK`, `FIXME`, `TODO`, `XXX`, `[ ]`, `[x]`
  - **Markdown**: regex `(//|#|<!--|;|/\*|^|^[ \t]*(-|\d+\.)\s*)($TAGS)` so Markdown list items like `- [ ]` and `1. [x]` are picked up.
  - **Excludes**: `node_modules`, `.venv`, `venv`
  - **Highlights**: BUG/FIXME and `[ ]`/`[x]` use project colors; status bar shows tag counts.
- **Login/setup**: None. Todo Tree uses the workspace and ripgrep; no account required.

---

## 3. Cursor todo files and conventions

- **Convention**: Cursor and agents may refer to:
  - **`docs/SESSION_STATE.md`** – current session, next steps, milestones (see AGENTS.md).
  - **`WORKLOG.md`** – work log; checkpoint summaries go here.
  - **`docs/CHANGELOG_REFAC.md`** – refactor/phase log.
  - A **Cursor.todo** or **TODO.md** in the repo root can hold a short, current task list; agents can read/update it if present.
- **This repo**: `TODO.md` in the repo root holds a short current task list and uses `- [ ]` / `- [x]` so Todo Tree lists them. Agents and checkpoints use `docs/SESSION_STATE.md` and `WORKLOG.md`; you can sync high-level items here for visibility.
- **No login**: Todo files are local; no Cursor account needed for them.

---

## 4. MCP tools (this workspace)

**Config:** `.cursor/mcp.json`. Full list and when to use: **docs/MCP_SETUP.md**. Later installs (TODO + configs): **docs/MCP_LATER_INSTALLS.md**.

MCP servers known to this project (from the Cursor project’s MCP config, e.g. under `mcps/` or Cursor settings):

| MCP / Extension   | Purpose                         | Login / setup |
|-------------------|----------------------------------|---------------|
| **cursor-ide-browser** | In-app browser (navigate, snapshot, click, etc.) | None. Lock/unlock workflow: navigate → lock → interact → unlock. |
| **cursor-browser-extension** | Browser automation for frontend/testing        | None. Use when testing web/frontend. |
| **project-0-etherweave-semgrep** | Semgrep rules for this project          | None. Use for security/code scanning (see .cursorrules: “semgrep” / “security_check”). |
| **user-context7** | Up-to-date docs/code examples for libraries     | May require sign-in or API key depending on Context7 config; check Cursor MCP settings. |
| **user-openaiDeveloperDocs** | Fetch OpenAI API docs                    | None for public docs. |
| **Workspace MCPs** (see docs/MCP_SETUP.md): **semgrep**, **sentry**, **socket**, **ref**, **jam**. Leverage: Semgrep (security), Ref (doc search), Jam (debug). Vale was removed from project config because the `vale` CLI does not speak MCP; use an npx-based Vale MCP if needed (see docs/MCP_LATER_INSTALLS.md). |

- **If an MCP asks you to log in**: Do so in the UI it provides (e.g. Cursor’s MCP panel or browser). We don’t store credentials in this repo.
- **Leverage**: Semgrep for security scans; Ref for doc search; Jam for debug context.
- **If an extension asks for setup**: Follow its own instructions (e.g. ShellCheck: install binary; Todo Tree: install extension and use `.vscode/settings.json`).

### 4.1 All MCPs show as error

- **Restart Cursor fully** (quit the app and reopen the project). MCP config is loaded at startup; a full restart often clears transient errors.
- **Remove or fix invalid entries** in `.cursor/mcp.json` (project) and `~/.cursor/mcp.json` (user). A single bad server (e.g. a `command` that doesn’t speak MCP, or a wrong URL) can cause Cursor to report failures. The Vale entry was removed from this project because the `vale` binary is a linter, not an MCP server.
- **Check network** if all servers are HTTP: ensure you can reach the endpoints (e.g. `https://api.openmemory.dev`, `https://mcp.semgrep.ai`, `https://mcp.context7.com`). VPN/firewall can block Cursor’s MCP client.
- **Check Cursor version** (Help → About) and update if you’re behind; MCP behavior and timeouts have changed across versions.
- **Get the exact error**: Cursor Settings → MCP (or Features → MCP) may show per-server status; enable developer/log options if available to see connection or timeout messages.
- **Sentry shows “errored” or 0 tools**: Sentry requires OAuth. In Cursor go to Settings → MCP → Sentry and complete sign-in with your Sentry organization; then reload.
- **Socket shows 0 tools / no prompts or resources**: Socket’s server expects type `http`, not `streamable-http`. In `.cursor/mcp.json` set `"type": "http"` for the socket server and reload Cursor.

---

## 5. Quick reference

| Item        | Install / enable                          | Config / doc |
|------------|-------------------------------------------|--------------|
| ShellCheck | `sudo apt install shellcheck`             | [ShellCheck installing](https://github.com/koalaman/shellcheck#installing) |
| Todo Tree  | `cursor --install-extension gruntfuggly.todo-tree` | `.vscode/settings.json`, [Todo Tree markdown](https://github.com/Gruntfuggly/todo-tree#markdown-support) |
| Cursor todo| `TODO.md` (repo root)                      | AGENTS.md, WORKLOG.md, docs/SESSION_STATE.md |
| MCPs       | `.cursor/mcp.json` + Cursor MCP settings | docs/MCP_SETUP.md, docs/MCP_LATER_INSTALLS.md, this file §4 |

---

**Last updated**: 2026-01-30
