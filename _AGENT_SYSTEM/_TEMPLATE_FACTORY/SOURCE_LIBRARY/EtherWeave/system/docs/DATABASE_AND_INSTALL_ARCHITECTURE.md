# Database and Install Architecture — Distribution-First

This document defines how Etherweave handles **database** and **install** so the app works for **any user** who installs it, without hardcoded usernames or tutorial-style config. It is binding for app code and install scripts.

---

## 1. Distribution-first mentality

- **Do NOT hardcode** the database user as `postgres`, `whyte`, or any specific OS username.
- **Always use the current OS user** for:
  - SQLite: database and data paths under that user’s home or XDG data dir.
  - PostgreSQL (if used later): connection user = current OS user; Peer Authentication (Unix sockets).
- **Detection:** Use `os.getlogin()`, `os.environ.get("USER")`, or `pathlib.Path.home()` so the running process’s user owns data and connections. Never assume a fixed username.

---

## 2. Current stack: SQLite (user-scoped paths)

Etherweave uses **SQLite** for the main app and project DBs. All DB files must live under a **user data directory** that is:

- Derived from the **current OS user** (e.g. `Path.home() / ".etherweave"` or `$XDG_DATA_HOME/etherweave`).
- Created on first use; install/setup ensures the directory exists and is writable by the installing user.

**Canonical helper:** `etherweave.lib.user_data.get_etherweave_data_dir()` returns the Path for the current user. Use it for:

- Main network DB: `get_etherweave_data_dir() / "etherweave.db"`
- Project/engagement DB: `get_etherweave_data_dir() / "etherweave_pro.db"`
- Evidence/audit: `get_etherweave_data_dir() / "evidence" / engagement_id / "audit.db"`

No relative paths like `./evidence/` or `etherweave_pro.db` in the default app path; those break distribution when the process cwd is not the repo.

---

## 3. Setup script (auto-deploy)

A **setup_data** step (script or install phase) must:

1. **Detect the current OS user** (e.g. `whoami`, `$USER`, or the user running the script).
2. **Ensure the user data directory exists** (e.g. `~/.etherweave` or `$XDG_DATA_HOME/etherweave`) and is writable by that user.
3. **Not create or own DBs as root** unless the app is explicitly run as root; for normal installs, the installing user must own the data dir.
4. **Idempotent:** Safe to run multiple times (mkdir -p, no overwrite of existing DBs).

Schema creation remains in app code (e.g. `CREATE TABLE IF NOT EXISTS` on first connect). The setup script only ensures the directory and permissions.

**Script:** `scripts/setup_data.sh` (and/or Python `scripts/setup_data.py`) — run once after install or as part of `install.sh`.

---

## 4. Legacy handling

- If a DB file or directory already exists but is **owned by another user** (e.g. from a previous install as root or another account), the setup script or app should:
  - **Detect** the mismatch (e.g. current user vs owner of `~/.etherweave`).
  - **Alert** the user with a clear message, and/or
  - **Suggest** fixing ownership (e.g. `chown -R $USER:$USER ~/.etherweave`) or re-running setup as that user.
- Do not silently overwrite or assume ownership; prefer prompting or documenting the fix.

---

## 5. Optional: PostgreSQL (future)

If Etherweave adds PostgreSQL as an option:

- **Connection:** Host=`localhost` (or socket dir), Port=5432, User=**detected OS user**, Password=None (Peer authentication).
- **Setup script:** Create database (e.g. `etherweave_prod`) if missing; assign ownership to the **current OS user**; run idempotent migrations.
- **Legacy:** If the DB exists but is owned by another user (e.g. `postgres` or an old username), alert and optionally offer `ALTER DATABASE ... OWNER TO current_user` (or document the manual fix).

This section is normative when PostgreSQL is introduced; until then, SQLite + user data dir is the standard.

---

## 6. Install best practices (summary)

- **Install script** (`install.sh`): Run as the user who will run the app, or explicitly create/write data dir as that user (e.g. `sudo -u "$original_user"` for any dir under home).
- **Venv:** Prefer creating the venv as the target user so all app-run-as-user behavior is consistent.
- **Desktop icons:** Point to launchers that run as the user (no hardcoded paths that assume one username).
- **Docs:** Document “run setup_data after install” and “if you see permission errors, ensure ~/.etherweave is owned by your user.”

---

## 7. References

- App code: `etherweave.lib.user_data`, `etherweave.lib.database`, `etherweave.lib.project_manager`
- Setup: `scripts/setup_data.sh`, `install.sh` (calls or documents setup_data)
- Load order / governance: `AGENTS.md`, `PROJECT_RULES.md`, `docs/CODING_SYSTEM_INDEX.md`
