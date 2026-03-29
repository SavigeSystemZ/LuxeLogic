# Subagent Registry

Each subagent has a role-specific prompt in `prompts/subagents/`.

## Core Orchestration
- Orchestrator: `prompts/subagents/SUBAGENT_ORCHESTRATOR.md`

## Build & Deployment
- Installer/Packager: `prompts/subagents/SUBAGENT_INSTALLER_PACKAGER.md`

## Wireless Operations
- Environment Scanning: `prompts/subagents/SUBAGENT_ENVIRONMENT_SCANNING.md`
- Wireless Capture: `prompts/subagents/SUBAGENT_WIRELESS_CAPTURE.md`
- Password Cracking: `prompts/subagents/SUBAGENT_PASSWORD_CRACKING.md`

## UX + Integration
- GUI/CLI UX: `prompts/subagents/SUBAGENT_GUI_CLI_UX.md`
- Reporting/Forensics: `prompts/subagents/SUBAGENT_REPORTING_FORENSICS.md`

## Team Workflows
- Blue Team: `prompts/subagents/SUBAGENT_BLUE_TEAM.md`
- Red Team: `prompts/subagents/SUBAGENT_RED_TEAM.md`
- Purple Team: `prompts/subagents/SUBAGENT_PURPLE_TEAM.md`

## Ecosystem Integrations
- Pwnagotchi: `prompts/subagents/SUBAGENT_PWNAGOTCHI.md`
- Pineapple: `prompts/subagents/SUBAGENT_PINEAPPLE.md`

## Quality & Reliability
- Debug/Testing: `prompts/subagents/SUBAGENT_DEBUG_TEST.md`

---

## Cursor Subagents (.cursor/agents/)

Cursor-specific subagents (isolated context, custom system prompts). Invoke via the main Cursor agent, e.g. "Use the etherweave-debugger subagent to …".

| Name | Purpose |
|------|---------|
| etherweave-code-reviewer | Code review vs PROJECT_RULES and architecture |
| etherweave-debugger | Debug/triage; follows DEBUG_REPAIR_PLAYBOOK |
| etherweave-gui-ux | PyQt6 layouts, thread safety, CLI parity |
| etherweave-wireless | Wireless capture, scanning, SSID/BSSID flows |
| etherweave-security | ValidationLayer, SudoCache, LootManager, auth |
| etherweave-architecture | Boundaries, fitness functions, ports/adapters |
| etherweave-checkpoint | Phase checkpoint (verify, commit, backup, WORKLOG) |
| etherweave-orchestrator | Task decomposition and subagent assignment |

See `.cursor/agents/README.md` for usage and mapping to `prompts/subagents/`.
