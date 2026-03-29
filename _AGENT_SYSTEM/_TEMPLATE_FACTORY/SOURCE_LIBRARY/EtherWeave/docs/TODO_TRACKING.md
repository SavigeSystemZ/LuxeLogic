# Etherweave — TODO & Milestones Tracking

**Purpose:** Single comprehensive list for advancement, security, enhancement, best practice, and health of the application. Use with TODO.md, WHERE_WE_LEFT_OFF.md, and NEXT_STEPS_AND_MILESTONES.md.

**Convention:** Milestone → Phase → Step (→ Step Part when needed). Status: Open | In progress | Done.

---

## Quick reference (next best steps)

| Priority | ID | Description | Status |
|----------|-----|-------------|--------|
| 1 | 2.1.1 | Pro API parity: add missing endpoints (GUI vs /docs) | Done (settings + tool-status) |
| 2 | 3.2.1 | Button audit: run auditor; move >10 buttons to dialogs | Done |
| 3 | 3.2.2 | ScrolledFrame where tabs exceed window height | Done |
| 4 | 1.1.1 | Mypy scope to app code or fix critical types | Done (gradual override + TYPE_CHECKING.md) |
| 5 | 1.1.2 | Shellcheck exclusions for install.sh safe patterns | Done (in-file disables + SHELLCHECK.md) |
| 6 | 2.3.2 | Web UI async init (defer heavy checks) | Done (requestIdleCallback/setTimeout) |
| 7 | 1.3.2 | USER_GUIDE: update for current tabs and workspace | Done (§3.0 + Advanced/Workspaces) |
| 8 | 1.2.3 | Bandit/detect-secrets baseline path or config | Open |

---

## Milestone 1 — Quality gate & code health

**Goal:** Verification and pre-commit reliable; code health improved.

### Phase 1.1 — Verification & pre-commit

| Step | Description | Status |
|------|-------------|--------|
| 1.1.1 | Scope mypy to app code only (exclude tests/scripts) or fix critical type errors | Done (gradual override; docs/TYPE_CHECKING.md) |
| 1.1.2 | Shellcheck exclusions for known safe patterns in install.sh | Done (install.sh disables; docs/SHELLCHECK.md) |
| 1.1.3 | Re-enable mypy and shellcheck in pre-commit once 1.1.1–1.1.2 done | Open |
| 1.1.4 | Ruff/isort: fix remaining failures so pre-commit passes on full codebase | Open |

### Phase 1.2 — Code health

| Step | Description | Status |
|------|-------------|--------|
| 1.2.1 | ButtonAuditor: report action-button count per tab; run once, document baseline | Done |
| 1.2.2 | Bare excepts in lib/: replace with `except Exception as e:` + logging | Done (audit: none in etherweave) |
| 1.2.3 | Bandit / detect-secrets: fix .secrets.baseline path or config | Open |
| 1.2.4 | Unit tests: filter logic, export, ValidationLayer, task runner | Open |
| 1.2.5 | Integration tests: critical GUI→CoreController flows | Open |
| 1.2.6 | Fitness: keep GUI subprocess-free; workers use signals only | Open |

### Phase 1.3 — Live test & docs

| Step | Description | Status |
|------|-------------|--------|
| 1.3.1 | Live test: desktop and Web API icon launch; document in WHERE_WE_LEFT_OFF/KNOWN_ISSUES | Done (LIVE_TEST_PROCEDURE.md) |
| 1.3.2 | USER_GUIDE: update for current tabs and workspace features | Done (§3.0 table + Advanced/Workspaces) |
| 1.3.3 | CHANGELOG: keep user-facing and breaking changes noted | Open |
| 1.3.4 | CONTRIBUTING: clear run/test/verify steps before PR | Open |

---

## Milestone 2 — Web UI extension

**Goal:** Meaningful Web flows; API parity and docs.

### Phase 2.1 — API parity

| Step | Description | Status |
|------|-------------|--------|
| 2.1.1 | Add missing Pro API endpoints (list GUI vs /docs; workspace/evidence/settings) | Done |
| 2.1.2 | OpenAPI examples for common flows | Done |
| 2.1.3 | GET /api/v1/settings (read-only) for Web UI settings display | Done |
| 2.1.4 | GET /api/v1/tool-status or equivalent if Web UI needs tool availability | Done |
| 2.1.5 | API versioning and deprecation policy doc | Open |

### Phase 2.2 — Web UI flows

| Step | Description | Status |
|------|-------------|--------|
| 2.2.1 | Web UI capture request (POST + feedback) | Done |
| 2.2.2 | Web UI attack request (POST + feedback) | Done |
| 2.2.3 | Web UI link to evidence/timeline or settings | Done |
| 2.2.4 | Web UI: engagement selector and scope display | Open |
| 2.2.5 | Web UI: last scan results pagination or virtual scroll | Open |

### Phase 2.3 — Web-first alignment

| Step | Description | Status |
|------|-------------|--------|
| 2.3.1 | Deep-theme CSS variables for Web UI | Done |
| 2.3.2 | Async init: defer heavy checks so Web UI renders fast | Done (requestIdleCallback/setTimeout in index.html) |
| 2.3.3 | Web UI error boundaries and retry UX | Open |
| 2.3.4 | Web UI accessibility (ARIA, keyboard nav) | Open |

---

## Milestone 3 — Config persistence & GUI polish

**Goal:** Settings load/save end-to-end; GUI polish.

### Phase 3.1 — Settings persistence

| Step | Description | Status |
|------|-------------|--------|
| 3.1.1 | Load settings from config on startup (full categories) | Done |
| 3.1.2 | Save/Apply persist all categories to config | Done |
| 3.1.3 | Alert rules persist to DB/config and restore | Done |
| 3.1.4 | Settings schema validation and migration path | Open |

### Phase 3.2 — GUI polish

| Step | Description | Status |
|------|-------------|--------|
| 3.2.1 | Button audit: run ButtonAuditor; move >10 buttons to dialogs/Advanced | Done |
| 3.2.2 | ScrolledFrame where tabs can exceed window height | Done |
| 3.2.3 | Min heights: QTextEdit 150px, QListWidget 100px everywhere | Done |
| 3.2.4 | Help dialog: keyboard shortcuts documented | Done |
| 3.2.5 | Toast/feedback: consistent success/error and loading indicators | Open |
| 3.2.6 | Popup positioning: consistent centering and responsiveness | Open |
| 3.2.7 | Theme: cyberpunk palette and accent image apply everywhere; no redundant QGroupBox | Open |
| 3.2.8 | Defense tab: fix any display/layout issues | Open |

---

## Milestone 4 — Workspace backends (ROADMAP B/C depth)

**Goal:** RF spectrum, site survey, or enterprise posture advanced.

### Phase 4.1 — RF & survey

| Step | Description | Status |
|------|-------------|--------|
| 4.1.1 | RF spectrum: real RF sampling (airodump-ng or SDR), DB storage, real-time updates | Open |
| 4.1.2 | Site survey heatmap: QGraphicsView, heatmap algo, floorplan import | Open |
| 4.1.3 | Channel utilization from DB (RFSpectrumWorkspace) | Done |

### Phase 4.2 — Enterprise

| Step | Description | Status |
|------|-------------|--------|
| 4.2.1 | EAP capture: Scapy EAP frame capture/parsing, trace viewer | Open |
| 4.2.2 | RADIUS log parsing: parser, event correlation, DB storage | Open |
| 4.2.3 | Posture assessment: 802.1X posture checks, cert validation | Open |

---

## Milestone 5 — Security hardening

**Goal:** Best-practice security; no regressions.

| Step | Description | Status |
|------|-------------|--------|
| 5.1 | ValidationLayer: ensure all user-facing and API inputs validated | Open |
| 5.2 | LootManager audit: all sensitive data encrypted at rest | Open |
| 5.3 | Parameterized queries only; no string concat for user input | Open |
| 5.4 | Dependency audit: pip-audit or similar; track CVEs | Open |
| 5.5 | Secrets scan in CI; .secrets.baseline maintained | Open |
| 5.6 | OWASP alignment: document and tick off Top 10 mitigations | Open |
| 5.7 | Auth/sudo: no silent privilege escalation; audit logging for privileged ops | Open |

---

## Milestone 6 — Performance & reliability

**Goal:** Fast, predictable behavior; single-instance and thermal rules.

| Step | Description | Status |
|------|-------------|--------|
| 6.1 | DB indexes for frequent queries (bssid, essid, channel) | Done |
| 6.2 | Single instance enforcement: self.db, self.radio_manager only | Open (audit) |
| 6.3 | GPU thermal guard: check before cracking; pause/resume thresholds | Open (audit) |
| 6.4 | Query optimization: profile slow paths; add limits for large lists | Open |
| 6.5 | Progressive rendering / virtual scrolling for very large network lists | Open |
| 6.6 | backup_project.sh: mktemp fallback for environments where it fails | Open |

---

## Milestone 7 — Observability & ops

**Goal:** Structured logs; runbooks; diagnostics.

| Step | Description | Status |
|------|-------------|--------|
| 7.1 | Structured logging (JSON or key=value) for critical flows | Open |
| 7.2 | Metrics hooks (counters/timers) for scan/capture/attack; no PII | Open |
| 7.3 | diagnose_launch.sh: keep in sync with all launch modes | Open |
| 7.4 | Runbooks: recovery from failed backup, DB corruption, permission errors | Open |
| 7.5 | Session logs: consistent format in logs/cursor and logs/codex | Open |

---

## Milestone 8 — Documentation & onboarding

**Goal:** World-class docs; easy onboarding.

| Step | Description | Status |
|------|-------------|--------|
| 8.1 | APPLICATION_USER_GUIDE: current tabs, workspace, launch options | Open |
| 8.2 | API docs: /docs and /redoc accurate; examples for all public endpoints | Open |
| 8.3 | ARCHITECTURE_GLOSSARY and BODYMAP up to date | Open |
| 8.4 | README: quick start, verify, launch, backup path | Open |
| 8.5 | CONTRIBUTING: run/test/verify/commit conventions | Open |
| 8.6 | CODING_SYSTEM_INDEX and WHERE_WE_LEFT_OFF referenced in onboarding | Done |

---

## Milestone 9 — Export, reporting & evidence

**Goal:** Professional export and chain-of-custody.

| Step | Description | Status |
|------|-------------|--------|
| 9.1 | PDF export for reports | Open |
| 9.2 | PCAP indexing with tshark | Open |
| 9.3 | Case bundle export: verify and document | Open |
| 9.4 | Evidence timeline: acknowledged_by, state updates in DB | Open |
| 9.5 | Alert investigation dialog: state transitions and audit | Open |

---

## Milestone 10 — Release & packaging (ROADMAP Phase E)

**Goal:** Repeatable builds; signed releases.

| Step | Description | Status |
|------|-------------|--------|
| 10.1 | Capability matrix + feature gating by chipset/driver | Open |
| 10.2 | Replay harness + golden datasets for regression | Open |
| 10.3 | Packaging: dist/etherweave-app; install.sh from bundle | Done (partial) |
| 10.4 | Signed releases and release notes | Open |
| 10.5 | SBOM for releases | Open |
| 10.6 | Semantic versioning and CHANGELOG for user-facing changes | Open |

---

## Step parts (when a step is large)

- **2.1.1a** — List all GUI/CLI entry points that call core (scan, capture, attack, evidence, settings).
- **2.1.1b** — Compare to FastAPI routes; add missing endpoints.
- **2.1.1c** — Document new endpoints in OpenAPI; add examples.
- **3.2.1a** — Run ButtonAuditor; produce per-tab counts.
- **3.2.1b** — Identify tabs with >10 buttons; design dialog/Advanced grouping.
- **3.2.1c** — Move buttons; re-run auditor; update Help if needed.
- **3.2.2a** — List tabs with long content (Recon, Capture, Evidence, etc.).
- **3.2.2b** — Wrap each in ScrolledFrame; verify layout and scroll.

---

## References

- **TODO.md** — Current task list (Todo Tree).
- **docs/WHERE_WE_LEFT_OFF.md** — Current state and next work thread.
- **docs/NEXT_STEPS_AND_MILESTONES.md** — Milestones 1–4 detail.
- **ROADMAP.md** — Phase A–E.
- **system/docs/PHASE_CHECKPOINT_PROTOCOL.md** — Checkpoint and backup.
- **files/todo** — Quick-reference pointer to this file.

---

*Last updated: 2026-02-18. Update status when steps are completed; add new steps as needed.*
