# Local Memory HTTP Server (Candle Compass)

A lightweight HTTP JSON wrapper for the local memory store.

## Run
```bash
python scripts/memory_server.py --host 127.0.0.1 --port 8766
./scripts/launch_memory_server.sh ~/candle_compass
./scripts/memory_status.sh ~/candle_compass
./scripts/stop_memory_server.sh ~/candle_compass
```

## Optional Auth
Store `CANDLE_COMPASS_MEMORY_TOKEN` in the secrets store and include a token header:
```
Authorization: Bearer <token>
```
or
```
X-Memory-Token: <token>
```

## Health
```
GET /health
```

## Tool List
```
GET /tools
```

## MCP-Style Calls
```
POST /mcp
{
  "tool": "search_memory",
  "params": {
    "query": "vectorized backtest",
    "limit": 5
  }
}
```

## Add
```
POST /add
{
  "title": "[Component] - Backtest Engine",
  "content": "Location: src/backtest/vectorized.py; Purpose: vectorized backtest",
  "memory_types": ["component"],
  "scope": "project",
  "project_id": "whyte/Candle Compass"
}
```

## Search
```
POST /search
{
  "query": "vectorized backtest",
  "limit": 10
}
```

## List
```
POST /list
{
  "limit": 20
}
```

## Delete (requires confirm)
```
POST /delete
{
  "ids": ["<id>"],
  "confirm": true
}
```

## Ingest
```
POST /ingest
{
  "replace": true,
  "config_path": "assistant/memory_ingest.yaml"
}
```

## Notes
- This is local-only and does not touch Cursor/Etherweave.
- Use `path` to point at a different memory file.
