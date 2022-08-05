const {Wallet, ContractFactory, providers: {JsonRpcProvider}} = require("ethers")
const fs = require("fs-extra")
require("dotenv").config()

async function main() {
    // Deploy the Ganache server!
    const provider = new JsonRpcProvider(process.env.BLOCKCHAIN_SERVER);
    const wallet = new Wallet(process.env.PRIVATE_KEY, provider);

    const abi = fs.readFileSync("./artifacts/contracts_SimpleStorage_sol_SimpleStorage.abi", "utf8")
    const binary = fs.readFileSync("./artifacts/contracts_SimpleStorage_sol_SimpleStorage.bin", "utf8")
    const contractFactory = new ContractFactory(abi, binary, wallet);
    // See: https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory
    const contract = await contractFactory.deploy({
        // gasPrice: 20000
    })

    // gets the receipt
    const transactionReceipt = await contract.deployTransaction.wait(1);

    // gets the deployTransaction
    // const deployTransaction = contract.deployTransaction
    const name = await contract.name()
    console.log("name: ", name)
    const txRes = await contract.store("test")
    await txRes.wait(1)
    const name1 = await contract.name()
    console.log("name: ", name1)
}

main()
    .then(() => process.exit(0))
    .catch(err => {
        console.error(err)
        process.exit(1)
    })