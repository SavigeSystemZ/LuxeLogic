# Database Architecture (Distribution-First)

This document is the **canonical database design** for Candle Compass and any other apps in this ecosystem. It ensures the app works for any Linux desktop user without hardcoded credentials.

## Principles

1. **Distribution-first**: The app is built to be distributed to users worldwide. No hardcoded database user (e.g. `postgres` or `whyte`).
2. **Current OS user**: The application **detects the current operating system user** (e.g. `whoami`, `os.getlogin()`, `process.env.USER`) and uses that user to connect to PostgreSQL.
3. **Peer authentication**: We use PostgreSQL **peer authentication** over Unix domain sockets where possible. Connection: host=localhost (or socket), port=5432, user=*detected_OS_user*, password=None.
4. **One database per application**: Each app has its own database (e.g. Candle Compass uses `candlecompass_prod`). No sharing of app data between applications.
5. **Setup once**: A single `setup_db` script is run once after install. It creates the DB (owned by the current user), initializes schema, and handles legacy ownership.

## Candle Compass specifics

- **App name**: Candle Compass  
- **Database name**: `candlecompass_prod`  
- **High-frequency data**: The setup script may recommend or apply WAL/checkpoint tuning for performance; connection logic remains standard peer auth.  
- **Default**: SQLite remains supported for zero-dependency runs; Postgres is optional and follows this architecture when enabled.

## Connection logic (implementation)

- If `CANDLE_COMPASS_DATABASE_URL` is set: use it (explicit override for CI/remote).
- Else when using Postgres:
  - **Peer mode** (default for desktop): Detect OS user; connect with that user, no password. Prefer Unix socket (omit host or use socket dir) so peer auth applies.
  - **Explicit user/password**: Only when config or env sets `user`/`password` (e.g. non-peer deployments).

## Setup script contract

The `setup_db` script (Python or Bash) must:

1. **Detect** the current OS user.
2. **Check** if the database (e.g. `candlecompass_prod`) exists and who owns it.
3. **If missing**: Create the database and assign ownership to the current OS user (via `postgres` superuser: `CREATE DATABASE ... OWNER current_user`).
4. **Initialize** schema (tables/indexes) if the DB is empty; if the DB already exists, run idempotent migrations.
5. **Legacy handling**: If the database exists but is owned by a different user (e.g. from a previous install or another OS user), **alert** the user and optionally offer to run `ALTER DATABASE ... OWNER TO current_user` (as postgres) to fix permissions.

## Why this works for distribution

- Alice downloads Candle Compass, runs `./setup_db.sh` (or `python scripts/setup_db.py`).
- The script sees she is user `alice`, creates `candlecompass_prod` owned by `alice`.
- The app starts, detects it is running as `alice`, and connects to Postgres as `alice` via peer auth.
- No passwords, no config files to edit, no permission errors.

## References

- Ops runbook: `assistant/resources/docs/OPS_RUNBOOK.md` (Database section)
- Schema: `app/engine/db/init_postgres.sql`
- Setup script: `app/scripts/setup_db.py`; shell wrapper: `app/scripts/setup_db.sh`
