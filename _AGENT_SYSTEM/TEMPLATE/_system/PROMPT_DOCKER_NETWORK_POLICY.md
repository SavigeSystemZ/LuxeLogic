# Docker Network Policy Prompt Rules

- App containers may publish their own UI/API port to loopback when needed for operator access.
- Internal services such as Redis, Dragonfly, Postgres, MinIO, queues, and caches must stay on the compose network by default.
- Compose files must carry healthchecks and restart policies for internal backends.
- Compose overrides that introduce host publishing must explain why the app cannot use the internal network path instead.
