# Ops Runbook

## Database (PostgreSQL optional)

**Design:** Distribution-first; see **`assistant/resources/docs/DATABASE_ARCHITECTURE.md`**. One database per app; Candle Compass uses `candlecompass_prod`. The app detects the current OS user and uses **peer authentication** (no password) when using the recommended setup.

- **Default:** SQLite at `runs/candle_compass.db` (no Postgres required).
- **PostgreSQL (recommended for installs):**
  1. **Run once after install** (from app root): `./scripts/setup_db.sh` or `python3 scripts/setup_db.py`
     - Detects current OS user, creates `candlecompass_prod` owned by that user, applies schema, and can fix legacy DB ownership. No passwords; uses peer auth.
     - Env: `CANDLE_COMPASS_PG_DB` (default `candlecompass_prod`), `CANDLE_COMPASS_PG_PORT` (default `5432`), `CANDLE_COMPASS_SETUP_DB_SILENT=1` for quiet.
  2. Enable Postgres: set `database.engine: postgres` in `config.yaml` (defaults: `dbname: candlecompass_prod`, `auth: peer`, no host = Unix socket).
  3. Install driver: `pip install 'psycopg[binary]'`.
- **Legacy / explicit user:** For a non-peer setup use `create_candle_compass_db.sh` and set `database.postgres.user` and optionally `CANDLE_COMPASS_PG_PASSWORD` or `CANDLE_COMPASS_DATABASE_URL`.
- **If the DB is missing or broken:** Re-run `./scripts/setup_db.sh`. Schema is idempotent. Do not mix other applications’ data; one database per app.
- **Nightly evolution script** (`run_nightly_evolution.py`) currently uses SQLite only; when using Postgres for the main app, either keep a SQLite file for evolution (set `CANDLE_COMPASS_DB_PATH`) or run evolution against the same Postgres DB (future).

## Full Refresh (Recommended)
- `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online`
- `python scripts/ui_health_check.py --runs runs/latest`
- Strict validation: `python scripts/ui_health_check.py --runs runs/latest --strict` and `python scripts/ui_smoke_test.py --runs runs/latest --strict`
- Opportunity ranking artifact is generated at `runs/latest/opportunity_board.json`.

## Advisory Only
- `python scripts/run_advisory.py --universe asset_universe.yaml --risk-profile moderate`

## Ranked Lists Only
- `python scripts/refresh_ranked_lists.py --universe asset_universe.yaml`
- `./scripts/install_ranked_timer.sh ~/candle_compass 30`

## Alerts Only
- `python scripts/alerts_runner.py --config config.yaml`
- `./scripts/install_alerts_timer.sh ~/candle_compass 15`

## Health Check
- `python scripts/health_check.py --config config.yaml`
- `python scripts/validate_startup_config.py --config config.yaml`
- `python scripts/e2e_smoke.py --runs runs/latest --strict`
- E2E with HTTP/WS probes (deterministic timeouts):  
  `python scripts/e2e_smoke.py --runs runs/latest --check-http --check-ws --ws-timeout 10 --strict`  
  Use `--ws-timeout` (default 10s) so WebSocket checks never block indefinitely; increase on slow hosts if needed.
- **WebSocket timeout/abort:** Replay and live-data WebSocket clients in the UI use browser defaults; backend replay and whale endpoints may keep connections open. For deterministic smoke runs, use `--ws-timeout` and avoid relying on long-lived WS in automated checks. For production, consider reconnection backoff and max-reconnect limits in UI code if you observe stuck connections.
- API ops status snapshot:
  - `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"uiDetached":"status","appService":"status","memoryServer":"status","backendServer":"status"}}'`
- API ops status snapshot (auth-enabled runtime controls):
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"uiDetached":"status","appService":"status","backendService":"status","memoryServer":"status","backendServer":"status"}}'`
- API detached UI restart:
  - `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"uiDetached":"restart"}}'`
- API app service restart:
  - `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"appService":"restart"}}'`
- API backend restart:
  - `curl -X POST -H "Content-Type: application/json" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"backendServer":"restart"}}'`
- API backend app-service restart:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"backendService":"restart"}}'`
- API app-service install/disable:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"appService":"install"}}'`
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"appService":"disable"}}'`
- API backend app-service install/disable:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"backendService":"install"}}'`
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"backendService":"disable"}}'`
- API service-action history status/clear:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"status"}}'`
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"clear"}}'`
  - Destructive clear with explicit server-side confirm + role:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" -H "x-runtime-role: operator" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"clear"}}'`
- API service-log status refresh:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceLogs":"status"}}'`
- `./scripts/install_health_check_timer.sh ~/candle_compass 60`
- `./scripts/stop_health_check_timer.sh`
- Optional push webhook: store `CANDLE_COMPASS_PUSH_WEBHOOK` in the secrets store

## Runtime Role Matrix (System Operations)
- API now returns runtime policy metadata:
  - `curl -s http://127.0.0.1:3967/api/candle_compass | jq '.runtimeAuth'`
- Runtime policy status action:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: viewer" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"runtimeRolePolicy":"status"}}'`
- Runtime policy set action:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: operator" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"runtimeRolePolicy":"set"},"runtimeRolePolicy":{"view":"viewer","operate":"operator","destructive":"operator"}}'`
- Runtime policy audit status:
  - `curl -s http://127.0.0.1:3967/api/candle_compass | jq '.runtimeRolePolicyAudit'`
- Runtime policy audit status action:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: viewer" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"runtimeRolePolicyAudit":"status"}}'`
- Runtime policy audit clear action:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperationConfirmText":"CONFIRM_RUNTIME_DESTRUCTIVE_ACTION","operations":{"runtimeRolePolicyAudit":"clear"}}'`
- Runtime policy audit trim action:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperationConfirmText":"CONFIRM_RUNTIME_DESTRUCTIVE_ACTION","runtimeRolePolicyAuditKeep":100,"operations":{"runtimeRolePolicyAudit":"trim"}}'`
- Runtime policy audit rotate action:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperationConfirmText":"CONFIRM_RUNTIME_DESTRUCTIVE_ACTION","runtimeRolePolicyAuditKeep":100,"operations":{"runtimeRolePolicyAudit":"rotate"}}'`
- Runtime policy audit timer install:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperatorRole":"owner","runtimeRolePolicyAuditKeep":100,"runtimeRolePolicyAuditTimerInterval":30,"operations":{"runtimeRolePolicyAuditTimer":"install"}}'`
- Runtime policy audit timer status:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperatorRole":"owner","operations":{"runtimeRolePolicyAuditTimer":"status"}}'`
- Runtime policy audit timer stop:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-role: owner" http://127.0.0.1:3967/api/candle_compass -d '{"runtimeOperatorRole":"owner","operations":{"runtimeRolePolicyAuditTimer":"stop"}}'`
- Runtime policy audit timer status/preflight snapshot:
  - `curl -s http://127.0.0.1:3967/api/candle_compass | jq '{runtimeRolePolicyAuditTimerStatus, runtimeRolePolicyAuditTimerPreflight}'`
- Runtime role hierarchy:
  - `viewer < operator < admin < owner`
- Operation tiers:
  - `view`: status/log refresh actions
  - `operate`: start/stop/restart/install/run checks/bundle actions
  - `destructive`: app/backend service disable, service action-history clear, kill switch
- Destructive request requirements:
  - role must satisfy `runtimeAuth.requiredRoles.destructive`
  - confirmation token must match `CONFIRM_RUNTIME_DESTRUCTIVE_ACTION`
- Persistence:
  - runtime policy file: `runs/latest/runtime_role_policy.json`
  - runtime policy audit file: `runs/latest/runtime_role_policy_audit.json`
  - runtime policy audit rotation status: `runs/latest/runtime_role_policy_audit_rotation_status.json`
  - runtime policy audit archive dir: `runs/archive/runtime_role_policy_audit/`
  - runtime policy audit timer status payload is computed live via `systemctl --user` probes on API requests.
  - `runtimeAuth.policySource` is `env` until first set action, then `file`.
- **Backup/restore for runtime role policy:** Before major upgrades or host migration, copy `runs/latest/runtime_role_policy.json` (and optionally `runtime_role_policy_audit.json`) into your single-copy backup or a versioned backup. To restore: place the file(s) back under `runs/latest/` and restart or reload the API so the next GET/POST reads the restored policy. Do not restore over a live system without verifying the policy contents.
- **Audit timer production enablement:**
  - **Prerequisites:** `systemctl --user` must be available (logind user session; not always available in containers or minimal envs).
  - **Interval baseline:** Use 180–360 minutes for production; shorter intervals increase log churn. Set via API `runtimeRolePolicyAuditTimerInterval` when installing the timer.
  - **Owner-role gating:** Only roles with `destructive` (e.g. `owner`/`admin`) should install/stop the audit timer. Restrict who has the runtime control key and destructive role in production.
  - **SOP:** Document in your runbook: (1) install timer via API or script with desired keep-count and interval, (2) verify `runtimeRolePolicyAuditTimerStatus` and preflight in API response, (3) use rotate/trim with confirm token when pruning audit history.
- Smoke validation including runtime policy guards:
  - `.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --strict --check-http --ui-api-url http://127.0.0.1:3100/api/candle_compass --backend-health-url http://127.0.0.1:8010/api/health`
- Example destructive request:
  - `curl -X POST -H "Content-Type: application/json" -H "x-runtime-control-key: $CANDLE_COMPASS_RUNTIME_CONTROL_KEY" -H "x-runtime-role: operator" -H "x-runtime-confirm-text: CONFIRM_RUNTIME_DESTRUCTIVE_ACTION" http://127.0.0.1:3967/api/candle_compass -d '{"operations":{"serviceActionHistory":"clear"}}'`

## HTTPS and Reverse Proxy (Production)

For production, do not expose the UI or backend directly on 0.0.0.0. Use a reverse proxy with TLS so the runtime control key and tokens are never sent over plain HTTP.

- **Recommended:** Run UI on `127.0.0.1:3967` and backend on `127.0.0.1:8010`; put nginx or Caddy in front with TLS (e.g. Let's Encrypt).
- **nginx (minimal):** Proxy `/` to `http://127.0.0.1:3967` and `/api` to `http://127.0.0.1:3967` (Next.js serves both) or split API to backend `http://127.0.0.1:8010` if you route backend separately. Use `proxy_http_version 1.1`, `proxy_set_header Host $host`, `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for`, `proxy_set_header X-Forwarded-Proto $scheme`. Enable SSL with `ssl_certificate` / `ssl_certificate_key` and redirect HTTP→HTTPS.
- **Caddy:** Automatic HTTPS with `reverse_proxy 127.0.0.1:3967` (or split to 8010 for API). Caddy obtains and renews certificates by default.
- **Secure cookies:** If you add session or auth cookies later, set `Secure` and `SameSite` attributes so they are only sent over HTTPS. The current runtime control key is sent via header (`x-runtime-control-key`); ensure the reverse proxy does not log or strip it.
- **Health behind proxy:** Ensure `/api/health` and `/api/candle_compass` (for status) are reachable through the proxy; adjust firewall so only the proxy can reach 3967/8010 on the host.
- **Optional rate limiting:** If the proxy exposes API publicly, consider rate limiting (nginx `limit_req`, Caddy `rate_limit`) or app middleware. Document limits when enabled.

See **Security and Deployment Checklist** §3 and §7 for bind address and HTTPS.

## Docker Production Usage

When running Candle Compass in Docker for production (see repo root `Dockerfile` and `docker-compose.yml`, and `docker/README.md`):

- **Resource limits:** Set memory and CPU limits in `docker-compose.yml` (e.g. `deploy.resources.limits.memory`, `cpus`) so a single container cannot exhaust the host. Backend and UI both have health endpoints; use `healthcheck` in compose and orchestration restarts.
- **Secrets injection:** Do not bake secrets into images. Use env files (e.g. `.env` not committed), Docker secrets, or a vault sidecar. Set `CANDLE_COMPASS_RUNTIME_CONTROL_KEY` and `CANDLE_COMPASS_REQUIRE_RUNTIME_CONTROL_KEY=true` via environment at runtime. For Ghost protocol, set `CANDLE_COMPASS_GHOST_TOKEN` and `CANDLE_COMPASS_GHOST_ALLOWED_IPS` via env.
- **Health checks:** Configure `healthcheck` in compose for backend (`GET /api/health`) and UI (`GET /api/health` or `/`). Use `interval`, `timeout`, `retries`, and `start_period` so orchestrators can replace unhealthy containers.
- **Bind and reverse proxy:** In production, avoid exposing backend/UI ports directly to the internet. Run behind a reverse proxy (nginx/Caddy) with TLS; use internal networks so only the proxy talks to the containers.
- **Volumes:** Persist `app/runs` (and optional Postgres/Redis data) so restarts do not lose artifacts. Backup these volumes regularly (see REPO_BOUNDARY_AND_BACKUP and single-copy backup policy).

## Observability (Optional)

- **Alerting on runtime errors:** The API appends failures to `runs/latest/runtime_error_events.jsonl` and updates `runs/latest/runtime_error_last.json`. To alert on repeated auth failures or error spikes, run a cron or sidecar that tails the JSONL (or reads `runtime_error_last.json`), counts recent entries by `errorId` or message pattern, and triggers a webhook or notification when a threshold is exceeded (e.g. more than N auth failures in 5 minutes). Do not log secrets; use error codes or message keys only.
- **Prometheus / metrics:** The app does not expose a `/metrics` endpoint by default. For request counts and health metrics you can: (1) Put a reverse proxy (nginx/Caddy) in front and use its metrics or a Prometheus exporter; (2) Add an optional `/api/metrics` or `/api/health/prometheus` in the backend that returns Prometheus text format (e.g. `http_requests_total`, `health_status`). Document any custom metrics and Grafana dashboard JSON in your runbook.

## Git Connectivity (MUST)
- Verify connectivity: `./scripts/git_connectivity_check.sh`
- If remote is unreachable, restore SSH/network access and rerun the check before continuing coding work.

## Secrets (Encrypted)
- Store secrets: `python scripts/secrets_tool.py set <NAME> <VALUE>`
- List secrets: `python scripts/secrets_tool.py list`
- The app prompts for the Master Password on startup when secrets exist.

**Secret rotation (runtime control key):** When rotating `CANDLE_COMPASS_RUNTIME_CONTROL_KEY`, (1) generate a new value (e.g. `openssl rand -base64 32`), (2) update env or secrets store and the value in launcher/Settings if persisted there, (3) restart UI and backend so the new key is loaded, (4) document rotation date in your runbook. See **Security and Deployment Checklist** for minimum key strength (e.g. ≥32 chars, cryptographically random).

## IP Whitelist
- Check public IP vs allowed list: `python scripts/ip_whitelist_check.py`
- Allowed IPs are stored in `data/security/ip_whitelist.json`

## Emergency Kill Switch
- `python scripts/kill_switch.py --exchanges binance,coinbase,kraken`
- Writes `runs/latest/security_lock.json` and `runs/latest/kill_switch.json`

## Ghost Protocol (Remote Emergency API)

Remote emergency close-all endpoint for authorized operators. Harden in production with IP allowlist and cooldown.

- **Endpoint:** `GET /api/emergency/close_all?token=<SECRET>`
- **Required env:** `CANDLE_COMPASS_GHOST_TOKEN`, and `CANDLE_COMPASS_SERVER_IP` for outbound emergency-link generation.
- **Best practices:**
  - **IP allowlist:** Set `CANDLE_COMPASS_GHOST_ALLOWED_IPS` to a comma-separated list of allowed client IPs (e.g. office or VPN egress). If set, only those IPs can trigger Ghost; others receive 403. Empty = allow all (not recommended for production).
  - **Cooldown:** Set `CANDLE_COMPASS_GHOST_COOLDOWN_SECONDS` (default 60; max 86400). After a successful trigger, further requests return 429 with `Retry-After` until the window elapses. Prevents accidental double-trigger and limits abuse.
  - **Token:** Use a long random token (e.g. `openssl rand -base64 32`). Comparison is constant-time to reduce timing leakage. Never log or expose the token.
  - **Exchanges:** Optional `CANDLE_COMPASS_GHOST_EXCHANGES` (comma-separated) to restrict which exchanges are closed; otherwise uses config/default.
- **On successful trigger,** backend writes: `runs/latest/security_lock.json`, `logic_gate_override.json`, `kill_switch.json`, `ghost_protocol_status.json`. Confirmation SMS: `PROTOCOL GHOST: All positions closed. System sleeping.`
- **Tests:** `tests/test_execution_router.py` covers invalid token (401), IP allowlist (403), cooldown (429), and successful trigger with artifacts.

## Admin Control API (UI)
- Read control payload:
  - `curl -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control`
- Export full signed audit log:
  - `curl -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" "http://127.0.0.1:3967/api/candle_compass/admin/control?export=audit"`
- Update notification preferences:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"notificationPrefs":{"users":{"default":{"enabled":true,"channels":["email","sms"],"email":"alerts@example.com","phone":"+15551234567"}}}}'`
- Update scoped user notification preferences:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"notificationPrefs":{"users":{"default":{"enabled":true,"channels":["email"]},"desk_alpha":{"enabled":true,"channels":["sms"],"phone":"+15550001111"}}}}'`
- Rollback strategy weights from history:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"strategyWeightsRollback":{"historyIndex":0,"reason":"operator_rollback","approval":{"approvedBy":"ops-admin","reason":"risk policy rollback"}}}'`
- Trigger Ghost via admin proxy (explicit confirmation text required):
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: superadmin" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"ghostTrigger":{"confirmText":"CLOSE ALL","approval":{"approvedBy":"ops-admin","reason":"emergency containment"}}}'`
- Trigger WORM export via admin proxy:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"wormExportRun":{"dryRun":false}}'`
- Trigger WORM export dry-run via admin proxy:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"wormExportRun":{"dryRun":true}}'`
- Trigger WORM retention validation via admin proxy:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"wormRetentionValidate":{"dryRun":false}}'`
- Trigger WORM retention validation dry-run via admin proxy:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"wormRetentionValidate":{"dryRun":true}}'`
- Trigger WORM environment preflight check via admin proxy:
  - `curl -X POST -H "Content-Type: application/json" -H "x-admin-key: $CANDLE_COMPASS_ADMIN_KEY" -H "x-admin-role: operator" http://127.0.0.1:3967/api/candle_compass/admin/control -d '{"wormEnvCheckRun":true}'`
- Optional signing key for audit signatures:
  - `CANDLE_COMPASS_AUDIT_SIGNING_KEY=<secret>`
- Optional off-host audit shipping:
  - `CANDLE_COMPASS_AUDIT_WEBHOOK_URL=<https-endpoint>`
  - `CANDLE_COMPASS_AUDIT_WEBHOOK_TOKEN=<bearer-token>`
  - `CANDLE_COMPASS_AUDIT_WEBHOOK_TIMEOUT_MS=4000`
  - `CANDLE_COMPASS_AUDIT_RETRY_SECONDS=30`
  - `CANDLE_COMPASS_AUDIT_RETRY_MAX_ATTEMPTS=20`
- Optional WORM-style archive settings:
  - `CANDLE_COMPASS_AUDIT_WORM_ENABLED=true`
  - `CANDLE_COMPASS_AUDIT_WORM_DIR=runs/audit_worm`
- Optional S3 object-lock export settings:
  - `CANDLE_COMPASS_AUDIT_WORM_S3_BUCKET=<bucket>`
  - `CANDLE_COMPASS_AUDIT_WORM_S3_PREFIX=audit/admin`
  - `CANDLE_COMPASS_AUDIT_WORM_S3_ENDPOINT_URL=<optional-s3-compatible-endpoint>`
  - `CANDLE_COMPASS_AUDIT_WORM_S3_REGION=<region>`
  - `CANDLE_COMPASS_AUDIT_WORM_S3_OBJECT_LOCK_ENABLED=true`
  - `CANDLE_COMPASS_AUDIT_WORM_S3_OBJECT_LOCK_MODE=COMPLIANCE`
  - `CANDLE_COMPASS_AUDIT_WORM_S3_RETENTION_DAYS=3650`
- One-shot WORM export:
  - `python scripts/export_audit_worm_s3.py --bucket <bucket>`
- Dry-run WORM export:
  - `python scripts/export_audit_worm_s3.py --bucket <bucket> --dry-run`
- One-shot retention validation probe:
  - `python scripts/validate_audit_worm_retention.py --bucket <bucket>`
- Retention validation dry-run:
  - `python scripts/validate_audit_worm_retention.py --bucket <bucket> --dry-run`
- WORM environment preflight:
  - `python scripts/check_audit_worm_env.py`
- Dependency note:
  - install boto3 first: `.venv/bin/pip install boto3`
  - configure credentials: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` (and `AWS_SESSION_TOKEN` if needed)
- Install WORM export timer:
  - `./scripts/install_audit_worm_export_timer.sh ~/candle_compass 60`
- Stop WORM export timer:
  - `./scripts/stop_audit_worm_export_timer.sh`
- Run one-shot queue flush worker:
  - `python scripts/admin_audit_ship_worker.py`
- Run continuous queue flush worker:
  - `python scripts/admin_audit_ship_worker.py --loop --interval-seconds 30`
- Install/enable user service for durable retries:
  - `./scripts/install_admin_audit_worker_service.sh ~/candle_compass 30`
- Stop/disable audit worker service:
  - `./scripts/stop_admin_audit_worker_service.sh`

## Data Health
- `python scripts/data_health_check.py --config asset_universe.yaml --cache-only`

## Scanner Provider Defaults (Regional Safe Mode)
- The MarketScanner defaults to `ccxt` (Coinbase/Kraken/Bitstamp/Kucoin) to avoid Binance 451 responses in restricted regions.
- Configure in `config.yaml`:
  - `scanner.crypto_source`: `ccxt` or `binance`
  - `scanner.ccxt_exchanges`: list of exchanges to poll
  - `scanner.binance_base`: override Binance base URL if needed
- If Binance returns HTTP 451, switch to `ccxt` and rerun the backend.

## Backend Redis Modes
- Default mode is Redis-enabled (`config.yaml` -> `backend.redis.enabled: true`).
- Enable Redis in config or per-run:
  - `CANDLE_COMPASS_REDIS_ENABLED=true CANDLE_COMPASS_REDIS_URL=redis://127.0.0.1:6379/0 PYTHONPATH=app python -m uvicorn app.main:app --reload`
- If Redis is disabled, scanner caching/hotlist persistence runs in memory only (no hard failure).

## Polygon Key (Stocks Scanner)
- Store key in encrypted secrets: `python scripts/secrets_tool.py set POLYGON_API_KEY <value>`
- Fallback env var is supported: `POLYGON_API_KEY=<value>`.
- If no key is available, stock universe discovery stays empty while crypto discovery continues.

## UI Launch
- Primary validation (Next.js command center):
- `python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online`
- `cd app/ui-next && npm run dev`
- Open `http://127.0.0.1:3967`
- `./scripts/launch_ui.sh ~/candle_compass`
- `./scripts/launch_ui_desktop.sh ~/candle_compass`
- `./scripts/launch_ui_detached.sh ~/candle_compass`
- `./scripts/launch_ui_detached.sh ~/candle_compass --runtime=production --no-open`
- `./scripts/launch_ui_detached.sh ~/candle_compass --runtime=development --no-open`
- `./scripts/stop_ui_detached.sh ~/candle_compass`
- Optional host/port: `CANDLE_COMPASS_UI_PORT=3967 CANDLE_COMPASS_UI_HOST=127.0.0.1 ./scripts/launch_ui.sh ~/candle_compass`

## Installer
- `./scripts/install_candle_compass.sh ~/candle_compass`
- Uses app-only manifest at `assistant/resources/install_manifest.txt` (paths are relative to `app/`)
- Installer creates `.venv`, installs Python deps, installs UI deps, and builds the Next.js UI by default.
- Installer skips offline smoke tests, excludes `data/fixtures`, and does not generate `runs/latest` artifacts.
- Optional installer flags:
  - `--skip-python-deps`
  - `--skip-ui-deps`
  - `--skip-ui-build`
  - `--skip-desktop-launcher`

## Services & Timers
- Install bundle refresh timer (validates working dir; adds MemoryMax/CPUQuota/TasksMax):
  - `./scripts/install_bundle_timer.sh /absolute/path/to/app 15 "--provider yfinance"`
  - Path must exist and contain `.venv` and `scripts/run_ui_bundle.py` or install will fail.
- Stop bundle timer (current + legacy names): `./scripts/stop_bundle_timer.sh`
- **One-time fix for rsiglobe-bundle journal spam** (service failing with "working directory missing"):
  - `./scripts/stop_legacy_rsiglobe_services.sh` — stops and disables legacy `rsiglobe-bundle.timer`/`.service`.
  - Then install with correct path if desired: `./scripts/install_bundle_timer.sh $(pwd) 15`
- Install runtime role-policy audit rotation timer:
  - `./scripts/install_runtime_role_policy_audit_timer.sh ~/candle_compass 30 100`
- Runtime role-policy audit rotation timer status:
  - `./scripts/runtime_role_policy_audit_timer_status.sh`
- Stop runtime role-policy audit rotation timer:
  - `./scripts/stop_runtime_role_policy_audit_timer.sh`
- Stop ranked timer: `./scripts/stop_ranked_timer.sh`
- Stop alerts timer: `./scripts/stop_alerts_timer.sh`
- Install UI service: `./scripts/install_service.sh ~/candle_compass`
- Install UI service with explicit host/port/runtime:
  - `CANDLE_COMPASS_UI_HOST=127.0.0.1 CANDLE_COMPASS_UI_PORT=3850 CANDLE_COMPASS_UI_RUNTIME=production ./scripts/install_service.sh ~/candle_compass`
- Stop UI service: `./scripts/stop_service.sh`
- Install backend service with explicit host/port:
  - `CANDLE_COMPASS_BACKEND_HOST=127.0.0.1 CANDLE_COMPASS_BACKEND_PORT=8010 ./scripts/install_backend_service.sh ~/candle_compass`
- Stop backend service: `./scripts/stop_backend_service.sh`
- Install audit ship worker service: `./scripts/install_admin_audit_worker_service.sh ~/candle_compass 30`
- Stop audit ship worker service: `./scripts/stop_admin_audit_worker_service.sh`
- Install audit WORM export timer: `./scripts/install_audit_worm_export_timer.sh ~/candle_compass 60`
- Stop audit WORM export timer: `./scripts/stop_audit_worm_export_timer.sh`
- Status check: `./scripts/ui_status.sh`

## Backups
- Single-copy policy: only one backup is retained. Creating a new one removes older ones.
- Light backup (excludes `.venv`): `./scripts/backup_project.sh ~/candle_compass`
- Full backup (includes `.venv`): `./scripts/backup_project.sh ~/candle_compass /home/whyte/.cursor full`

## Memory Server
- Start: `python scripts/memory_server.py --host 127.0.0.1 --port 8766`
- Detached start: `./scripts/launch_memory_server.sh ~/candle_compass`
- Status: `./scripts/memory_status.sh ~/candle_compass`
- Stop: `./scripts/stop_memory_server.sh ~/candle_compass`
- Health: `GET /health`
- MCP endpoint: `POST /mcp`
- Optional auth token: store `CANDLE_COMPASS_MEMORY_TOKEN` in the secrets store

## Backend Detached Runtime
- Start detached backend: `./scripts/launch_backend_detached.sh ~/candle_compass`
- Backend status: `./scripts/backend_status.sh ~/candle_compass`
- Stop detached backend: `./scripts/stop_backend_detached.sh ~/candle_compass`

## Backend User Service
- Install/enable backend user service: `./scripts/install_backend_service.sh ~/candle_compass`
- Backend service status: `./scripts/backend_service_status.sh`
- Stop/disable backend user service: `./scripts/stop_backend_service.sh`

## Nightly Checklist
See `assistant/context/NIGHTLY_CHECKLIST.md` for the latest checklist.
