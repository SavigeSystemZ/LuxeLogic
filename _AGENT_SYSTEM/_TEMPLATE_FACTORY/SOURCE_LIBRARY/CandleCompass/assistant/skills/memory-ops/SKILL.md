---
name: memory-ops
description: Operate and maintain the Candle Compass local memory system (CLI + HTTP server). Use when ingest/search/add/list/delete flows change, memory safety rules are updated, or memory tooling/docs need alignment.
---

# Memory Ops

## Workflow
1. Choose interface: CLI (`scripts/memory_tool.py`) or HTTP server (`scripts/memory_server.py`).
2. Use `ingest` to refresh memory from project context when needed.
3. Use `search` before major implementation work to recover prior decisions/preferences.
4. Use `add` only for durable facts, decisions, and stable preferences.
5. Never store secrets; follow memory safety rules.
6. Keep docs aligned: `assistant/MEMORY_GUIDE.md`, `assistant/rules/MEMORY_RULES.md`, and memory system docs.

## Validation
- `python scripts/memory_tool.py list --limit 5`
- `python scripts/memory_tool.py search --query "ui bundle"`
- `python scripts/memory_server.py --host 127.0.0.1 --port 8766`

## Output Checklist
- Memory flows are documented and reproducible.
- Safety rules are explicit and enforced by workflow.
- MCP-related metadata remains accurate when server details change.

## References
- `references/memory-commands.md`
- `references/memory-safety.md`
