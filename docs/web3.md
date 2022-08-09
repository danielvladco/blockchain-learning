# Web 3
Interact with blockchains from codebase.

Examples:
- deploy/deploy.js - deploy a smart contract using ethers
- deploy/deploy-raw.js - alternatively deploy smart contract using a low level transaction


Tools/Resources:
- https://docs.ethers.io/ - Interact with blockchain using a js library, allows to deploy smart contracts and create transactions in the blockchain
- https://www.alchemy.com/ - Node as a service
- https://hardhat.org/ - A framework for easily building, compiling and testing smart contracts using fake networks

### Ethers API

`wallet.enrypt()` - Encrypt a private key, so it can be decrypted only using a password
`wallet.fromEncryptedJson()` - Create a wallet from an encrypted json
`wallet.connect()` - Connect to a provider
`ethers.getContractAt("ABI", "0xaddress")` - Get a contract by address

### Connect to a blockchain
- Run a `geth` node locally and connect to it
- Use a third party provider (node as a service) such as Alchemy - https://www.alchemy.com/

### Alchemy
- Provides tools for monitoring the transactions (successfully/unsuccessful) 
- See the mempool (Pending tab) - You can debug why a transaction is not going through (for example having too low gas fee)


### Verify & Publish using Etherscan
To verify & publish you can go to etherscan.io click on the contract address and go to `Contract` tab then click `verify & publish`
Now everyone can read the code for the contract !
>This can be useful for getting the `abi` if you have the code

Interact with the published contract:
- Read Contract - This tab has all the read methods from a contract
- Write Contract - This tab has all the write methods for the contract

>Hardhat allows to verify programatically 

### Hardhat
- Deploy with the `--network` flag allows to deploy in the specified network, the networks are configured in `hardhat.config.ts`  
- Can att tasks to the hardhat CLI. Most of the time will use scripts
- MainNet forking - Copy the mainnet in the local machine and work with it locally
  - Pros: Quick, easy, close to the original env
  - Cons: Need an API? some contracts are hard to work with