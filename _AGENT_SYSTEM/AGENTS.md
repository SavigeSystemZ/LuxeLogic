# AGENTS.md

This file governs work in the master AIAST source repo.

## Repo layers

1. Installable product: `TEMPLATE/`
2. Factory-only maintenance and rollout tooling: `_TEMPLATE_FACTORY/`
3. Master-repo-only meta-system design workspace: `_META_AGENT_SYSTEM/`
4. Installable meta operating system product: `MOS_TEMPLATE/`
5. MOS factory-only maintenance and validation tooling: `_MOS_TEMPLATE_FACTORY/`
6. MOS donor/source intake library: `MOS_SOURCE_LIBRARY/`

## Boundary rules

- Only `TEMPLATE/` is copied into app repos.
- Only `MOS_TEMPLATE/` is copied into repos that are using MOS to build future system-of-systems templates.
- Do not put maintainer-only AIAST planning, research, handoff state, or future system-for-the-system design files into `TEMPLATE/`.
- Put AIAST-maintainer working state and future meta-system work in `_META_AGENT_SYSTEM/`.
- Put build, audit, scoring, smoke, and rollout automation in `_TEMPLATE_FACTORY/`.
- Put MOS donor manifests, source provenance, and reusable intake references in `MOS_SOURCE_LIBRARY/`.
- Put MOS build, smoke, and validation automation in `_MOS_TEMPLATE_FACTORY/`.
- Keep installable files inside `TEMPLATE/` neutral enough that a fresh app repo does not inherit master-template maintenance state.
- Keep installable files inside `MOS_TEMPLATE/` neutral enough that a fresh system-of-systems repo does not inherit master-repo maintenance state.

## When touching `TEMPLATE/`

- Treat `TEMPLATE/` as the app-facing product.
- Keep working files and context files repo-neutral unless the file is explicitly about AIAST versioning or installable system contracts.
- If the change is only about maintaining or evolving AIAST itself, record the planning and handoff state in `_META_AGENT_SYSTEM/`, not in installable working files.
- When changing installable agent rules or contracts, also read `TEMPLATE/AGENTS.md`.

## When touching `_META_AGENT_SYSTEM/`

- Treat it as the design studio for the system that shapes the system.
- Keep it clearly marked as master-repo-only.
- Do not assume anything there will exist in installed app repos.

## When touching `MOS_TEMPLATE/`

- Treat it as the installable Meta Operating System product.
- Keep its working files, context files, and prompt packs meta-prefixed and neutral.
- Do not leak `_META_AGENT_SYSTEM/` maintainer planning state into it.
- When changing MOS contracts or scripts, also read `MOS_TEMPLATE/META_AGENTS.md`.

## Validation

- Run `_TEMPLATE_FACTORY/run-automation-lane.sh` after meaningful changes to the installable system.
- If only `_META_AGENT_SYSTEM/` changes, keep the boundary docs truthful and avoid leaking those changes into `TEMPLATE/`.
- Run `_MOS_TEMPLATE_FACTORY/run-automation-lane.sh` after meaningful changes to `MOS_TEMPLATE/` or `MOS_SOURCE_LIBRARY/`.
