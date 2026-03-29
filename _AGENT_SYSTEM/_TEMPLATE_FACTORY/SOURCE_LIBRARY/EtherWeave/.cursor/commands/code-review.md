# Code Review

Review the code in scope (current file, selection, or recent changes) against Etherweave project rules and architecture.

**Do this now:**
1. Identify the code to review (current file, user selection, or run `git diff` for recent changes).
2. Apply the checklist from **etherweave-code-review** skill: code quality (type hints, docstrings, no bare except, ValidationLayer, logging), PyQt6 (no place(), QThread, thread-safe updates, 10-button rule), security (SudoCache, LootManager, parameterized queries), architecture (CoreController, no GUI in core, single instances, feature parity), performance (indexes, GPUThermalGuard).
3. Report findings as: **Critical** (must fix), **Suggestion** (should fix), **Nice to have**. Cite rule/source and file:line. Suggest concrete fixes where possible.
4. Recommend running `python tools/fitness_check.py` and `tools/verify.sh` if available.

Authority order: PROJECT_RULES.md (or .cursorrules), MASTER_AI_REFERENCE.md, docs/ARCHITECTURE_BOUNDARIES.md, docs/ARCHITECTURE_FITNESS_FUNCTIONS.md.
