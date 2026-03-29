# Skill: Generate Prompt Packs (Cursor/Codex/Gemini)

## Inputs
- Canonical docs (PRD/ARCH/DATA/NFR/RUNBOOK)
- Milestone list with objective + deliverables

## Steps
1) For each milestone, write prompts Mx.0..Mx.4:
   - Planning (plan + files + questions)
   - Implementation (strict scope)
   - Tests (edge + negative cases)
   - Docs/Polish (runbook/docs updates)
   - Review checklist
2) Include constraints: minimal diffs, no secrets, run validations.
3) Reference canonical docs by name and require agents to read them.
4) Ensure output is copy/paste ready.

## Outputs
- system/ai-governance/prompt-packs/M0.md ... system/ai-governance/prompt-packs/Mn.md
