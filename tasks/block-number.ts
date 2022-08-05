import {task} from "hardhat/config"

// add custom functionality to hardhat cli
task("block-nr", "Prints the current block number")
    .setAction(async (taskArgs, hre) => {
        console.log("Current block number: ", await hre.ethers.provider.getBlockNumber())
    })