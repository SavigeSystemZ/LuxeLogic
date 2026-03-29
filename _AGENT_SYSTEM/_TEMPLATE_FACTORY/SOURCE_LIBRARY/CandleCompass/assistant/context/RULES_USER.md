# User-Specified Rules

- Maintain persistent context and memory files.
- Create rules for any user rules provided in the future.
- Reference context files from master system prompt.
- Maintain at most **one** manual backup copy; when creating a backup, remove older backups so only one is retained. Do not create multiple backup archives.
- Any suggestion or item phrased as a question for future work must be added to `assistant/TODO.md` (or another explicit backlog list) for later follow-up.
- If anything is missed, overlooked, skipped, or cannot be completed, add it to `assistant/TODO.md` and call it out explicitly.
- Keep the assistant stack optimized for strong programming execution and intentional UI design quality (prompts, rules, skills, and context must stay coherent).
- For Candle Compass execution, any phase, step, task, part, or work item created in planning or implementation must be added to `assistant/TODO.md`.
- After major implementation batches, context files must be refreshed to current truth (`CURRENT_STATUS`, `WHERE_WE_LEFT_OFF`, `CHANGELOG`, `TODO`).
- **Multi-agent handoff**: At session start, read `assistant/AGENTS_AND_SYSTEM.md`, `assistant/context/WHERE_WE_LEFT_OFF.md`, and `assistant/TODO.md` so work continues correctly regardless of which agent (Cursor, Windsurf, Codex, Gemini, Claude, etc.) last edited the repo. On handoff, update WHERE_WE_LEFT_OFF and TODO with what was done and what is next.
