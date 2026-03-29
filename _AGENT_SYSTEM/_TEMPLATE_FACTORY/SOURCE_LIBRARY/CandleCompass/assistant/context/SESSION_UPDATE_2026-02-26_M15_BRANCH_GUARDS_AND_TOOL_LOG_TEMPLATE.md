# Session Update — 2026-02-26 — M15 Branch Guards + Tool Log Template

## Summary

Implemented local git hook guardrails for the `main / backup / design/tools` workflow and added a reusable AI tool usage log template for milestone tracking across Codex/Cursor/Gemini/Windsurf/Claude.

## Implemented

- `.githooks/pre-commit`
  - Preserves existing context-update behavior
  - Blocks direct commits to `backup` / `backup/*` unless:
    - `CANDLE_COMPASS_ALLOW_BACKUP_BRANCH_COMMIT=1`
  - Blocks runtime code commits on `design` / `design/tools` / `design/*` unless:
    - `CANDLE_COMPASS_ALLOW_DESIGN_RUNTIME_COMMIT=1`

- `.githooks/pre-push`
  - Blocks direct pushes to `backup` / `backup/*` unless:
    - `CANDLE_COMPASS_ALLOW_BACKUP_PUSH=1`
  - Requires explicit confirmation for pushes to `design` / `design/*` unless:
    - `CANDLE_COMPASS_ALLOW_DESIGN_PUSH=1`

- `app/scripts/install_git_hooks.sh`
  - Installs/chmods both `pre-commit` and `pre-push`
  - Prints active hook summary

- `assistant/resources/docs/AI_TOOL_USAGE_LOG_TEMPLATE.md`
  - Milestone-level template for recording:
    - tool
    - prompt pack
    - constraints
    - validation
    - issues / quirks
    - commits and handoff notes

- `assistant/FULL_CONTEXT_INDEX.md`
  - Indexed the new tool-usage log template

## Validation

- `bash -n .githooks/pre-commit .githooks/pre-push app/scripts/install_git_hooks.sh` ✅
- `bash app/scripts/install_git_hooks.sh` ✅

## Remaining M15 Follow-up

- Formalize automated `main -> backup` sync workflow in CI or a documented script path
- Optionally add a `design/tools` sync/publish helper for prompt-pack artifacts only
