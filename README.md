SwapPay Wallet Backend
The backend for SwapPay Wallet, built for the OKX ETHCC Hackathon 2025, provides the smart contract and server infrastructure for a non-custodial DeFi wallet on the XLayer testnet (chain ID 195). It integrates with the OKX DEX API for token swaps, with the frontend hosted in a separate repository: swappay-frontend.
Features

Smart Contract: Executes token swaps on XLayer testnet with audited, non-custodial design.
Security: On-chain transaction verification, private keys remain on user devices, end-to-end encryption.
Backend Server: Proxies OKX DEX API calls for secure and optimized token swap quotes.
Deployment: Smart contract deployed at 0x354b0DD7cD380542a462505296871f1F1954f325.

Repository Structure

assets/: Images like architecture-diagram.png and logo.png.
backend/: Smart contract (SwapPayWallet.sol), Hardhat config, deployment scripts (deploy.js, verify.js), server files (api.js, middleware.js, okxProxy.js), and tests (SwapPayWallet.test.js).
docs/: Documentation for API integration, deployment, and security (API_INTEGRATION.md, DEPLOYMENT.md, SECURITY.md).
demo-video-script.md: Voice-over script for the demo video.

Setup

Clone the Repository:git clone https://github.com/elghonerox/swappay-wallet


Install Dependencies:cd backend
npm install


Configure Environment:
Copy backend/.env.example to backend/.env and add your OKX DEX API credentials:OKX_BASE_URL=https://web3.okx.com
OKX_API_KEY=your-api-key
OKX_SECRET_KEY=your-secret-key
OKX_PASSPHRASE=your-passphrase




Deploy Smart Contract:
Configure backend/hardhat.config.js with XLayer testnet RPC (https://testrpc.xlayer.network).
Deploy:cd backend
npx hardhat run scripts/deploy.js --network xlayer




Run Backend Server (if applicable):
Start the server for OKX DEX API proxying:cd backend/server
node api.js





Smart Contract

Address: 0x354b0DD7cD380542a462505296871f1F1954f325
Network: XLayer testnet (chain ID 195)
Explorer: OKLink Explorer
Source: backend/contracts/SwapPayWallet.sol

Testing

Run contract tests:cd backend
npx hardhat test


Tests are in backend/test/SwapPayWallet.test.js.

Deployment

The smart contract is deployed on XLayer testnet.
The backend server (if used) can be deployed on Vercel or another platform. See docs/DEPLOYMENT.md for details.

Frontend

The frontend, built with React and OKX DEX API integration, is in a separate repository: swappay-frontend.
Deployed on Vercel: https://swappay-vercel.vercel.app.

Hackathon Submission
This repository is part of the OKX ETHCC Hackathon 2025 submission. The demo video and full details are available via DoraHacks, showcasing OKX DEX API integration, XLayer testnet compatibility, and security features.
License
MIT License
