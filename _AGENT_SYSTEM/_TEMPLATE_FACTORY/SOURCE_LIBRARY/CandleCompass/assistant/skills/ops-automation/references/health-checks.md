# Health Checks

## UI Artifact Check
- `python scripts/ui_health_check.py --runs runs/latest`
- `python scripts/ui_health_check.py --runs runs/latest --strict`
- `./scripts/ui_status.sh`
- `./scripts/memory_status.sh`

## Data Health
- `python scripts/data_health_check.py --config asset_universe.yaml --cache-only`
