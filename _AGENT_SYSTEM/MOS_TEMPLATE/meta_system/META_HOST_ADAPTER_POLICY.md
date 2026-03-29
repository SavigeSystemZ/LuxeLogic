# Meta Host Adapter Policy

This policy governs the tool-specific adapter files that sit on top of the shared MOS core.

## Canonical Sources

- `META_AGENTS.md`
- `META_INSTRUCTION_PRECEDENCE_CONTRACT.md`
- `META_REPO_OPERATING_PROFILE.md`
- `META_LOAD_ORDER.md`
- `META_PROMPT_EMISSION_CONTRACT.md`
- `meta-host-adapter-manifest.json`

## Generated Surfaces

All adapter files under `host-adapters/` are generated from `meta-host-adapter-manifest.json`.

## Change Rules

- Do not hand-edit generated adapter files as the primary maintenance path.
- Update the canonical docs or the manifest, then run `bootstrap/generate-meta-host-adapters.sh <repo> --write`.
- Run `bootstrap/check-meta-host-adapter-alignment.sh <repo>` after changing the manifest or generator.
- Keep first-class and spec-only adapter tiers explicit.
