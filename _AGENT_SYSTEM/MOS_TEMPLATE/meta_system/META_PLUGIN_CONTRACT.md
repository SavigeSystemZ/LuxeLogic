# Meta Plugin Contract

MOS plugins extend the meta-system without silently rewriting its core.

## Plugin Layout

Plugins live under `meta_system/plugins/<plugin-name>/`.

Each plugin must provide:

- `plugin.json`
- `README.md`

## Required Manifest Fields

- `name`
- `version`
- `description`
- `hooks`
- `owned_paths`
- `requires`

## Allowed Hooks

- `bootstrap.post_install`
- `validation.preflight`
- `security.scan`
- `packaging.prepare`
- `release.preflight`

## Rules

- Plugins may only mutate their owned paths unless a core touchpoint is explicitly declared.
- Plugins must not bypass integrity, security, or precedence contracts.
- Plugins must not claim first-class tool support unless the core adapter manifest also declares it.
