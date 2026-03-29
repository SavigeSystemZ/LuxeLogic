# AGENTS.md

This directory is for master-repo-only AIAST design work.

## Core rule

- Use this workspace for planning, research, design, handoff, and future file creation that applies to the system itself rather than to installed app repos.
- Use `KEY.md` when you need the exhaustive file-by-file map of the maintainer workspace instead of the shorter summaries in `README.md`.

## Do here

- design future agent-system files
- record maintainer-only AIAST planning state
- stage future prompts, contexts, and coordination surfaces for the system that shapes the system

## Do not do here

- do not treat this directory as installable app-repo content
- do not assume these files exist after `TEMPLATE/bootstrap/init-project.sh`
- do not move runtime code, packaging manifests, or app-facing repo truth here

## Cross-boundary rule

- if a change must affect installed app repos, update `TEMPLATE/` separately and keep its working files neutral
- if a change is only about evolving AIAST or its future meta-system, keep the working state here
