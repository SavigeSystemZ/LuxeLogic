# Ledger Loop — System & Design Context

**Purpose:** This directory holds all **design, architecture, prompts, rules, MCP config, skills, URL context, and meta-documentation** used to design, architect, code, and build Ledger Loop. It is **logically separate** from the application runtime: nothing under `_system/` is executed by the app. The application code lives in `src/`, `scripts/`, and root config files (`package.json`, `tsconfig.json`, etc.).

---

## Why `_system/`?

- **Separation of concerns:** Design and context live here; application code lives in `src/` and related runtime paths.
- **Single load point:** AI agents and developers can "load" this directory (and its index) to get full context.
- **Backup clarity:** Full backups of the **application** can exclude or include `_system/` explicitly (see BACKUP_STRATEGY.md).
- **Discoverability:** All system files are in one place; no mixing with controllers, routes, or config that runs the app.

---

## Contents (index)

| File | Role |
|------|------|
| **README.md** | This index; explains _system and points to app vs system vs backup. |
| **MASTER_SYSTEM_PROMPT.md** | Canonical system prompt for any AI working on Ledger Loop. |
| **CURSOR_RULES.md** | Cursor IDE rules; reference from project `.cursorrules` or copy into Cursor settings. |
| **PROMPTS_INDEX.md** | Index of all prompts (PROMPT_PACK_GEMINI, milestones, one-offs). |
| **MCP_CONFIG.md** | MCP (Model Context Protocol) servers and config reference. |
| **SKILLS_INDEX.md** | Skills and capabilities expected of agents (security, API, DB, testing, etc.). |
| **URL_CONTEXTS.md** | Reference URLs (APIs, docs, standards) for design and implementation. |
| **WHERELEFTOFF.md** | Single place for "where we left off" and next-action state. |
| **FIXME_TODO_INDEX.md** | Index of TODO/FIXME/XXX/HACK and where they live. |
| **BACKUP_STRATEGY.md** | One-copy backup at `/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/`; run `scripts/backup-ledgerloop.sh` when requested. |
| **GIT_BRANCH_POLICY.md** | Backup-branch policy for system/prompt/rules snapshots (`backup/system-context`) and no-merge guardrails for `main`. |

---

## Canonical docs (at repo root, referenced by _system)

These remain at repo root for visibility and existing references; _system points to them:

- **AGENT_CONTEXT.md** — Master agent context (load first).
- **PRD.md** — Product requirements.
- **ARCHITECTURE.md** — Stack, modules, constraints.
- **DATA_MODEL.md** — Relational model.
- **NFR.md** — Non-functional requirements.
- **RUNBOOK.md** — Local dev, test, deploy, rollback.
- **TODO.md** — Current task list.
- **PROMPT_PACK_GEMINI.md** — Milestone prompts M0–M9.
- **DEVELOPMENT_STANDARDS.md** — Coding conventions.
- **AI_AGENT_COORDINATION.md** — Multi-agent protocols.
- **architecture/** — API_DESIGN, DB schema, client sync, etc.

---

## How to use

1. **For AI agents:** Load `AGENT_CONTEXT.md` first (root), then `_system/MASTER_SYSTEM_PROMPT.md` and `_system/WHERELEFTOFF.md`. Use other _system files as needed.
2. **For Cursor:** Ensure project `.cursorrules` exists (root) and references `_system/CURSOR_RULES.md` or inlines key rules.
3. **For backups:** Follow `_system/BACKUP_STRATEGY.md` for application vs full backup separation.
4. **For Git backup snapshots:** Follow `_system/GIT_BRANCH_POLICY.md` and keep system/prompt/rules backup commits on `backup/system-context`.

*Last updated: 2026-03-04.*
