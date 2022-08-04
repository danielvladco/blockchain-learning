const ethers = require("ethers")
const fs = require("fs-extra")

async function main() {
    // TODO: Deploy the server with Ganache!
    const provider = ethers.providers.JsonRpcProvider("http://0.0.0.0:8545");
    const wallet = new ethers.Wallet("private_key", provider);

    const abi = fs.readFileSync("../artifacts/contracts_FundMe_sol_FundMe.abi", "utf8")
    const binary = fs.readFileSync("../artifacts/contracts_FundMe_sol_FundMe.bin", "utf8")
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
    const contract = await contractFactory.deploy({
        // gasPrice: 20000
    })

    // gets the receipt
    const transactionReceipt = await contract.deployTransaction.wait(1);

    // gets the deployTransaction
    const deployTransaction = contract.deployTransaction
}

main()
    .then(() => process.exit(0))
    .catch(err => {
        console.error(err)
        process.exit(1)
    })