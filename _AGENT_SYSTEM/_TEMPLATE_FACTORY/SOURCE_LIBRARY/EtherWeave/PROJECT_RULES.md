# Wraiths‑Etherweave — Project Rules (PyQt6)

These are repo-wide engineering + UX rules for Etherweave’s PyQt6 GUI and core platform.

Source-of-truth governance:
- `docs/KERNEL_CONTRACT.md`
- `docs/PHASE_CHECKPOINT_PROTOCOL.md`
- `docs/DEBUG_REPAIR_PLAYBOOK.md`

## Safety posture (non-negotiable)
- Defensive/authorized wireless assessment platform by default (monitoring, inventory, configuration validation, evidence collection, reporting, compliance/hardening).
- No automated exploitation/credential attacks/traffic disruption shipped by default.
- Potentially harmful features, if present, must be quarantined behind fail-closed stubs + explicit operator gating + audit logging.

## UI / Layout rules (PyQt6)
- Use layouts (`QVBoxLayout`, `QHBoxLayout`, `QGridLayout`) instead of absolute positioning (`setGeometry`, manual pixel placement) except for rare/justified cases.
- Maintain consistent spacing/padding and avoid clipping; preserve `CyberFrame`/`ScrolledFrame` patterns where used.
- Avoid double borders: do not nest multiple framed widgets that each render borders unless visually intentional.
- Keep the UI powerful but not cluttered: prefer progressive disclosure (dialogs/menus) when a tab becomes crowded.

## Responsiveness rules
- No blocking work on the GUI thread.
- Long operations run in `QThread` (or equivalent worker) and update UI via signals/slots.
- Global “panic/stop” cancels running tasks safely.

## Hardware + capability rules
- Detect capabilities (chipset/driver/privileges) and gate features in UI accordingly.
- Monitor mode and other privileged operations require explicit user invocation and are gated by Lab/Privileged Ops mode.
- Do not assume injection support; treat it as an advanced capability and do not ship disruptive behaviors by default.

## Installer / multi-distro support
- Support Debian/Ubuntu (`apt`), Fedora (`dnf`), Arch (`pacman`) via explicit branches.
- Preflight checks must be accurate and non-destructive; avoid silent privilege escalation.

## Database and install (distribution-first)
- **No hardcoded DB users.** Use the current OS user for all DB paths and (if using PostgreSQL) connections. See **system/docs/DATABASE_AND_INSTALL_ARCHITECTURE.md**.
- **User data dir:** All SQLite DBs and evidence live under a single user data dir (e.g. `~/.etherweave` or `$XDG_DATA_HOME/etherweave`). Use `etherweave.lib.user_data.get_etherweave_data_dir()` (and helpers) for defaults.
- **Setup script:** `scripts/setup_data.sh` ensures the data dir exists and is writable by the current user; run as the installing user (install.sh runs it before desktop icon). Idempotent; no overwrite of existing DBs.
- **Legacy:** If data dir or DB is owned by another user, alert and document fix (e.g. `chown -R $USER ~/.etherweave`).

## Appearance / theme rules
- Default theme should match the project’s primary “icon palette” / reference screenshots.
- Provide selectable alternate themes (e.g., Dark Purple).
- Wallpaper background (user-selected local file) is optional and must preserve readability and accessibility.

## Security rules
- Never commit secrets (tokens/keys/passwords). Use `tools/secrets_scan.sh` before push.
- Never log sensitive material (passwords/keys/raw credentials).
- Sudo caching: never store secrets; clear cache on panic/exit where appropriate.
- Shred RAM-disk with 3-pass overwrite on panic

### Panic Protocol
- Global Panic 3.0 MUST:
  1. Wipe RTX 5060 VRAM explicitly
  2. Shred RAM-disk with random data
  3. Flush sudo cache and restart NetworkManager
  4. Show 1-second countdown with "PURGE IN PROGRESS" visual
  5. Complete all operations in <1 second

---

## 🚀 Performance Rules

### IRQ Balancing
- Bind wireless interface IRQs to CPU cores 2+
- Leave cores 0/1 free for GUI rendering
- Use `PerformanceTuner.balance_irqs()` for IRQ binding

### Socket Optimization
- Tune `rmem_max` and `wmem_max` to 16MB for high-speed injection
- Prevent dropped packets during handshake captures
- Use `PerformanceTuner.optimize_socket_buffers()`

### Thread Management
- All long-running operations MUST run in background threads
- Use `QThread` for non-blocking operations
- Use `QTimer.singleShot(0, ...)` for thread-safe GUI updates

---

## 📊 Code Quality Rules

### Error Handling
- Never use empty `except` blocks
- Always log errors with `logger.error()` or `logger.warning()`
- Use `ErrorOracle` for comprehensive error tracking
- Provide user-friendly error messages

### Input Validation
- Validate ALL user inputs using `ValidationLayer`
- Sanitize BSSID, ESSID, Channel inputs
- Prevent command injection vulnerabilities
- Use whitelisting, not blacklisting

### Module Organization
- Keep GUI logic separate from core logic
- Use `CoreController` for all subprocess calls
- Implement callback systems for UI updates
- Maintain headless operation capability

---

## 🧭 Work Breakdown Rules

### Atomic Tasks
- Define each task/feature with **one clear outcome**
- Avoid "and" in task titles/descriptions; split into separate steps
- Prefer verb‑noun naming for tasks (e.g., "validate-input", "save-settings")

### Dependency Discipline
- Capture dependencies explicitly when one step relies on another
- Avoid circular dependencies in multi‑step workflows
- Keep workflows testable at each step (atomic outcomes)

---

## 🧪 Testing Rules

### Hardware Verification
- Always check hardware capabilities before operations
- Use `HardwareAudit` on startup
- Verify GPU, wireless chipset, and driver support
- Provide clear warnings for missing hardware

### Feature Parity
- Ensure GUI and CLI have feature parity
- Every GUI button must have a CLI equivalent
- Use `CoreEngine` for shared logic
- Test both interfaces independently

---

## 📝 Documentation Rules

### Code Comments
- Document all Phase implementations
- Include usage examples in docstrings
- Mark experimental features clearly
- Document security considerations

### Module Headers
- Every module MUST have a header with:
  - Phase number
  - Purpose description
  - Key features list
  - Usage examples

---

## ⚠️ Breaking Change Protocol

### Before Making Core Changes
- Operator has granted blanket approval for in-repo changes; do not request confirmation for normal edits.
- Still require explicit confirmation for destructive operations, external/network actions, or scope changes.
- Check if feature already exists
- Verify if something is actually broken
- Never summarize - read prompts in full

### Change Authorization
- Core system changes: **EXECUTE** (non-destructive, in-repo)
- Bug fixes and optimizations: **EXECUTE**
- UI improvements: **EXECUTE**
- New features: **EXECUTE** (if non-breaking)

---

## 🎯 Priority Enforcement

### Critical Rules (Must Follow)
1. ✅ No `place()` - use `grid()` or layout managers
2. ✅ 10-button rule per tab
3. ✅ RTX 5060 thermal check before cracking
4. ✅ Recursive dependency installer protocol
5. ✅ 85% opacity for CyberFrames with wallpaper

### High Priority Rules
1. ✅ Use `CyberFrame` for all group boxes
2. ✅ Encrypted RAM-disk for .pcap files
3. ✅ IRQ balancing for wireless interfaces
4. ✅ Color sampling for adaptive theming
5. ✅ UI ghosting for active tabs

### Standard Rules
1. ✅ Thread-safe GUI updates
2. ✅ Input validation on all inputs
3. ✅ Error logging with ErrorOracle
4. ✅ Hardware verification on startup
5. ✅ Feature parity between GUI and CLI

---

## 📋 Checklist for Every Edit

Before committing any changes, verify:

- [ ] No `place()` used - only `grid()` or layouts
- [ ] All group boxes use `CyberFrame` class
- [ ] Tab has ≤10 buttons (excluding global)
- [ ] RTX 5060 thermal check implemented
- [ ] Input validation applied
- [ ] Error handling with logging
- [ ] Thread-safe GUI updates
- [ ] 85% opacity if wallpaper active
- [ ] No doubled/tripled borders
- [ ] 15px bottom padding on containers

---

## 🔄 Rule Updates

This document is the **MASTER MANIFEST**. All future edits to Wraiths-Etherweave must:
1. Read this file first
2. Adhere to all rules
3. Update this file if rules change
4. Document exceptions clearly

**Last Verified:** All Phases 1-22 Complete ✅

---

## 📚 Related Documents

- `PHASE_1_5_COMPLETE.md` - Architecture & Graphical Foundation
- `PHASE_6_9_COMPLETE.md` - Intelligence & Mapping
- `PHASE_10_12_COMPLETE.md` - AI Ghost Engines
- `PHASE_13_16_COMPLETE.md` - Stealth & Post-Exploitation
- `PHASE_17_19_COMPLETE.md` - Deployment & WIPS
- `PHASE_20_22_COMPLETE.md` - Performance & Skinning

---

**END OF MASTER MANIFEST**
