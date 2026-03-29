# Review Workflow

Use MOS to review an existing AIAST-like system in a repeatable, evidence-backed way.

## Inputs

- the repo under review
- the canonical MOS contracts
- `meta_system/prompt-packs/M9_AIAST_SYSTEM_REVIEW.md`

## Review Sequence

1. Load the MOS startup contract.
2. Read the repo’s installable system entrypoints and precedence rules.
3. Compare repo-local truth against emitted prompts, adapters, and validation surfaces.
4. Record findings in severity order.
5. Separate factual defects from open questions and future improvements.

## Expected Outputs

- findings with file references
- residual risks and test gaps
- recommended next actions
- updated handoff state in `META_WHERE_LEFT_OFF.md` when the review repo owns live state
