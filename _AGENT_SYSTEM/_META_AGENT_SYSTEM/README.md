# Meta Agent System Workspace

This directory is the master-repo-only workspace for designing and evolving the
systems that shape AIAST itself.

## Purpose

- keep AIAST-maintainer planning, research, handoff state, and future
  "system-for-the-system" files out of the installable template
- provide the canonical outage-resume packet for maintainer-only work that must
  not ship into app repos or installed meta-system repos
- preserve a hard boundary between app-facing installable files and
  master-repo-only system-design files

## Boundary

- `TEMPLATE/` is the installable product copied into app repos
- `_TEMPLATE_FACTORY/` is factory-only build, validation, scoring, and rollout
  tooling
- `_META_AGENT_SYSTEM/` is meta-only design and planning space for the system
  that shapes the system
- `MOS_TEMPLATE/` is the installable Meta Operating System product for building
  future system-of-systems templates
- `_MOS_TEMPLATE_FACTORY/` is factory-only MOS validation and smoke
  infrastructure
- `MOS_SOURCE_LIBRARY/` is maintainer-only donor intake and source manifest
  state

Nothing in this directory is copied into new or existing app repos by the
normal AIAST install flow.

## Current state

- The MOS MVP product exists as a parallel installable system with its own
  bootstrap, adapters, golden examples, plugins, source manifest, and factory
  validation lane
- The source-boundary hardening follow-through is complete for both AIAST and
  MOS, including installed-repo source rejection, negative smoke coverage, and
  aligned lifecycle wording
- AIAST `1.13.7` now includes the earlier greenfield-bootstrap, blueprint,
  placeholder, recommender, upgrade-truthfulness, packaging, host-ingestion,
  key-surface, and strict-version validation work, plus downstream-tested
  Python packaging guidance for scaffolded repos and the mobile bootstrap
  guidance that tells agents to run `flutter create --platforms=android .`
  before expecting full Flutter build commands from the copied minimal mobile
  foundation
- MOS `0.1.2` still reflects the last validated MOS baseline, including
  markdownlint-backed generated host-adapter cleanup
- This workspace now carries the live maintainer continuity packet for the
  first canonical isolated test-session proof wave, not just the earlier
  template-only validation state
- The maintainer workspace now has both an executable continuity validator and
  a dedicated maintainer lane wrapper
- Durable meta-context now records the true current validated AIAST `1.13.7`
  plus MOS `0.1.2` baseline, the March 25 AtlasPilot, SentinelOps, and
  PromptMage-class product evidence, and the March 26 downstream app evidence
  from `service-api`, `admin-cli`, `portal-web`, `control-plane`, and
  `ops-mobile`
- `_META_AGENT_SYSTEM/COMPLETION_SHEET.md` serves as the one-stop finish-line
  tracker for remaining work, deferred work, enhancements, polish, and testing
  phases
- `_META_AGENT_SYSTEM/KEY.md` serves as the exhaustive maintainer-facing map of
  every file in this workspace and when it should be used
- `_META_AGENT_SYSTEM/TEST_APP_CAMPAIGN.md` plus
  `_TEMPLATE_FACTORY/prepare-test-session.sh` now define, prepare, and record
  the first scripted isolated test-app matrix
- No known blocking meta-system gap remains before returning to primary
  downstream-driven app-builder-system work

## Next step

- use `_TEMPLATE_FACTORY/prepare-test-session.sh` for the next external proof
  session and otherwise wait for the next real downstream repo before opening
  another AIAST or MOS slice
