# Contributing

## Goals
- Reproducibility
- Clear diagnostics
- Safe research workflows

## Standards
- Update `assistant/context/WHERE_WE_LEFT_OFF.md` and `assistant/context/CHANGELOG.md` after major changes.
- Keep context files fresh by running `scripts/update_project_context.py` before commits.
- Add tests for new core logic.
- Prefer vectorized operations.
- Do not add live trading execution without explicit user request.

## Local Setup
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
./scripts/install_git_hooks.sh
scripts/update_project_context.py
pytest -q
```

## Context Enforcement
- Local pre-commit hook auto-runs `scripts/update_project_context.py` and stages:
  - `assistant/TODO.md`
  - `assistant/ROADMAP.md`
  - `assistant/context/ACTIVE_STRATEGY.md`
- CI also enforces this by failing if those files change after the script runs.
