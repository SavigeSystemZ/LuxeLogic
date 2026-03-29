# Meta Repo Operating Profile

## Product Identity

- Product name: Meta Operating System
- Product version: `0.1.2`
- Product purpose: define how agents create and evolve system-of-systems templates
- Runtime boundary: MOS governs scaffolds, prompts, rules, adapters, validation, and governance surfaces; it does not define application runtime code

## Canonical Startup Contract

Load these first:

1. `META_AGENTS.md`
2. `meta_system/META_INSTRUCTION_PRECEDENCE_CONTRACT.md`
3. `meta_system/META_REPO_OPERATING_PROFILE.md`
4. `meta_system/META_LOAD_ORDER.md`

## Major Surfaces

- Core contracts: `meta_system/`
- Canonical product specification: `docs/`
- Public maintenance commands: `bootstrap/`
- Generated host adapters: `meta_system/host-adapters/`
- Golden examples and pattern guides: `meta_system/golden-examples/`
- Plugin framework: `meta_system/plugins/`

## Adapter Policy

- First-class adapters: Codex, Cursor, Claude, Gemini, Windsurf, Copilot
- Spec adapters: DeepSeek, Abacus, OpenAI LLM, Llama, Agent Zero
- All adapter surfaces are generated from `meta_system/meta-host-adapter-manifest.json`

## Golden Example Policy

- Golden examples are neutralized reference patterns, not donor copies
- MOS ships both cross-cutting pattern guides and category guidance for web, mobile, desktop, CLI, and API
- Downstream systems must adapt those patterns to repo-local facts

## Review Workflow

The first downstream workflow MOS supports is structured review of an existing AIAST-like system using `docs/ReviewWorkflow.md` and `meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md`.
