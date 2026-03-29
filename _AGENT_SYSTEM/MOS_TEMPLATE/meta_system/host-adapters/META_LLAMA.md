# MOS Adapter Spec for Llama

- Tool: Llama
- Support tier: spec-only

## Load First

1. `META_AGENTS.md`
2. `meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md`
3. `meta_system/META_REPO_OPERATING_PROFILE.md`
4. `meta_system/META_LOAD_ORDER.md`

## Load When Needed

- `meta_system/META_PROJECT_RULES.md`
- `meta_system/META_EXECUTION_PROTOCOL.md`
- `meta_system/META_PROMPT_EMISSION_CONTRACT.md`
- `docs/ReviewWorkflow.md`
- `meta_system/prompt-packs/M2_DEFINE_META_SYSTEM_SPEC.md`
- `meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md`
- `meta_system/golden-examples/PATTERN_INDEX.md`

## Rules

- Repo-local truth and repo-local MOS core contracts win over host context.
- Treat this adapter as a translation layer, not the source of truth.
- Keep runtime code independent from the meta-system.

This file is generated from `meta_system/meta-host-adapter-manifest.json`.
