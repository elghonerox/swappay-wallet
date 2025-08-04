const hre = require("hardhat");

async function main() {
  console.log("Deploying SwapPayWallet contract...");

  const SwapPayWallet = await hre.ethers.getContractFactory("SwapPayWallet");
  const swapPayWallet = await SwapPayWallet.deploy();

  // Wait for the contract to be deployed
  await swapPayWallet.waitForDeployment();

  console.log("SwapPayWallet deployed to:", await swapPayWallet.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });