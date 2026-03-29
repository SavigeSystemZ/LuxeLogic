# Golden Example Selection

The golden example system is intentionally curated per pattern instead of choosing one "best app" and copying it everywhere.

## Why not one donor repo

- no single repo is strongest in every dimension
- one donor repo would leak product bias into unrelated projects
- different patterns mature at different speeds across the portfolio

## Current primary donors by pattern

- Continuity and handoff: CandleCompass, LedgerLoop
  Reason: strongest evidence of durable state, explicit handoff packets, and validation-aware resume surfaces.

- Governance and prompting: IdeaForge, EtherWeave
  Reason: strongest governance-first rules, prompt-pack discipline, and MCP least-privilege thinking.

- Multi-agent and MCP: EtherWeave, IdeaForge
  Reason: strongest multi-agent role modeling, tool fallback posture, and MCP policy depth.

- Validation and release: LedgerLoop, CandleCompass
  Reason: strongest executable signoff posture for install, packaging, runtime, and release confidence.

- Platform surfaces: PromptMage, LedgerLoop, CandleCompass
  Reason: strongest examples of separating web, desktop, mobile, packaging, ops, and AI-oriented surfaces.

## Strong repos not used as primary donors everywhere

- Immortality and Vetraxis
  Reason: both score strongly on repo maturity signals and were reviewed on 2026-03-22, but their strongest material remains too app-specific to justify promoting them into the installed golden-example pack.

- TraceForge
  Reason: strongest current scorecard on documentation and profile completeness, but its most distinctive material is still bound to investigative recovery workflows and does not add a safer neutral donor pattern than the current curated set.

- HQIQ
  Reason: strong docs shape and filled profile, but still visibly in active maturation for several operational surfaces.

- Orignym
  Reason: promising structure, but the nested template copy inflates maturity signals and makes it a weaker donor until it stabilizes.

- ShadowCall and other active repos
  Reason: useful future donor candidates, but not yet the clearest quality-bar source for the current pack.

## Maintenance rule

Refresh the scorecard first. Update this selection doc second. Only then change the installed golden-example pack if the neutralized guidance should actually move.
Record candidate-specific review outcomes in `REVIEW_NOTES.md` before promoting or rejecting a new donor.
Apply the baseline rules in `PROMOTION_CRITERIA.md` and `promotion-rubric.json` before changing any primary donor mapping.
