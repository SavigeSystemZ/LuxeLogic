# Copilot Instructions (Etherweave)

Before coding, load the repo context from `docs/AI_CONTEXT_INDEX.md` and follow the
listed load order. This project is a defensive, authorized wireless assessment
platform; do not add automated exploitation, credential attacks, or traffic
disruption. Respect engagement scope and privileged ops gating.

Key rules:
- GUI must remain non-blocking; use QThread + signals for long tasks.
- No `place()`; use Qt layouts and CyberFrame/ScrolledFrame patterns.
- CoreController is the single GUI/CLI entry point.
- Validate inputs with ValidationLayer and log errors with ErrorOracle.
- Keep feature parity between GUI and CLI.

Subagent system:
- Protocol: docs/SUBAGENT_PROTOCOL.md
- Registry: docs/SUBAGENT_REGISTRY.md
- Supervisor: tools/subagent_supervisor.py
