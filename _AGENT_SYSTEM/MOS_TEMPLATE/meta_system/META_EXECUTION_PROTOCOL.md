# Meta Execution Protocol

## Default Flow

1. Load the canonical MOS startup files.
2. Identify whether the task is specification, generation, repair, validation, or review.
3. Read the smallest additional set of docs needed to act safely.
4. Make coherent changes across contracts, manifests, generated artifacts, and validation flows.
5. Run the narrowest meaningful validation immediately, then the broader lane before handoff.

## Change Discipline

- Prefer modifying existing canonical surfaces over adding redundant files.
- Keep host-adapter generation and emitted prompts manifest-driven.
- Treat spec-only adapters as supported contracts, not first-class runtime promises.
- When a change affects downstream behavior, update `docs/` and any affected prompt pack.
