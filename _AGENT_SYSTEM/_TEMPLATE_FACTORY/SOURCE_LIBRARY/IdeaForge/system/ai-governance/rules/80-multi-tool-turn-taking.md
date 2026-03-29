# Multi-Tool Turn-Taking Rule (Cursor, Codex, Gemini, Claude, Windsurf)

## Goal
Prevent conflicting edits and context loss when multiple AI coding tools take turns on the same app.

## Required operating model

1. **Single active writer**
   - Exactly one tool may modify files at any given time.

2. **Handoff packet required between turns**
   - outgoing objective and completion status
   - exact files changed
   - validation commands run + pass/fail
   - remaining blockers/risks

3. **Mandatory handoff files**
   - `WHERE_LEFT_OFF.md`
   - `TODO.md`
   - `FIXME.md`

4. **Conflict policy**
   - Never rewrite another tool’s unresolved edit in place without documenting why.
   - Prefer additive follow-up commits/patches over silent rewrites.

5. **Verification policy per turn**
   - at minimum run impacted tests
   - for runtime changes also run typecheck/lint
   - for launcher/install changes run launcher checks

6. **Tool provenance**
   - In PR/notes, include: tool name, intent, validation evidence, known limits.

## Tool-role suggestions

- Cursor / Windsurf: implementation + refactoring with file-aware context
- Codex: targeted patch generation and review diffs
- Gemini / Claude: design alternatives, threat modeling, doc quality, red-team prompt review

Use role specialization, but keep one writer at a time.
