# META_CHANGELOG.md

## 0.1.2

- `bootstrap/generate-meta-host-adapters.sh` now emits Markdown with the
  required blank lines around headings and lists, so generated host adapters
  pass structural markdown lint instead of requiring manual cleanup.
- `bootstrap/lint-meta-system.sh` now honors a repo-local
  `.markdownlint-cli2.jsonc` when `markdownlint-cli2` is available, and the
  installable MOS template now ships that config with `MD013` disabled to match
  the repo's prose-heavy documentation style.

## 0.1.1

- `install-meta-missing-files.sh` now regenerates derived MOS artifacts after additive recovery and supports strict validation for installed repos.
- Strict MOS init, additive recovery, and update flows now record the latest successful validation in `meta_system/context/CURRENT_STATUS.md` and `META_WHERE_LEFT_OFF.md`.
- Strict MOS update now revalidates instruction-layer alignment and install-boundary cleanliness instead of only checking file presence.

## 0.1.0

- Initial Meta Operating System MVP scaffold.
- Installed repos now receive seeded meta working-state surfaces instead of only placeholder continuity files.
- Installed repos now receive an inferred first focus and next validation command based on repo shape.
