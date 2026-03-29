# Socket MCP — Configuration & Usage (Etherweave)

Socket MCP provides **dependency security scoring** (supply chain, quality, maintenance, vulnerability, license) via the **depscore** tool. There are no project-side "tools", "prompts", or "resources" to configure in the repo — the server exposes one tool from Socket's side.

---

## Official sites (authentication & configuration)

| Purpose | URL |
|--------|-----|
| **Socket product & login** | [https://socket.dev](https://socket.dev) |
| **Documentation** | [https://docs.socket.dev](https://docs.socket.dev) |
| **Remote Socket MCP (install)** | [https://docs.socket.dev/docs/remote-socket-mcp](https://docs.socket.dev/docs/remote-socket-mcp) |
| **Guide to Socket MCP (tools, rules)** | [https://docs.socket.dev/docs/guide-to-socket-mcp](https://docs.socket.dev/docs/guide-to-socket-mcp) |
| **API reference** | [https://docs.socket.dev/reference](https://docs.socket.dev/reference) |

- **Public MCP server:** [https://mcp.socket.dev/](https://mcp.socket.dev/) — **no API key or authentication required.**
- **Optional (self-hosted / API):** Log in at [socket.dev](https://socket.dev) to get an API key; use with local MCP (`SOCKET_API_KEY`, `npx @socketsecurity/mcp@latest`). See [Local Socket MCP](https://docs.socket.dev/docs/local-socket-mcp) in the docs.

---

## Tools, prompts, and resources

- **Tools:** The only tool exposed by the public Socket MCP is **`depscore`**. You do not configure tools in the project; Cursor discovers them when connected to `socket-mcp`.
- **Prompts:** Socket does not provide MCP "prompts" in the Cursor sense. To steer the AI to use Socket, use **Cursor rules** (see below).
- **Resources:** The server does not expose MCP "resources" in the repo. Configuration is either the server URL (already in `.cursor/mcp.json`) or optional client-side rules.

---

## Configuring behavior (Cursor rules)

Socket’s docs recommend customizing behavior via your AI client’s rules. For Cursor, that means **`.cursor/rules`**.

- **Rule added in this project:** `.cursor/rules/etherweave-socket-mcp.mdc`
  - Tells the agent to use Socket’s **depscore** when adding or changing dependencies (e.g. `requirements.txt`, `pyproject.toml`, `package.json`), and to prefer alternatives or escalate if scores are low.

You can edit that rule to:
- Restrict to specific manifests (e.g. only `requirements.txt`).
- Require a minimum score before adding a dependency.
- Add project-specific guidance (e.g. “always check PyPI packages with depscore”).

---

## Workspace MCP config (reference)

In `.cursor/mcp.json`:

```json
"socket-mcp": {
  "type": "http",
  "url": "https://mcp.socket.dev/"
}
```

No auth, no API key, no project-side tools/prompts/resources. For authentication or advanced usage (e.g. self-hosted), use [socket.dev](https://socket.dev) and [docs.socket.dev](https://docs.socket.dev).

---

## depscore usage (from Socket docs)

- **Parameters:** `packages[]` with `ecosystem` (e.g. `npm`, `pypi`), `depname`, optional `version`.
- **Example ask:** “Check the security score for express version 4.18.2” or “Analyze the security of my requirements.txt dependencies.”

See [Guide to Socket MCP](https://docs.socket.dev/docs/guide-to-socket-mcp) for full parameter list and sample requests/responses.

---

**Last updated:** 2026-01-30
**See also:** `docs/MCP_SETUP.md`, `docs/MCP_TROUBLESHOOTING.md`
