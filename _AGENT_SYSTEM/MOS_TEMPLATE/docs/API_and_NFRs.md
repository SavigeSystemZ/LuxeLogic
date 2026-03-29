# API and Non-Functional Requirements

## CLI Surfaces

- `bootstrap/init-meta-project.sh`
- `bootstrap/install-meta-missing-files.sh`
- `bootstrap/update-meta-template.sh`
- `bootstrap/validate-meta-system.sh`
- `bootstrap/validate-meta-instruction-layer.sh`
- `bootstrap/detect-meta-instruction-conflicts.sh`
- `bootstrap/detect-meta-drift.sh`
- `bootstrap/repair-meta-system.sh`
- `bootstrap/heal-meta-system.sh`
- `bootstrap/system-meta-doctor.sh`
- `bootstrap/generate-meta-system-registry.sh`
- `bootstrap/generate-meta-operating-profile.sh`
- `bootstrap/generate-meta-host-adapters.sh`
- `bootstrap/check-meta-host-adapter-alignment.sh`
- `bootstrap/emit-meta-host-prompt.sh`
- `bootstrap/emit-meta-host-bundle.sh`
- `bootstrap/check-meta-hallucination.sh`
- `bootstrap/lint-meta-system.sh`

## Non-Functional Requirements

- Cross-tool compatibility through one canonical adapter manifest
- Security scanning for secrets and localhost-safe defaults
- Self-healing via install, repair, and doctor flows
- Hallucination detection grounded in repo-local paths and canonical contracts
- Auto-lint for shell, JSON, YAML, and Markdown when the tools are available
- Clear, headless CLI output suitable for automation
