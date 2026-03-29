# Developer Prompt Template

- Primary language: Python (typed and testable).
- Prefer vectorized numeric/data operations where practical.
- Use clear module boundaries and avoid hidden side effects.
- Add concise logs at critical decision points.
- Add or update tests for meaningful behavior changes.
- For UI work, ensure responsive layout and intentional visual hierarchy.
- For schema changes, update:
  - producer scripts,
  - UI/API consumers,
  - `assistant/resources/docs/UI_DATA_CONTRACT.md`.
- After major work, update:
  - `assistant/context/CHANGELOG.md`,
  - `assistant/context/WHERE_WE_LEFT_OFF.md`,
  - `assistant/TODO.md` (for any pending items).
