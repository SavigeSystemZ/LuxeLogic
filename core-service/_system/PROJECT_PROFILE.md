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

- App name: LuxeLogic Core Service
- App id: io.luxelogic.core.service
- Desktop entry id: io.luxelogic.core.service
- Android application id: io.luxelogic.core.service
- Repo purpose: Central business logic and beauty knowledge base for the LuxeLogic makeup app.
- Product category: Beauty & Lifestyle / Educational
- Primary users: Women and beauty enthusiasts seeking professional-grade makeup techniques.
- Main workflows: User profile management, beauty tutorial discovery, personalized maintenance plans, and AI-driven beauty advice.
- Primary success criteria: Fast discovery of techniques, accurate AI advice, and high-fidelity tutorial streaming support.
- Non-goals: General social media features, non-beauty tutorials.

## Runtime boundaries

- Runtime code roots: src/
- Test roots: tests/
- Scripts / tooling roots:
- Packaging / deploy roots: ops/, packaging/, mobile/, ai/
- Infrastructure roots:
- Agent-system root: `_system/`
- No-touch zones:

## Stack

- Primary languages: Python 3.12+
- Primary frameworks: FastAPI, SQLAlchemy, Pydantic
- Components: REST API, Celery Worker, PostgreSQL, DragonflyDB (Redis-compatible)
- Datastores: PostgreSQL (User data, Tutorial metadata), DragonflyDB (Cache, Task Queue)
- Package managers: pip
- Build tools: Docker
- Runtime environments: Python
- Supported environments: Linux, Docker
- Deployment targets: Cloud / Linux Host

## Build and packaging

- Packaging targets: Docker Image
- Native package targets:
- Universal package targets:
- Packaging manifest paths: packaging/appimage.yml, packaging/flatpak-manifest.json, packaging/snapcraft.yaml
- Installer commands: ops/install/install.sh, ops/install/repair.sh, ops/install/uninstall.sh, ops/install/purge.sh
- Signing identity: Release owner placeholder; replace before shipping signed artifacts
- Minimum runtime versions: Python 3.10
- System dependencies: libpq-dev, ffmpeg
- Build entrypoints: src/main.py
- Release artifacts: docker-image

## Validation commands

- Format: black .
- Lint: flake8 .
- Typecheck: mypy .
- Unit tests: pytest tests/
- Integration tests: pytest tests/integration/
- End-to-end or smoke:
- Build: docker build -t luxelogic-core-service .
- Install / launch verification:
- Packaging verification:
- Visual regression or design smoke:
- Security or policy checks: bootstrap/scan-security.sh /home/whyte/.MyAppZ/LuxeLogic/core-service

## Mobile and AI

- Mobile targets: Android, iOS (via future beauty-frontend)
- Android module path: mobile/flutter/
- Mobile release artifacts:
- Mobile build flavors:
- LLM config path: ai/llm_config.yaml
- Default LLM provider: Gemini
- Chatbot surfaces: Voice REPL, REST endpoint
- Command bus or action registry:
- Local documentation sources:

## Operations and deployment

- Default ports: 8000
- Default port range: 382xx-383xx (refer to ~/.MyAppZ/PORTS_REGISTRY.md)
- Bind model: 0.0.0.0 (inside container)
- Required background services: PostgreSQL, DragonflyDB
- Service model: Microservice
- Migration model: Alembic
- Database mode: Persistent
- Container runtime preference: Docker
- Service account model:
- Required env vars: DATABASE_URL, REDIS_URL
- Optional providers:
- Known degraded modes: Read-only if DB is down
- Backup location:
- Filesystem layout:
- Environment files: .env
- Reverse proxy or ingress: Traefik (api-gateway)

## Security and compliance

- Safety / compliance: GDPR (User data)
- Security: OAuth2 with JWT
- Secret handling: Environment variables
- Data classification: Personal
- Audit or retention requirements:
- Threat model doc:

## Observability

- Structured logging surface: JSON logging to stdout
- Metrics surface: Prometheus metrics
- Health or readiness surface: /health
- Tracing or profiling surface:
- Alerting or dashboards:

## Constraints

- Performance: Sub-second API responses
- UI / design: Deep Glass aesthetic (for frontend)
- Accessibility expectations: High (female-centric accessibility)
- Data integrity: High (Beauty routines are personalized)
- Release / packaging: Standard Docker
- Repo workflow: AIAST
- Compatibility requirements:

## MCP plan

- Project-scoped servers:
- User-level shared servers:
- Read-only defaults:
- Elevation rules:
- Servers to avoid:

## Canonical docs

- Product spec: PRODUCT_BRIEF.md
- Architecture: ARCHITECTURE_NOTES.md
- Data model: src/models.py
- Runbook:
- Standards:
- Threat model:
- Additional design docs:

## Experience targets

- Visual quality bar: High (Deep Glass aesthetic, frosted effects, soft shadows)
- Interaction quality bar: Fluid (Sub-100ms transitions)
- Performance quality bar: High-res video support
- Accessibility expectations: WCAG 2.1 AA
- Device targets: Modern smartphones
- Brand or tone constraints: Female-oriented, elegant, professional, helpful

## Release model

- Environments: dev, prod
- Branch strategy: main
- Rollout method: Blue-green
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
