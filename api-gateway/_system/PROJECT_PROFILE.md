# Project Profile

Fill this file in immediately after copying the operating system into a real repo. The stronger and more specific this file is, the better every agent will perform.

## Completion status

- [ ] Identity filled
- [ ] Runtime boundaries filled
- [ ] Stack filled
- [ ] Components filled
- [ ] Build, packaging, and install filled
- [ ] Mobile and AI filled
- [ ] Validation commands filled
- [ ] Operations and deployment filled
- [ ] Security and compliance filled
- [ ] Observability filled
- [ ] Constraints filled
- [ ] MCP plan filled
- [ ] Canonical docs filled
- [ ] Experience targets filled
- [ ] Release model filled

## Identity

- App name: LuxeLogic API Gateway
- App id: io.luxelogic.api.gateway
- Desktop entry id: io.luxelogic.api.gateway
- Android application id: io.luxelogic.api.gateway
- Repo purpose: Stable entry point and traffic orchestrator for LuxeLogic microservices.
- Product category: API Infrastructure
- Primary users: Mobile/Web clients, Internal services
- Main workflows: Request routing, SSL termination, and service discovery.
- Primary success criteria: High availability, sub-millisecond routing overhead, and secure TLS termination.
- Non-goals: Business logic, complex request transformation.

## Runtime boundaries

- Runtime code roots:
- Test roots:
- Scripts / tooling roots:
- Packaging / deploy roots: ops/, packaging/, mobile/, ai/
- Infrastructure roots:
- Agent-system root: `_system/`
- No-touch zones:

## Stack

- Primary languages: Go (Traefik)
- Primary frameworks: Traefik
- Components: Traefik Proxy
- Datastores:
- Package managers:
- Build tools: Docker
- Runtime environments: Traefik Binary
- Supported environments: Linux, Docker
- Deployment targets: Cloud / Edge

## Build and packaging

- Packaging targets: Docker Image
- Native package targets:
- Universal package targets:
- Packaging manifest paths: packaging/appimage.yml, packaging/flatpak-manifest.json, packaging/snapcraft.yaml
- Installer commands: ops/install/install.sh, ops/install/repair.sh, ops/install/uninstall.sh, ops/install/purge.sh
- Signing identity: Release owner placeholder; replace before shipping signed artifacts
- Minimum runtime versions: Traefik 3.0+
- System dependencies:
- Build entrypoints: docker-compose.yml labels
- Release artifacts: docker-image

## Validation commands

- Format:
- Lint:
- Typecheck:
- Unit tests:
- Integration tests:
- End-to-end or smoke:
- Build:
- Install / launch verification:
- Packaging verification:
- Visual regression or design smoke:
- Security or policy checks: bootstrap/scan-security.sh /home/whyte/.MyAppZ/LuxeLogic/api-gateway

## Mobile and AI

- Mobile targets:
- Android module path: mobile/flutter/
- Mobile release artifacts:
- Mobile build flavors:
- LLM config path: ai/llm_config.yaml
- Default LLM provider:
- Chatbot surfaces:
- Command bus or action registry:
- Local documentation sources:

## Operations and deployment

- Default ports: 80, 443, 8080 (Dashboard)
- Default port range:
- Bind model: 0.0.0.0
- Required background services: Docker Socket (for discovery)
- Service model: Gateway
- Migration model:
- Database mode:
- Container runtime preference: Docker
- Service account model:
- Required env vars:
- Optional providers:
- Known degraded modes:
- Backup location:
- Filesystem layout:
- Environment files:
- Reverse proxy or ingress: Traefik

## Security and compliance

- Safety / compliance:
- Security: Automatic HTTPS (Let's Encrypt), Header hardening
- Secret handling: Docker Secrets / Environment variables
- Data classification: Metadata (Traffic)
- Audit or retention requirements: Access logs
- Threat model doc:

## Observability

- Structured logging surface: JSON Access Logs
- Metrics surface: Traefik Metrics (Prometheus)
- Health or readiness surface: /ping
- Tracing or profiling surface:
- Alerting or dashboards: Traefik Dashboard

## Constraints

- Performance: Ultra-low latency
- UI / design: N/A
- Accessibility expectations:
- Data integrity:
- Release / packaging: Standard Docker
- Repo workflow: AIAST
- Compatibility requirements: HTTP/3 support

## MCP plan

- Project-scoped servers:
- User-level shared servers:
- Read-only defaults:
- Elevation rules:
- Servers to avoid:

## Canonical docs

- Product spec: PRODUCT_BRIEF.md
- Architecture: ARCHITECTURE_NOTES.md
- Data model:
- Runbook:
- Standards:
- Threat model:
- Additional design docs:

## Experience targets

- Visual quality bar:
- Interaction quality bar:
- Performance quality bar: High availability (99.99%)
- Accessibility expectations:
- Device targets:
- Brand or tone constraints:

## Release model

- Environments: dev, prod
- Branch strategy: main
- Rollout method: Rolling
- Backout method: Rollback docker image
- Release signoff:
- Post-release verification:

## High-value conventions

- Naming conventions:
- Module boundary rules:
- Logging rules:
- Testing rules:
- Handoff expectations:
- Documentation update expectations:
