const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SwapPayWallet", function () {
  let SwapPayWallet, wallet, owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    SwapPayWallet = await ethers.getContractFactory("SwapPayWallet");
    wallet = await SwapPayWallet.deploy();
    await wallet.deployed();
  });

  it("should allow owner to add and remove authorized callers", async function () {
    await wallet.addAuthorizedCaller(addr1.address);
    expect(await wallet.authorizedCallers(addr1.address)).to.equal(true);

    await wallet.removeAuthorizedCaller(addr1.address);
    expect(await wallet.authorizedCallers(addr1.address)).to.equal(false);
  });

  it("should execute swap with proper params", async function () {
    const tokenIn = "0x0000000000000000000000000000000000000001";
    const tokenOut = "0x0000000000000000000000000000000000000002";

    // Mint tokens and approve SwapPayWallet (mock tokens needed in real test)

    // Skipping actual ERC20 interaction here for brevity
    // Just test event emission on swap execution with mock params

    await wallet.addAuthorizedCaller(owner.address);

    await expect(
      wallet.executeSwap({
        tokenIn,
        tokenOut,
        amountIn: 100,
        minAmountOut: 90,
        recipient: addr1.address,
        deadline: Math.floor(Date.now() / 1000) + 3600,
      })
    ).to.emit(wallet, "SwapExecuted");
  });
});
