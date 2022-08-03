# Smart contracts

### Check contracts for smart contracts examples

Examples:
 - SimpleStorage.sol - Is a simple example showing that you can store data in the blockchain storage
 - StorageFactory.sol - Is a simple example showing how you can deploy other contracts using a contract
 - ExtraStorage.sol - Demonstrates inheritance and abstractization
 - FundMe.sol - Send money and payable functions

Some concepts:
- After a require function fails, revert all the actions before and sends the remaining gas back.
  
  It will actually spend gas for the actions before require but not for the actions after.
- Smart contracts are unable to connect with external systems, data feeds, APIs, external payment systems, etc.
- Blockchain is a deterministic system

Oracles:
- Any device that interacts with the outside world to provide data or computation to smart contracts
- Chainlink is a oracltee - it is decentralized - creates hybrid smart contracts with on chain and off chain apps to create feature rich apps
- We dont want to get all data through centralized nodes
- The oracle nodes gets data from exchanges and service providers and bring that data to decentralized chainlink nodes
- Data gets updated once in a period of time

Chainlink: (https://docs.chain.link/ethereum/)
- Data feeds / price feeds - ways of getting pieces of data from real world that is already aggregated and decentralized
- VRF - random number generator
- Keepers - Listen to certain events
- Make requests to external resources
  - makes two transactions - one for request and the other for response
- Requesting data from a chain link we are required to pay oracle gas (link token)
- You can import contracts or contract interfaces (or ABI) from NPM package manager which is created from the GitHub repo (https://github.com/smartcontractkit/chainlink)   

Useful Tools:
- https://eth-converter.com/ - convert ETH/Wei/Gwei
- https://etherscan.io/ - monitor transactions in the blockchain
- https://faucets.chain.link/rinkeby - fund testnet accounts
- https://remix.ethereum.org/ - In browser IDE for working with smart contracts
