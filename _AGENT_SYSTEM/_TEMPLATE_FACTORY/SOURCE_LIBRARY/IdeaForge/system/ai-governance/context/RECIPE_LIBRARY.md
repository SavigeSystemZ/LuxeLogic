# Recipe Library (vNext)

Recipes are standardized sequences of generator runs that produce a complete bundle.
Store recipes as data (JSON/YAML) so they are versioned and exportable.

## R1: Blueprint Bundle
1) blueprint: PRD/ARCH/DATA/NFR/RUNBOOK
2) milestones: risk-first list
3) prompt_pack: Cursor/Codex/Gemini per milestone

## R2: Blueprint + Threat Model
1) R1
2) threat_model: abuse cases + controls
3) security_review: checklists and gates

## Recipe rules
- Each step declares: inputs, outputs, validation.
- Recipes are idempotent (new versions, no overwrite).
- Runs form a DAG; lineage is stored.
