# MCP Server Catalog Template (vNext)

Fields
- name, purpose
- command/args
- env schema (no secret values)
- scopes supported
- baseline scopes (read/discovery)
- elevation scopes (when/why)
- risk rating (low/med/high)
- audit requirements

Defaults
- No wildcard scopes.
- Baseline is read-only.
- Elevation requires explicit intent and is logged with correlation ID.
