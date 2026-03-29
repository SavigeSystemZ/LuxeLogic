# Session Update — 2026-02-26 (Installer / Launcher Remediation)

## Trigger
User provided fresh-install output showing:
- Postgres setup failure during installer DB step (while installer text claimed SQLite),
- install hydration traceback (`ImportError: AlertOnly`),
- desktop launcher icon not appearing as expected,
- manual `launch_ui_detached.sh` failure with `/usr/bin/env: node: No such file or directory`.

## Root Causes Identified
1. Installer DB step called `scripts/setup_db.py` (Postgres-focused) unconditionally.
2. `src.strategies.__init__` imported Strategy Lab builder exports eagerly, breaking unrelated hydration/backtest flows if builder import failed.
3. Desktop launcher creation only targeted Desktop path and used a direct SVG path without local icon install/app-menu registration.
4. `launch_ui_detached.sh` supported local `next` binary fallback but not Node/NVM PATH bootstrapping, so `next` shebang failed under minimal environments.
5. `setup_db.py` hardcoded `-h localhost`, conflicting with project’s peer-auth/socket-first PostgreSQL design.

## Fixes Implemented
- Added `app/scripts/ensure_data_lake.py` (SQLite required, Postgres optional if configured).
- Updated installer to use `ensure_data_lake.py` and prefer `hydrate_all.sh` for resilient artifact hydration.
- Updated desktop launcher generator to:
  - detect Desktop path more reliably,
  - create Desktop + App Menu launchers,
  - install compass icon to local icon directories (with optional PNG conversion).
- Updated desktop entry point + detached launcher for first-launch DB bootstrap and stronger failure diagnostics.
- Added NVM/Node environment bootstrapping in `launch_ui_detached.sh`.
- Relaxed `src.strategies` builder import to optional, preventing hydration import crashes.
- Updated `setup_db.py` to use local socket/peer auth by default (no forced `localhost`).

## Validation
- `bash -n` on updated shell scripts -> pass
- `python3 -m py_compile` on updated Python scripts -> pass
- `PYTHONPATH=app .venv/bin/python -c 'import src.strategies'` -> pass
- Desktop launcher dry-run -> Desktop file + app menu file created; icon installed in `~/.local/share/icons/...`

## Next Verification (Manual Host)
1. Run installer option `1` again and confirm:
   - DB step initializes SQLite successfully,
   - hydration no longer crashes on `AlertOnly`,
   - Desktop + App Menu launchers exist,
   - compass icon renders.
2. Launch installed app via `/opt/CandleCompass/scripts/launch_ui_detached.sh` and desktop icon; confirm no NVM/Node PATH failure.
