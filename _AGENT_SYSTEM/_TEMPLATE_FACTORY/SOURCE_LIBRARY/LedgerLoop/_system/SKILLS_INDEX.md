# Ledger Loop — Skills Index

**Purpose:** Skills and capabilities expected of agents (and developers) working on Ledger Loop. Use this to scope tasks and to ensure design/context supports world-class implementation.

---

## Core skills (required)

| Skill | Description | Where it applies |
|-------|-------------|------------------|
| **TypeScript (strict)** | Types, interfaces, async/await, error handling. | All of `src/`. |
| **Node.js / Express** | REST APIs, middleware, routing, env/config. | Backend: `src/index.ts`, routes, controllers, middleware. |
| **PostgreSQL** | SQL, parameterized queries, transactions, migrations, indexes. | DB layer, schema, migrations. |
| **Security** | Tenant isolation, RBAC, no secrets in repo, audit logging, input validation. | Every loop-scoped endpoint; auth middleware; NFR.md. |
| **Testing** | Jest, Supertest, unit and integration tests, coverage. | `src/tests/`, RUNBOOK. |
| **API design** | REST, error envelopes, pagination, versioning considerations. | architecture/API_DESIGN.md, DEVELOPMENT_STANDARDS.md. |

---

## Domain skills (Ledger Loop specific)

| Skill | Description | Where it applies |
|-------|-------------|------------------|
| **Multi-tenant data model** | Loop/Member/Bucket/Account/Transaction; membership and roles. | DATA_MODEL.md, AGENT_CONTEXT terminology, all loop-scoped APIs. |
| **Ledger integrity** | Transactions canonical; splits sum = total; audit trail. | Transactions, splits, transaction log service; NFR. |
| **Envelope / zero-based budgeting** | Periods, planned amounts, available balance, rollovers. | M3 (budget engine); DATA_MODEL; future Budget Sheet. |
| **Collaboration and privacy** | Roles (ARCHITECT/CONTRIBUTOR/AUDITOR); invite/accept; private vs shared. | Auth, RBAC, members, invite flow; NFR privacy. |

---

## Supporting skills (recommended)

| Skill | Description | Where it applies |
|-------|-------------|------------------|
| **React + TypeScript** | When frontend is added: components, state, routing. | ARCHITECTURE (planned); M1.1 minimal UI, M2+ sheets. |
| **Grid / virtualization** | Large lists (10k+ rows); AG Grid or TanStack Table + Virtual. | NFR performance; Transactions Sheet, Budget Sheet. |
| **CSV / import pipelines** | Parse, validate, preview, commit, dedupe. | M5 imports; DATA_MODEL. |
| **DevOps / runbook** | Docker, migrations, systemd, deploy, rollback. | RUNBOOK.md, install.sh, scripts. |
| **Git and multi-agent coordination** | Small commits, handoff notes, TODO/AGENT_CONTEXT updates. | AI_AGENT_COORDINATION.md, AGENT_CONTEXT Section 8. |

---

## Skills not in scope (MVP)

- Full GAAP accounting, journal entries, invoices.
- Investment performance analytics (basic balances only).
- Direct bank integrations (Plaid/OFX) — post-MVP.
- Payroll, time tracking, complex business bookkeeping.

See PRD.md "Explicit non-goals (v1)".

---

## How to use this index

- **Assigning work:** Ensure the agent or human has the core skills and the domain skills for the task.
- **Gaps:** If a skill is missing (e.g. React), use PROMPT_PACK_GEMINI or AGENT_CONTEXT "Next steps" to phase it (e.g. frontend bootstrap).
- **Quality bar:** All work should align with DEVELOPMENT_STANDARDS.md and NFR.md; security and tenant isolation are non-negotiable.

---

*Skills index is in `_system/SKILLS_INDEX.md`. Application code is in `src/`.*
