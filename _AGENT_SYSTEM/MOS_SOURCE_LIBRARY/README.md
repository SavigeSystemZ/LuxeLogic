# MOS Source Library

This directory holds donor and provenance state for the Meta Operating System.

## Purpose

- record which source systems, contracts, and patterns were used to build `MOS_TEMPLATE/`
- keep donor intake and audit metadata out of the installable MOS product
- provide one machine-readable manifest that the MOS factory lane can refresh and validate

## Boundary

- `MOS_TEMPLATE/` is the installable product
- `_MOS_TEMPLATE_FACTORY/` is factory-only automation
- `MOS_SOURCE_LIBRARY/` is maintainer-only donor intake and manifest state

No files in this directory are copied into installed target repos by the normal MOS install flow.
