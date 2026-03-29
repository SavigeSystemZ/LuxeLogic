# Ledger Loop — Cursor Rules

**Purpose:** Rules for Cursor IDE when working on Ledger Loop. Copy into **Cursor Settings → Rules → Project Rules** or ensure the project `.cursorrules` file references this. Keeps design/context separate from app code (this file lives in `_system/`).

---

## Project identity

- **App:** Ledger Loop — Excel-like, multi-user budgeting for couples/families.
- **Stack:** Node.js, TypeScript, Express 5, PostgreSQL, Jest. No frontend yet (API-only).
- **Canonical context:** Load `AGENT_CONTEXT.md` first; then `TODO.md`, `DEVELOPMENT_STANDARDS.md`, `AI_AGENT_COORDINATION.md`.

---

## Terminology (use consistently)

- **Loop** = Household (code/DB/API). **Buckets** = budget categories (code). **ARCHITECT / CONTRIBUTOR / AUDITOR** = roles (code). In docs/product use Household/Categories/Member where appropriate; do not rename existing Loop/Bucket/Member in code without team agreement.

---

## Code and architecture

- **TypeScript:** Strict mode; explicit types for function params and returns; no `any` without justification.
- **API:** REST; nouns for resources (`/api/loops`, `/api/loops/:loop_id/buckets`, `/api/loops/:loop_id/accounts`); consistent error envelope; pagination for lists.
- **DB:** Parameterized queries only; transactions for multi-row writes; migrations for schema changes; tenant isolation (`loop_id` + membership) on every loop-scoped resource.
- **Security:** No secrets in repo; env vars; RBAC middleware on sensitive routes; audit events for membership/role changes and destructive actions.
- **Tests:** New behavior must have tests; critical paths (auth, RBAC, tenant isolation) must stay covered. Run `npm test` and `npm run lint` before finishing.

---

## File and scope discipline

- **Application code:** `src/` (controllers, routes, middleware, services, jobs, tests). Do not put design docs or prompts inside `src/`.
- **System/design/context:** `_system/` (prompts, rules, MCP, skills, URL context, WHERELEFTOFF, backup strategy). Do not import or execute _system from app code.
- **Root docs:** PRD, ARCHITECTURE, DATA_MODEL, NFR, RUNBOOK, TODO, AGENT_CONTEXT, DEVELOPMENT_STANDARDS, AI_AGENT_COORDINATION, PROMPT_PACK_GEMINI stay at root; _system indexes and extends them.

---

## Before and after changes

- **Before:** Read the part of PRD/ARCHITECTURE/DATA_MODEL that your task touches; check AGENT_CONTEXT Section 4 (implemented vs planned).
- **After:** Update TODO.md; if API/schema changed, update `architecture/API_DESIGN.md` and AGENT_CONTEXT; add "Last work" in AGENT_CONTEXT Section 8.3.

---

## Backup (single copy only)

- **Maintain only one manual backup** of the app at **`/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/`**. Run `scripts/backup-ledgerloop.sh` when requested; first run = full copy, subsequent runs = sync (only changes). Do not create additional backup copies or use other backup directories. See `_system/BACKUP_STRATEGY.md`.

---

## Don’ts

- Do not commit secrets or API keys.
- Do not create more than one manual backup copy; use only `/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/` for the internal manual backup.
- Do not add UI-only security; enforce at API/DB.
- Do not break tenant isolation or RBAC.
- Do not skip tests for new features or critical paths.
- Do not rename Loop/Bucket/ARCHITECT/CONTRIBUTOR/AUDITOR in code without documenting and coordinating.

---

*Cursor rules are maintained in `_system/CURSOR_RULES.md`. Application code is in `src/`.*
