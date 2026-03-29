# Architecture

## Modules

- `MOS_TEMPLATE/`: installable Meta Operating System product
- `MOS_TEMPLATE/meta_system/`: canonical contracts, manifests, prompt packs, plugins, golden examples, generated adapters, and durable meta context
- `MOS_TEMPLATE/bootstrap/`: public CLI surface for install, update, validation, repair, prompt emission, and generation
- `_MOS_TEMPLATE_FACTORY/`: factory-only source validation, automation lane, and clean-room smoke
- `MOS_SOURCE_LIBRARY/`: donor/source manifest and provenance intake
- `_META_AGENT_SYSTEM/`: maintainer-only design workspace for evolving MOS and AIAST

## Interaction Model

1. Source donors are recorded in `MOS_SOURCE_LIBRARY/`.
2. `_MOS_TEMPLATE_FACTORY/` validates the source template and donor manifests.
3. `MOS_TEMPLATE/` is installed into a target system repo.
4. The installed repo uses `bootstrap/` to generate adapters, emit prompts, validate drift, and repair missing surfaces.
5. Agents load the canonical `meta_system/` contracts and then execute milestone- or review-specific prompt packs.
