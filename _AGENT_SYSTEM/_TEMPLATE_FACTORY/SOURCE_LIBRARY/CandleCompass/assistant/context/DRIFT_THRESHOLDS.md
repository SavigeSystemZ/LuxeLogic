# Drift Thresholds Rationale

This project uses lightweight statistical drift checks to flag changes in return distributions.
The thresholds below are conservative and intended for **research alerts**, not automated shutdown.

## Thresholds
- mean_shift_z_max: 2.5
  - Rationale: allow moderate mean drift (~2.5 standard deviations) before alerting.
- vol_ratio_max: 2.0
  - Rationale: tolerate up to 2x volatility expansion; beyond that is likely regime shift.
- ks_pvalue_min: 0.01
  - Rationale: require strong evidence (p<0.01) to flag distribution change.

## Usage
- Evaluated on returns using ref_window and cur_window.
- If drift_ok = False, treat as investigation trigger.

## Tuning
- For more sensitivity: lower mean_shift_z_max and ks_pvalue_min.
- For more tolerance: raise mean_shift_z_max and vol_ratio_max.
