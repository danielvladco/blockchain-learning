const {Wallet, ContractFactory, providers: {JsonRpcProvider}} = require("ethers")
const fs = require("fs-extra")

async function main() {
    // Deploy the Ganache server!
    const provider = new JsonRpcProvider("http://127.0.0.1:7545");
    const wallet = new Wallet("c59d3c5f894b084f84dd85ad380e620c2071deac79f63866e7bd1df1d8490187", provider);

    const abi = fs.readFileSync("../artifacts/contracts_FundMe_sol_FundMe.abi", "utf8")
    const binary = fs.readFileSync("../artifacts/contracts_FundMe_sol_FundMe.bin", "utf8")
    const contractFactory = new ContractFactory(abi, binary, wallet);
    // See: https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory
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