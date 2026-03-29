# Security and Deployment Checklist

This document supports **advancement, security, enhancement, and best practice** for Candle Compass. Use it for deployment, audits, and ongoing hardening.

## 1. Secrets and Credentials

- [ ] **Never commit secrets.** Use `.env` (gitignored), encrypted secrets store (`scripts/secrets_tool.py`), or a vault. Rotate keys periodically.
- [ ] **Runtime control key:** Set `CANDLE_COMPASS_RUNTIME_CONTROL_KEY` to a strong random value in production. Set `CANDLE_COMPASS_REQUIRE_RUNTIME_CONTROL_KEY=true` for production.
  - **Minimum strength:** At least 32 characters; use a cryptographically random value (e.g. `openssl rand -base64 32`).
  - **Rotation:** Rotate the key when operators change or if compromise is suspected. Update the key in env/secrets and in launcher/Settings; restart UI/backend so new key is loaded. Document rotation date in your runbook.
  - **No default in production:** Do not run production with an empty or example key.
- [ ] **API keys:** Store optional keys (Polygon, Reddit, Google Trends, AlphaVantage, TheGraph, SEC user agent) in env or secrets store. App runs in degraded mode without them.
- [ ] **Ghost protocol:** Set `CANDLE_COMPASS_GHOST_TOKEN` and `CANDLE_COMPASS_GHOST_ALLOWED_IPS` for emergency link; keep cooldown and IP allowlist tight.
- [ ] **Database:** Use peer auth or strong passwords; never commit `CANDLE_COMPASS_PG_PASSWORD` or connection strings with secrets.
- [ ] **SMTP/Twilio:** Store credentials in env or secrets; do not hardcode in repo.

## 2. Runtime and Authorization

- [ ] **Role policy:** Configure `runtime_role_policy.json` (via API or file) so `view`/`operate`/`destructive` tiers match your operator model. Default destructive role: `operator` or higher.
- [ ] **Audit trail:** Runtime role-policy audit is persisted; ensure retention (trim/rotate) and timer are configured if using systemd user timers.
- [ ] **Destructive actions:** Require confirmation text `CONFIRM_RUNTIME_DESTRUCTIVE_ACTION` and appropriate role for service disable, audit clear, policy set.
- [ ] **Health endpoints:** Protect `/api/health` and trading gates from public abuse if exposed; use reverse proxy or firewall where appropriate.

## 3. Network and Host

- [ ] **Bind address:** Prefer `127.0.0.1` for UI/backend in development; use reverse proxy (nginx, Caddy) for production with TLS. See **OPS_RUNBOOK** "HTTPS and Reverse Proxy (Production)" for minimal nginx/Caddy examples.
- [ ] **Ports:** Default UI 3967, backend 8010; avoid conflict with other services. Document any overrides in runbooks.
- [ ] **CORS / CSP:** If API is consumed by other origins, configure CORS and Content-Security-Policy appropriately.
- [ ] **Firewall:** Restrict access to UI/backend ports to trusted networks where possible. In production, only the reverse proxy host should reach 3967/8010.

## 4. Data and Artifacts

- [ ] **Contract artifacts:** Treat `runs/latest/*` as contracts; run `python app/scripts/validate_artifacts.py --runs app/runs --strict` after schema changes.
- [ ] **Error log retention:** `runtime_error_events.jsonl` is trimmed (e.g. last 500 lines); ensure rotation is enabled in long-lived deployments.
- [ ] **Backup:** Single internal manual backup at `$HOME/.BackupZ-MyAppZ/CandleCompass.bak`; use `backup_project.sh` or `rotate_external_backups.sh`. Do not rely on deprecated paths.
- [ ] **Database backups:** If using PostgreSQL, schedule pg_dump or equivalent; store backups outside repo.

## 5. Dependencies and Supply Chain

- [ ] **Python:** Pin critical deps in `requirements.txt`. CI runs `pip audit` in the `security_scan` job; fix or suppress known issues and track remediation.
- [ ] **Node/npm:** CI runs `npm audit --audit-level=high` in `app/ui-next` (job may be `continue-on-error` until findings are triaged). Run `npm audit` locally; fix or accept risks for vulnerabilities.
- [ ] **Updates:** Plan upgrades for framework and major deps; test in staging before production.

## 6. Observability and Operations

- [ ] **Logging:** UI/backend/memory logs under `app/runs/*.log`; ensure log rotation and retention.
- [ ] **Structured request logging (audit):** Optionally log request id, role, and operation for sensitive POSTs (e.g. runtime policy set, service disable). See OPS_RUNBOOK for request-id and JSON log format guidance.
- [ ] **Health checks:** Use `/api/health` and trading gate for monitoring; integrate with existing alerting.
- [ ] **Runtime errors:** Monitor `runtime_error_last.json` or `runtime_error_events.jsonl` for repeated auth or API failures.
- [ ] **Service lifecycle:** Validate install/stop/status scripts for UI and backend services on target hosts.

## 7. Application Hardening

- [ ] **No blocking dialogs:** All confirmations/prompts use React modals (ConfirmDialog, PromptDialog); no `window.alert`/`confirm`/`prompt`.
- [ ] **Input validation:** API and UI validate inputs; use parameterized queries and sanitization for DB and user content.
- [ ] **HTTPS:** Use TLS in production for UI and API; avoid transmitting runtime key or tokens over plain HTTP. Put nginx or Caddy in front; bind app to 127.0.0.1. See OPS_RUNBOOK "HTTPS and Reverse Proxy (Production)."
- [ ] **Secure cookies:** If adding session/auth cookies, set `Secure` and `SameSite`; do not log headers that carry the runtime control key.

## 8. Pre-Deployment Verification

- [ ] Run full test suite: `pytest -q` and UI tests (e.g. Vitest).
- [ ] Run UI smoke: `python app/scripts/ui_smoke_test.py --runs app/runs/latest`.
- [ ] Run artifact validation: `python app/scripts/validate_artifacts.py --runs app/runs --strict` (with artifacts present).
- [ ] Run debug validation script: `bash scripts/run_debug_validation.sh` and review summary.
- [ ] Confirm runtime control key and role policy are set for target environment.

---

**References:** `assistant/resources/docs/OPS_RUNBOOK.md`, `assistant/resources/docs/APP_USER_GUIDE.md`, `assistant/FIXME.md`, `app/.env.example`.
