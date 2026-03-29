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

- App name: cache
- App id: io.aiaast.cache
- Desktop entry id: io.aiaast.cache
- Android application id: io.aiaast.cache
- Repo purpose:
- Product category:
- Primary users:
- Main workflows:
- Primary success criteria:
- Non-goals:

## Runtime boundaries

- Runtime code roots:
- Test roots:
- Scripts / tooling roots:
- Packaging / deploy roots: ops/, packaging/, mobile/, ai/
- Infrastructure roots:
- Agent-system root: `_system/`
- No-touch zones:

## Stack

- Primary languages:
- Primary frameworks:
- Components:
- Datastores:
- Package managers:
- Build tools:
- Runtime environments:
- Supported environments:
- Deployment targets:

## Build and packaging

- Packaging targets:
- Native package targets:
- Universal package targets:
- Packaging manifest paths: packaging/appimage.yml, packaging/flatpak-manifest.json, packaging/snapcraft.yaml
- Installer commands: ops/install/install.sh, ops/install/repair.sh, ops/install/uninstall.sh, ops/install/purge.sh
- Signing identity: Release owner placeholder; replace before shipping signed artifacts
- Minimum runtime versions:
- System dependencies:
- Build entrypoints:
- Release artifacts:

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
- Security or policy checks: bootstrap/scan-security.sh /home/whyte/.MyAppZ/LuxeLogic/cache

## Mobile and AI

- Mobile targets:
- Android module path: mobile/flutter/
- Mobile release artifacts:
- Mobile build flavors:
- LLM config path: ai/llm_config.yaml
- Default LLM provider:
- Chatbot surfaces: CLI REPL, REST endpoint, GUI side panel when a UI exists
- Command bus or action registry:
- Local documentation sources:

## Operations and deployment

- Default ports:
- Default port range:
- Bind model:
- Required background services:
- Service model:
- Migration model:
- Database mode:
- Container runtime preference:
- Service account model:
- Required env vars:
- Optional providers:
- Known degraded modes:
- Backup location:
- Filesystem layout:
- Environment files:
- Reverse proxy or ingress:

## Security and compliance

- Safety / compliance:
- Security:
- Secret handling:
- Data classification:
- Audit or retention requirements:
- Threat model doc:

## Observability

- Structured logging surface:
- Metrics surface:
- Health or readiness surface:
- Tracing or profiling surface:
- Alerting or dashboards:

## Constraints

- Performance:
- UI / design:
- Accessibility expectations:
- Data integrity:
- Release / packaging:
- Repo workflow:
- Compatibility requirements:

## MCP plan

- Project-scoped servers:
- User-level shared servers:
- Read-only defaults:
- Elevation rules:
- Servers to avoid:

## Canonical docs

- Product spec:
- Architecture:
- Data model:
- Runbook:
- Standards:
- Threat model:
- Additional design docs:

## Experience targets

- Visual quality bar:
- Interaction quality bar:
- Performance quality bar:
- Accessibility expectations:
- Device targets:
- Brand or tone constraints:

## Release model

- Environments:
- Branch strategy: main for runtime code, system for copied AIAST updates, optional short-lived feature branches
- Rollout method:
- Backout method:
- Release signoff:
- Post-release verification:

## High-value conventions

- Naming conventions:
- Module boundary rules:
- Logging rules:
- Testing rules:
- Handoff expectations:
- Documentation update expectations:
