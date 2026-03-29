# Architecture Boundaries

## Dependency Rule
- GUI depends on adapters only.
- Application layer depends on Domain + Ports only.
- Domain depends on nothing.

## Allowed Imports
- Domain: standard library only.
- Application: Domain + Ports.
- Adapters: Domain + Ports + external dependencies.
- GUI: Adapters + Qt.

## Safety Constraints
- No automated exploitation or credential attacks.
- Active testing is allowed only for authorized, defensive diagnostics.
- Privileged operations must be gated by AuthPort + sudo cache.

## Current Violations (to address in phases)
- Core controllers mix tool execution and orchestration without ports.
