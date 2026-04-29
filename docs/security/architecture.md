# Backend Security Architecture

## Summary

LuxeLogic no longer publishes its internal Postgres or Dragonfly services to host ports by default.

- `postgres-db` is internal-only on the compose network.
- `dragonfly-cache` is internal-only on the compose network.
- `core-service` continues to reach both services by their compose service names.

## Functional role

- Postgres is the primary relational datastore for `core-service`.
- Dragonfly is provisioned as a Redis-compatible cache backend, but no active application call sites were identified in this pass.

This change resolves the observed host collisions with Immortality on `5433` and `6380` without forcing a port reassignment in Immortality.
