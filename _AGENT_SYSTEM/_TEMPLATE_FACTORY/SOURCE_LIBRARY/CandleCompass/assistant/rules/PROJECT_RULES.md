# Project Rules

1. Keep all changes runnable from repo root with explicit commands.
2. Default to research or paper-trading assumptions unless user explicitly requests live execution behavior.
3. Do not commit or expose secrets; use `.env`, encrypted storage, and secret tooling.
4. Treat `runs/latest/*` as contract artifacts for UI/API consumers.
5. When schema fields change, update producers, consumers, and data contract docs in one pass.
6. Prefer deterministic scripts and idempotent operations for automation.
7. Include transaction costs, slippage, and risk constraints in any backtest logic.
8. Validate data ingestion paths (schema, timestamps, missing values) before downstream use.
9. Add or update tests for material behavior changes.
10. Use targeted checks first; run broader suites when risk warrants it.
11. Record significant changes in `assistant/context/CHANGELOG.md` and `assistant/context/WHERE_WE_LEFT_OFF.md`.
12. Capture unfinished work, misses, and follow-ups in `assistant/TODO.md`.
13. Maintain only one backup copy; when creating a backup, remove older backups so a single archive is retained.
14. Preserve git connectivity to `origin/main` as an operational guardrail.
15. After major phase work, sync `assistant/TODO.md`, `assistant/context/CURRENT_STATUS.md`, `assistant/context/WHERE_WE_LEFT_OFF.md`, and `assistant/context/CHANGELOG.md` in the same pass.
16. **NEVER use blocking browser dialogs** (`window.alert`, `window.confirm`, `window.prompt`). Always use React modal components (`ConfirmDialog`, `PromptDialog`, `ModalShell`) that support ESC key, click-outside dismissal, and proper close buttons. See `assistant/rules/NO_BLOCKING_DIALOGS.md`.
