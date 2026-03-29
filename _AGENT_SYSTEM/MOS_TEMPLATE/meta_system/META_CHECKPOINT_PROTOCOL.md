# Meta Checkpoint Protocol

Create a checkpoint when any of the following changes:

- the canonical precedence or load-order contract
- the host-adapter manifest or generated adapters
- the plugin contract
- the golden-examples manifest
- the validation or repair lane

At each checkpoint:

1. update the affected canonical docs
2. regenerate derived artifacts
3. run the relevant validation commands
4. record outcomes in `META_WHERE_LEFT_OFF.md` and `meta_system/context/CURRENT_STATUS.md` if the repo owns live working state
