# Data Model

MOS uses file-based entities rather than database tables.

## Canonical Documents

Markdown files under `meta_system/` and `docs/` define rules, specs, and load order.

## Plugin Manifest

`plugin.json` declares:

- `name`
- `version`
- `description`
- `hooks`
- `owned_paths`
- `requires`

## Golden Example Manifest

`meta_system/golden-examples/meta-golden-example-manifest.json` lists:

- pattern files
- category files
- working-file exemplars
- donor notes

## Operating Profile

`meta_system/meta-operating-profile.json` summarizes:

- installed MOS version
- canonical startup files
- supported adapters
- validation commands

## Source Manifest

`MOS_SOURCE_LIBRARY/meta-source-manifest.json` records donor inputs and source boundaries.
