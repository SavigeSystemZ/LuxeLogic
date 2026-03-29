# Generator Contracts (IdeaForge)

## Standard inputs
- idea_id
- idea_snapshot (title, summary, constraints, notes)
- generator_profile (provider, model, params)
- artifact_request (type + naming + versioning rules)
- safety_policy (redaction + forbidden content)

## Standard outputs
- generator_run record (id, timestamps, prompt bundle, metadata)
- artifacts[] (type, name, content, format, version, lineage)
- user-facing summary (what was generated, what to review)

## Failure modes
- provider auth missing
- rate limit / timeout
- content filtered (policy)
- validation error (schema mismatch)
All must return actionable errors without leaking secrets.
