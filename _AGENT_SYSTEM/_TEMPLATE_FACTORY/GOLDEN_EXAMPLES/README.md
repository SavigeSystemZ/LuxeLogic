# Golden Examples Factory Assets

This directory is factory-only. It exists to help maintainers choose which sibling repos should influence the neutral golden-example pack shipped in `TEMPLATE/_system/golden-examples/`.

## Files

- `repo-scorecard.json` — machine-readable maturity scan of sibling repos
- `REPO_SCORECARD.md` — human-readable score summary
- `SELECTION.md` — curated donor mapping by pattern
- `REVIEW_NOTES.md` — candidate-specific promotion or rejection outcomes
- `PROMOTION_CRITERIA.md` — human-readable donor-promotion rules
- `promotion-rubric.json` — machine-readable donor-promotion thresholds used by validation

## Validation

- Run `../validate-golden-examples.sh` after changing the scorecard, selection map, review notes, or rubric.

Installed repos must not depend on this directory.
