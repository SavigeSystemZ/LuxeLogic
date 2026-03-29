# Skill: Generate MCP Config Stubs

## Inputs
- Idea metadata (tools/integrations needed)
- Target MCP client/host (Claude Code, Copilot, Cursor, etc.)

## Steps
1) Choose only the minimal MCP servers needed for the idea (principle of least privilege).
2) Prefer read-only endpoints and scoped filesystem access.
3) Emit a config stub in the host’s expected schema.
4) Include a README with security notes and how to test connectivity.

## Outputs
- mcp/servers.<idea>.json (or host-specific format)
- mcp/README.md updated with intent and safety notes
