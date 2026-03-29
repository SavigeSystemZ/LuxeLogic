# Multi-Agent and MCP

Multi-agent systems stay coherent by assigning one shared source of truth and by documenting optional tool layers separately from core contracts.

## Pattern

- shared startup contract for all agents
- optional MCP or tool overlays loaded only when needed
- explicit ownership and handoff expectations between agents

## Adapt Locally

- declare which agent families are first-class
- avoid inventing hidden MCP dependencies
