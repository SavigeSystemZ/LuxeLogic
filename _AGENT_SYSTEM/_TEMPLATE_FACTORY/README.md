# Template Factory

This directory holds master-repo-only assets used to build, audit, and batch-deploy AIAST.

Nothing in this directory is part of the installed operating system inside application repos.

## Contents

- `scaffold-repos.sh` — batch deployment script for repos under `~/.MyAppZ/`
- `BUILD_REPORT.md` — merge and expansion rationale for the master template
- `BUILD_SOURCE_MANIFEST.md` — copied-source inventory used to construct the template
- `SOURCE_LIBRARY/` — preserved source material used for provenance and future extraction work
- `GOLDEN_EXAMPLES/` — factory-only donor scorecards and selection notes for the neutral example pack
- `refresh-golden-examples.sh` — rescan sibling repos and rebuild the donor scorecard
- `validate-golden-examples.sh` — validate donor scorecard, selection, review notes, and promotion criteria coherence
- `validate-meta-workspace.sh` — validate maintainer-only continuity state inside `_META_AGENT_SYSTEM/`
- `run-maintainer-lane.sh` — run the dedicated maintainer-only continuity lane
- `run-automation-lane.sh` — run the deterministic validator plus optional builder-aware packaging smoke
- `validate-master-template.sh` — run the full source-template, installed-repo, packaging-target, host-adapter fixture, external host-bundle, and runtime-foundation proof chain
- `smoke-installed-repo.sh` — run a clean-room install and validation smoke against the master template
- `smoke-packaging-targets.sh` — run clean-room packaging and systemd-target smoke against a generated repo
- `smoke-packaging-builders.sh` — run opportunistic Flatpak-first builder smoke when host tooling is available
- `smoke-host-adapter-fixture.sh` — prove that an external adapter fixture can consume the canonical host-prompt emitter safely
- `smoke-host-bundle.sh` — prove that a separate external workspace can consume a self-contained host bundle without direct repo access
- `smoke-live-host-clis.sh` — opportunistically prove that actual installed external host CLIs can consume the exported host-bundle flow headlessly
- `smoke-runtime-foundations.sh` — run live runtime-foundation smoke in a clean-room generated repo
- `prepare-test-session.sh` — create a removable dated sandbox session under the sibling `_AI_AGENT_SYSTEM_TESTS/` root and scaffold a fresh campaign into it

## Boundary

- `TEMPLATE/` is the actual product.
- `_TEMPLATE_FACTORY/` is the factory floor that maintains the product.
- Agents working inside installed app repos should not depend on `_TEMPLATE_FACTORY/`.
