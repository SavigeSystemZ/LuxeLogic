# Full Context Index

## Core Operating Files
- Master system prompt: `assistant/MASTER_SYSTEM_PROMPT.md`
- Multi-agent system and handoff: `assistant/AGENTS_AND_SYSTEM.md`
- Assistant load order: `assistant/ASSISTANT_LOADOUT.md`
- Project rules: `assistant/rules/PROJECT_RULES.md`
- Memory rules: `assistant/rules/MEMORY_RULES.md`
- User constraints: `assistant/context/RULES_USER.md`
- Backlog and next steps: `assistant/TODO.md`
- Known gaps: `assistant/FIXME.md`

## Prompt Templates
- `assistant/prompts/system_prompt_template.md`
- `assistant/prompts/developer_prompt_template.md`
- `assistant/prompts/user_prompt_template.md`
- `assistant/prompts/M1_DASHBOARD_FRAMEWORK_PROMPT_PACK.md` (UIA Blueprint milestone prompt pack: Cursor/Codex/Gemini/Windsurf/Windsor/Claude)
- `assistant/prompts/M12_M16_ADDENDUM_PROMPT_PACK.md` (UIA Addendum milestones: multi-tool prompt-pack template)
- `assistant/prompts/M17_M23_EXPANSION_PROMPT_PACK.md` (post‑2026‑02‑26 milestone prompt pack: Cursor/Codex/Gemini/Windsurf/Windsor/Claude)

## Skills
- Skill catalog root: `assistant/skills/`
- Advisory pipeline: `assistant/skills/advisory-pipeline/SKILL.md`
- Backtesting: `assistant/skills/backtesting/SKILL.md`
- Data ingestion: `assistant/skills/data-ingestion/SKILL.md`
- Memory ops: `assistant/skills/memory-ops/SKILL.md`
- Ops automation: `assistant/skills/ops-automation/SKILL.md`
- Risk management: `assistant/skills/risk-management/SKILL.md`
- Strategy design: `assistant/skills/strategy-design/SKILL.md`
- UI console: `assistant/skills/ui-console/SKILL.md`

## Context Continuity
- Active backlog: `assistant/TODO.md`
- Current status: `assistant/context/CURRENT_STATUS.md`
- Where we left off: `assistant/context/WHERE_WE_LEFT_OFF.md`
- Change log: `assistant/context/CHANGELOG.md`
- Status report (session snapshot): `assistant/context/STATUS_REPORT_2026-02-18.md`
- Phase audit: `assistant/context/PHASE_AUDIT.md`
- Decisions: `assistant/context/DECISIONS.md`
- Long-term memory notes: `assistant/context/MEMORY.md`
- Nightly checklist: `assistant/context/NIGHTLY_CHECKLIST.md`

## Operational References
- Command catalog: `assistant/commands/COMMANDS.md`
- Alias catalog: `assistant/commands/ALIASES.md`
- System overview: `assistant/resources/docs/SYSTEM_OVERVIEW.md`
- UI data contract: `assistant/resources/docs/UI_DATA_CONTRACT.md`
- Ops runbook: `assistant/resources/docs/OPS_RUNBOOK.md`
- Security and deployment checklist: `assistant/resources/docs/SECURITY_AND_DEPLOYMENT_CHECKLIST.md`
- Master prompt upgrade report (trading-domain + UX/product doctrine): `assistant/resources/docs/MASTER_SYSTEM_PROMPT_UPGRADE_REPORT.md`
- Repository boundary and backup policy (single-copy path, restore drill): `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`
- App user guide (runtime auth, API keys, expected vs actual errors): `assistant/resources/docs/APP_USER_GUIDE.md`
- Database architecture (distribution-first): `assistant/resources/docs/DATABASE_ARCHITECTURE.md`
- Quality gates: `assistant/resources/docs/QUALITY_GATES.md`
- UIA expansion blueprint (PRD/MVP/architecture/data model/milestones): `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`
- UIA blueprint addendum (solo-dev workflow, three-branch model, menus/themes/onboarding, M12-M16): `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT_ADDENDUM.md`
- Post‑2026‑02‑26 next instruction set (M17-M23 expansion plan): `assistant/resources/docs/CANDLE_COMPASS_NEXT_INSTRUCTION_SET_POST_2026_02_26.md`
- AI tool usage log template (milestone-level record across tools): `assistant/resources/docs/AI_TOOL_USAGE_LOG_TEMPLATE.md`
- Ultimate advancement plan (master execution plan, 2026-03-06): `assistant/resources/docs/CANDLE_COMPASS_ULTIMATE_ADVANCEMENT_PLAN_2026_03_06.md`
- Memory system: `assistant/resources/docs/MEMORY_SYSTEM.md`
- Memory server: `assistant/resources/docs/MEMORY_SERVER.md`

## Config + Runtime Anchors
- Runtime app root: `app/` (must not depend on `assistant/`)
- Root project rules for IDEs: `.cursorrules` (points to assistant system)
- Memory ingest config: `assistant/memory_ingest.yaml`
- Installer manifest: `assistant/resources/install_manifest.txt`
- Resource URLs: `assistant/resources/urls.json`
- MCP resources: `assistant/resources/mcp/` (e.g. `candle_compass_memory.json`)
