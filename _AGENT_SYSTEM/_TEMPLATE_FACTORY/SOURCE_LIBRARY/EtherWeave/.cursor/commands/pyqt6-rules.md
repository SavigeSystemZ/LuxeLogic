# Apply PyQt6 Rules

Apply Etherweave PyQt6 layout and threading rules to the current or specified GUI code.

**Do this now:**
1. Identify the GUI code in scope (current file, selection, or user-specified path).
2. Check and fix: **Layout** — No `place()`; use QVBoxLayout/QHBoxLayout only; no redundant QGroupBox stylesheets; QTextEdit min-height 150px, QListWidget min-height 100px; 15px bottom margin. **Threading** — No UI blocking; long ops in QThread; GUI updates from threads via `QTimer.singleShot(0, ...)` or pyqtSignal; use `hasattr()` before widget access. **10-button rule** — No tab with more than 10 action buttons; move excess to dialogs or "Advanced" sub-menu.
3. Propose concrete edits with file:line or snippets.

Reference: **etherweave-pyqt6-rules** skill, PROJECT_RULES.md, `.cursor/rules/etherweave-pyqt6.mdc`.
