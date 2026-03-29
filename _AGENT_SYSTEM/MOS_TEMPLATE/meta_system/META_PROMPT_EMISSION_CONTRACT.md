# Meta Prompt Emission Contract

This contract defines how MOS emits startup prompts and portable bundles for external hosts and orchestrators.

## Required Startup References

Every emitted prompt must reference these repo-local files by path:

1. `META_AGENTS.md`
2. `meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md`
3. `meta_system/META_REPO_OPERATING_PROFILE.md`
4. `meta_system/META_LOAD_ORDER.md`

## Emission Rules

- Distinguish host-level orchestration context from repo-local truth.
- Prefer path references over copied rule bodies.
- If a prompt pack is included, reference it by path or include it as an additive section instead of replacing the core startup contract.
- Generated prompts must remain safe for both first-class and spec-only tool adapters.
- Portable bundles may embed file contents, but they must preserve canonical file paths and version markers.

## Validation

- `bootstrap/emit-meta-host-prompt.sh`
- `bootstrap/emit-meta-host-bundle.sh`
- `bootstrap/check-meta-host-adapter-alignment.sh`
