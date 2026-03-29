# AI Tool Usage Log Template (Single-Developer / Multi-Tool Workflow)

Use this template to record which AI coding tool was used for each milestone or major change set.

## Entry

- Date (UTC):
- Milestone / Phase:
- Branch:
- Tool:
  - `Codex` / `Cursor` / `Gemini` / `Windsurf` / `Claude` / other
- Prompt Pack / Prompt File:
- Goal Summary:
- Files Touched:
- Constraints Given:
- Validation Run:
  - lint:
  - tests:
  - build:
  - manual checks:
- Issues / Tool Quirks:
- Follow-up Needed:
- Final Commit(s):
- Notes for Next Tool Session:

## Usage Notes

- Record one entry per substantial work batch (not every tiny edit).
- Include exact validation commands when possible.
- If the tool produced incorrect code, note the failure mode so future prompt packs can be tightened.
- Link to the relevant session update file in `assistant/context/` when applicable.
