# Validation

```bash
docker compose -f docker-compose.yml config
docker compose -f docker-compose.yml up -d postgres-db dragonfly-cache
docker compose -f docker-compose.yml ps postgres-db dragonfly-cache
docker compose -f docker-compose.yml port dragonfly-cache 6379 || true
```

Expected signals:

- Compose renders cleanly.
- Postgres and Dragonfly start without host-port allocation failures.
- `docker compose ... port dragonfly-cache 6379` prints no host mapping.
