# Decisions

- MOS is a separate installable product from the app-facing AIAST template.
- `_META_AGENT_SYSTEM/` remains maintainer-only and is not copied into installed targets.
- MOS adapters live under `meta_system/host-adapters/` instead of tool-native app repo entrypoints.
- MOS uses first-class and spec-only adapter tiers to avoid overstating host support.
