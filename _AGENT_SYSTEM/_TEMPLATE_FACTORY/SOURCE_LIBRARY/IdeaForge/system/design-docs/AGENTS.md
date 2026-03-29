# system/design-docs/AGENTS.md — Repo Rules for Agentic Coding Tools

## Mission
Build and maintain IdeaForge as a production-quality, secure-by-default repository that outputs text-first instruction bundles.

## Canonical docs (SSoT)
These documents define truth:
- system/design-docs/PRD.md
- system/design-docs/ARCHITECTURE.md
- system/design-docs/DATA_MODEL.md
- system/design-docs/NFR.md
- system/design-docs/RUNBOOK.if2.md

## Work protocol
1) Plan before implementing.
2) Keep diffs minimal; no unrelated refactors.
3) Never introduce secrets. Use env vars/placeholders only.
4) Add/update tests for every behavior change.
5) Run validation commands from system/design-docs/RUNBOOK.if2.md and report results.
6) For any security boundary, update `logs/THREAT_MODEL_LOG.md`.

## Multi-tool collaboration protocol (Cursor/Codex/Gemini/Claude/Windsurf)
1) One active tool owns edits at a time (single writer model).
2) Every handoff must include:
   - current objective
   - files touched
   - commands run + outcomes
   - known risks/blockers
3) Incoming tool must read latest handoff notes before editing:
   - `WHERE_LEFT_OFF.md`
   - `TODO.md`
   - `FIXME.md`
4) Do not overwrite unresolved in-progress edits from another tool; create a follow-up commit/patch instead.
5) Record provenance in commit/PR notes: tool used, prompt intent, verification evidence.

## Required output for every task
1) Plan (bullets)
2) Files touched (list)
3) Summary (file-by-file)
4) Validation (commands + pass/fail)
5) Risks / follow-ups
