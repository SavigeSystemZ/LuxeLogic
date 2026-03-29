# META_RELEASE_NOTES.md

- Release target: MOS 0.1.2
- Status: template scaffolded with markdown-lintable generated host adapters and an explicit repo-local markdown lint policy
- Release confidence: validated for source-template and clean-room installed-repo smoke with markdown lint active
- Notes: generated MOS host adapters now emit structurally valid Markdown, the installable template ships a `.markdownlint-cli2.jsonc` that disables `MD013` to match the repo's prose-heavy documentation style, and the current MOS automation lane passes with zero Markdown lint errors
