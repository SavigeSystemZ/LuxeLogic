# Memory Commands

## CLI
- `python scripts/memory_tool.py ingest --replace`
- `python scripts/memory_tool.py search --query "vectorized backtest"`
- `python scripts/memory_tool.py add --title "Fix: X" --content "Issue/diagnosis/solution" --type debug --scope project`
- `python scripts/memory_tool.py list --limit 20`
- `python scripts/memory_tool.py delete --id <memory_id> --yes`

## HTTP Server
- `python scripts/memory_server.py --host 127.0.0.1 --port 8766`
- `./scripts/launch_memory_server.sh ~/candle_compass`
- `./scripts/memory_status.sh ~/candle_compass`
- `./scripts/stop_memory_server.sh ~/candle_compass`
- `GET /health`
- `GET /tools`
- `POST /search` with `{ "query": "...", "limit": 10 }`

## Auth
- Set `CANDLE_COMPASS_MEMORY_TOKEN` and pass `Authorization: Bearer <token>`
