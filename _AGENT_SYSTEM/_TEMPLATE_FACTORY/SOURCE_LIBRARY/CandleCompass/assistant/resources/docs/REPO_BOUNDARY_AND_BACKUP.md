# Repository Boundary and Backup Policy

This document defines the **three-way separation** between (1) application runtime code, (2) system/design files used to build the app, and (3) backups. Multiple AI agents (Cursor, Windsurf, Codex, Gemini, Claude, etc.) use this boundary so runtime stays clean and handoffs stay coherent. See `assistant/AGENTS_AND_SYSTEM.md` for multi-agent handoff.

## 1. Three-Way Boundary Model

### 1.1 Runtime Application Surface
- **Path**: `app/` (and root-level symlinks into `app/` where present).
- **Purpose**: All code and assets that **run** Candle Compass. Ship and execute only from here.
- **Includes**:
  - backend runtime (`app/main.py`, `app/src/*`)
  - frontend runtime (`app/ui-next/*`)
  - runtime scripts (`app/scripts/*`)
  - runtime config and data under `app/` (e.g. `app/config.yaml`, `app/data/`, `app/runs/*`)
- **Rule**: No imports or runtime dependency on `assistant/`. The app must run without any `assistant/` files.

### 1.2 System Design Surface
- **Path**: `assistant/`
- **Purpose**: Prompts, skills, rules, architecture notes, context memory, and coding-system instructions. Used by humans and AI agents to **design and build** the app, not to run it.
- **Includes**:
  - `assistant/MASTER_SYSTEM_PROMPT.md`, `assistant/AGENTS_AND_SYSTEM.md`
  - `assistant/rules/*`, `assistant/skills/*`, `assistant/prompts/*`
  - `assistant/context/*` (WHERE_WE_LEFT_OFF, TODO, FIXME, CURRENT_STATUS, etc.)
  - `assistant/resources/docs/*`, `assistant/resources/mcp/*`
- **Rule**: System files may reference `app/` paths for documentation and automation, but runtime must never depend on `assistant/`.

### 1.3 Backup and Non-Runtime Tracks
- **Paths**: External backup root (e.g. `$HOME/.BackupZ-MyAppZ/CandleCompass.bak`) and optional Git branches (`backup/state`, `system/files`).
- **Purpose**: Snapshots and procedure/state history. **Logically separate** from both runtime and system so that:
  - Restores don’t overwrite live code or system files by mistake.
  - Backup policy and retention live outside the main release flow.
- **Rule**: Backups and branch-only tracks are not part of the default app run path; keep them distinct in docs and scripts.

## 2. Operational Rules
- Runtime behavior must **not** depend on files under `assistant/`.
- `assistant/` is metadata/process control for development and multi-agent handoff, not runtime app logic.
- Keep runtime logic in `app/` and developer/system process logic in `assistant/`.
- Keep backup artifacts and backup-only branches separate from both `app/` and `assistant/` in policy and tooling.

## 3. Internal Manual Backup (One Copy Only)

**Policy: one copy only.** The internal manual backup process keeps a **single** backup at the designated directory. First run creates the copy; subsequent runs replace/update that one copy. Do not retain multiple manual backup archives.

**Canonical backup location:**
- `$HOME/.BackupZ-MyAppZ/CandleCompass.bak` (e.g. `/home/whyte/.BackupZ-MyAppZ/CandleCompass.bak`)

Scripts:
```bash
# Manual one-off backup (single copy retained in OUT_DIR)
bash app/scripts/backup_project.sh /path/to/repo $HOME/.BackupZ-MyAppZ/CandleCompass.bak

# External rotation (creates snapshot, keeps 1 by default)
bash scripts/rotate_external_backups.sh
```

Defaults:
- Backup root: `$HOME/.BackupZ-MyAppZ/CandleCompass.bak`
- Retention: **1** archive (single copy; older archives in that directory are removed after creating a new one)
- Archive format: `CandleCompass_snapshot_<UTC_TIMESTAMP>.tar.gz` or `CandleCompass_backup_<TIMESTAMP>.tar.gz`

Custom usage:
```bash
bash scripts/rotate_external_backups.sh /path/to/repo /path/to/backup/root 1
```

Override via environment (optional):
- `CANDLE_COMPASS_EXTERNAL_BACKUP_DIR` — backup root (default: `$HOME/.BackupZ-MyAppZ/CandleCompass.bak`)

Status artifact:
- `app/runs/latest/external_backup_status.json`

**Old locations (no longer used):**  
`~/.candle_compass_external_backups/RSIGlobe` and `~/.BackupZMyAppZ` (without hyphen) are deprecated. After ensuring the new path holds your single backup, you can remove those directories if present; nothing crucial should remain there.

### Restore drill checklist (single-copy backup)

When restoring from `$HOME/.BackupZ-MyAppZ/CandleCompass.bak`:

1. **Identify the archive:** List `ls -la $HOME/.BackupZ-MyAppZ/CandleCompass.bak/` and note the latest `CandleCompass_snapshot_*.tar.gz` or `CandleCompass_backup_*.tar.gz`.
2. **Extract to a staging directory:** `mkdir -p /tmp/cc_restore && tar -xzf /path/to/CandleCompass_snapshot_YYYYMMDDTHHMMSSZ.tar.gz -C /tmp/cc_restore`.
3. **Compare critical paths:** Check `app/runs/latest/`, `app/config.yaml`, and any env or secrets references. Do not overwrite a live app root without a separate backup of the current state.
4. **Restore selectively or fully:** Copy only needed files (e.g. `runtime_role_policy.json`, `strategy_lab_templates.json`) into the live repo, or replace the entire repo from the archive if doing a full restore.
5. **Re-run setup if needed:** After full restore, run `./scripts/setup_db.sh` if using Postgres, reinstall services if desired, and run a quick health check (`python app/scripts/validate_artifacts.py --runs app/runs`, `python app/scripts/e2e_smoke.py --runs app/runs/latest --strict`).
6. **Document:** Note restore date and archive name in your runbook or change log.

## 4. Branch Strategy for Non-Runtime Tracks (Three-Branch Workflow)

The current single-developer workflow may use the following branches:

- `main`
  - primary production/runtime development branch
  - source of truth for deployable Candle Compass code
- `backup`
  - redundant mirror of `main` for recovery purposes
  - should not be directly edited except by explicit backup/recovery workflows
- `design/tools` (or equivalent design branch name)
  - prompts, templates, architecture docs, AI tool artifacts, process/system docs
  - no runtime app code should live here

Compatibility note:
- Older docs may reference `system/files` and `backup/state`. If those names exist in your repo history, treat them as legacy operational branches unless explicitly retained.

Policy:
- Do not merge `backup` into runtime release flow.
- Keep runtime code changes on `main` unless intentionally performing branch sync/recovery.
- Treat `design/tools` as a design/process surface (prompts, docs, templates, AI artifacts), not a runtime code branch.
- Prefer automation/scripts for `main -> backup` sync after validation checkpoints.

Recommended safeguards:
- local branch-guard hooks to block direct commits/pushes to `backup`
- explicit confirmation when committing runtime files while on `design/tools`
- documented recovery and sync scripts in `app/scripts/` or `assistant/commands/`

### Standardized Sync Workflows

Use these scripts after validation checkpoints instead of direct branch pushes:

```bash
# Mirror the current validated commit to a backup branch.
bash app/scripts/git_sync_backup_branch.sh --branch backup/rolling --push

# Publish the design/system surface listed in the manifest to design/tools.
bash app/scripts/git_sync_design_branch.sh --branch design/tools --push
```

Notes:
- `git_sync_backup_branch.sh` mirrors a chosen source ref to `backup/*`.
- `git_sync_design_branch.sh` publishes only manifest-listed paths (default: `AGENTS.md`, `assistant/`, `.githooks/`) to `design/*`.
- Both scripts support `--dry-run` for proof before push.
- The design publish manifest lives at `assistant/resources/design_tools_manifest.txt`.

## 5. Verification Checklist

After major changes (and before handoff to another agent):
1. Confirm app still builds/tests from `app/` (no dependency on `assistant/`).
2. Confirm system files are still confined to `assistant/`.
3. Run backup rotation once and verify status artifact (if using external backups).
4. Update:
   - `assistant/TODO.md` (mark done, add next steps/phases).
   - `assistant/FIXME.md` (if new gaps found).
   - `assistant/context/WHERE_WE_LEFT_OFF.md` (what was done, validation results).
5. If you added or changed system files, add them to `assistant/FULL_CONTEXT_INDEX.md` and, if critical, to `assistant/ASSISTANT_LOADOUT.md` and `assistant/memory_ingest.yaml`.
