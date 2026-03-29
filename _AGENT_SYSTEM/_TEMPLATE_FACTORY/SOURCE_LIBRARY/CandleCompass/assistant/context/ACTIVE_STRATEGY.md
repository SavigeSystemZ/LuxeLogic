# Active Strategy

This document is a durable memory of why key strategy/UX systems were built.

## Arbitrage Strategy Memory
- Objective: detect price inefficiencies that may create short-lived edge opportunities.
- Spatial Arbitrage: compare best bid/ask across Coinbase, Kraken, KuCoin, and Binance (when available), then only surface spreads that remain positive after fees and transfer cost assumptions.
- Triangular Arbitrage: model in-exchange currency loops (A -> B -> C -> A) and flag loops where compounded conversion exceeds fee-adjusted break-even.
- Delivery Pattern: publish opportunities to `runs/latest/arbitrage_opportunities.json` and render in the Gap Hunter widget so operators can review and simulate execution.
- Why: this converts fragmented market structure into explicit, rankable opportunities while preserving research-first controls.

## Gamification + Flow State Memory
- Objective: make the platform easier to navigate and more engaging without losing decision clarity.
- Zen Mode: a focus toggle that hides non-essential clutter and keeps primary chart + buy/sell context visible.
- Progression System: track usage XP and tier badges (`Scout`, `Analyst`, `Strategist`, `Whale`) based on streaks, watchlist activity, backtests, and simulated performance milestones.
- Signal Summary: present technical/sentiment/whale confluence as clear red/green lights and emphasize all-green states for fast one-glance decisions.
- Why: reduce cognitive overload, increase consistency of user workflows, and reinforce repeated high-quality analysis behavior.

## Phase 16-19 Ecosystem Memory
- Objective: complete the platform with Creation, Simulation, and Intelligence pillars.
- Creation (The Laboratory):
  - `Strategy Laboratory` provides visual strategy composition without coding.
  - Templates are saveable/reloadable and exportable as JSON strategy specs.
- Simulation (The Time Machine):
  - `Time Machine` provides replay and strategy verification modes over historical data.
  - Backtest runs can feed progression updates through `progressionUpdate` API payloads.
- Intelligence (The Newsroom):
  - `Newsroom` fuses headline tone, signal bias, and social hype into an explicit narrative context.
- Voice Interface (The Audio-Interface):
  - `VoiceInput` bridges browser speech capture to Cortex command processing.
  - Supports manual activation and wake-word-first workflows (`Candle`) for hands-free operation.
- Why: close the loop between strategy design, validation, and market explanation while preserving research-first controls.

## Operating Guardrails
- These systems are research and decision-support features, not implicit live-trading automation.
- Opportunity displays remain subject to slippage/liquidity validation before any real execution design.
