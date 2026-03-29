# Golden Example Promotion Criteria

This file defines the factory-side promotion rubric for donor repos that influence the neutral golden-example pack shipped inside `TEMPLATE/_system/golden-examples/`.

## Purpose

- reduce donor-selection drift and chat-memory dependence
- make promotion and rejection decisions easier to audit after context resets
- keep the installed golden-example pack neutral instead of letting one strong but app-specific repo dominate

## Hard gates

- every primary donor must exist in `repo-scorecard.json`
- every primary donor must satisfy the minimum measurable baseline in `promotion-rubric.json`
- every high-scoring repo above the review threshold in `promotion-rubric.json` that is not a current primary donor must appear in `REVIEW_NOTES.md`
- every promotion or rejection decision must include a clear pattern-level reason, not just a repo-level score

## Selection rules

- prefer donors that contribute a clearly neutral pattern rather than product-specific truth
- prefer donors whose strengths are complementary across patterns instead of trying to crown one universal best repo
- treat scorecard results as triage, not as automatic promotion authority
- keep factory-only provenance and donor debate in `_TEMPLATE_FACTORY/GOLDEN_EXAMPLES/`, not in the installed repo pack

## Rejection rules

- reject candidates whose strongest material is still dominated by product domain facts, irreversible workflow coupling, or vendor-specific operating assumptions
- reject candidates when neutralizing them would mostly preserve formatting discipline without adding a stronger reusable pattern
- reject candidates when the current donor set already covers the same pattern more safely

## Review cadence

- rerun `refresh-golden-examples.sh` before meaningful template releases
- run `validate-golden-examples.sh` after updating the scorecard, selection map, review notes, or rubric
- update `SELECTION.md` only after the scorecard and review notes are current

## Machine-readable mirror

- `promotion-rubric.json` is the machine-readable mirror used by `validate-golden-examples.sh`
- if this file changes materially, update the JSON mirror in the same change
