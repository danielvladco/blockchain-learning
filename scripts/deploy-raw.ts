import {providers, Wallet} from "ethers"
import {readFileSync} from "fs-extra"
import "dotenv/config"

async function main() {
    // Deploy the Ganache server!
    const provider = new providers.JsonRpcProvider(process.env.RPC_URL!);
    const wallet = new Wallet(process.env.PRIVATE_KEY!, provider);
    const binary = readFileSync("./artifacts/contracts_SimpleStorage_sol_SimpleStorage.bin", "utf8")

    const nonce = await wallet.getTransactionCount()
    const sentTxRes = await wallet.sendTransaction({
        nonce,
        gasPrice: 20000000000,
        gasLimit: 6721975,
        value: 0,
        data: `0x${binary}`,
        chainId: 1337, // Chain ID is different from network id for some reason 5777,
    })
    const transactionReceipt = await sentTxRes.wait(1) // wait for a number of blocks to be confirmed
    console.log(transactionReceipt)
}

main()
    .then(() => process.exit(0))
    .catch(err => {
        console.error(err)
        process.exit(1)
    })