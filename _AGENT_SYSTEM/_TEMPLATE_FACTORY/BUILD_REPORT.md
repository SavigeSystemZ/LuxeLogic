# Consolidation Report

Factory-only asset. This document describes how the master template was built and is not part of installed AIAST operation inside application repos.

## Result

Created `/home/whyte/.MyAppZ/_AI_AGENT_SYSTEM_TEMPLATE` as the new root-level master agent operating system.

It has two top-level surfaces:

- `TEMPLATE/` — the merged canonical operating system intended to be copied into future app repos
- `_TEMPLATE_FACTORY/` — build-only provenance, rollout, and audit assets for maintaining the template master repo

## What was analyzed

The consolidation focused on application-local files that define how agents work with the repo, not runtime code that merely exposes AI features to end users.

Primary source repos:

- `CandleCompass`
- `EtherWeave`
- `IdeaForge`
- `LedgerLoop`

High-value source categories:

- repo entrypoint files (`AGENTS.md`, `CLAUDE.md`, `.cursorrules`)
- master prompts and prompt templates
- MCP configs and MCP policy docs
- skills, commands, rules, and tool-specific overlays
- handoff and continuity files (`TODO`, `WHERE_LEFT_OFF`, changelog/state docs)
- backup and separation guidance

## Merge decisions

### Shared repo contract

`TEMPLATE/AGENTS.md` merges:

- CandleCompass' clean runtime-vs-system separation
- EtherWeave's tool-agnostic multi-agent governance and context-reload discipline
- IdeaForge's single-writer and handoff-packet rigor
- LedgerLoop's canonical-doc loading and state-tracking model

### System prompt and rules

`TEMPLATE/_system/MASTER_SYSTEM_PROMPT.md` and `TEMPLATE/_system/PROJECT_RULES.md` merge:

- CandleCompass' emphasis on correctness, context continuity, and coherent update passes
- EtherWeave's validation-as-contract, MCP fallback behavior, and explicit session recovery
- LedgerLoop's practical engineering rules around validation, docs, and handoff
- IdeaForge's provenance, minimal-diff, and governance-first constraints

### Cursor layer

`TEMPLATE/.cursorrules`, `TEMPLATE/.cursor/rules/`, `TEMPLATE/.cursor/commands/`, and `TEMPLATE/.cursor/skills/` merge:

- EtherWeave's mature Cursor rules/skills/commands packaging
- CandleCompass' lean load-order approach
- IdeaForge's prompt-pack and MCP skill patterns
- LedgerLoop's system-directory pointer pattern

### MCP model

`TEMPLATE/_system/MCP_CONFIG.md` and `TEMPLATE/_system/mcp/` merge:

- EtherWeave's workspace-vs-user MCP layering and "do not block on MCP failure" rule
- IdeaForge's least-privilege and scope-elevation model
- LedgerLoop's multi-app namespacing strategy for shared local tooling

### Handoff state

`TEMPLATE/TODO.md`, `TEMPLATE/FIXME.md`, `TEMPLATE/WHERE_LEFT_OFF.md`, and `TEMPLATE/CHANGELOG.md` merge:

- CandleCompass' rich continuity and unfinished-work capture
- LedgerLoop's explicit "must record discovered work before handoff" rule
- EtherWeave's session checkpoint discipline
- IdeaForge's structured handoff packet content

### New higher-order operating docs added on top of the merge

The final system goes beyond direct file merging and adds upgraded hybrid documents built from the strongest patterns across the source repos:

- `TEMPLATE/_system/CONTEXT_INDEX.md`
- `TEMPLATE/_system/EXECUTION_PROTOCOL.md`
- `TEMPLATE/_system/DEBUG_REPAIR_PLAYBOOK.md`
- `TEMPLATE/_system/CHECKPOINT_PROTOCOL.md`
- `TEMPLATE/_system/MEMORY_RULES.md`
- `TEMPLATE/_system/SECURITY_REDACTION_AND_AUDIT.md`
- `TEMPLATE/_system/context/*`

These did not exist as one coherent system in any single source repo; they were synthesized from the best parts of CandleCompass, EtherWeave, IdeaForge, and LedgerLoop.

### Additional systems implemented in the operating-system expansion pass

The system now also includes:

- `TEMPLATE/_system/AGENT_DISCOVERY_MATRIX.md`
- `TEMPLATE/_system/DESIGN_EXCELLENCE_FRAMEWORK.md`
- `TEMPLATE/_system/RELEASE_READINESS_PROTOCOL.md`
- `TEMPLATE/_system/FAILURE_MODES_AND_RECOVERY.md`
- `TEMPLATE/_system/SYSTEM_EVOLUTION_POLICY.md`
- `TEMPLATE/_system/WORKING_FILES_GUIDE.md`
- `TEMPLATE/_system/TEMPLATE_NEUTRALITY_POLICY.md`
- `TEMPLATE/_system/review-playbooks/*`
- `TEMPLATE/_system/mcp/MCP_SERVER_CATALOG.md`
- `TEMPLATE/_system/mcp/MCP_SELECTION_POLICY.md`
- `TEMPLATE/_system/mcp/MCP_FAILURE_FALLBACKS.md`
- `TEMPLATE/bootstrap/*`
- expanded generic working files:
  - `TEMPLATE/ARCHITECTURE_NOTES.md`
  - `TEMPLATE/RESEARCH_NOTES.md`
  - `TEMPLATE/TEST_STRATEGY.md`
  - `TEMPLATE/RISK_REGISTER.md`
  - `TEMPLATE/RELEASE_NOTES.md`
- expanded durable context surfaces:
  - `TEMPLATE/_system/context/ASSUMPTIONS.md`
  - `TEMPLATE/_system/context/INTEGRATION_SURFACES.md`
- upgraded agent adapters and Cursor overlays so every supported tool sees the same working-file model
- `TEMPLATE/bootstrap/install-missing-files.sh` for safe rollout of newly added template files into existing installed repos
- expanded prompt templates and prompt packs through `M11`
- expanded Cursor commands, skills, and optional agent specs

This moved the master template from a strong scaffold into a more complete agent operating system.

### Golden example system

The template now includes a neutral golden-example pack under `TEMPLATE/_system/golden-examples/` plus a factory-only donor scoring workflow under `_TEMPLATE_FACTORY/GOLDEN_EXAMPLES/`.

This was implemented deliberately as a curated per-pattern system rather than choosing one "best app" and copying it everywhere.

Current pattern donors:

- CandleCompass and LedgerLoop for continuity, handoff quality, and validation-aware working files
- IdeaForge and EtherWeave for governance, prompting, multi-agent, and MCP policy patterns
- PromptMage as a primary platform-surface donor for multi-surface repo shaping

The installed template only carries neutralized pattern guidance and exemplar working files. Donor provenance and scoring remain factory-only so installed repos do not depend on live sibling repos.

### First-use refinements from sandbox testing

Testing against temporary app sandboxes surfaced two concrete onboarding issues, both now fixed:

- bootstrap now preserves an existing app `README.md` and installs the system overview as `AI_SYSTEM_README.md`
- `bootstrap/check-placeholders.sh` now focuses on actionable repo-owned operating files by default instead of producing noisy hits from prompt templates, bootstrap scripts, and example config files
- `bootstrap/suggest-project-profile.sh` now provides safe baseline inference for repo shape, languages, package managers, and runtime environments so first-time onboarding starts with less manual blank filling

Additional stress testing against React, FastAPI, and static-site sandboxes drove a second onboarding improvement pass:

- `init-project.sh` now auto-runs `suggest-project-profile.sh --write` and `seed-working-state.sh`
- profile suggestion now infers common framework and validation-command hints for Vite/React, FastAPI-style Python repos, and static frontends
- newly installed repos start with a seeded first milestone, plan objective, status snapshot, and release target instead of only generic blank placeholders
- `_system/starter-blueprints/` now captures reusable launch patterns for React/Vite/TypeScript, FastAPI APIs, and static frontends based on the stress-tested repo shapes

### 1.4.1 hardening pass

A follow-up hardening pass closed the remaining ambiguity between the neutral source template and real installed repos:

- placeholder-aware commands now auto-detect repo mode and allow explicit `--mode auto|template|installed` overrides
- the source template now passes strict validation in template mode while still treating unresolved installed-repo placeholders as real failures
- runtime-foundation validation now checks that generated env defaults are shell-sourceable
- factory smoke now includes both clean-room installed-repo proof and live runtime install/repair/launch/purge proof
- `validate-master-template.sh` now provides a one-command release-proof chain for the master repo itself
- high-scoring candidate repos `Immortality` and `Vetraxis` were reviewed explicitly and not promoted into the installed golden-example pack because their strongest patterns remain too app-specific

### 1.5.0 proof expansion

A further expansion pass extended the proof chain into packaging targets and host-safe prompt emission:

- `bootstrap/check-packaging-targets.sh` now validates packaging manifests, shared desktop launchers, and generated systemd units
- `_TEMPLATE_FACTORY/smoke-packaging-targets.sh` now proves packaging targets in a clean-room generated repo, including `systemd-analyze verify`
- `generate-runtime-foundations.sh` now renders placeholders in file paths as well as file contents, which allows app-specific launcher filenames to be generated correctly
- `bootstrap/emit-host-prompt.sh` now provides a canonical repo-side host prompt emitter
- `bootstrap/check-host-ingestion.sh` now proves the prompt emission contract, prompt surfaces, and canonical emitter behavior
- `_TEMPLATE_FACTORY/validate-master-template.sh` now covers packaging-target smoke in addition to source, installed-repo, and runtime-foundation proof

### 1.5.1 automation and external-fixture follow-up

A follow-up pass operationalized the proof chain and tightened the remaining bounded external-facing seams:

- `_TEMPLATE_FACTORY/run-automation-lane.sh` now provides one shared local-and-CI entrypoint for the master proof lane
- `.github/workflows/validate-master-template.yml` now runs the automation lane on pushes, pull requests, manual dispatch, and a schedule without duplicating shell logic in YAML
- `_TEMPLATE_FACTORY/smoke-host-adapter-fixture.sh` now proves that an external adapter fixture can consume `bootstrap/emit-host-prompt.sh` deterministically in a clean-room repo
- `_TEMPLATE_FACTORY/smoke-packaging-builders.sh` now provides optional Flatpak-first real builder execution when host tooling and runtimes are present
- `_TEMPLATE_FACTORY/validate-master-template.sh` now includes host-adapter fixture proof while keeping real builder smoke additive instead of mandatory

### 1.6.0 generated adapter alignment

A further follow-up pass turned the real tool-adapter surfaces into canonical generated outputs instead of independent prose islands:

- `_system/HOST_ADAPTER_POLICY.md` now defines how tool-entry and load-context adapter files are governed
- `_system/host-adapter-manifest.json` now acts as the machine-readable source for the generated adapter set
- `bootstrap/generate-host-adapters.sh` now regenerates the primary tool-entry files and shared Cursor load-context surfaces
- `bootstrap/check-host-adapter-alignment.sh` now validates adapter alignment as part of the instruction layer
- managed write flows now refresh generated adapters before rebuilding the registry, operating profile, and integrity manifest

### 1.7.0 external host-bundle bridge

A further follow-up pass extended the host-safe prompt system into a self-contained external-consumer path without coupling the template to one vendor host:

- `_system/HOST_BUNDLE_CONTRACT.md` now defines the exported host-bundle contract
- `bootstrap/emit-host-bundle.sh` now exports a self-contained prompt-and-context bundle for external consumers that cannot read repo-local paths directly
- `bootstrap/check-host-bundle.sh` now validates the bundle contract, emitter output, and capability markers
- `_TEMPLATE_FACTORY/smoke-host-bundle.sh` now proves that a separate external workspace can consume the exported bundle without direct repo access
- `_TEMPLATE_FACTORY/validate-master-template.sh` now includes external host-bundle smoke in the deterministic proof chain

## Why the new structure is split

The final system intentionally does not flatten everything into one folder of mixed files.

Instead:

- `TEMPLATE/` contains the cleaned, merged, reusable operating system
- `_TEMPLATE_FACTORY/SOURCE_LIBRARY/` preserves copied originals for audit, provenance, and future extraction
- `_system/` inside `TEMPLATE/` gives each target app its own local agent system separate from runtime code

This matches the goal of letting multiple agents work on different apps at the same time without reading and mutating one shared live directory.

## Intentional exclusions

The consolidation did not copy or merge:

- user-level global configs that contain secrets or tokens
- machine-local permission files
- app runtime source files that implement AI-facing product features rather than repo-governance behavior
- log folders and noisy generated session artifacts that are not durable operating rules

Examples:

- `CandleCompass/.claude/settings.local.json` was excluded as machine-local policy state
- home-level MCP configs were inspected for format only and not copied because they contain secrets
- runtime files such as agent endpoints, UI chat components, or in-app agent logic were excluded from the master system layer

## Final inventory

- Source files copied: 306
- Canonical operating-system files created: 264
- Source repos consolidated: 4

## Recommended use

1. Use `TEMPLATE/bootstrap/init-project.sh` to install the operating system into a new or existing app repo, or copy `TEMPLATE/` manually.
2. Edit `TEMPLATE/_system/PROJECT_PROFILE.md` first.
3. Configure project-scoped MCP entries from `TEMPLATE/_system/mcp/`.
4. Keep application runtime code outside `_system/`.
5. Use `_TEMPLATE_FACTORY/SOURCE_LIBRARY/` only as reference material, not as live shared context.

### Scaffolding readiness pass

A final hardening pass was applied before the system was declared ready for batch scaffolding:

- `validate-system.sh` upgraded from 117-file partial coverage to 259 required-file coverage, including all Cursor overlays, MCP configs, context READMEs, `SYSTEM_EVOLUTION_POLICY.md`, and the golden-example pack
- `_TEMPLATE_FACTORY/scaffold-repos.sh` created as the factory rollout script for batch deployment to all application repos under `~/.MyAppZ/`, with `--list`, `--all`, `--replace`, `--strict`, and `--dry-run` modes
- repos with legacy agent files get automatic backup before replacement
- file inventory updated from 128 to 264 across all docs

## Verification completed

- JSON example configs parse cleanly
- TOML example configs parse cleanly
- bootstrap shell scripts pass `bash -n`
- dry-run bootstrap succeeds
- strict end-to-end bootstrap into a scratch repo succeeds
- strict validation of the installed scratch repo succeeds
- 259 required-file validation coverage confirmed programmatically
- `_TEMPLATE_FACTORY/scaffold-repos.sh` `--list` and `--all --replace --dry-run` modes verified
- end-to-end sandbox test with JS app: profile auto-detection, seeding, strict validation all pass
- source template strict validation passes cleanly in template mode
- clean-room installed-repo smoke passes via `_TEMPLATE_FACTORY/smoke-installed-repo.sh`
- clean-room packaging-target smoke passes via `_TEMPLATE_FACTORY/smoke-packaging-targets.sh`
- clean-room host-adapter fixture smoke passes via `_TEMPLATE_FACTORY/smoke-host-adapter-fixture.sh`
- clean-room external host-bundle smoke passes via `_TEMPLATE_FACTORY/smoke-host-bundle.sh`
- live runtime-foundation smoke passes via `_TEMPLATE_FACTORY/smoke-runtime-foundations.sh`
- local host-ingestion validation passes via `bootstrap/check-host-ingestion.sh`
- repo automation lane passes via `_TEMPLATE_FACTORY/run-automation-lane.sh`
- generated tool-adapter alignment passes via `bootstrap/check-host-adapter-alignment.sh`

### Security Hardening Pass

A comprehensive security hardening pass was performed across the system and all 4 primary applications:

- **Standardization:** Created `_system/SECURITY_HARDENING_CONTRACT.md` and `_system/review-playbooks/SECURITY_HARDENING_REVIEW_PLAYBOOK.md` to define and verify loopback-only binds, systemd hardening, secure web headers, and structured logging.
- **Propagation:** The new security governance files were pushed to `CandleCompass`, `EtherWeave`, `IdeaForge`, and `LedgerLoop`.
- **Implementation:** 
  - All 4 apps now bind to `127.0.0.1` by default.
  - Security header middleware (CSP, nosniff, Referrer-Policy, Cache-Control: no-store) implemented in all 4 apps.
  - Hardened systemd service units (UMask=0077, NoNewPrivileges, PrivateTmp, etc.) provided for all apps.
- **Verification:** Created `validate-security.sh` for each app; all 4 apps currently pass their security validation.
