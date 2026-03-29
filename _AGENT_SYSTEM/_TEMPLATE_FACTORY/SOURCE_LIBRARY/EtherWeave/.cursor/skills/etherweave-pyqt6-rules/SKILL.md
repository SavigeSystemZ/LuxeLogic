---
name: etherweave-pyqt6-rules
description: PyQt6 layout and threading rules for Etherweave. Use when adding or modifying GUI widgets, tabs, dialogs, or background workers.
---

# Etherweave PyQt6 Rules

Apply when writing or changing GUI code in this app.

## Layout (mandatory)

- **No place()** — Use QVBoxLayout or QHBoxLayout only.
- **No redundant QGroupBox stylesheets** — Use global style only (avoids doubled borders).
- **Min heights** — QTextEdit: setMinimumHeight(150); QListWidget: setMinimumHeight(100).
- **Bottom padding** — 15px bottom margin to prevent border clipping (e.g. setContentsMargins(10, 10, 10, 15)).

## Threading (mandatory)

- **No UI blocking** — Long operations in QThread (or equivalent).
- **Thread-safe updates** — From workers use QTimer.singleShot(0, lambda: widget.update(...)) or pyqtSignal. Never touch widgets directly from worker threads.
- **Widget access** — Use hasattr(self, 'widget_name') and self.widget_name before accessing; widgets may not exist during teardown.

## Buttons

- **10-button rule** — No tab may have more than 10 action buttons. Move excess to a dialog or "Advanced" sub-menu.
- Global header buttons (Settings, Cache Sudo, System Maintenance, Global Panic) do not count.

## Patterns

```python
# Thread-safe append to output
QTimer.singleShot(0, lambda: self.output_widget.append(text))

# Worker signals
class Worker(QThread):
    result_ready = pyqtSignal(str)
    def run(self):
        r = long_operation()
        self.result_ready.emit(r)
```

Reference: PROJECT_RULES.md, .cursorrules, MASTER_AI_REFERENCE.md.
