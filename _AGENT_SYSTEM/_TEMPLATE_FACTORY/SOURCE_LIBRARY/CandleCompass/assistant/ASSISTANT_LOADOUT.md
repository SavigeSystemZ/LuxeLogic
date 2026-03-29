# Assistant Loadout (Read Order)

Use this sequence to bootstrap quickly with minimal context waste.

## Tier 0: Operating Contract (always)
- `assistant/MASTER_SYSTEM_PROMPT.md`
- `assistant/AGENTS_AND_SYSTEM.md` (multi-agent handoff and single source of truth)
- `assistant/rules/PROJECT_RULES.md`
- `assistant/rules/MEMORY_RULES.md`
- `assistant/context/RULES_USER.md`

## Tier 1: Current State (always)
- `assistant/context/WHERE_WE_LEFT_OFF.md` (read first on resume)
- `assistant/TODO.md` (priorities, next steps, phases; update on handoff)
- `assistant/context/CURRENT_STATUS.md`
- `assistant/context/CHANGELOG.md`
- `assistant/context/DECISIONS.md`
- `assistant/context/MEMORY.md`
- `assistant/FIXME.md` (known gaps)

## Tier 2: Prompting + Skills (load as needed)
- `assistant/prompts/system_prompt_template.md`
- `assistant/prompts/developer_prompt_template.md`
- `assistant/prompts/user_prompt_template.md`
- `assistant/skills/`

## Tier 3: Execution References (task-driven)
- `assistant/commands/COMMANDS.md`
- `assistant/commands/ALIASES.md`
- `assistant/resources/docs/SYSTEM_OVERVIEW.md`
- `assistant/resources/docs/UI_DATA_CONTRACT.md`
- `assistant/resources/docs/OPS_RUNBOOK.md`
- `assistant/resources/docs/QUALITY_GATES.md`
- `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`

## Tier 4: Extended Context (when needed)
- `assistant/context/PHASE_AUDIT.md`
- `assistant/context/DRIFT_THRESHOLDS.md`
- `assistant/MEMORY_GUIDE.md`
- `assistant/TODO.md`

## Fast Path
If time constrained, load Tier 0 + Tier 1 only.
