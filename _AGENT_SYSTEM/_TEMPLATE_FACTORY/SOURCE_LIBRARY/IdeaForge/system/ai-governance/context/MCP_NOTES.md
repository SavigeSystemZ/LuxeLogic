# MCP Notes (Model Context Protocol)

IdeaForge outputs MCP config stubs to help external agents/IDEs connect to tool servers relevant to a specific idea.

Security defaults:
- Treat MCP servers as untrusted by default.
- Maintain an allow-list of servers per idea/workspace.
- Prefer read-only tools for discovery over mutation tools.
- Keep filesystem access scoped to a single folder and read-only unless explicitly needed.
