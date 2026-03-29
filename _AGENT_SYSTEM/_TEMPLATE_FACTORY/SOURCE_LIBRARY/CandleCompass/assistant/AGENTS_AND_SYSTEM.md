# Multi-Agent Development System: Candle Compass

This document is the **single source of truth** for how the Candle Compass application is designed, coded, built, and improved by **multiple AI coding agents** that take turns. The system must know which agents exist and how to hand off work so the application stays coherent and world-class.

## 1. Recognized AI Coding Agents

The following agents may design, code, build, architect, or improve Candle Compass. **Always assume you are one of several agents**; never assume you are the only one editing the repo.

| Agent   | Typical role / context |
|--------|--------------------------|
| Cursor | IDE-integrated; rules, prompts, multi-file edits, Composer |
| Windsurf | IDE-integrated; codebase navigation, agentic workflows |
| Codex   | GitHub/OpenAI; completions, refactors, CLI-style context |
| Gemini  | Google; broad context, multi-modal, API or IDE |
| Claude  | Anthropic; long context, design and architecture, API or IDE |

**Others**: Any future agent (e.g. Copilot, Cody, custom models) should follow this same system: read `assistant/` context first, respect runtime vs system separation, and update `TODO.md` / `WHERE_WE_LEFT_OFF.md` on handoff.

## 2. Why This Matters

- **Continuity**: The next agent (or human) must know what was done and what is next without re-deriving everything.
- **No double work**: Avoid duplicate features or conflicting patterns by using shared context.
- **Quality**: Shared rules and prompts keep code style, safety, and architecture consistent across agents.
- **Handoff**: When a session ends or an agent switches, the next one should resume from `WHERE_WE_LEFT_OFF.md` and `TODO.md`.

## 3. Single Source of Truth (What to Load)

Every agent should load, in order:

1. **Operating contract**  
   - `assistant/MASTER_SYSTEM_PROMPT.md`  
   - `assistant/rules/PROJECT_RULES.md`  
   - `assistant/context/RULES_USER.md`  
   - **This file**: `assistant/AGENTS_AND_SYSTEM.md`

2. **Current state**  
   - `assistant/context/WHERE_WE_LEFT_OFF.md` — last session and recent changes  
   - `assistant/context/CURRENT_STATUS.md` — high-level status  
   - `assistant/TODO.md` — active priorities, next steps, phases, backlog  
   - `assistant/FIXME.md` — known gaps and follow-ups  

3. **Execution references** (task-dependent)  
   - `assistant/ASSISTANT_LOADOUT.md` — full load order  
   - `assistant/FULL_CONTEXT_INDEX.md` — index of all system files  
   - `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md` — runtime vs system vs backup  

4. **Prompts, skills, MCP** (as needed)  
   - `assistant/prompts/*`  
   - `assistant/skills/*`  
   - `assistant/resources/mcp/` — MCP config (e.g. candle_compass memory)  

## 4. Repository Boundaries (Critical)

- **Runtime application**: `app/` only. Code that runs the product (backend, UI, scripts, `app/runs/*`). No agent should make runtime behavior depend on `assistant/`.
- **System / design layer**: `assistant/` only. Prompts, rules, skills, context, docs that guide how we build. Not executed by the app.
- **Backups**: External dir (e.g. `~/.BackupZ-MyAppZ/CandleCompass.bak` (one copy only; old path `~/.candle_compass_external_backups/RSIGlobe` deprecated)) and optional branches (`backup/state`, `system/files`). Separate from both runtime and system so restores and history don’t mix with live code.

Keep these three **logically separate** so that:
- The app can run and ship from `app/` without `assistant/`.
- System files can be updated by any agent without breaking the app.
- Backups don’t overwrite or confuse runtime or system files.

## 5. Handoff Protocol (When Interrupted or Switching Agents)

Before ending a session or when handing off:

1. **Update** `assistant/context/WHERE_WE_LEFT_OFF.md`:  
   - What was just done (brief bullet list).  
   - Validation commands run and result (e.g. pytest, lint, build).  
   - Any open decision or blocker.

2. **Update** `assistant/TODO.md`:  
   - Mark completed items `(done)`.  
   - Add any new next step, phase, or suggestion.  
   - Keep "Next best steps / phases" and "If interrupted" section current.

3. **If you created or changed system files**:  
   - Ensure they live under `assistant/` (or `app/` only for runtime).  
   - Add new files to `assistant/FULL_CONTEXT_INDEX.md` and, if critical, to `assistant/ASSISTANT_LOADOUT.md` and `assistant/memory_ingest.yaml`.

4. **Optional**: Bump or append `assistant/context/CHANGELOG.md` for user-visible or architecturally significant changes.

## 6. Best Practices for World-Class Outcomes

- **Read before writing**: Always read the relevant context (WHERE_WE_LEFT_OFF, TODO, FIXME, rules) before making changes.
- **One source of truth**: Prefer updating existing docs (e.g. TODO, WHERE_WE_LEFT_OFF) over creating parallel lists.
- **Small, coherent changes**: Prefer minimal diffs; keep runtime and system changes in separate commits when useful.
- **Validate**: Run the appropriate checks (lint, tests, build, smoke) and record results in WHERE_WE_LEFT_OFF or TODO.
- **No secrets in repo**: Never commit API keys or secrets; use env and secure storage.
- **Research-first**: Default to research/backtest; no live trading without explicit user intent and safeguards.

## 7. Application Identity

- **Name**: Candle Compass  
- **Purpose**: High-precision algorithmic trading intelligence platform (research and backtesting; no implicit live trading).  
- **Location**: This repo lives under `.MyAppZ/CandleCompass`; runtime is under `app/`, system under `assistant/`.

---

*Last updated: 2026-02-17. Keep this file in sync when adding agents or changing handoff rules.*
