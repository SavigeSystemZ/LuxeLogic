# PROMPT_PACK_GEMINI.md — Ledger Loop (Gemini 2.5 Flash)

> Use these prompts **one-by-one** with Gemini 2.5 Flash in your coding tool.  
> Each prompt is self-contained, requests explicit deliverables, and references the canonical docs:
> PRD.md, ARCHITECTURE.md, DATA_MODEL.md, NFR.md, RUNBOOK.md.

---

## PROMPT M0.0 — Planning (Repo + SSoT Docs)

"""
ROLE:
You are a senior full-stack engineer and software architect.

TASK:
Bootstrap the Ledger Loop repo for a production-quality budgeting app. This is M0 (foundation): establish repo structure, tooling, and canonical spec docs.

CONSTRAINTS:

- Plan-first. Do NOT implement yet.
- Keep it simple: modular monolith.
- Assume an empty repo unless you detect otherwise.
- No secrets. Use env vars/placeholders.
- Output must be actionable and file-path specific.

INPUT CONTEXT (must incorporate):

- App: Ledger Loop — Excel-like budgeting for couples/families/multi-user.
- Canonical docs required: PRD.md, ARCHITECTURE.md, DATA_MODEL.md, NFR.md, RUNBOOK.md.

OUTPUT FORMAT (markdown):

1. Proposed tech stack (explicit) and justification (short).
2. Repo file tree (paths).
3. Tooling plan (lint/typecheck/test/format).
4. Deliverables list for M0.1 (exact files to create/edit).
5. Risks + assumptions (max 10 bullets).
   """

---

## PROMPT M0.1 — Implementation (Scaffold + Canonical Docs)

"""
ROLE:
You are a senior full-stack engineer.

TASK:
Implement Milestone M0: scaffold the repo, add tooling, and create the canonical docs.

CONSTRAINTS:

- Only M0 scope.
- Do not add optional features (no ledger/business logic yet).
- Provide full file contents for every new/changed file.
- Add scripts for dev/test/lint.
- No secrets.

DELIVERABLES (minimum):
A) Repo scaffold with:

- package manager config
- TypeScript config (if TS)
- formatting + linting
- test framework
- minimal app skeleton (hello page)
  B) Create these docs at repo root with the provided content structure:
- PRD.md
- ARCHITECTURE.md
- DATA_MODEL.md
- NFR.md
- RUNBOOK.md
  C) Add a /docs/decisions/ADR-0001-stack.md (stack decision record)

OUTPUT FORMAT:

- Section 1: File list (created/modified)
- Section 2: Full file contents, grouped by path
- Section 3: How to run (commands)
  """

---

## PROMPT M0.2 — Tests (Foundation)

"""
ROLE:
You are a senior engineer.

TASK:
Add baseline tests for the scaffold:

- A smoke test that the app boots
- A placeholder unit test suite structure

CONSTRAINTS:

- No business logic yet.
- Tests must run in CI and locally.

DELIVERABLES:

- test config + sample tests
- CI workflow skeleton (if applicable)

OUTPUT:

- Files changed + full contents
- Commands to run tests
  """

---

## PROMPT M0.3 — Docs/Polish

"""
TASK:
Polish M0:

- Ensure RUNBOOK.md is complete and accurate for local dev, tests, lint, and build.
- Add README.md with:
  - what Ledger Loop is
  - how to run locally
  - how milestones are executed using PROMPT_PACK_GEMINI.md
- Add SECURITY.md with baseline practices (no secrets, authz checks, logging guidance).

CONSTRAINTS:

- Keep docs concise but complete.

OUTPUT:

- Updated files + full contents
  """

---

## PROMPT M0.4 — Review Checklist

"""
Review M0 changes as a code reviewer.
Deliver:

- issues/risks found
- missing pieces
- suggested next steps for M1
  """

---

## PROMPT M1.0 — Planning (Auth + Tenancy + RBAC)

"""
ROLE:
Senior engineer.

TASK:
Plan Milestone M1: implement authentication, household tenancy, membership roles, and authorization guards.

CONSTRAINTS:

- Read PRD.md, ARCHITECTURE.md, DATA_MODEL.md, NFR.md first.
- Privacy model must be server-enforced (no UI-only hiding).
- Keep auth minimal but production-safe.

OUTPUT:

1. Endpoints/routes and pages to add
2. DB migrations/schema updates
3. AuthZ matrix (role x action)
4. Test plan (unit + integration)
5. File list to touch
   """

---

## PROMPT M1.1 — Implementation (Auth + Tenancy + RBAC)

"""
TASK:
Implement M1:

- Auth (sign in/up)
- Household create/select
- Membership: invite/accept, role enforcement
- Server-side authz guards for household-scoped resources
- Seed/dev helpers for local testing (no secrets)

DELIVERABLES:

- DB schema + migrations
- API endpoints
- Minimal UI: auth screens, household selection, members page
- Audit events for membership changes

OUTPUT:

- Files touched
- Full contents for changes
- Validation commands (from RUNBOOK.md)
  """

---

## PROMPT M1.2 — Tests

"""
Add tests for M1:

- cannot access household data without membership
- role restrictions (viewer cannot invite, member cannot change roles, etc.)
- invite accept flow works
  Include negative tests (authz failures).
  """

---

## PROMPT M2.0 — Planning (Ledger Core)

"""
Plan M2: implement Accounts, Categories, Payees, Transactions (with splits), and the Transactions Sheet grid view.

Deliver:

- API list
- UI pages/sheets list
- Data integrity rules (split sums, tenant checks)
- Import placeholder (M2 can add CSV parsing in M3 instead if needed)
  """

---

## PROMPT M2.1 — Implementation (Ledger Core)

"""
Implement M2:

- Accounts CRUD
- Category groups + categories CRUD
- Payees CRUD
- Transactions CRUD + list (filters, pagination)
- Transaction splits editor (must enforce sum equality)
- Transactions Sheet:
  - grid with virtualization
  - filtering/search
  - bulk categorize action

Output full file contents for changes. Add audit events for deletes/edits.
"""

---

## PROMPT M2.2 — Tests

"""
Add tests for ledger correctness:

- split sum enforcement
- tenant isolation
- bulk update respects authz
- pagination/filtering works
  """

---

## PROMPT M3.0 — Planning (Budgeting Engine + Budget Sheet)

"""
Plan M3: implement monthly budget periods, planned amounts, envelope available computation, and Budget Sheet (Excel-like grouped columns).

Deliver:

- exact computation definitions (Plan/Actual/Available)
- endpoints
- UI layout spec for Budget Sheet grid (grouped headers, totals)
- drill-down design (“explain this number”)
  """

---

## PROMPT M3.1 — Implementation (Budgeting Engine + Budget Sheet)

"""
ROLE:
Senior engineer.

TASK:
Implement M3 exactly:

- Budgets (default per household), BudgetPeriods (monthly), BudgetCategoryPlans
- Budget computations (Plan / Actual / Available) per DATA_MODEL.md definitions
- Budget Sheet UI with spreadsheet-like grouping:
  - Rows: Category Groups > Categories
  - Columns (grouped headers): Plan | Actual | Delta | Available
  - Totals row per group + grand totals
  - Inline edit planned amount
  - Drill-down from Actual to Transactions Sheet filtered to contributing txns

CONSTRAINTS:

- Computations must be explainable: every aggregate links to contributing transaction IDs.
- Enforce tenant + privacy at API layer.
- Keep MVP manageable: one default budget, monthly periods only.

DELIVERABLES:
Backend:

- DB migrations + models for budgets/periods/plans/adjustments (if included)
- Endpoints:
  - get current period
  - set planned amount(s) (single + bulk)
  - get budget sheet view model (grouped rows + aggregates)
  - drill-down endpoint returning contributing transactions for a category+period
    Frontend:
- Budget Sheet page in app navigation
- Grid with grouped column headers and pinned category column
- Planned amount editor with validation

OUTPUT FORMAT:

1. Files touched
2. Full contents for new/changed files
3. Validation commands + expected results
   """

---

## PROMPT M3.2 — Tests (Budget Correctness)

"""
Add tests proving:

- Available calculation matches definition across rollover policies
- Planned amounts update and reflect in sheet
- Actual reflects transaction splits correctly in period boundaries
- Drill-down returns only authorized + in-period txns
  Include negative tests for:
- cross-household access
- private category/account leakage
  """

---

## PROMPT M3.3 — Docs/Polish

"""
Update docs:

- PRD.md: confirm MVP acceptance criteria now covered
- ARCHITECTURE.md: add Budget Sheet ViewModel contract details
- RUNBOOK.md: ensure commands for migrations and tests are accurate
  """

---

## PROMPT M3.4 — Review Checklist

"""
Review M3 changes:

- correctness edge cases (timezone boundary, month start/end)
- performance (N+1 queries, heavy aggregates)
- security (IDOR, privacy leakage via aggregates)
- missing tests or docs
  """

---

## PROMPT M4.0 — Planning (Sheet Engine + Excel-like UX)

"""
Plan M4: create a reusable Sheet/Grid system so all “Sheets” behave consistently like Excel.

Scope:

- Grid component wrapper with:
  - virtualization
  - keyboard navigation baseline
  - column grouping support
  - pinned columns/rows
  - inline cell editing patterns
- Sheet definition model:
  - columns, grouping, formatters, aggregations, drill-down links
- Persist user view state:
  - column widths/order/hidden
  - saved filters for a sheet
  - last-selected household + period

Deliver:

1. Component architecture (where grid code lives)
2. Data contracts between API and grid (row models)
3. Files to create/touch
4. Risks and fallback plan (if grid lib limits grouping)
   """

---

## PROMPT M4.1 — Implementation (Sheet Engine)

"""
Implement M4:

- Create /src/sheets framework:
  - SheetRegistry (list of sheets)
  - SheetDefinition type (columns, groups, row id, drilldown)
  - Shared Grid wrapper component with column grouping + virtualization
- Refactor existing Transactions Sheet and Budget Sheet to use the shared grid wrapper.
- Add Accounts Sheet (balances, status) using the same sheet framework.

Constraints:

- Minimal refactor: keep domain logic unchanged; focus on UI consistency.
- Maintain or improve performance.

Deliverables:

- New sheet framework files
- Updated sheets using it
- Persisted view state per user

Output: files + full contents + validation steps.
"""

---

## PROMPT M4.2 — Tests

"""
Add UI/integration tests (as feasible in your stack):

- grid renders and virtualizes large datasets
- column grouping appears correctly
- persisted view state restores
  """

---

## PROMPT M4.3 — Docs/Polish

"""
Document:

- How to add a new sheet (template)
- SheetDefinition conventions (naming, column IDs)
- UX keyboard shortcuts supported
  """

---

## PROMPT M4.4 — Review Checklist

"""
Review:

- regression risk from refactor
- a11y (focus management, keyboard nav)
- performance (virtualization correctness)
  """

---

## PROMPT M5.0 — Planning (Imports + Reconciliation + Rules)

"""
Plan M5:

1. CSV import end-to-end:
   - upload, parse, column mapping, preview, commit
   - duplicate detection
2. Reconciliation skeleton:
   - mark transactions cleared/reconciled, statement balance capture
3. Rules v1:
   - payee-based auto category suggestion (optional)
     Deliver:

- UX flows + screens
- DB schema changes (imports/imported_rows, reconciliation tables if added)
- API endpoints
- Security considerations (CSV injection, file validation)
  """

---

## PROMPT M5.1 — Implementation (Imports + Reconciliation + Rules)

"""
Implement M5:
CSV Import:

- Import upload endpoint (store file, compute hash)
- Parse CSV into imported_rows with normalization
- UI: Import wizard (select account, map columns, preview rows, commit)
- Commit creates transactions + splits (default category can be 'Uncategorized')
- Dedupe: prevent duplicates by row_hash; allow user override if needed

Reconciliation:

- Add Reconciliation model (statement end date, statement balance)
- UI on Accounts Sheet to start reconciliation and mark txns reconciled

Rules v1:

- Simple rule table: contains matchers (payee contains, memo contains) and actions (set category)
- Apply rules on import commit and on manual entry suggestions

Deliver full file contents and validations.
"""

---

## PROMPT M5.2 — Tests

"""
Add tests for:

- CSV parsing edge cases (dates, negative amounts, quoted commas)
- dedupe logic and overrides
- reconciliation state transitions
- rules application correctness
  Include authz tests.
  """

---

## PROMPT M5.3 — Docs/Polish

"""
Update:

- RUNBOOK.md with import troubleshooting
- NFR.md with file upload constraints (size limits, content-type)
  """

---

## PROMPT M5.4 — Review Checklist

"""
Review:

- CSV injection risks (formula injection into exports)
- large file performance and pagination
- audit events for import commit and reconciliation
  """

---

## PROMPT M6.0 — Planning (Reports + Exports)

"""
Plan M6:
Reports to implement:

- Category spend (by month, date range)
- Cashflow summary (income/expense/net over time)
- Net worth snapshot (by month)
  Exports:
- CSV export for transactions, budget, reports
  Deliver:
- report query strategy (SQL aggregation vs materialized views)
- API endpoints
- UI pages with filters
- performance plan for large datasets
  """

---

## PROMPT M6.1 — Implementation (Reports + Exports)

"""
Implement M6:

- Reports module:
  - endpoints returning timeseries + breakdowns
  - enforce privacy scoping
- Reports UI:
  - table + chart (optional) but ensure table is first-class
  - export buttons (CSV)
- Export hardening:
  - sanitize against CSV formula injection (prefix risky cells)
  - include timezone and currency metadata

Output full file contents and validations.
"""

---

## PROMPT M6.2 — Tests

"""
Add tests for:

- report correctness on controlled fixtures
- privacy: private categories/accounts excluded or aggregated per policy
- CSV export sanitization
  """

---

## PROMPT M6.3 — Docs/Polish

"""
Update PRD.md with report acceptance criteria completion.
Add /docs/reporting.md describing each report and how it's computed.
"""

---

## PROMPT M6.4 — Review Checklist

"""
Review:

- performance (indexes, query plans)
- correctness (timezone boundaries)
- privacy leakage via aggregates
  """

---

## PROMPT M7.0 — Planning (Collaboration + Couples Mode)

"""
Plan M7 (post-MVP collaboration enhancements):

- Budget change proposals:
  - member proposes planned amount changes
  - owner/admin approves or rejects
  - decisions log for weekly review
- Comments on categories/transactions
- Notifications (in-app)
  Deliver:
- data model additions
- UX flow
- permission matrix
  """

---

## PROMPT M7.1 — Implementation (Collaboration)

"""
Implement M7:

- Proposal entities + endpoints
- Budget Sheet: propose/approve UI
- Decisions log page ("Weekly Review")
- Comments on transactions and categories (minimal)

Constraints:

- Keep it lightweight; no email notifications required.
- Must be auditable (audit events).

Output file contents and validations.
"""

---

## PROMPT M7.2 — Tests

"""
Add tests for:

- proposal authz (who can approve)
- correct application of approved changes
- audit events recorded
  """

---

## PROMPT M7.3 — Docs/Polish

"""
Document Couples Mode in /docs/couples-mode.md including privacy model and workflows.
"""

---

## PROMPT M7.4 — Review Checklist

"""
Review:

- abuse cases (spam proposals/comments)
- permission edge cases
- auditability completeness
  """

---

## PROMPT M8.0 — Planning (Bank Integrations: Plaid + OFX/QFX)

"""
Plan M8: optional integrations.

- Plaid Link connection flow (token-based), consent and revocation UI
- Sync transactions into imports pipeline (do not bypass ledger rules)
- OFX/QFX import support (file upload + parse)
  Deliver:
- security plan (token storage, encryption, revocation)
- endpoints and background jobs strategy
- UX flows
  """

---

## PROMPT M8.1 — Implementation (Integrations)

"""
Implement M8 carefully:
Plaid:

- Add connection model storing access tokens securely (encrypted at rest or via KMS abstraction)
- Link flow UI
- Sync job that pulls transactions and stores as imported_rows (reusing import dedupe pipeline)
- Revocation: user can disconnect; purge tokens; log audit event

OFX/QFX:

- Accept .ofx/.qfx uploads and parse to imported_rows
- Reuse commit workflow

Constraints:

- No secrets in repo; all credentials via env vars.
- Strict authz, rate limits on sync endpoints.

Output full file contents + validation.
"""

---

## PROMPT M8.2 — Tests

"""
Add tests for:

- token access control (only household members)
- sync idempotency
- ofx/qfx parsing fixture
  """

---

## PROMPT M8.3 — Docs/Polish

"""
Update NFR.md:

- integration threat model
- data retention and revocation behavior
  Add /docs/integrations.md with setup steps.
  """

---

## PROMPT M8.4 — Review Checklist

"""
Review:

- security of token handling
- least privilege
- audit logs for connect/disconnect
  """

---

## PROMPT M9.0 — Planning (Hardening + Performance + Accessibility)

"""
Plan M9:

- Security hardening: CSP, rate limits, dependency auditing, logging
- Performance: indexes, query optimization, caching of sheet view models
- A11y pass: keyboard nav, ARIA where needed
- Backup/DR runbook
  Deliver: checklist + exact changes.
  """

---

## PROMPT M9.1 — Implementation (Hardening)

"""
Implement M9:

- Add security headers and CSP
- Add dependency audit tooling in CI
- Add rate limiting middleware
- Add DB indexes per query patterns
- Add performance budget checks for sheets
- Finish BACKUP_AND_DR.md with restore steps

Output files + validation steps.
"""

---

## PROMPT M9.2 — Tests

"""
Add tests for:

- rate limit behavior (where testable)
- CSP headers present
- critical queries still correct after index changes
  """

---

## PROMPT M9.3 — Docs/Polish

"""
Finalize docs:

- RUNBOOK.md: deploy/rollback/restore
- SECURITY.md: threat model summary and operational practices
  """

---

## PROMPT M9.4 — Final Review Checklist

"""
Final production readiness review:

- security
- correctness
- performance
- UX/a11y
- operability
  Provide a prioritized punch list.
  """
