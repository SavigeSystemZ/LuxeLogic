# Ledger Loop — TODO & Tracking

**Context for agents:** See `AGENT_CONTEXT.md` for system design and terminology. Full phases and milestones: `_system/PHASES_AND_MILESTONES.md`. Super App Master Plan is at `_system/SUPER_APP_MASTER_PLAN.md`. Update this file and AGENT_CONTEXT when completing work.
**Rule:** Any unfinished issue, bug, follow-up, or deferred improvement discovered during work must be added to this file before handoff (even if low priority).

---

## Completed (reference)

- [x] Phase 1: Infrastructure & Login Fix (CORS, Health, Database)
- [x] Phase 2: Offline-First Sync (RxDB, SyncEngine, SyncStatus)
- [x] Phase 3: The Brain - Financial Logic (Fair Share, Rollover, Velocity, Subscriptions)
- [x] Phase 4: The Face - Deep Glass UI (Cockpit Layout, LoopRing, BucketCard)
- [x] Phase 5: World-Class Polish (Command Palette, Recharts, AI Panel)
- [x] Dynamic Theme Engine (CSS Variables, 4 themes, persistence)
- [x] Command Palette (Ctrl+K with transaction search and quick actions)
- [x] Drag & Drop Organization (Bucket reordering and grouping)
- [x] Skeleton Loaders & Rich Toasts (Shimmer effects and sonner integration)
- [x] Debt Payoff Simulator (Snowball vs Avalanche logic)
- [x] Subscription Command (Monthly billing calendar and detection)
- [x] Receipt Scanner (Drag-and-drop OCR interface)
- [x] Master Settings Dashboard (Master-Detail layout with Automation/Sync tabs)
- [x] Native OS Integration (System Tray, Notifications, safeStorage for tokens)
- [x] Port Collision Fallback (DB_PORT 5433 / API_PORT 5001 fallback)
- [x] Offline-First Conflict Hardening (FOR UPDATE locking, Soft deletes)
- [x] Desktop Icon Standard (XDG menu install)
- [x] Installer Auto-Heal (NodeSource 20.x bootstrap, build-essential, port collision .env.local fallback)
- [x] Database Rebuild Support (Drop/Recreate DB & Role, connection termination)
- [x] Installer Optimization (Repair mode speedup, --skip-npm option)
- [x] Build Stability (Fixed all TypeScript errors in Accounts, Transactions, and AuditLog)
- [x] Infinite Scroll Virtualization (Smooth high-performance ledger scrolling)
- [x] Privacy Scopes (Shared/Private accounts for household members)
- [x] Transaction Audit Trail (Verifiable history for administrators)
- [x] Linux Packaging Automation (AppImage, deb, rpm, pacman built in CI)

---

## Phase G: Sheet Engine & Reporting (M4 / M5)

- [x] G.1 Sheet definitions (dataset, columns, aggregations)
- [x] G.2 Grid virtualization (Implemented for Transactions; Budget UI ready)
- [x] G.3 CSV import dedupe + idempotency safeguards
- [x] G.4 Export controls (date/window + scoped dataset options)
- [x] G.5 Reports date-range consistency (summary + bucket balances + print view)

## Phase F: Budget Lifecycle Polish

- [x] F.5 Template naming/archival and period workflow refinements (template seeding + archive/unarchive + UI controls)

---

## Phase H: Resilience & Distribution

- [x] H.1 Single backup location; H.2 verify-install script
- [x] H.6 Installer desktop integration hardening
- [x] H.3 Upgrade path doc (RUNBOOK: install vs deploy; when to run migrations)
- [x] H.4 Version in health
- [x] H.5 Move service env to `/etc/ledgerloop`
- [ ] H.7 Cross-desktop QA (GNOME/KDE/XFCE; helper: `npm run ops:h7:desktop-qa`, optional shortcut repair: `npm run ops:h7:desktop-qa:repair`; evidence: `docs/CROSS_DESKTOP_QA_LOG.md`)
- [x] H.8 MCP multi-app profiles (global + project-scoped LedgerLoop server)
- [x] H.9 Packaging script controls (target selection, deb compression override, timeout)
- [x] H.10 Packaging graceful-degrade behavior (skip unsupported targets instead of aborting all builds)
- [x] H.11 Packaging host prerequisites for full matrix (`scripts/package-prereqs.sh`, npm aliases, distro-aware install hints/auto-install wiring)
- [x] H.12 Host privileged execution pass (run installer + verify-install with interactive sudo on host; packaging deps are optional with container matrix fallback, helper: npm run ops:h12:host-validate, host-only mode: npm run ops:h12:host-validate -- --host-only; closeout helper: npm run ops:phase-h:closeout)

- [x] H.13 Containerized packaging fallback readiness (Docker/Podman-capable build matrix via `docker/build-matrix.Dockerfile` + `scripts/package-all-docker.sh`)
- [ ] H.14 MCP runtime reload verification (restart IDE/agent session and confirm MCP resources/templates enumerate; precheck/helper: `npm run ops:phase-h:closeout`)
- [x] H.15 Backup-branch merge guard (`.githooks/pre-merge-commit` + `npm run hooks:install`) to prevent `backup/system-context` merges into `main`
- [x] H.16 Phase-H closeout orchestrator (`npm run ops:phase-h:closeout` + `docs/PHASE_H_CLOSEOUT_REPORT.md`)

---

## Phase I: Privacy & Compliance Readiness

- [x] I.1 Privacy scopes (Implemented for accounts)
- [x] I.2 Audit query API (Implemented transaction_log audit)
- [x] I.3 Compliance note in RUNBOOK (financial/PII; Plaid later)

---

## Phase J: Performance & Scale

- [x] J.1 Pagination everywhere
- [x] J.2 Indexes (schema has loop_id, user_id, dates, etc.)
- [x] J.3 Budget sheet < 1s on realistic data (validated on host synthetic realistic fixture: 200 buckets, 1200 tx, 10 runs avg 13.55ms, max 30.43ms, threshold 1000ms)
- [x] J.3a Budget sheet backend perf hardening (period-bounded query path + partial transaction index + timing header)
- [x] J.3b Budget-sheet benchmark harness (`npm run perf:budget-sheet`) for repeatable threshold checks
- [x] J.4 Client bundle optimization
- [x] J.5 Reduce production chunk-size warning (manual Vite chunk splitting implemented)

---

## Quality Debt / Stability

- [x] Q.1 Eliminate remaining lint warnings (`npm run lint` now clean)
- [x] Q.2 Investigate intermittent Jest worker-exit warning and enforce clean teardown in parallel runs (rollover cron no longer auto-starts in test imports)
- [x] Q.3 Add sync controller test coverage (new `src/tests/sync.test.ts` for pull/push/conflicts)
- [x] Q.4 Address client dependency vulnerabilities (`client npm audit` now 0 findings)
- [x] Q.5 Address root dependency vulnerabilities (`npm audit` now 0 findings after `electron-builder`/`electron` stack upgrade and lock refresh)
- [x] Q.6 Fix packaging regressions after electron-builder upgrade (`linux.desktop.entry` schema update + non-docker matrix control-flow fix + docker-daemon preflight fallback in `scripts/package-all.sh`)

---

## Phase K: Institutional Open Banking (Phase 2 rollout)

- [x] K.1 Provider adapter contract (`src/services/institutions/ProviderInterface.ts`)
- [x] K.2 Provider registry + adapters scaffold (Plaid, GoCardless, SimpleFIN)
- [x] K.3 Schema foundation (`013_add_institution_sync_foundation.sql`) for connections/accounts/review status
- [x] K.4 Background sync worker (`src/jobs/syncInstitutions.ts`) + ingestion pipeline
- [x] K.5 Entity resolution to canonical payees (`EntityResolutionService` + `PatternRecognitionService`)
- [x] K.11 Auto-categorization 2.0 (`PatternRecognitionService.predictCategory` + Import Controller integration)
- [x] K.6 Pending-review workflow (`review_status = PENDING_REVIEW`, review endpoints)
- [x] K.7 Secure token pathing (Electron `safeStorage` read/write/delete + client vault without localStorage)
- [x] K.8 UI workflow for institution connect/sync/review screens (`client/src/pages/Institutions.tsx`)
- [x] K.9 Complete GoCardless/SimpleFIN live API pull implementation (provider account/transaction pulls + cursor/date handling + adapter tests)
- [x] K.10 Automated secure token resolver bridge for background sync job (`TokenBridge` TTL cache + `/institutions/tokens/register` + scheduled resolver fallback)
- [x] K.12 Proportional Fair-Share allocation analysis (backend service + report UI)
- [x] K.13 Collaborative Weekly Sync ritual workflow (database schema + guided session module + decision log)
- [x] K.14 Mobile Quick-Nav optimization (bottom navigation bar for persistent access)

---

## Phase L: Agentic Tool Bridge (Phase 4 prep)

- [x] L.1 Read-only tool endpoints (`/api/agent/tools`) with loop membership checks
- [x] L.2 Tool registry/execution for spending by bucket/payee + net summary
- [x] L.3 AgentChat bridge command path using server tools (query phrases like "what did I spend on X last month?")
- [x] L.4 Local LLM daemon bridge (Ollama transport + tool-calling orchestration via `/api/agent/chat`)
- [x] L.5 Event-driven alert engine + backend pub/sub trigger surface (alert bus + loop alert APIs + native/electron notification dispatch)
- [x] L.6 Enhanced Agent Intelligence (Fair Share and Budget Summary tools for AI Copilot)
- [x] L.7 Global Command Palette Search (Unified discovery for transactions, buckets, and decisions)

---

## Suggested next steps (priority)

1. **H.12 installer + privileged host validation** — Run `sudo bash ./install.sh --reinstall --yes` and `bash ./scripts/verify-install.sh` (or `npm run ops:h12:host-validate`).
2. **H.14 + H.7** — MCP runtime reload verification and cross-desktop QA (GNOME/KDE/XFCE; run `npm run ops:h7:desktop-qa` per desktop environment).
3. **Optional host-only packaging parity** — If you must avoid containerized matrix fallback, install host prereqs (`rpm`, `libarchive-tools`) and rerun `npm run pack:linux:matrix`.

---

*Phases and milestones: `_system/PHASES_AND_MILESTONES.md`. Standards: `DEVELOPMENT_STANDARDS.md`. Coordination: `AI_AGENT_COORDINATION.md`.*
