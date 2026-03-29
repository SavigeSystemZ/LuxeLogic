# Ledger Loop — URL Contexts

**Purpose:** Reference URLs for APIs, standards, and documentation used in the design, architecture, and implementation of Ledger Loop. Use these when implementing integrations, checking best practices, or loading external context.

---

## Standards and specs

| Topic | URL | Use |
|-------|-----|-----|
| **REST API design** | https://restfulapi.net/ | Resource naming, HTTP verbs, status codes. |
| **JSON:API** (optional reference) | https://jsonapi.org/format/ | If we ever align with JSON:API; currently we use a custom envelope. |
| **JWT (RFC 7519)** | https://datatracker.ietf.org/doc/html/rfc7519 | Access/refresh token design. |
| **OWASP Top 10** | https://owasp.org/www-project-top-ten/ | Security checklist (injection, auth, etc.). |
| **PostgreSQL docs** | https://www.postgresql.org/docs/current/ | SQL, types, transactions, indexes. |
| **Express 5** | https://expressjs.com/ | Routing, middleware, error handling. |
| **TypeScript** | https://www.typescriptlang.org/docs/ | Strict mode, types, config. |
| **Jest** | https://jestjs.io/docs/getting-started | Testing, mocks, coverage. |

---

## Runtime and deployment

| Topic | URL | Use |
|-------|-----|-----|
| **Node.js LTS** | https://nodejs.org/en/docs/ | Version (v18+), env, modules. |
| **Docker Compose** | https://docs.docker.com/compose/ | Local Postgres; see docker-compose.yml. |
| **systemd** | https://www.freedesktop.org/software/systemd/man/systemd.service.html | Service unit (install.sh, RUNBOOK). |

---

## Future integrations (not MVP)

| Topic | URL | Use |
|-------|-----|-----|
| **Plaid** | https://plaid.com/docs/ | Bank linking (post-MVP); security and token practices. |
| **React** | https://react.dev/ | When adding frontend. |
| **TanStack Table** | https://tanstack.com/table/latest | Grid virtualization candidate. |
| **AG Grid** | https://www.ag-grid.com/documentation | Alternative grid with virtualization. |

---

## Project-local (no URL)

- **API surface:** `architecture/API_DESIGN.md`
- **Schema:** `architecture/DB_SCHEMA_DDL.sql`, migrations
- **Runbook:** RUNBOOK.md
- **Agent context:** AGENT_CONTEXT.md

---

## How to use

- **Implementing a feature:** Open the relevant standard or doc (e.g. PostgreSQL for a new query pattern, OWASP for authz).
- **AI context:** When using a web-fetch or URL context tool, prioritize the URLs above for consistency.
- **Security:** Never put secrets or internal URLs in this file; use placeholders if needed.

---

*URL context list is in `_system/URL_CONTEXTS.md`. Application code is in `src/`.*
