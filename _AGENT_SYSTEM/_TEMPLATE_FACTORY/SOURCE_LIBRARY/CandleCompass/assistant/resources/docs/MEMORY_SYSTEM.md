# Local Memory System (Candle Compass)

This project uses a local, file-backed memory store to replace external MCP memory services.
It provides add/search/list/delete operations via a CLI tool.

## Store Location
- Default: `data/memory/memories.jsonl`
- Override: `CANDLE_COMPASS_MEMORY_PATH=/path/to/memories.jsonl`

## Ingest Config
- Default: `assistant/memory_ingest.yaml`
- Override: `CANDLE_COMPASS_MEMORY_CONFIG=/path/to/assistant/memory_ingest.yaml`

## Optional Auth (HTTP Server)
- Store `CANDLE_COMPASS_MEMORY_TOKEN` in the secrets store and send `Authorization: Bearer <token>` or `X-Memory-Token: <token>`.
- Managed lifecycle scripts: `./scripts/launch_memory_server.sh`, `./scripts/memory_status.sh`, `./scripts/stop_memory_server.sh`.

## CLI Tool
All operations are available via:
```bash
python scripts/memory_tool.py <command> [options]
```

### Ingest (load project context)
```bash
python scripts/memory_tool.py ingest --replace
```
- Scans prompts, context, rules, skills, commands, docs, and core code.

### Search
```bash
python scripts/memory_tool.py search --query "vectorized backtest"
```

### Add
```bash
python scripts/memory_tool.py add \
  --title "[Component] - Backtest Engine" \
  --content "Location: src/backtest/vectorized.py; Purpose: vectorized backtest" \
  --type component \
  --scope project
```

### List
```bash
python scripts/memory_tool.py list --limit 20
```

### Delete
```bash
python scripts/memory_tool.py delete --id <memory_id> --yes
```

## Safety
- The tool redacts obvious secrets during ingest.
- Do not store API keys, tokens, passwords, or secrets.

## Scopes
- `project`: project facts, components, implementations, debug
- `user_project`: preferences for Candle Compass only
- `user_global`: preferences across projects

## Notes
- This is local-only and does not touch Cursor/Etherweave.
- HTTP wrapper: see `assistant/resources/docs/MEMORY_SERVER.md`.
