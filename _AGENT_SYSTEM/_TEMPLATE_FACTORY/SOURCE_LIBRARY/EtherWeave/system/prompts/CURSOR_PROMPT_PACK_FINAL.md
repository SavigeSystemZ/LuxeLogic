# Etherweave-Nexus Cursor Prompt Pack (Final)

## Current Architecture State
- Domain contracts and error taxonomy in `etherweave/domain/`.
- Ports in `etherweave/ports/`.
- Event bus in `etherweave/core/event_bus.py`.
- TaskRunner for QThread lifecycle in `etherweave/gui/task_runner.py`.
- Scan Networks vertical slice wired: GUI → CoreController → use-case → adapters.
- Tab controllers extracted for System, Recon, Capture, Interface Management.

## Glossary (Canonical)
- Domain: pure types/invariants only.
- Application/Use-cases: orchestration depends on Domain + Ports only.
- Ports: interface definitions (ToolRunnerPort, RadioPort, PersistencePort, TelemetryPort, AuthPort, ClockPort, FileSystemPort).
- Adapters: concrete implementations (Qt, SQLite, subprocess wrapper, RadioManager adapter).
- OperationRequest/Result: typed request/response.
- AppEvent: typed event packet.
- Event Bus: in-process pub/sub.
- TaskRunner: QThread lifecycle manager emitting AppEvents.
- Fitness Functions: automated boundary checks.
- Acceptance Gate: deterministic checks to advance phases.

## Bodymap (Summary)
- Brain: Domain (`etherweave/domain/`).
- Nervous System: Event bus (`etherweave/core/event_bus.py`).
- Motor Control: TaskRunner (`etherweave/gui/task_runner.py`).
- Senses: Ports (`etherweave/ports/`).
- Limbs: Adapters (`etherweave/adapters/`).
- Immune System: ValidationLayer + ErrorOracle (`etherweave/lib/validation_layer.py`, `etherweave/lib/error_oracle.py`).

## Boundaries
- GUI depends on adapters only.
- Application depends on Domain + Ports only.
- Domain depends on nothing.
- GUI must not call subprocess directly (migrate to adapters).

## Fitness Functions
Run: `python tools/fitness_check.py`
- Fails on GUI subprocess usage.
- Fails if AppEvent schema drifts from `docs/APP_EVENT_SCHEMA.json`.

## Test Strategy
- L1: Domain contract tests.
- L2: Use-case tests with fake ports.
- L3: Adapter contract tests (SQLite temp DB).
- L5: Optional pytest-qt GUI signal smoke test.

## Review Checklist
- Verify GUI actions route through CoreController/use-cases.
- Confirm no UI thread blocking (QThread for long ops).
- Check 10-Button Rule per tab.
- Ensure no direct subprocess calls in GUI.
- Validate AppEvent schema update when contracts change.

## Codex ↔ Cursor Parity
- Keep AGENTS.md and .cursor/rules aligned.
- Workflow contract: Questions (only as many as needed) → Prereqs → one or two tightly-related steps when safe.
- Auto-execute safe in-repo prereqs when possible; log actions.
- Context index: `docs/AI_CONTEXT_INDEX.md` (load this first on reset).
- Safety gates: Engagement Scope, explicit confirmation for sensitive actions.
- Checkpoint discipline: WORKLOG + backups + git bundle + hashes + GitHub sync.
- Per-session logs under logs/codex and logs/cursor.
- Canonical backlog: WIRELESS_PLATFORM_WORLDCLASS_ENHANCEMENTS.md + ROADMAP.md.
- Model preference: GPT-5.2-Codex with reasoning "high" (or the most advanced high-reasoning model available); switch via `/model` if needed.
- If context appears reset, incomplete, or timed out, notify the operator and request a full reload before proceeding.
- Command set: "load master architectural systems now!" triggers the full load order; log actions and confirm readiness. If the load risks context overflow, split into step parts and continue on request.
- Context safety: if the context window is at risk, stop before overflow, state the cutoff, and request continuation with the next step part.

## Subagent System
- Protocol: `docs/SUBAGENT_PROTOCOL.md`
- Registry: `docs/SUBAGENT_REGISTRY.md`
- Session state: `docs/SESSION_STATE.md`
- Supervisor: `tools/subagent_supervisor.py` (Ollama CLI; manual fallback supported)
- Artifacts: `contexts/subagents/<run_id>/<agent>/input.md` and `output.md`
- Default model order: `deepseek-coder:33b`, `codellama:34b-instruct`, `codellama:34b`, `codellama:13b-instruct`

## Remaining High-Value Work
1) Move remaining GUI subprocess usage into adapters/use-cases (system info, network manager actions, tool checks).
2) Extract remaining tabs into controllers (Attack, Cracking, Defense, Postex, Reporting, etc.).
3) Add telemetry adapter and structured AppEvent logging.
4) Expand tests to cover new adapters and task cancellation paths.

## Acceptance Gates
- `python tools/fitness_check.py`
- `python -m pytest -q`

## Safety Boundary
Only authorized, defensive diagnostics and assessment flows. No automation for exploitation or credential attacks.
