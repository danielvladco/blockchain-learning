# Smart contracts

### Check contracts for smart contracts examples


Tools/Resources:
- https://solidity-by-example.org/ - Learn solidity concepts by example 
- https://eth-converter.com/ - convert ETH/Wei/Gwei
- https://etherscan.io/ - monitor transactions in the blockchain
- https://faucets.chain.link/rinkeby - fund testnet accounts
- https://remix.ethereum.org/ - In browser IDE for working with smart contracts

Code Examples:
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


### Libraries
Like contracts without state and sending ether
Can also extend native types with custom user defined functions

#### SafeMath
Was used a lot before version 0.8 because the numbers wrap.
In versions 0.8 and above the problem is fixed ant there is no reason to use SafeMath 
If you still want the old behaviour of integers you ca use `uncecked { uint8 a = 255; a = a +1 }`
Unchecked makes the codee more Gas efficient

### Sending funds

Ways to send funds (https://solidity-by-example.org/sending-ether/):
 - transfer - 2300 gas, throws error
 - send - 2300 gas, returns bool
 - call - forward all gas or set gas (!the recommended way!), returns bool (low level way to call any function) can be used like this `(bool callSuccess, ) = call{value: balance}("")`

The address of the sender should be payable address. An address can be casted to payable 

### Modifiers
Wraps a function with some functionality

### error

Example defining an error:
`error NotFound()`

**revert** can revert manually a contract and go back the callstack 
> Similar to throw in java but also reverts the previous actions

### Fallback & Receive
Calldata is a bytes array that usually is populated with the address of the function (is it taken from the ABI)

Special functions:
- `receive() external payable` - Is called whenever a transaction is sent without calldata
- `fallback() external payable` - Is called when calldata is present but no function is defined for the calldata (like a default in a switch statement)
 