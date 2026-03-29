# Meta Operating System

`MOS_TEMPLATE/` is the installable product for building and governing future system-of-systems templates like AIAST.

## What It Does

- defines the authoritative meta-level rules that tell agents how to build system scaffolds, prompts, adapters, plugins, and validation surfaces
- keeps that work separate from application runtime code and from the app-facing AIAST product
- ships a validation, lint, repair, prompt-emission, adapter-generation, working-state-seeding, repo-shape suggestion, and strict lifecycle-recording lane so the meta-system remains self-checking and resumable after install

## Main Entry Points

- `META_AGENTS.md`
- `meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md`
- `meta_system/META_REPO_OPERATING_PROFILE.md`
- `meta_system/META_LOAD_ORDER.md`
- `docs/`
- `bootstrap/`

## Boundary

- `MOS_TEMPLATE/` is installable
- `_MOS_TEMPLATE_FACTORY/` is factory-only
- `MOS_SOURCE_LIBRARY/` is donor intake only
- `_META_AGENT_SYSTEM/` is maintainer planning and design state only

## Quick Start

```bash
# Validate the source template in place
./bootstrap/validate-meta-system.sh .
./bootstrap/system-meta-doctor.sh . --mode template

# Emit a host-safe startup prompt
./bootstrap/emit-meta-host-prompt.sh .

# Install MOS into a target repo
./bootstrap/init-meta-project.sh /path/to/target-repo --source .
```

## Source Boundary

- Point `--source` at the canonical MOS template root only.
- Do not point MOS lifecycle commands at the master repo root.
- Do not point MOS lifecycle commands at an already-installed MOS target repo.
- Use `bootstrap/check-meta-install-boundary.sh` after install or repair when you want explicit proof that maintainer-only layers did not leak into the target repo.
- `bootstrap/install-meta-missing-files.sh` now also regenerates local derived outputs after additive recovery, and strict MOS lifecycle runs now record the latest successful validation in the installed continuity files.
