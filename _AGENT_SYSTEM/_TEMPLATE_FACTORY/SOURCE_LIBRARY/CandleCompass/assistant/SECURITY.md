# Security

- Do not commit secrets or API keys.
- Store API keys and secrets in the encrypted secrets store (`scripts/secrets_tool.py`). Do not place them in `.env`.
- Secrets are encrypted with AES‑256‑GCM and require a Master Password on startup.
- Keep fixtures and test data non-sensitive.
- Live trading requires explicit user confirmation.
