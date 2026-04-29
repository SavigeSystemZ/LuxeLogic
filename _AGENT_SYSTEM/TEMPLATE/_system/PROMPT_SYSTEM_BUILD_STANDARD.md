# System Build Standard

- Default to secure-by-default scaffolding, not opt-in hardening.
- Keep runtime endpoints env-driven and avoid hardcoded `localhost`, `127.0.0.1`, or shared host services in application code.
- Treat Redis, Dragonfly, Postgres, MinIO, queues, and other internals as owned backends with an explicit service role and exposure model.
- Generate `docs/security/architecture.md`, `docs/security/backend-inventory.md`, `docs/security/validation.md`, and `docs/security/rollback.md` whenever a runtime or deployment surface is added.
- Require validation and rollback steps in the same change set that introduces or changes backend infrastructure.
