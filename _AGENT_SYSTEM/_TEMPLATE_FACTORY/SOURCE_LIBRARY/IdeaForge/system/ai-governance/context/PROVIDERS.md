# Provider Notes (MVP)

## Goals
- Provider-agnostic interface for text generation.
- Minimal provider metadata persisted (tokens/costs if available).
- Secrets never stored in DB; only via runtime env (web) or OS keychain (desktop).

## Provider adapter interface
- generateText(request) -> response
- normalize errors to a shared model:
  - AUTH_MISSING
  - RATE_LIMITED
  - PROVIDER_UNAVAILABLE
  - VALIDATION_FAILED
  - POLICY_BLOCKED
