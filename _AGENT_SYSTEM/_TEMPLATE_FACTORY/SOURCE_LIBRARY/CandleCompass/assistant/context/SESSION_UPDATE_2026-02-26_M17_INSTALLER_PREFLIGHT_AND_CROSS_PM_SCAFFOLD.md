# Session Update — 2026-02-26 — M17 Installer Preflight + Cross-Package-Manager Scaffold

## Summary

Started `M17` (Installer & Platform Hardening) by extending the installer with cross-package-manager detection, a safe preflight/dry-run mode, non-interactive action parsing, and clearer section headers.

## Implemented

- `app/scripts/install_candle_compass.sh`
  - Added CLI parsing:
    - `--preflight`
    - `--dry-run` (alias for preflight)
    - `--non-interactive`
    - `--action fresh|repair|purge`
  - Added package manager detection:
    - `apt`
    - `dnf`
    - `yum`
    - `pacman`
  - Updated dependency install path to branch by detected package manager
  - Added `print_preflight_report()`:
    - prerequisite versions/statuses (python, pip, node, npm, psql, redis-server, systemctl)
    - best-effort service status checks
    - planned action summary
  - Added installer section headers for major phases (artifact copy, python deps, UI build, DB init, hydration, desktop integration)
  - Added Redis service unit fallback checks (`redis-server` or `redis`)

## Validation

- `bash -n app/scripts/install_candle_compass.sh` ✅
- `bash app/scripts/install_candle_compass.sh --preflight` ✅
  - confirmed no side effects and clean prerequisite/planned-actions report

## Remaining M17 Follow-up

- Validate package mappings on non-apt distros (Fedora/Arch)
- Improve explicit reuse prompts for existing Node/Postgres/Redis installations (currently package managers no-op on installed packages; DB reuse is already interactive)
- Optional: add `--preflight --json` output for CI/automation checks
