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

- App name: LuxeLogic Video Engine
- App id: io.luxelogic.video.engine
- Desktop entry id: io.luxelogic.video.engine
- Android application id: io.luxelogic.video.engine
- Repo purpose: Specialized service for high-definition makeup tutorial transcoding and 3D/AR render generation.
- Product category: Video Processing / AR Renders
- Primary users: Backend microservices (core-service)
- Main workflows: Tutorial HLS transcoding, thumbnail extraction, and high-fidelity 4K beauty render generation.
- Primary success criteria: Flawless 4K renders, fast transcoding, and accurate AR texture application.
- Non-goals: General purpose video editing, user-facing video player.

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
- Primary frameworks: Celery, PyFFmpeg, Blender (for high-res renders)
- Components: Celery Worker, FFmpeg, ImageMagick
- Datastores: Shared media storage, DragonflyDB (Task Queue)
- Package managers: pip
- Build tools: Docker
- Runtime environments: Python
- Supported environments: Linux, Docker
- Deployment targets: GPU-accelerated host (preferred)

## Build and packaging

- Packaging targets: Docker Image
- Native package targets:
- Universal package targets:
- Packaging manifest paths: packaging/appimage.yml, packaging/flatpak-manifest.json, packaging/snapcraft.yaml
- Installer commands: ops/install/install.sh, ops/install/repair.sh, ops/install/uninstall.sh, ops/install/purge.sh
- Signing identity: Release owner placeholder; replace before shipping signed artifacts
- Minimum runtime versions: Python 3.10
- System dependencies: ffmpeg, imagemagick, libopenimageio-dev
- Build entrypoints: src/worker.py
- Release artifacts: docker-image

## Validation commands

- Format: black .
- Lint: flake8 .
- Typecheck: mypy .
- Unit tests: pytest tests/
- Integration tests: pytest tests/integration/
- End-to-end or smoke:
- Build: docker build -t luxelogic-video-engine .
- Install / launch verification:
- Packaging verification:
- Visual regression or design smoke:
- Security or policy checks: bootstrap/scan-security.sh /home/whyte/.MyAppZ/LuxeLogic/video-engine

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

- Default ports:
- Default port range:
- Bind model:
- Required background services: DragonflyDB (Task Queue), Shared Media Volume
- Service model: Worker service
- Migration model:
- Database mode:
- Container runtime preference: Docker
- Service account model:
- Required env vars: REDIS_URL, MEDIA_STORAGE_PATH
- Optional providers:
- Known degraded modes:
- Backup location:
- Filesystem layout:
- Environment files: .env
- Reverse proxy or ingress:

## Security and compliance

- Safety / compliance:
- Security: Internal Docker network communication
- Secret handling: Environment variables
- Data classification: Proprietary (Tutorials)
- Audit or retention requirements:
- Threat model doc:

## Observability

- Structured logging surface: JSON logging to stdout
- Metrics surface:
- Health or readiness surface: Celery worker health
- Tracing or profiling surface:
- Alerting or dashboards:

## Constraints

- Performance: High-throughput video processing
- UI / design: N/A (Backend service)
- Accessibility expectations:
- Data integrity: High (Video assets must be valid)
- Release / packaging: Standard Docker
- Repo workflow: AIAST
- Compatibility requirements: FFmpeg 6.0+

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

- Visual quality bar: Extremely High (4K, professional color grading, realistic makeup rendering)
- Interaction quality bar:
- Performance quality bar: Hardware accelerated transcoding
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
