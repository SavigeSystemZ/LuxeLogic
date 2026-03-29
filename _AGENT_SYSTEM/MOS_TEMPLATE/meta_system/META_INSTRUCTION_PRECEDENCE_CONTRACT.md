# Meta Instruction Precedence Contract

This contract defines how MOS resolves conflicts across repo-local meta truth, tool adapters, prompt packs, plugins, and host-level orchestration.

## Roles

- Repo-local runtime and product files hold factual truth about the system being built.
- Repo-local MOS core files hold the authoritative meta operating contract.
- Host adapters translate the shared contract into tool-specific startup surfaces.
- Prompt packs and emitted prompts are reusable orchestration surfaces, not primary authority.
- Plugins may extend MOS, but they do not silently replace core contracts.

## Authoritative Repo-Local Meta Files

1. `META_AGENTS.md`
2. `meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md`
3. `meta_system/META_REPO_OPERATING_PROFILE.md`
4. `meta_system/META_LOAD_ORDER.md`
5. `meta_system/META_PROJECT_RULES.md`
6. `meta_system/META_EXECUTION_PROTOCOL.md`
7. `meta_system/META_PROMPT_EMISSION_CONTRACT.md`

When the question is factual rather than instructional, actual repo files win over summaries.

## Precedence Order

1. Repo-local runtime and product truth.
2. Repo-local MOS core contracts.
3. Repo-local MOS host-adapter overlays in `meta_system/host-adapters/`.
4. Repo-local MOS prompt packs and emitted bundles.
5. Declared plugins that stay within their owned paths.
6. Host-level orchestration context.

## Conflict Rules

- Host instructions never override repo-local truth.
- Host adapters must point back to the canonical MOS core instead of replacing it.
- Prompt packs must cite canonical docs by path and avoid copying large rule bodies.
- Plugins may only change files they own and must declare any core touchpoints explicitly.
- If two repo-local docs conflict, prefer the more specific factual source and record the conflict in `META_WHERE_LEFT_OFF.md`.

## Resolution Workflow

1. Load `META_AGENTS.md`, this contract, `META_REPO_OPERATING_PROFILE.md`, and `META_LOAD_ORDER.md`.
2. Identify whether the collision is factual, procedural, adapter-specific, or host-specific.
3. Resolve the issue using the precedence order above.
4. If the conflict is structural, run `bootstrap/detect-meta-instruction-conflicts.sh <repo> --strict`.
5. Record unresolved ambiguity in `meta_system/context/OPEN_QUESTIONS.md`.
