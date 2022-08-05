import { ethers, run, network } from "hardhat";

async function main() {
  const SimpleStorage = await ethers.getContractFactory("SimpleStorage");
  const simpleStorage = await SimpleStorage.deploy();

  await simpleStorage.deployed();
  console.log("Deployed to:", simpleStorage.address);
  if (network.config.chainId === 4 && process.env.ETHERSCAN_API_KEY) { // Check if the network is rinkeby (questionable method but for the test sake will suffice)
    console.log("Verifying contract:");
    await simpleStorage.deployTransaction.wait(6)
    await verify(simpleStorage.address, [])
  }

  console.log("Contract verified");

  // test if the deployed contract works!
  const name = await simpleStorage.name()
  console.log("name: ", name)
  const txRes = await simpleStorage.store("test")
  await txRes.wait(1)
  const name1 = await simpleStorage.name()
  console.log("name: ", name1)
}

async function verify(contractAddress: string, args: any) {
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args
    })
  } catch (e: any) {
    if (e.message.toLowerCase().includes("already verified")) { // Pretty bat implementation butt for testing is ok
      console.log("Already verified!")
    } else {
      console.error(e)
    }
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
