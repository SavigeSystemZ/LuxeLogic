# AI Agent Operating System

This directory is the consolidated master copy of the AI-agent operating system used to bootstrap application repos inside `/home/whyte/.MyAppZ`.

## Structure

- `TEMPLATE/` — the actual reusable operating system copied into project repos.
- `_TEMPLATE_FACTORY/` — tagged master-repo-only factory assets used to build, audit, and batch-deploy the template. These files are not part of installed AIAST operation.
- `_META_AGENT_SYSTEM/` — master-repo-only design workspace for AIAST-maintainer planning, research, and future "system-for-the-system" files. These files are not part of installed AIAST operation.
- `MOS_TEMPLATE/` — the installable Meta Operating System used to build and govern future system-of-systems templates.
- `_MOS_TEMPLATE_FACTORY/` — factory-only MOS build, validation, and smoke infrastructure.
- `MOS_SOURCE_LIBRARY/` — donor/source intake manifest area for MOS.

## Quick Start

```bash
# Run the local automation lane used by CI and scheduled validation
./_TEMPLATE_FACTORY/run-automation-lane.sh

# Run only the deterministic master-template proof chain
./_TEMPLATE_FACTORY/validate-master-template.sh

# See all repos and their scaffolding status
./_TEMPLATE_FACTORY/scaffold-repos.sh --list

# Scaffold a single clean repo
./_TEMPLATE_FACTORY/scaffold-repos.sh WRAITHS --strict

# Scaffold a repo that has legacy agent files (backs up first)
./_TEMPLATE_FACTORY/scaffold-repos.sh CandleCompass --replace --strict

# Scaffold all repos at once
./_TEMPLATE_FACTORY/scaffold-repos.sh --all --replace --strict

# Preview what would happen without making changes
./_TEMPLATE_FACTORY/scaffold-repos.sh --all --replace --dry-run

# Validate the installable meta-system product
./_MOS_TEMPLATE_FACTORY/run-automation-lane.sh
```

## Intended Use

1. Use `_TEMPLATE_FACTORY/scaffold-repos.sh` to install the operating system into application repos, or use `TEMPLATE/bootstrap/init-project.sh` directly for a single target.
2. Fill in `_system/PROJECT_PROFILE.md` in the installed repo.
3. Populate the installed repo's working files such as `PLAN.md`, `TODO.md`, `TEST_STRATEGY.md`, `DESIGN_NOTES.md`, and `WHERE_LEFT_OFF.md`.
4. Configure project-specific MCP entries from `_system/mcp/`.
5. Use `TEMPLATE/bootstrap/install-missing-files.sh` later if you want to seed newly added template files into an already-installed repo without overwriting repo-owned files; it now also backfills missing runtime scaffolds and safe onboarding defaults.
6. `init-project.sh` now performs a first-pass profile suggestion and working-state seeding automatically, and `bootstrap/update-template.sh` now reuses that same safe onboarding refresh path during upgrades; you can re-run `bootstrap/suggest-project-profile.sh <target-repo> --write` later if the repo grows new tooling or validation scripts.
7. Use `_system/starter-blueprints/` when you want a stronger launch pattern for React/Vite/TypeScript, FastAPI APIs, Next.js full-stack, Python CLIs, or static frontends.
8. Use `bootstrap/system-doctor.sh`, `bootstrap/check-system-awareness.sh`, and `bootstrap/check-hallucination.sh` to keep installed repos grounded in real evidence and real local paths.
9. `validate-system.sh`, `check-placeholders.sh`, and `system-doctor.sh` now auto-detect source-template vs installed-repo mode. The neutral source template may keep expected blanks, but installed repos still fail on unresolved repo-owned placeholders.
10. Use `bootstrap/emit-host-prompt.sh` when an upstream host or orchestrator needs a canonical repo-safe startup prompt instead of assembling one ad hoc.
11. Use `bootstrap/emit-host-bundle.sh --output <file>` when an external host cannot read repo-local paths directly and needs a self-contained prompt-and-context snapshot.
12. Use `bootstrap/generate-host-adapters.sh` and `bootstrap/check-host-adapter-alignment.sh` when tool-entry or load-context adapter surfaces change.
13. Use `bootstrap/update-template.sh`, `bootstrap/repair-system.sh`, and `bootstrap/detect-drift.sh` for versioned lifecycle management after install.
14. Keep runtime code separate from `_system/` and agent-only files.
15. Keep the master template source generic; do not sync app-specific content back into it.
16. Use `TEMPLATE/_system/GOLDEN_EXAMPLES_POLICY.md` and `TEMPLATE/_system/golden-examples/` when you want a neutral quality-bar example instead of copying another app's live files.
17. Use `_TEMPLATE_FACTORY/run-automation-lane.sh` locally or `.github/workflows/validate-master-template.yml` in automation when you want the full master proof chain plus optional builder-aware smoke.
18. Use `_META_AGENT_SYSTEM/` for AIAST-maintainer planning, research, handoff, and future meta-system file creation instead of storing that state in installable app-facing working files inside `TEMPLATE/`.
19. Use `MOS_TEMPLATE/` when the task is to build or evolve the system that builds AIAST-like systems rather than the app-facing AIAST product itself.
20. Use `_MOS_TEMPLATE_FACTORY/` and `MOS_SOURCE_LIBRARY/` to validate and curate MOS source material without leaking that maintainer-only state into installable repos.
21. For any lifecycle command that accepts `--source`, point it at the canonical installable product root (`TEMPLATE/` or `MOS_TEMPLATE/`) in template-source mode, never at this master repo root or at an already-installed target repo.

If the target repo already has an app `README.md`, the installer preserves it and drops the system overview in `AI_SYSTEM_README.md`.

## Design Goal

The merged operating system keeps agent rules, prompts, MCP guidance, debug, checkpoint, review, design, risk, testing, release, and durable context surfaces logically separate from application runtime code so multiple agents can work across different repos without sharing mutable live context.

It has also been stress-tested against isolated React, FastAPI, and static-frontend sandboxes to tighten first-use onboarding and common validation flows.

## Boundary Rule

- Treat `TEMPLATE/` as the product.
- Treat `_TEMPLATE_FACTORY/` as build, provenance, and batch-rollout infrastructure for maintaining the product.
- Treat `_META_AGENT_SYSTEM/` as master-repo-only design space for evolving the system itself.
- Treat `MOS_TEMPLATE/` as a separate installable product for building system-of-systems templates.
- Treat `_MOS_TEMPLATE_FACTORY/` as MOS-only build and validation infrastructure.
- Treat `MOS_SOURCE_LIBRARY/` as MOS donor intake and provenance state.
- Do not copy `_TEMPLATE_FACTORY/` into app repos as part of the operating system install.
- Do not copy `_META_AGENT_SYSTEM/` into app repos as part of the operating system install.
- Do not copy `_MOS_TEMPLATE_FACTORY/` or `MOS_SOURCE_LIBRARY/` into downstream repos as part of MOS installation.
