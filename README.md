# Decentralized Perpetual Exchange Core

This repository provides an expert-level blueprint for a decentralized perpetual futures exchange. It utilizes a Virtual AMM (vAMM) architecture to provide liquidity and price discovery for synthetic assets with up to 10x leverage.

### Key Features
* **vAMM Pricing:** Uses the constant product formula ($x \times y = k$) to determine entry and exit prices without requiring real liquidity providers in the pool.
* **Margin Management:** Handles collateral deposits, maintenance margin checks, and liquidation triggers.
* **Funding Rates:** Implements a periodic funding mechanism to align the market price with the underlying index price.
* **Liquidations:** Automated logic to close underwater positions and distribute penalties to the insurance fund.

### Technical Components
* **ClearingHouse.sol:** The central hub managing user positions and collateral.
* **VirtualAMM.sol:** The pricing engine that tracks virtual reserves.
* **InsuranceFund.sol:** A safety buffer to cover protocol deficits during volatile market conditions.
