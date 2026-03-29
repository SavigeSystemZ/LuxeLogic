# MOS Bootstrap Commands

- `init-meta-project.sh` installs MOS into a target repo
- `install-meta-missing-files.sh` adds newly introduced MOS files without overwriting repo-owned state, then regenerates derived outputs and optionally runs strict recovery validation
- `seed-meta-working-state.sh` replaces placeholder continuity defaults with an initial installed-repo baseline
- `suggest-meta-baseline.sh` infers a first repo-shape-aware focus and next validation command for installed MOS repos
- `update-meta-template.sh` refreshes non-stateful files from the source template and, in strict mode, revalidates instruction-layer and boundary state
- `generate-meta-host-adapters.sh` regenerates adapter overlays from the manifest
- `generate-meta-system-registry.sh` regenerates the machine-readable file index
- `generate-meta-operating-profile.sh` regenerates the machine-readable operating profile
- `validate-meta-system.sh` checks required file presence and structural shape
- `check-meta-install-boundary.sh` fails if maintainer-only or foreign product layers leaked into an installed MOS repo
- `validate-meta-instruction-layer.sh` checks authority-chain alignment
- `check-meta-host-adapter-alignment.sh` verifies generated adapters stay in sync
- `detect-meta-instruction-conflicts.sh` checks structural precedence conflicts
- `detect-meta-drift.sh` compares an installed repo against a source template
- `repair-meta-system.sh` restores missing surfaces and regenerates derived outputs
- `heal-meta-system.sh` convenience wrapper for repair
- `system-meta-doctor.sh` runs the integrated diagnostic lane
- `emit-meta-host-prompt.sh` emits a host-safe startup prompt
- `emit-meta-host-bundle.sh` emits a portable prompt-and-context bundle
- `check-meta-hallucination.sh` detects unsupported references and evidence gaps
- `lint-meta-system.sh` runs opportunistic lint and secret checks

## Source Policy

- For every `--source` flow, point at the canonical MOS template root in template-source mode.
- Do not point MOS install or update flows at the master repo root.
- Do not point MOS install or update flows at an already-installed MOS target repo.
- Use `check-meta-install-boundary.sh <target-repo>` when you want an explicit proof that maintainer-only layers did not leak into the installed repo.
- `init-meta-project.sh` and `install-meta-missing-files.sh` now seed the first installed-repo `META_*` continuity surfaces automatically.
- `init-meta-project.sh` and `install-meta-missing-files.sh` now also infer a first repo-shape-aware focus and next command automatically.
- Strict MOS lifecycle runs now record the latest passing validation into `meta_system/context/CURRENT_STATUS.md` and `META_WHERE_LEFT_OFF.md`.
