# Decisions

- Use vectorized engines by default for speed.
- Use yfinance for initial OHLCV data.
- Add ccxt for order-book research data.
- Use a lightweight execution simulator for fills and slippage in portfolio backtests.
- Use baseline metric regression checks for validation.
- Use a confluence engine to blend advisory signals into a single score/bias.
- Enforce UI data contracts with `runs/latest` artifacts and a UI health check.
- Segregate runtime application files under `app/` and keep assistant/meta assets under `assistant/`, with root-level symlinks for developer convenience.
- Store API keys/secrets in AES-256 encrypted store (master password at startup); avoid plaintext secrets in `.env`.
- Split the “Brain” (FastAPI backend) from the “Face” (React frontend) so the RTX 5060 can prioritize WebGL/LLM visual rendering without UI input lag from trading logic.
- Standardize a hybrid chart stack for ui-next: Lightweight Charts for primary OHLCV/price interaction; keep microstructure widgets on a stable Canvas fallback path with optional WebGL acceleration.
- Keep Redis optional and opt-in for local backend/scanner workflows (default no-Redis mode for easier startup).
- Treat Git remote connectivity as a hard operational gate: verify `origin/main` reachability before major work and restore immediately if connectivity is degraded.
- Keep at most 3 local backups; rotate the oldest on new milestone backups, and push a snapshot to the `backups` branch when created.
