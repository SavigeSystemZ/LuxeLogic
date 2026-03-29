---
name: ops-automation
description: Build and maintain Candle Compass automation scripts, scheduled jobs, service wrappers, and operational runbooks. Use when updating launch/stop/status flows, timers, health checks, backups, or bundle refresh operations.
---

# Ops Automation

## Workflow
1. Identify the operational workflow and failure modes.
2. Implement or adjust scripts in `app/scripts/` with safe rerun behavior.
3. Ensure PID/log handling is deterministic for long-running jobs.
4. For emergency-control changes, keep Ghost protocol controls aligned (`token`, allowlist, cooldown, status artifact).
5. Update runbook docs and command catalogs.
6. Validate with dry-run/status checks.

## Validation
- `bash scripts/ui_status.sh`
- `python scripts/health_check.py`
- `python scripts/ui_health_check.py --runs runs/latest`
- `python -m pytest -q tests/test_execution_router.py`

## Output Checklist
- Scripts are idempotent and operator-friendly.
- Failure states are visible and recoverable.
- Docs and command aliases match runtime behavior.

## References
- `references/ops-commands.md`
- `references/health-checks.md`
