---
name: etherweave-code-review
description: Review code against Etherweave PROJECT_RULES, MASTER_AI_REFERENCE, architecture boundaries, and fitness functions. Use when reviewing pull requests, examining code changes, or when the user asks for a code review or to check compliance with project rules.
---

# Etherweave Code Review

## When to Use

- User asks for a **code review** or to **check project compliance**
- Reviewing pull requests or staged/unstaged changes
- Before or after implementing a feature (verify rules and boundaries)

## Authority Sources

Apply these in order; conflicts resolve to earlier source:

1. **PROJECT_RULES.md** (or root `.cursorrules`) — master manifest
2. **MASTER_AI_REFERENCE.md** — architecture and patterns
3. **docs/ARCHITECTURE_BOUNDARIES.md** — layer/port/adapter rules
4. **docs/ARCHITECTURE_FITNESS_FUNCTIONS.md** — automated checks
5. **prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md** — hard constraints and glossary

## Review Checklist

### Code quality
- [ ] Type hints on all function parameters and return values
- [ ] Google-style docstrings for functions, classes, modules
- [ ] No bare `except:` — use `except Exception as e:` with logging
- [ ] Input validated via `ValidationLayer` before processing
- [ ] Errors handled gracefully; no raw exceptions to user
- [ ] Logging used appropriately (debug/info/error/exception)

### PyQt6 / GUI
- [ ] No UI thread blocking — long ops use `QThread`
- [ ] GUI updates from threads via `QTimer.singleShot(0, ...)` or `pyqtSignal`
- [ ] Layouts only — no `place()`; use `QVBoxLayout` / `QHBoxLayout`
- [ ] QTextEdit / QListWidget have `setMinimumHeight()` (150px / 100px)
- [ ] No redundant QGroupBox stylesheets (use global style)
- [ ] Widget access guarded with `hasattr()` where appropriate
- [ ] 10-button rule: no tab with >10 action buttons (excess in dialogs)

### Security and auth
- [ ] `SudoCache` for sudo; no stored passwords
- [ ] Sensitive data encrypted via `LootManager`
- [ ] Parameterized queries (no SQL injection)
- [ ] Authorization and permissions checked before privileged ops

### Architecture
- [ ] CoreController remains single GUI/CLI entry to core
- [ ] No GUI imports in core/application/lib layers
- [ ] No direct subprocess in GUI except adapters/wrappers
- [ ] Single instances: `self.db`, `self.radio_manager` (no duplicate instances)
- [ ] Feature parity: GUI feature has CLI equivalent via CoreController

### Performance
- [ ] Database indexes used for frequent queries (bssid, essid, channel)
- [ ] GPU ops guarded by `GPUThermalGuard` where applicable
- [ ] Module-level imports; no unused imports

## Output Format

- **Critical**: Must fix before merge (rules violation, security, correctness)
- **Suggestion**: Should fix for consistency or maintainability
- **Nice to have**: Optional improvement

For each finding: cite rule/source, file:line or snippet, and concrete fix when possible.

## Verification

If fitness checks exist, recommend running:

```bash
python tools/fitness_check.py
tools/verify.sh
```

Reference **docs/DEBUG_REPAIR_PLAYBOOK.md** if failures need diagnosis.
