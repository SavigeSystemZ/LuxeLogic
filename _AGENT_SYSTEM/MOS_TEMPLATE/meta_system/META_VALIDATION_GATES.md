# Meta Validation Gates

Run these gates after meaningful MOS changes:

1. `bootstrap/validate-meta-system.sh <repo>`
2. `bootstrap/validate-meta-instruction-layer.sh <repo>`
3. `bootstrap/check-meta-host-adapter-alignment.sh <repo>`
4. `bootstrap/check-meta-hallucination.sh <repo>`
5. `bootstrap/lint-meta-system.sh <repo>`
6. `bootstrap/system-meta-doctor.sh <repo>`

For source-template maintenance, also run `_MOS_TEMPLATE_FACTORY/run-automation-lane.sh`.
