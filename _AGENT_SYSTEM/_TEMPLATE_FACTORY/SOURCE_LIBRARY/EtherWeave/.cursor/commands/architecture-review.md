# Architecture Review

Review the current or specified code for Clean Architecture and boundary compliance.

**Do this now:**
1. Identify the code in scope (current file, selection, or user-specified path).
2. Check **dependency rule**: Domain (stdlib only) → Application (Domain + Ports) → Adapters (Domain + Ports + external) → GUI (Adapters + Qt only). No GUI imports in core/application/lib; no direct subprocess in GUI except adapters; worker threads must not mutate UI directly.
3. Check **CoreController** as single GUI/CLI entry; **ports/adapters** usage; **AppEvent/OperationRequest/Result** for cross-subsystem communication where applicable.
4. Report violations with file:line. Suggest moving code to the correct layer or introducing a port/adapter.
5. Recommend running `python tools/fitness_check.py` if available.

Reference: `docs/ARCHITECTURE_BOUNDARIES.md`, `docs/ARCHITECTURE_FITNESS_FUNCTIONS.md`, **etherweave-architecture** subagent.
