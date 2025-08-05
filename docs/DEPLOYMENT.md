Deployment Guide for SwapPay Wallet Backend
This document outlines the steps to deploy the SwapPay Wallet backend, including the smart contract on the XLayer testnet (chain ID 195) and the backend server (if used) for OKX DEX API integration. This is part of the OKX ETHCC Hackathon 2025 submission.
Prerequisites

Node.js: Version 16 or higher.
Hardhat: For smart contract compilation and deployment.
MetaMask: Configured with an XLayer testnet account and testnet ETH.
OKX DEX API Credentials: Obtain API key, secret key, and passphrase from the OKX developer portal.
Vercel Account (optional): For deploying the backend server, if used.

Smart Contract Deployment

Clone the Repository:
git clone https://github.com/elghonerox/swappay-wallet
cd swappay-wallet


Install Dependencies:
cd backend
npm install


Configure Environment:

Copy backend/.env.example to backend/.env:cp backend/.env.example backend/.env


Add your OKX DEX API credentials and XLayer testnet private key:OKX_BASE_URL=https://web3.okx.com
OKX_API_KEY=your-api-key
OKX_SECRET_KEY=your-secret-key
OKX_PASSPHRASE=your-passphrase
XLAYER_PRIVATE_KEY=your-metamask-private-key




Configure Hardhat:

Edit backend/hardhat.config.js to include XLayer testnet:module.exports = {
  solidity: "0.8.20",
  networks: {
    xlayer: {
      url: "https://testrpc.xlayer.network",
      chainId: 195,
      accounts: [process.env.XLAYER_PRIVATE_KEY]
    }
  }
};




Compile the Smart Contract:

Run:cd backend
npx hardhat compile




Deploy the Smart Contract:

Deploy SwapPayWallet.sol to XLayer testnet:npx hardhat run scripts/deploy.js --network xlayer


Note the deployed contract address (e.g., 0x354b0DD7cD380542a462505296871f1F1954f325).


Verify the Contract:

Verify on OKLink explorer:npx hardhat run scripts/verify.js --network xlayer


Check: OKLink Explorer.



Backend Server Deployment (Optional)
If using the backend server (backend/server/api.js, middleware.js, okxProxy.js) for OKX DEX API proxying:

Configure Vercel:

Create a vercel.json in backend/:{
  "version": 2,
  "builds": [
    {
      "src": "server/api.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "server/api.js"
    }
  ]
}


Add to Git:git add backend/vercel.json
git commit -m "Add vercel.json for backend server"




Deploy to Vercel:

Install Vercel CLI:npm install -g vercel


Deploy:cd backend
vercel --prod


Add environment variables in Vercel dashboard:OKX_BASE_URL=https://web3.okx.com
OKX_API_KEY=your-api-key
OKX_SECRET_KEY=your-secret-key
OKX_PASSPHRASE=your-passphrase




Test the Server:

Access the deployed server URL (e.g., https://swappay-wallet-backend.vercel.app).
Ensure it proxies OKX DEX API calls (e.g., /api/v5/dex/aggregator/quote).



Integration with Frontend

The frontend is in a separate repository: swappay-frontend.
Update the frontend’s index.tsx to use the deployed contract address (0x354b0DD7cD380542a462505296871f1F1954f325) and backend server URL (if applicable).

Verification

Smart Contract: Check OKLink Explorer.
Backend Server: Test API endpoints with tools like Postman.
Frontend: Deployed at https://swappay-vercel.vercel.app.
