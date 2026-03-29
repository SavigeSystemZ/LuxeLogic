# Assistant Instruction Aliases

These are chat-level macros. When you type the alias, I expand it to the described action unless you override parameters.

Alias: `/load_system`
Expansion: Load Priority 0 and Priority 1 items from `assistant/ASSISTANT_LOADOUT.md` and report what was opened.

Alias: `/load_master`
Expansion: Synonym for `load_system`.

Alias: `/load_system_full`
Expansion: Load Priority 0-3 items from `assistant/ASSISTANT_LOADOUT.md` plus `assistant/FULL_CONTEXT_INDEX.md` and report what was opened.

Alias: `/load_custom_model`
Expansion: Synonym for `load_system`.

Alias: `/load_rules`
Expansion: Open `assistant/rules/PROJECT_RULES.md`, `assistant/rules/MEMORY_RULES.md`, and `assistant/context/RULES_USER.md`.

Alias: `/load_context`
Expansion: Open `assistant/context/WHERE_WE_LEFT_OFF.md`, `assistant/context/CHANGELOG.md`, `assistant/context/MEMORY.md`, `assistant/context/DECISIONS.md`, and `assistant/context/DRIFT_THRESHOLDS.md`.

Alias: `/load_skills`
Expansion: List all `assistant/skills/*/SKILL.md` files and open each one. Also list any `assistant/skills/*/agents/*.yaml` sub-agent configs.

Alias: `/load_mcp`
Expansion: Open all MCP config files in `assistant/resources/mcp/` and report what's configured.

Alias: `/load_subagents`
Expansion: Open all `assistant/skills/*/agents/*.yaml` files and summarize available sub-agents.

Alias: `/load_prompts`
Expansion: Open `assistant/prompts/system_prompt_template.md`, `assistant/prompts/developer_prompt_template.md`, and `assistant/prompts/user_prompt_template.md`.

Alias: `/load_docs`
Expansion: Open `README.md`, `assistant/ROADMAP.md`, `assistant/resources/docs/SYSTEM_OVERVIEW.md`, `assistant/resources/docs/UI_DATA_CONTRACT.md`, `assistant/resources/docs/OPS_RUNBOOK.md`, `assistant/resources/docs/QUALITY_GATES.md`, `assistant/resources/docs/ASSET_TAXONOMY.md`, `assistant/resources/docs/ROBINHOOD_ACCESS.md`, and `data/public/README.md`.

Alias: `/load_everything`
Expansion: Run `load_system_full`, `load_rules`, `load_context`, `load_skills`, `load_mcp`, `load_subagents`, `load_prompts`, and `load_docs` in sequence, then summarize what was loaded.

Alias: `/memory_reingest`
Expansion: Run `python scripts/memory_tool.py ingest --replace` and report the result.

Alias: `/memory_search "<query>"`
Expansion: Run `python scripts/memory_tool.py search --query "<query>"` and summarize the hits.

Alias: `/memory_up`
Expansion: Run `./scripts/launch_memory_server.sh` and report PID/health status.

Alias: `/memory_status`
Expansion: Run `./scripts/memory_status.sh` and summarize PID/health status.

Alias: `/memory_down`
Expansion: Run `./scripts/stop_memory_server.sh` and confirm shutdown.

Alias: `/ui_refresh`
Expansion: Run the UI bundle refresh and checks.

Alias: `/ui_health`
Expansion: Run `python scripts/ui_health_check.py --runs runs/latest` and `python scripts/ui_smoke_test.py --runs runs/latest --strict`.

Alias: `/health_check`
Expansion: Run `python scripts/health_check.py --config config.yaml` and summarize failures.

Alias: `/mc_guard`
Expansion: Run `python scripts/monte_carlo.py --returns runs/latest/returns.parquet` and summarize fragility status.

Alias: `/walk_forward_anchored`
Expansion: Run `python scripts/walk_forward_anchored.py --symbol <symbol> --start <start> --end <end>` and summarize segment metrics.

Alias: `/regression_checks`
Expansion: Run `python scripts/regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --key single_asset`, `python scripts/risk_regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --positions runs/latest/positions.parquet --key single_asset`, and `python scripts/drift_check.py --path runs/latest/returns.parquet --column returns --ref_window 252 --cur_window 63`.

Alias: `/data_health`
Expansion: Run `python scripts/data_health_check.py --config asset_universe.yaml --cache-only` and `python scripts/fetch_universe.py --config asset_universe.yaml --validate`.

Alias: `/backup_project [target_path]`
Expansion: Run `./scripts/backup_project.sh` with the provided target path or the default script behavior, then log the archive path in `assistant/context/WHERE_WE_LEFT_OFF.md` and `assistant/context/CHANGELOG.md`.

Alias: `/git_connectivity`
Expansion: Run `./scripts/git_connectivity_check.sh` and summarize connectivity to `origin/main`.

Alias: `/git_sync_backup [branch]`
Expansion: Run `./scripts/git_sync_backup_branch.sh --branch <branch> --push` (default branch `backup/rolling`) after validation to mirror the current commit into the backup branch.

Alias: `/git_sync_design [branch]`
Expansion: Run `./scripts/git_sync_design_branch.sh --branch <branch> --push` (default branch `design/tools`) to publish the manifest-defined design/system surface into the design branch.

Alias: `/update_context "<summary>"`
Expansion: Append the summary to `assistant/context/WHERE_WE_LEFT_OFF.md` and `assistant/context/CHANGELOG.md`.

# Shell Aliases

Shells do not expand aliases containing `/` as the command word. We keep the
`/`-prefixed names for parity with chat-level commands and also provide
no-slash equivalents for terminal use.

These are provided in `assistant/.shell_aliases.sh`. Source that file from your shell rc to use them.

```sh
# Memory
alias /mem_ingest="python scripts/memory_tool.py ingest --replace"
alias mem_ingest="python scripts/memory_tool.py ingest --replace"
alias /mem_list="python scripts/memory_tool.py list --limit 20"
alias mem_list="python scripts/memory_tool.py list --limit 20"
alias /mem_search="python scripts/memory_tool.py search --query"
alias mem_search="python scripts/memory_tool.py search --query"
alias /memory_up="./scripts/launch_memory_server.sh"
alias memory_up="./scripts/launch_memory_server.sh"
alias /memory_status="./scripts/memory_status.sh"
alias memory_status="./scripts/memory_status.sh"
alias /memory_down="./scripts/stop_memory_server.sh"
alias memory_down="./scripts/stop_memory_server.sh"

# UI
alias /ui_bundle="python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online --provider auto"
alias ui_bundle="python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online --provider auto"
alias /ui_health="python scripts/ui_health_check.py --runs runs/latest"
alias ui_health="python scripts/ui_health_check.py --runs runs/latest"
alias /ui_smoke="python scripts/ui_smoke_test.py --runs runs/latest --strict"
alias ui_smoke="python scripts/ui_smoke_test.py --runs runs/latest --strict"
alias /ui_refresh="python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online --provider auto && python scripts/ui_health_check.py --runs runs/latest && python scripts/ui_smoke_test.py --runs runs/latest --strict"
alias ui_refresh="python scripts/run_ui_bundle.py --universe asset_universe.yaml --risk-profile moderate --mode online --provider auto && python scripts/ui_health_check.py --runs runs/latest && python scripts/ui_smoke_test.py --runs runs/latest --strict"
alias /mc_guard="python scripts/monte_carlo.py --returns runs/latest/returns.parquet"
alias mc_guard="python scripts/monte_carlo.py --returns runs/latest/returns.parquet"
alias /wf_anchored="python scripts/walk_forward_anchored.py --symbol BTC-USD --start 2020-01-01 --end 2024-01-01"
alias wf_anchored="python scripts/walk_forward_anchored.py --symbol BTC-USD --start 2020-01-01 --end 2024-01-01"
alias /regime_confidence="python scripts/regime_confidence.py --symbol BTC/USD --provider ccxt --exchange coinbase --start 2023-01-01 --end 2024-12-31"
alias regime_confidence="python scripts/regime_confidence.py --symbol BTC/USD --provider ccxt --exchange coinbase --start 2023-01-01 --end 2024-12-31"

# Regression
alias /regression_checks="python scripts/regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --key single_asset && python scripts/risk_regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --positions runs/latest/positions.parquet --key single_asset && python scripts/drift_check.py --path runs/latest/returns.parquet --column returns --ref_window 252 --cur_window 63"
alias regression_checks="python scripts/regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --key single_asset && python scripts/risk_regression_check.py --returns runs/latest/returns.parquet --equity runs/latest/equity.parquet --positions runs/latest/positions.parquet --key single_asset && python scripts/drift_check.py --path runs/latest/returns.parquet --column returns --ref_window 252 --cur_window 63"

# Data health
alias /data_health="python scripts/data_health_check.py --config asset_universe.yaml --cache-only && python scripts/fetch_universe.py --config asset_universe.yaml --validate"
alias data_health="python scripts/data_health_check.py --config asset_universe.yaml --cache-only && python scripts/fetch_universe.py --config asset_universe.yaml --validate"

# Health checks
alias /health_check="python scripts/health_check.py --config config.yaml"
alias health_check="python scripts/health_check.py --config config.yaml"

# Backups
alias /backup_project="./scripts/backup_project.sh"
alias backup_project="./scripts/backup_project.sh"
alias /git_tag_checkpoint="./scripts/git_tag_checkpoint.sh"
alias git_tag_checkpoint="./scripts/git_tag_checkpoint.sh"
alias /git_backup_roll="./scripts/git_backup_branch.sh"
alias git_backup_roll="./scripts/git_backup_branch.sh"
alias /git_sync_backup="./scripts/git_sync_backup_branch.sh --push"
alias git_sync_backup="./scripts/git_sync_backup_branch.sh --push"
alias /git_sync_design="./scripts/git_sync_design_branch.sh --push"
alias git_sync_design="./scripts/git_sync_design_branch.sh --push"
alias /git_connectivity="./scripts/git_connectivity_check.sh"
alias git_connectivity="./scripts/git_connectivity_check.sh"
alias /secrets_set="python scripts/secrets_tool.py set"
alias secrets_set="python scripts/secrets_tool.py set"
alias /secrets_list="python scripts/secrets_tool.py list"
alias secrets_list="python scripts/secrets_tool.py list"
alias /ip_whitelist_check="python scripts/ip_whitelist_check.py"
alias ip_whitelist_check="python scripts/ip_whitelist_check.py"
alias /kill_switch="python scripts/kill_switch.py --exchanges binance,coinbase,kraken"
alias kill_switch="python scripts/kill_switch.py --exchanges binance,coinbase,kraken"
```
