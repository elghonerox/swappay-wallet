# API Integration Documentation

## OKX DEX API Overview

SwapPay Wallet integrates the OKX DEX API to facilitate token swaps, price queries, and market data retrieval. This backend proxy server communicates securely with the OKX API using API keys.

## Endpoints Used

- `/tokens`: Fetch supported tokens for swaps.
- `/quote`: Get price quotes for swaps.
- `/swap`: Execute token swap transactions.
- `/price/{tokenAddress}`: Fetch real-time token prices.

## Authentication

API requests to OKX DEX require API key, secret, and passphrase, which are securely stored in environment variables:

- `OKX_API_KEY`
- `OKX_SECRET_KEY`
- `OKX_PASSPHRASE`

## Backend Proxy Server

The backend Express server (`backend/server/api.js`) exposes these endpoints under `/api/okx` and handles rate limiting, CORS, and security headers.

## Frontend Usage

The React frontend uses a service wrapper (`frontend/src/services/okxDexApi.js`) to interact with the backend proxy endpoints.

Example usage in React:

```js
import OKXDexService from '../services/okxDexApi';

const tokens = await OKXDexService.getTokenList();
const quote = await OKXDexService.getQuote({ fromToken, toToken, amount });
const swapResult = await OKXDexService.executeSwap(swapParams);
