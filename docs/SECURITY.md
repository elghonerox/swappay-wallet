Security Features of SwapPay Wallet Backend
This document outlines the security measures implemented in the SwapPay Wallet backend, built for the OKX ETHCC Hackathon 2025, ensuring a secure non-custodial DeFi wallet on the XLayer testnet (chain ID 195).
Non-Custodial Design

User Control: Private keys remain on the user’s device (via MetaMask), with no access by the backend or smart contract.
Decentralized: The wallet operates on XLayer testnet, leveraging blockchain for trustless operations.

Smart Contract Security

Audited Contract: SwapPayWallet.sol (deployed at 0x354b0DD7cD380542a462505296871f1F1954f325) is audited for vulnerabilities, with tests in backend/test/SwapPayWallet.test.js.
On-Chain Verification: Transactions are verified on-chain via XLayer testnet, ensuring transparency.
Open-Source: Contract source is available in backend/contracts/SwapPayWallet.sol and verifiable on OKLink Explorer.

Backend Server Security (if applicable)

End-to-End Encryption: API calls to OKX DEX (https://web3.okx.com) use HTTPS and secure headers (configured in backend/server/middleware.js).
API Key Protection: OKX DEX API credentials are stored in environment variables (backend/.env), not hardcoded.
Rate Limiting: Implemented in backend/server/middleware.js to prevent abuse.

OKX DEX Integration

Best Price Aggregation: Uses OKX DEX API (/api/v5/dex/aggregator/quote) for optimal swap pricing.
Low Slippage: Configured to minimize price impact during swaps.
MEV Protection: Leverages OKX DEX’s anti-MEV mechanisms.
Gas Optimization: Smart contract and API calls are optimized for low gas costs on XLayer testnet.

Testing and Validation

Unit Tests: backend/test/SwapPayWallet.test.js covers swap execution and edge cases.
Network: XLayer testnet (RPC: https://testrpc.xlayer.network) ensures secure and reliable transactions.

Reporting Issues

If you discover security vulnerabilities, contact the team via the hackathon’s Discord or GitHub Issues.
Responsible disclosure is appreciated to maintain the integrity of the wallet.
