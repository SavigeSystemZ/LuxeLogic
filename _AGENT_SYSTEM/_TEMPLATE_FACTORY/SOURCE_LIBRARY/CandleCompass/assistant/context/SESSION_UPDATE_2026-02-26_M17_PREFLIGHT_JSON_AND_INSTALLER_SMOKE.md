# Session Update — 2026-02-26 — M17 Preflight JSON + Installer Smoke Validation

## Summary

Extended the `M17` installer hardening work with a machine-readable preflight mode and a dedicated installer smoke script for regression checks.

## Implemented

- `app/scripts/install_candle_compass.sh`
  - Added `--json` flag (valid only with `--preflight` / `--dry-run`)
  - `--preflight --json` now emits **JSON only** (no banner/text contamination)
  - Preflight JSON includes:
    - installer metadata / target path / requested action
    - system + package manager support status
    - prerequisite version strings
    - service status map (best-effort)
    - planned actions list

- `app/scripts/installer_smoke.sh`
  - Validates installer syntax and non-destructive argument flows:
    - syntax check
    - preflight text output
    - preflight JSON output
    - `--dry-run` alias JSON path
    - argument guard failures (`--json` without preflight, missing/invalid `--action`)
    - combined `--preflight --json --non-interactive --action fresh`

## Validation

- `bash -n app/scripts/install_candle_compass.sh app/scripts/installer_smoke.sh` ✅
- `bash app/scripts/install_candle_compass.sh --preflight --json` ✅
- `bash app/scripts/installer_smoke.sh` ✅

## M17 Remaining Work

- Cross-distro runtime validation on Fedora/Arch package mappings
- Better explicit reuse prompts/statuses for existing Postgres/Redis/Node installations
- Optional CI integration for `installer_smoke.sh`
