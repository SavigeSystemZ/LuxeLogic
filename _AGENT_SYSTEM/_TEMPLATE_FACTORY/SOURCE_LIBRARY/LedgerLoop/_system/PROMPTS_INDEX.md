# Ledger Loop — Prompts Index

**Purpose:** Single index of all prompts used to design, plan, and implement Ledger Loop. Prompts are **design/context** assets; they live in docs, not in application code.

---

## Primary prompt pack (milestone-based)

| Location | Description |
|----------|-------------|
| **PROMPT_PACK_GEMINI.md** (repo root) | Full set of prompts M0–M9 for phased implementation. Use one-by-one with Gemini 2.5 Flash or any coding agent. |

**Milestones summarized:**

- **M0:** Repo bootstrap, canonical docs (PRD, ARCHITECTURE, DATA_MODEL, NFR, RUNBOOK), tooling, tests, SECURITY.md.
- **M1:** Auth, tenancy, RBAC, invite/accept, membership, household create/select.
- **M2:** Ledger core — Accounts, Categories/Payees, Transactions (splits), Transactions Sheet grid.
- **M3:** Budgeting engine, budget periods, envelope available, Budget Sheet (grouped columns, drill-down).
- **M4:** Sheet engine — shared grid, virtualization, column grouping.
- **M5:** Imports — CSV upload, parse, preview, commit, dedupe.
- **M6+:** Reconciliation, reporting UI, polish, etc.

Each milestone has Planning, Implementation, and Test prompts. See PROMPT_PACK_GEMINI.md for exact text.

---

## System and agent prompts (in _system)

| File | Role |
|------|------|
| **_system/MASTER_SYSTEM_PROMPT.md** | Canonical system prompt for any AI; load as system context. |
| **_system/CURSOR_RULES.md** | Cursor-specific rules (project rules / .cursorrules). |

---

## Inline / one-off prompts

- **AGENT_CONTEXT.md** Section 7 — "Next best steps" (prioritized); can be used as task prompts.
- **TODO.md** — Task list; each unchecked item can be turned into a focused prompt for an agent.

---

## How to use

1. **New feature by milestone:** Use PROMPT_PACK_GEMINI.md in order (e.g. M2.0 Planning → M2.1 Implementation → M2.2 Tests).
2. **General session:** Load MASTER_SYSTEM_PROMPT.md + AGENT_CONTEXT.md + TODO.md; pick a task and work.
3. **Cursor:** Use CURSOR_RULES.md (or .cursorrules that references it) so Cursor applies Ledger Loop context.

---

*Prompts index is in `_system/PROMPTS_INDEX.md`. Application code is in `src/`.*
