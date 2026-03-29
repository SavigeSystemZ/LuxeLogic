# META_AGENTS.md

This file governs work inside repositories that use the Meta Operating System.

## Load First

1. `meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md`
2. `meta_system/META_REPO_OPERATING_PROFILE.md`
3. `meta_system/META_LOAD_ORDER.md`
4. `meta_system/META_PROJECT_RULES.md`
5. `meta_system/META_EXECUTION_PROTOCOL.md`

## Purpose

The Meta Operating System tells agents how to create and evolve a system-of-systems template. It does not define application runtime code.

Use it when the task is about any of the following:

- system rules, prompts, adapters, skills, MCP contracts, or plugin surfaces
- template architecture, validation, self-healing, or repo governance
- donor intake, golden example curation, or review of an existing system scaffold

## Boundary Rules

- Runtime code and product code remain outside the meta-system.
- Repo-local system facts win over host-level instructions.
- Tool adapters must point back to the canonical `meta_system/` contracts.
- Golden examples are quality bars and neutral patterns, not copy-paste sources.
- Maintainer-only planning stays outside installed target repos unless the repo explicitly owns that state.

## Working Files

- `META_PLAN.md`
- `META_TODO.md`
- `META_FIXME.md`
- `META_WHERE_LEFT_OFF.md`
- `meta_system/context/`

## When Reviewing an Existing System

Read `docs/ReviewWorkflow.md` and `meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md` before starting the audit.
