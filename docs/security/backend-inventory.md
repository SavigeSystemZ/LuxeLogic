# Backend Inventory

| Backend | Role | Auth model | Persistence | Exposure | Host port | Rationale |
|---|---|---|---|---|---|---|
| `postgres-db` | primary database for `core-service` | env-driven user/password | `pgdata` volume | internal-only | none | Host publishing removed because no current host-native dependency was found. |
| `dragonfly-cache` | Redis-compatible cache backend | URL-driven; no auth enforced in current repo | ephemeral in current compose file | internal-only | none | Host publishing removed to eliminate the collision with Immortality and reduce unnecessary exposure. |
