# Skill: Import/Export Portability

## Goal
Round-trip bundles (export → share → import) without losing provenance and without leaking secrets.

## Export requirements
- Redaction preflight hard-fail
- Evaluation gate (optional but recommended)
- Manifest includes hashes + run lineage + policy summaries

## Import requirements
- Validate manifest schema and artifact hashes
- Reject bundles with secrets detected
- Reconstruct run lineage as imported references
- Mark imported artifacts as "external provenance" unless fully regenerated locally
