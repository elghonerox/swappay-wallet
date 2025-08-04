require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.20",
      },
    ],
  },
  networks: {
    xlayer_testnet_195: {
      url: process.env.XLAYER_RPC_URL || "https://testrpc.xlayer.tech",
      chainId: 195,
      accounts: [process.env.PRIVATE_KEY].filter(Boolean),
    },
  },
};
