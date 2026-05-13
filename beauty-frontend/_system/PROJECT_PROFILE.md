# Project Profile

## Identity

- App name: LuxeLogic Beauty Frontend
- App id: io.luxelogic.beauty.frontend
- Desktop entry id: io.luxelogic.beauty.frontend
- Android application id: io.luxelogic.beauty.frontend
- Repo purpose: High-fidelity, female-oriented user interface for LuxeLogic, featuring real-time 3D makeup and jewelry try-ons.
- Product category: Frontend / AR UI
- Primary users: Women, beauty enthusiasts, makeup artists.
- Main workflows: Real-time makeup preview, 3D model manipulation, voice-activated beauty assistance, jewelry try-on.
- Primary success criteria: Visually stunning "Deep Glass" aesthetic, smooth 3D performance (60fps), accurate AR mapping.
- Non-goals: General purpose video editing, non-beauty tutorials.

## Runtime boundaries

- Runtime code roots: src/
- Test roots: tests/
- Scripts / tooling roots:
- Packaging / deploy roots: ops/, packaging/, mobile/
- Infrastructure roots:
- Agent-system root: `_system/`
- No-touch zones:

## Stack

- Primary languages: TypeScript
- Primary frameworks: Next.js 14, React 18
- Components: Three.js, @react-three/fiber, @react-three/drei, MediaPipe Face Mesh, Tailwind CSS
- Datastores: Browser LocalStorage (Session)
- Package managers: npm
- Build tools: Next.js (Webpack/Turbopack)
- Runtime environments: Node.js (SSR), Web Browser (Client)
- Supported environments: Modern Browsers (Chrome, Safari, Firefox)
- Deployment targets: Vercel, Docker

## Build and packaging

- Packaging targets: Docker Image, Static Assets
- Native package targets:
- Universal package targets:
- Packaging manifest paths:
- Installer commands:
- Signing identity:
- Minimum runtime versions: Node.js 18.x
- System dependencies:
- Build entrypoints: src/app/page.tsx
- Release artifacts: build-bundle

## Validation commands

- Format: npx prettier --write .
- Lint: npm run lint
- Typecheck: npm run typecheck
- Unit tests:
- Integration tests:
- End-to-end or smoke:
- Build: npm run build
- Install / launch verification:
- Packaging verification:
- Visual regression or design smoke:
- Security or policy checks:

## Mobile and AI

- Mobile targets: Mobile Browsers, PWA
- Android module path:
- Mobile release artifacts:
- Mobile build flavors:
- LLM config path:
- Default LLM provider: Gemini (via core-service)
- Chatbot surfaces: Voice/Text UI in-app
- Command bus or action registry:
- Local documentation sources:

## Operations and deployment

- Default ports: 3000
- Default port range:
- Bind model: 0.0.0.0
- Required background services: core-service
- Service model: Frontend
- Migration model:
- Database mode:
- Container runtime preference: Docker
- Service account model:
- Required env vars: NEXT_PUBLIC_API_URL
- Optional providers:
- Known degraded modes: No 3D if WebGL is disabled
- Backup location:
- Filesystem layout:
- Environment files: .env.local
- Reverse proxy or ingress: Traefik

## Security and compliance

- Safety / compliance: GDPR
- Security: Content Security Policy (CSP), SSL/TLS
- Secret handling: Environment variables
- Data classification: Public / Non-sensitive
- Audit or retention requirements:
- Threat model doc:

## Observability

- Structured logging surface: Browser Console, Sentry
- Metrics surface: Vercel Analytics / Core Web Vitals
- Health or readiness surface:
- Tracing or profiling surface:
- Alerting or dashboards:

## Constraints

- Performance: Sub-2s LCP, 60fps 3D
- UI / design: Deep Glass aesthetic (Frosted glass, pastel gradients, soft shadows)
- Accessibility expectations: WCAG 2.1 AA
- Data integrity:
- Release / packaging:
- Repo workflow: AIAST
- Compatibility requirements: WebGL 2.0

## Experience targets

- Visual quality bar: Extremely High (Deep Glass, elegant typography, fluid animations)
- Interaction quality bar: High (Sub-100ms response to touch/drag)
- Performance quality bar: Hardware-accelerated 3D
- Accessibility expectations: High
- Device targets: High-end smartphones and tablets
- Brand or tone constraints: Elegant, professional, empowering, helpful

## Release model

- Environments: dev, prod
- Branch strategy: main
- Rollout method: Vercel Deployments
- Backout method: Git Revert
- Release signoff:
- Post-release verification:
