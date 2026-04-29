# Rollback

1. Revert `docker-compose.yml`, `.env.example`, and the security docs added in this pass.
2. If host publishing must be restored temporarily, reintroduce loopback-only port mappings and document the reason in `docs/security/backend-inventory.md`.
3. Re-run the validation commands after rollback.
