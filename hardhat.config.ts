import {HardhatUserConfig} from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-etherscan";
import "dotenv/config"
import "./tasks/block-number"

const config: HardhatUserConfig = {
    defaultNetwork: "hardhat",
    networks: {
        // hardhat: {
        //     forking: {
        //         url: "" // address of the mainnet
        // will also have hake mainnet accounts
        //     }
        // },
        rinkeby: {
            url: process.env.RPC_URL!,
            accounts: [process.env.PRIVATE_KEY!],
            chainId: 4,
        }
    },
    solidity: "0.8.12",
    etherscan: {
        apiKey: process.env.ETHERSCAN_API_KEY!
    }
};

export default config;
