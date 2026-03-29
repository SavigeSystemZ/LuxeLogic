# Meta Golden Examples Policy

Golden examples give MOS neutral quality-bar guidance without copying donor systems verbatim.

## Goals

- preserve high-signal patterns from strong donor systems
- neutralize app-specific and repo-specific content
- provide reusable guidance across web, mobile, desktop, CLI, and API system surfaces

## Rules

- Do not copy donor runtime code into MOS golden examples.
- Do not present a donor example as if it were authoritative for the current repo.
- Each example must state what pattern it demonstrates and what must be adapted locally.
- Cross-cutting patterns and category guides must remain neutral and reusable.

## Validation

- `bootstrap/check-meta-hallucination.sh`
- `_MOS_TEMPLATE_FACTORY/validate-meta-golden-examples.sh`
