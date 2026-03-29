# Ledger Loop — Backup Strategy

**Purpose:** Define what to backup, where to store it, and how to keep **application** backups logically separate from **design/context** and from the live repo. Ensures the Ledger Loop application can be restored and that system/prompt/rule files are versioned and recoverable.

---

## Internal manual backup: one copy only

- **Policy:** We maintain **only one** internal manual backup of the app. No duplicate backup copies or alternate backup directories; a single destination is used.
- **Location:** Backups are stored at:
  **`/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/`**
- **Behavior:** First run = full copy into that directory. Subsequent runs = **sync**: only changed files are updated, so the one copy stays current without creating additional copies.
- **Script:** `scripts/backup-ledgerloop.sh`
  - Usage: `[BACKUP_DEST=/path] bash scripts/backup-ledgerloop.sh`
  - Default: `BACKUP_DEST=/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak` (can override if needed).
  - Uses `rsync` when available (sync = only changes after first copy); falls back to tar extract if rsync is not installed.
- **Retiring old locations:** Any previous backup location (e.g. `/var/backups/ledgerloop` or timestamped tar.gz elsewhere) is superseded by this single directory. After confirming the new backup at the path above works, old copies can be removed to avoid confusion and duplication. Do not delete anything until the new backup has been run and verified.

---

## Logical separation (three layers)

| Layer | Contents | Purpose |
|-------|----------|---------|
| **Application (runtime)** | Code and config that **run** the app: `src/`, `scripts/` (launch, deploy, DB setup), `package.json`, `package-lock.json`, `tsconfig*.json`, `jest.config.js`, `docker-compose.yml`, `install.sh`, root `.env.example` (no secrets). | Deploy, run, restore a working app. |
| **System / design / context** | Design and meta files that **do not run**: `_system/`, root docs (PRD, ARCHITECTURE, DATA_MODEL, NFR, RUNBOOK, TODO, AGENT_CONTEXT, DEVELOPMENT_STANDARDS, AI_AGENT_COORDINATION, PROMPT_PACK_GEMINI), `architecture/`, `docs/`. | Recreate context for development and AI; restore prompts, rules, MCP ref, backup strategy. |
| **Full repo** | Application + system + Git history (`.git/`). Optionally: `.cursorrules`, `.cursorignore`, `.env` (only in secure backup; never in shared repo). | Full history and collaboration. |

---

## What gets backed up (sync contents)

The script syncs the full repo into the backup directory, **excluding**:

- `node_modules/`, `dist/`, `client/dist/`, `coverage/`
- `.git/` (optional; exclude keeps backup smaller; include if you want history in the backup)
- `.env` (secrets; never in backup)
- `*.log`

So the **one copy** at `/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/` contains application + system + root docs + architecture (and optionally `.git` if you change the script). Restore by copying from that directory and running `npm install`, `npm run build`, then DB/migrate/start as in RUNBOOK.

---

## Restore procedures

### Restore from the internal backup (one-copy directory)

1. Copy or rsync from `/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/` to the desired restore path (e.g. a new repo clone or `/opt/ledgerloop`).
2. Run `npm install`, `npm run build`.
3. Configure DB (e.g. run `scripts/setup-database.sh` or set `DATABASE_URL` in `.env`).
4. Run migrations if present.
5. Start app: `npm start` or systemd service if installed.

### Restore from Git

- Clone or pull from the canonical repo; then run install/build/DB/migrate/start as above. Use this backup strategy only when you also want a second, internal copy at the path above.

---

## Summary

- **One copy only:** Single internal manual backup at **`/home/whyte/.BackupZ-MyAppZ/LedgerLoop.bak/`**.
- **On request:** Run `scripts/backup-ledgerloop.sh`; first time = full copy, then only changes are synced.
- **Old locations:** Superseded; can be retired after the new backup is verified. Do not remove anything until the new backup has been run and checked.

*Backup strategy is in `_system/BACKUP_STRATEGY.md`. Application code is in `src/`.*
