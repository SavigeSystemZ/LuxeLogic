# MCP Later Installs — Etherweave

TODO list and config snippets for MCP servers to add **later** (when you start mobile app, web app, non-SQLite DB, Harness CI, Vault, etc.). Skip list (Browserbase, CodeSherlock, Corridor, Fluid Attacks, You.com) is not included.

**Reference:** [Cursor MCP Directory](https://cursor.com/docs/context/mcp/directory) | **Analysis:** docs/MCP_ANALYSIS.md | **Current config:** .cursor/mcp.json, docs/MCP_SETUP.md

---

## TODO — Install when

- [ ] **Bitrise** — When you start the mobile app (mobile CI/CD).
- [ ] **Browser Use** — When you adopt the [browser-use](https://github.com/browser-use/browser-use) Python library in code.
- [ ] **DBHub** — When you add a non-SQLite DB (e.g. Postgres for web backend).
- [ ] **Firecrawl** — When you need web scrape/search for research or structured web data.
- [ ] **Harness** — When you standardize CI/CD on Harness.
- [ ] **Playwright** — When you have a web app and need E2E test authoring.
- [ ] **Replicate** — When you add ML/AI model calls (e.g. traffic or vulnerability prediction).
- [ ] **Zapier** — When you need integrations (Slack, Notion, etc.).
- [ ] **Vault** — When you adopt HashiCorp Vault for secrets (team/cloud).

---

## Config snippets (paste into `.cursor/mcp.json` → `mcpServers`)

Install `vale-cli` if Vale fails to start (e.g. `npm i -g vale-cli` or use npx; see MCP_SETUP.md). All others below are for **later** installs.

### Bitrise (when mobile app)

Requires: Bitrise account, [PAT](https://devcenter.bitrise.io/en/account/personal-access-tokens.html).

```json
"bitrise": {
  "type": "streamable-http",
  "url": "https://mcp.bitrise.io",
  "headers": {
    "Authorization": "Bearer YOUR_BITRISE_PAT"
  }
}
```

Do not commit the PAT; use env or Cursor’s secret storage.

---

### Browser Use (when browser-use library adopted)

Add from [Cursor MCP Directory — Browser Use](https://cursor.com/docs/context/mcp/directory) when you use the browser-use Python library. No snippet here; use the directory’s “Add to Cursor” config.

---

### DBHub (when non-SQLite DB)

Requires: Node/npx, DSN for your DB (e.g. Postgres).

```json
"dbhub": {
  "command": "npx",
  "args": [
    "-y",
    "@bytebase/dbhub",
    "--transport",
    "stdio",
    "--dsn",
    "postgres://user:password@localhost:5432/dbname"
  ]
}
```

Replace `--dsn` with your real DSN. Do not commit credentials; use env or Cursor secrets.

---

### Firecrawl (when web scrape/search needed)

Requires: [Firecrawl API key](https://firecrawl.dev).

```json
"firecrawl": {
  "command": "npx",
  "args": ["-y", "firecrawl-mcp"],
  "env": {
    "FIRECRAWL_API_KEY": "YOUR_API_KEY"
  }
}
```

Do not commit the key; use env.

---

### Harness (when CI/CD on Harness)

Requires: Harness account, API key, org ID, project ID.

```json
"harness": {
  "command": "npx",
  "args": ["-y", "@harness/mcp-server", "stdio"],
  "env": {
    "HARNESS_API_KEY": "",
    "HARNESS_DEFAULT_ORG_ID": "",
    "HARNESS_DEFAULT_PROJECT_ID": ""
  }
}
```

Fill env via Cursor or shell; do not commit.

---

### Playwright (when web app + E2E)

No API key. Install when you have a web UI and want the agent to author/maintain E2E tests.

```json
"playwright": {
  "command": "npx",
  "args": ["-y", "@playwright/mcp@latest"]
}
```

---

### Replicate (when ML/AI models)

Requires: [Replicate API token](https://replicate.com/account/api-tokens). Use when you add features that call Replicate models.

```json
"replicate": {
  "type": "streamable-http",
  "url": "https://mcp.replicate.com/sse",
  "headers": {
    "Authorization": "Bearer YOUR_REPLICATE_TOKEN"
  }
}
```

Do not commit the token; use env or Cursor secrets.

---

### Zapier (when integrations needed)

Requires: Zapier MCP connection (see [Cursor directory](https://cursor.com/docs/context/mcp/directory) or Zapier docs for the exact URL/path; often includes a connection ID).

Example pattern (replace with your Zapier MCP URL):

```json
"zapier": {
  "type": "streamable-http",
  "url": "https://mcp.zapier.com/api/mcp/YOUR_CONNECTION_PATH"
}
```

Use the “Add to Cursor” link from Zapier or Cursor directory to get the exact config.

---

### Vault (when HashiCorp Vault for secrets)

Requires: Vault server, token (or auth method), optional namespace.

```json
"vault": {
  "command": "docker",
  "args": [
    "run",
    "-i",
    "--rm",
    "-e", "VAULT_ADDR",
    "-e", "VAULT_TOKEN",
    "-e", "VAULT_NAMESPACE",
    "hashicorp/vault-mcp-server:latest"
  ],
  "env": {
    "VAULT_ADDR": "https://vault.example.com",
    "VAULT_TOKEN": "",
    "VAULT_NAMESPACE": ""
  }
}
```

Do not commit tokens; use env. Adjust image tag if needed.

---

## After adding a later MCP

1. Reload Cursor so `.cursor/mcp.json` is picked up.
2. Confirm in Settings → Features → MCP that the server is listed and enabled.
3. Uncheck the corresponding TODO above when the install is done.
