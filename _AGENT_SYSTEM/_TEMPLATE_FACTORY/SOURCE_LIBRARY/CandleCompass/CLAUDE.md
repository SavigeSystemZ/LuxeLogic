# Candle Compass - Claude Code Configuration

## First Steps (Always)
1. Read `assistant/AGENTS_AND_SYSTEM.md` (multi-agent handoff protocol)
2. Read `WHERE_WE_LEFT_OFF.md` (last session state)
3. Read `assistant/TODO.md` (priorities, next steps, phases)
4. Read `assistant/FIXME.md` (known gaps)
5. Read `assistant/MASTER_SYSTEM_PROMPT.md` (operating contract)

## Project Structure
- **Frontend**: `app/ui-next/` (Next.js 14, App Router, Tailwind, Framer Motion, Lightweight Charts)
- **Backend**: `app/src/` (Python 3.12, FastAPI, async services)
- **Scripts**: `app/scripts/` (maintenance, launch, install, hydration)
- **System/AI**: `assistant/` (prompts, rules, skills, context docs - NOT executed by app)
- **Config**: `app/config.yaml`, `app/asset_universe.yaml`
- **Artifacts**: `app/runs/latest/*.json` (runtime data contract for UI/API consumers)
- **Database**: SQLite default, optional PostgreSQL (`app/candle_compass.db` or `candlecompass_prod`)

## Key Conventions
- Runtime code lives in `app/` only; design/AI system files in `assistant/` only
- Never make runtime behavior depend on `assistant/` files
- Treat `runs/latest/*` as contract artifacts for UI/API consumers
- Default to research/paper-trading; no live execution without explicit user intent
- Never commit secrets; use `.env` and encrypted storage
- Never use blocking browser dialogs (`window.alert/confirm/prompt`); use React modals
- Python uses type hints + pydantic for contracts; TypeScript stays strict
- Maintain one backup copy only; remove older backups when creating new ones

## Validation Commands
```bash
# Backend tests
.venv/bin/python -m pytest -q

# Frontend lint
cd app/ui-next && npx eslint .

# Frontend tests
cd app/ui-next && npx vitest run

# Frontend build
cd app/ui-next && npx next build

# E2E smoke
.venv/bin/python app/scripts/e2e_smoke.py --runs app/runs/latest --out app/runs/latest/e2e_smoke.json --strict

# UI artifact smoke
.venv/bin/python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict
```

## Handoff Protocol
Before ending a session:
1. Update `WHERE_WE_LEFT_OFF.md` with what was done, validation results, and any blockers
2. Update `assistant/TODO.md` marking completed items and adding new steps
3. If system files changed, update `assistant/FULL_CONTEXT_INDEX.md`

## Architecture Highlights
- **Visual**: Cyber-Futurist Glassmorphism (deep-space `#0a0b1e`, neon accents, frosted glass)
- **Dashboard**: Modular widget grid with drag/resize, `DashboardManager` + `WidgetWrapper`
- **Data Pipeline**: WebSocket broadcaster (`/ws/market_data`), SWR hooks, Redis pub/sub
- **AI/Cortex**: Agentic co-pilot with tool registry, floating chat UI
- **Themes**: JSON-based Chameleon engine + ThemeEditor + runtime CSS variables
- **Risk**: RiskGuardian gate, position sizing, circuit breakers, exposure caps
- **Auth**: Runtime role policy (viewer/operator/admin/owner), control key enforcement

## Ports
- UI: `3967` (default), fallback `3100`
- Backend: `8010`
- Memory MCP: `8766`
- Redis: `6379`
