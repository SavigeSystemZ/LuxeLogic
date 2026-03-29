# Export Redaction Rules (vNext)

Goal: prevent leakage of secrets, tokens, credentials, and identifying paths into export bundles or logs.

## Pipeline stages
1) Normalize text
2) Detect high-confidence secrets (HARD_FAIL)
   - PEM private keys
   - JWTs
   - provider key patterns
   - cloud access key formats
3) Detect medium-confidence (WARN or REDACT per policy)
   - high-entropy strings
   - tokens embedded in URLs
4) Apply allow-list exceptions
   - placeholders like "YOUR_KEY_HERE"
5) Emit redaction report + block export if HARD_FAIL triggers

## Validation
- Unit tests for each rule (positive + negative)
- Regression tests for any real incident (sanitized sample)
