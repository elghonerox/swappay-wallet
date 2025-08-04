const { run } = require("hardhat");

async function main() {
  try {
    const contractAddress = process.argv[2];
    if (!contractAddress) {
      console.error("Please provide the contract address as an argument.");
      process.exit(1);
    }

    console.log("Verifying contract at:", contractAddress);

    await run("verify:verify", {
      address: contractAddress,
    });

    console.log("Verification successful!");
  } catch (error) {
    if (error.message.toLowerCase().includes("already verified")) {
      console.log("Contract already verified.");
    } else {
      console.error("Verification failed:", error);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
