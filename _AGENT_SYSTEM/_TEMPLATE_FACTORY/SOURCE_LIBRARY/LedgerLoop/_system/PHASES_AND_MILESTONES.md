# Ledger Loop — Phases, Milestones & Advancement Plan

**Purpose:** Master tracking for advancement, security, enhancement, best practice, and long-term health of the application. Use with TODO.md for context and checkboxes. Update status as work completes.

---

## Phase A: Security & Input Hardening

**Goal:** Align with NFR (tenant isolation, authz, OWASP basics, rate limits, secrets hygiene). Harden inputs and responses.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| A.1  | Input validation layer | Centralized validation for critical API bodies (lengths, types, allowed values). Apply to auth, loop, account, bucket, transaction, category group, payee create/update. | Done |
| A.2  | Request correlation ID | Middleware to assign/generate correlationId per request; include in error envelope and structured logs. | Done |
| A.3  | Error envelope consistency | All API errors return { code, message, details?, correlationId? }. Global handler and controllers use it. | Done |
| A.4  | Auth body validation | Validate register/login: email format, password min length, optional max lengths. Return 400 with clear messages. | Done |
| A.5  | UUID/ID validation | Reject invalid UUIDs for loop_id, account_id, bucket_id, etc. at middleware or controller entry. | Done |
| A.6  | Rate limit tuning | Document AUTH_RATE_LIMIT_MAX; consider per-endpoint limits for expensive or write-heavy routes if needed. | Done (auth only) |
| A.7  | Security headers audit | Confirm Helmet defaults; consider CSP when SPA is stable; document in RUNBOOK. | Done (CSP off for SPA) |
| A.8  | Secrets & RUNBOOK | No secrets in repo; RUNBOOK documents .env, peer auth, and production secret replacement. | Done |

---

## Phase B: Observability & Operations

**Goal:** NFR observability (structured logs, correlationId); operations-friendly health and versioning.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| B.1  | Health version/build | GET /api/health returns version (from package.json) and optional build/git commit. | Done |
| B.2  | Structured logging | Ensure key operations log with correlationId, userId, loopId where appropriate. | Partial |
| B.3  | Audit events queryable | Audit trail for destructive actions and role changes; document how Owner/Admin can query (e.g. transaction_logs, future audit_events). | Partial (txn logs) |
| B.4  | Log levels | Use consistent levels (error, warn, info, debug); avoid console in app code. | Done (logger) |

---

## Phase C: Code Quality & Maintainability

**Goal:** Lint-clean, typed, test-covered; easy for multiple contributors.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| C.1  | Lint warnings | Fix remaining nullish coalescing (|| → ??), any types, no-console. | Done (lint is clean; `npm run lint` returns 0 warnings) |
| C.2  | Test coverage | Meet or document coverage thresholds; add tests for new validation and critical paths. | Partial |
| C.3  | Integration test | At least one flow: register → login → create loop → add transaction (test DB or mocks). | Done |
| C.4  | CI workflow | GitHub Actions (or similar): build, lint, test on push/PR. | Done |
| C.5  | TypeScript strict | No any in public APIs; explicit return types where helpful. | Partial |

---

## Phase D: Data Integrity & Correctness

**Goal:** NFR data correctness; audit and split rules enforced.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| D.1  | Split sum = total | Enforce in service/DB; reject updates where split sum ≠ transaction total. | Done (per prior context) |
| D.2  | DB transactions | Multi-row writes (e.g. transaction + splits) in a single DB transaction. | Done |
| D.3  | Audit for destructive | Transaction logs for updates/deletes; extend to membership/role changes if not already. | Partial |
| D.4  | Migrations applied | setup_db.sh / setup-database.sh run all migrations in order (003, 004 included). | Done |

---

## Phase E: M2 Ledger Completion (Frontend & Linkage)

**Goal:** Category groups and payees usable from UI; transactions optionally linked to payees/accounts.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| E.1  | Category groups UI | Frontend: list, create, edit, delete category groups; assign buckets to groups. | Done (list, create, delete; assign buckets in bucket edit later) |
| E.2  | Payees UI | Frontend: list, create, edit, delete payees. | Done |
| E.3  | Transaction payee link | Transaction create/edit can set payee_id; UI shows payee name. | Done |
| E.4  | Bucket group_id | Bucket create/edit can set group_id; API already supports. Frontend optional. | Done |

---

## Phase F: Budget Engine (M3)

**Goal:** Envelope-style budgeting; periods, planned amounts, available balance.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| F.1  | Budget periods schema | Tables for budget periods and planned amounts per bucket/period. | Done |
| F.2  | Envelope computation | Service to compute available balance (rollover + planned − spent). | Done |
| F.3  | Budget Sheet API | GET view: categories/groups, plan, actual, available for a period. | Done |
| F.4  | Budget Sheet UI | Frontend: Budget Sheet view (grid or list) with plan/actual/available. | Done |
| F.5  | Budget lifecycle polish | Template naming/archival and period workflow refinements. | Done |

---

## Phase G: Sheet Engine & Reporting (M4 / M5)

**Goal:** Excel-like grids; imports; reporting polish.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| G.1  | Sheet definitions | Dataset source, columns, aggregations for Budget and Transactions sheets. | Done |
| G.2  | Grid virtualization | Frontend: virtualized grid (e.g. TanStack Table + Virtual) for 10k+ rows. | Done (transactions virtualization implemented) |
| G.3  | Imports (M5) | CSV upload, parse, preview, commit, dedupe; rate limit and validation. | Done |
| G.4  | Export transactions | CSV export for loop/date range (API + UI). | Done |
| G.5  | Reports date range | Reports accept date range filter; optional print/PDF. | Done |

---

## Phase H: Resilience & Distribution

**Goal:** Reliable install, backup, upgrade path.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| H.1  | Single backup location | Internal manual backup at /home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/; sync on request. | Done |
| H.2  | Verify script | scripts/verify-install.sh: port, health, SPA, logs. | Done |
| H.3  | Upgrade path doc | RUNBOOK: re-run install vs deploy script; when to run migrations. | Done |
| H.4  | Version in health | Health returns version/build for support and CI. | Done |
| H.5  | Service env location | Keep service-managed env under `/etc/ledgerloop`. | Done |
| H.6  | Desktop integration hardening | Installer validates launcher/desktop/icon reliability. | Done |
| H.7  | Cross-desktop QA | Validate launcher/icon behavior on GNOME/KDE/XFCE (`npm run ops:h7:desktop-qa`, optional `ops:h7:desktop-qa:repair`, plus manual desktop checks; evidence in `docs/CROSS_DESKTOP_QA_LOG.md`). | Pending |
| H.8  | MCP multi-app profiles | Global + project-scoped LedgerLoop MCP setup. | Done |
| H.9  | Packaging controls | Target selection, deb compression override, timeout controls. | Done |
| H.10 | Packaging graceful-degrade | Skip unsupported targets rather than aborting all packaging. | Done |
| H.11 | Packaging host prerequisites | Distro-aware check/install tooling for `rpmbuild` + `bsdtar` deps. | Done |
| H.12 | Host privileged execution pass | Interactive sudo installer/dependency validation run on host. | Pending |
| H.13 | Containerized packaging fallback | Docker/Podman-capable build matrix (`docker/build-matrix.Dockerfile`). | Done |
| H.14 | MCP runtime reload verification | Restart IDE/agent sessions and verify MCP discovery. | Pending |
| H.15 | Backup-branch merge guard | Repo-managed git hook blocks `backup/system-context` merges into `main`. | Done |
| H.16 | Phase-H closeout orchestration | One-command closeout runner + report (`npm run ops:phase-h:closeout`, `docs/PHASE_H_CLOSEOUT_REPORT.md`). | Done |

---

## Phase I: Privacy & Compliance Readiness

**Goal:** NFR privacy; optional private accounts/categories; audit queryability.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| I.1  | Privacy scopes | Define visibility (shared/private) for accounts/categories; enforce in API. | Done |
| I.2  | Audit query API | Endpoint or doc for Owner/Admin to query audit events (e.g. role changes, deletes). | Done (transaction audit endpoints/logs) |
| I.3  | Compliance note | NFR and RUNBOOK note on financial/PII data; Plaid later = token/consent/revocation. | Done |

---

## Phase J: Performance & Scale

**Goal:** NFR performance; pagination and indexing.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| J.1  | Pagination everywhere | List endpoints (transactions, accounts, buckets, etc.) support limit/offset and total. | Done |
| J.2  | Indexes | DB indexes on loop_id, user_id, transaction_date, bucket_id, payee_id, etc. | Done (per schema) |
| J.3  | Budget sheet < 1s | Target render in < 1s for typical households (≤ 200 categories). | Done (validated with 200 buckets + 1200 transactions; benchmark avg 13.55ms, max 30.43ms, threshold 1000ms) |

---

## Phase K: Advanced Financial Logic & Collaboration

**Goal:** Elevate LedgerLoop to "Super App" status with intelligent analysis and deep collaboration features.

| ID   | Milestone | Description | Status |
|------|-----------|-------------|--------|
| K.1  | Multi-Currency Engine | Support accounts/transactions in multiple currencies with daily FX rate synchronization and converted reporting. | Done |
| K.2  | Auto-Categorization 2.0 | Smarter transaction classification using historical loop patterns and keyword heuristics (predictCategory). | Done |
| K.3  | Predictive Cashflow | Forward-looking liquidity projections using live account balances and historical burn rates. | Done |
| K.4  | Fair Share Allocation | Income-proportional household contribution analysis for equitable shared expense funding. | Done |
| K.5  | Weekly Sync Ritual | Guided collaborative workflow for couples to review ledgers, align on splits, and log decisions. | Done |
| K.6  | Decision Log | Permanent historical record of household financial agreements and budget shifts. | Done |
| K.7  | Mobile Quick Navigation | Optimized mobile UI with a persistent quick-action bar for Cockpit, Ritual, Ledger, and Copilot. | Done |

---

## Suggested Order of Execution (Next Best Steps)

1. **H.12** — Interactive sudo installer + verify-install validation on host.
2. **H.14 + H.7** — MCP runtime reload validation and cross-desktop QA (GNOME/KDE/XFCE; execute `npm run ops:h7:desktop-qa` on each desktop target).
3. **Optional host-only parity:** Install missing host packaging prerequisites and rerun full matrix only if containerized matrix fallback cannot be used.
4. **H.14 + H.7** — MCP runtime reload + cross-desktop QA completion pass.

---

*Phases and milestones are in `_system/PHASES_AND_MILESTONES.md`. Application code is in `src/`. Sync checkboxes with TODO.md.*
