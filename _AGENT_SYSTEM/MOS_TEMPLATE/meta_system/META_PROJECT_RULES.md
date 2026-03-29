# Meta Project Rules

## Product Boundary

- MOS defines how to build and review a system-of-systems template.
- MOS does not ship application runtime code.
- MOS does not replace the app-facing AIAST product.

## Authoring Rules

- Keep canonical rule bodies in `meta_system/`.
- Keep tool-specific overlays in `meta_system/host-adapters/`.
- Keep milestone prompts in `meta_system/prompt-packs/`.
- Keep donor intake and scoring outside the installable product.
- Keep maintainer-only planning for this master repo in `_META_AGENT_SYSTEM/`, not inside installed targets.

## Validation Rules

- Update generated artifacts after changing canonical contracts or adapter manifests.
- Use `bootstrap/validate-meta-system.sh` for structure.
- Use `bootstrap/validate-meta-instruction-layer.sh` for authority-chain checks.
- Use `bootstrap/check-meta-host-adapter-alignment.sh` after adapter changes.
- Use `bootstrap/check-meta-hallucination.sh` after major doc or prompt edits.
