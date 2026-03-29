# MCP Troubleshooting (Etherweave)

Resolve MCP server errors and configuration issues. **Context7** and **Socket** are the only servers that may work without extra setup; others need the fixes below.

**Agent behavior:** When any MCP errors, agents should **note once** and **continue** with in-repo context (see **system/docs/ENVIRONMENT_AND_MCP_MODEL.md**). Use this doc to fix the underlying cause; do not block tasks on MCP availability.

**Keychain / credential store:** If **user-level** MCPs (OpenMemory, Context7, OpenAI Developer Docs) repeatedly show "fetch failed" or connection errors, Cursor may be unable to read or store credentials because the **OS keyring is unavailable**. See **docs/KDE_KEYRING_AND_ENVIRONMENT.md** and [VS Code: Troubleshooting keychain issues](https://code.visualstudio.com/docs/configure/settings-sync#_troubleshooting-keychain-issues). Fixing keyring (e.g. `cursor --password-store="gnome-libsecret"` and persisting in argv.json) often resolves those MCP errors.

---

## Quick reference: what’s fixed in this repo

| Server    | Status / fix |
|----------|----------------|
| **context7** | User-level; no change. |
| **socket-mcp** | Workspace config fixed: key `socket-mcp`, type `http`, URL `https://mcp.socket.dev/`. Reload Cursor. |
| **semgrep** | Switched from remote (deprecated) to **local** `semgrep mcp`. Requires `semgrep` on PATH (e.g. `pip install semgrep` / `brew install semgrep`). |
| **sentry** | Requires **OAuth** in Cursor. No config fix; complete sign-in in Cursor Settings → MCP → Sentry. |
| **ref** | Staging URL in use. If 401: re-auth in Cursor or try production URL (see below). |
| **jam** | Streamable-http; if it errors, check network / Cursor MCP logs. |

---

## 1. Socket (“doesn’t look configured” / 0 tools)

**Cause:** Wrong key or type in `mcp.json`.

**Fix applied in this repo:**

- In `.cursor/mcp.json`, Socket is configured as **`socket-mcp`** (official name), type **`http`**, URL **`https://mcp.socket.dev/`** (no path).
- Do **not** use `streamable-http` for Socket.

**What you should do:**

1. Open **Cursor Settings → Features → MCP**.
2. If you see an old server named **"socket"**, remove it (Socket’s official config uses the name **"socket-mcp"**).
3. Ensure the workspace config is used: project has `.cursor/mcp.json` with the `socket-mcp` entry above.
4. **Reload Cursor** (e.g. Developer: Reload Window).

If Socket still shows 0 tools, check Cursor’s MCP logs for connection errors and that no firewall/proxy blocks `https://mcp.socket.dev/`.

---

## 2. Semgrep (remote server error / 401 / deprecated)

**Cause:** Semgrep deprecated the **remote** MCP server (`https://mcp.semgrep.ai/mcp`). It often returns 401 or “Bearer authentication required”. The supported way is the **local** Semgrep MCP.

**Fix applied in this repo:**

- `.cursor/mcp.json` now uses the **local** Semgrep MCP:
  - `"command": "semgrep"`
  - `"args": ["mcp"]`
- `.cursor/hooks.json` added for Semgrep (stop + afterFileEdit hooks), per [Semgrep MCP instructions](https://mcp.semgrep.ai/instructions).

**What you should do:**

1. Install Semgrep (version **≥ 1.146.0**):
   - `pip install semgrep` or `brew install semgrep`
   - Run: `semgrep --version`
2. (Optional) Pro features: `semgrep login && semgrep install-semgrep-pro`
3. Reload Cursor so it picks up the updated `mcp.json` (local command instead of remote URL).

If Semgrep still errors, check that `semgrep` is on your PATH when Cursor starts (e.g. same terminal/PATH where you run `semgrep --version`).

---

## 3. Sentry (errored / 0 tools / fetch failed)

**Cause:** Sentry’s hosted MCP uses **OAuth**. Until you sign in, Cursor cannot use it.

**Fix (no repo config change):**

1. **Cursor Settings → Features → MCP**.
2. Find **Sentry** and complete **sign-in** with your Sentry organization (OAuth).
3. Reload Cursor if needed.

Config in this repo is correct: `type: streamable-http`, `url: https://mcp.sentry.dev/mcp`. The only fix is completing OAuth in Cursor.

---

## 4. Ref (401 / not configured)

**Cause:** Staging URL may require re-auth or a different endpoint.

**Config in repo:** `https://api.staging-ref.tools/mcp` (kept for OAuth compatibility; see SESSION_STATE).

**What you can try:**

1. **Re-auth:** Cursor Settings → MCP → Ref → sign in again if prompted.
2. **Production URL:** If staging keeps returning 401, edit `.cursor/mcp.json` and set Ref’s URL to:
   - `https://api.ref.tools/mcp`
   Then reload Cursor.
3. Check Cursor MCP logs for the exact error (401 vs network).

---

## 5. Jam (errors)

**Cause:** Streamable-http to `https://mcp.jam.dev/mcp` can fail due to network, TLS, or Cursor MCP client issues.

**What you can do:**

1. Confirm you can open `https://mcp.jam.dev` in a browser (no firewall/proxy block).
2. Reload Cursor and check MCP logs for Jam.
3. If Jam is not critical, you can disable it in Cursor Settings → MCP or remove the `jam` entry from `.cursor/mcp.json`.

---

## 6. Context7 (working)

No change. Context7 is typically configured at **user level** and provides doc search. Keep as is.

---

## 7. OpenMemory (if enabled)

OpenMemory often needs:

- Running the installer: `npx @openmemory/install --client cursor --env OPENMEMORY_API_KEY=your-key`
- Reloading Cursor after install.

See `docs/OPENMEMORY_SETUP.md` for this project.

---

## After changing MCP config

1. Save `.cursor/mcp.json` (and any edits to Cursor Settings).
2. **Reload Cursor**: Command Palette → “Developer: Reload Window” (or restart Cursor).
3. Check **Cursor Settings → Features → MCP**: servers should show “Connected” or list tools; note any that still show errors.
4. If a server still fails, use Cursor’s MCP/log output to see the exact error (401, timeout, TLS, etc.).

---

## Current workspace `.cursor/mcp.json` (reference)

```json
{
  "mcpServers": {
    "semgrep": {
      "command": "semgrep",
      "args": ["mcp"]
    },
    "sentry": {
      "type": "streamable-http",
      "url": "https://mcp.sentry.dev/mcp"
    },
    "socket-mcp": {
      "type": "http",
      "url": "https://mcp.socket.dev/"
    },
    "ref": {
      "type": "streamable-http",
      "url": "https://api.staging-ref.tools/mcp"
    },
    "jam": {
      "type": "streamable-http",
      "url": "https://mcp.jam.dev/mcp"
    }
  }
}
```

- **Semgrep:** Local command; no URL.
- **Socket:** Key must be `socket-mcp`, type `http`, URL with no path.
- **Sentry:** OAuth in Cursor required.
- **Ref:** Staging URL; try production or re-auth if 401.
- **Jam:** Streamable-http; disable or debug via logs if needed.

---

**Last updated:** 2026-01-30
**See also:** `docs/MCP_SETUP.md`, `docs/MCP_LATER_INSTALLS.md`
