const express = require('express');
const axios = require('axios');
const router = express.Router();

const OKX_API_KEY = process.env.OKX_API_KEY;
const OKX_SECRET_KEY = process.env.OKX_SECRET_KEY;
const OKX_PASSPHRASE = process.env.OKX_PASSPHRASE;
const OKX_BASE_URL = process.env.OKX_BASE_URL || 'https://www.okx.com';

function getAuthHeaders() {
  // TODO: Implement OKX API authentication headers if needed
  return {};
}

router.get('/tokens', async (req, res) => {
  try {
    const response = await axios.get(`${OKX_BASE_URL}/api/v5/asset/currencies`, {
      headers: getAuthHeaders()
    });
    res.json(response.data);
  } catch (error) {
    console.error('Error fetching tokens:', error.message);
    res.status(500).json({ error: 'Failed to fetch tokens' });
  }
});

router.get('/quote', async (req, res) => {
  try {
    const params = req.query;
    const response = await axios.get(`${OKX_BASE_URL}/api/v5/asset/quote`, {
      params,
      headers: getAuthHeaders()
    });
    res.json(response.data);
  } catch (error) {
    console.error('Error fetching quote:', error.message);
    res.status(500).json({ error: 'Failed to fetch quote' });
  }
});

router.post('/swap', async (req, res) => {
  try {
    const swapParams = req.body;
    // Proxy the swap request to OKX DEX API
    const response = await axios.post(`${OKX_BASE_URL}/api/v5/trade/swap`, swapParams, {
      headers: getAuthHeaders()
    });
    res.json(response.data);
  } catch (error) {
    console.error('Error executing swap:', error.message);
    res.status(500).json({ error: 'Swap failed' });
  }
});

router.get('/price/:tokenAddress', async (req, res) => {
  try {
    const tokenAddress = req.params.tokenAddress;
    const response = await axios.get(`${OKX_BASE_URL}/api/v5/market/ticker`, {
      params: { instId: tokenAddress },
      headers: getAuthHeaders()
    });
    res.json(response.data);
  } catch (error) {
    console.error('Error fetching token price:', error.message);
    res.status(500).json({ error: 'Failed to fetch token price' });
  }
});

module.exports = router;
