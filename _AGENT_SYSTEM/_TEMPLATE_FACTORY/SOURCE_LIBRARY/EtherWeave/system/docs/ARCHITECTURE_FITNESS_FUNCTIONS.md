# Architecture Fitness Functions

Planned automated checks (Phase 2):

1) No GUI imports in application/core/lib layers.
2) No direct subprocess calls in GUI (except adapters or process runner wrapper).
3) Worker threads must not mutate UI directly.
4) AppEvent schema changes require docs/tests update.

Implementation target: lightweight AST checker.

## Runner

```bash
python tools/fitness_check.py
```

## AppEvent schema contract

If `etherweave/domain/contracts.py` changes the AppEvent fields, update:\n`docs/APP_EVENT_SCHEMA.json` to keep the schema aligned.
