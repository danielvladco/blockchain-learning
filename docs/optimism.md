# Optimism

A L2 Ethereum network

Uses Optimistic Rollup Protocol - Blockchain that piggybacks off of the security of another "parent" blockchain. Take advantage of the consensus mechanism (like PoW or PoS) of their parent chain

Uses data on Chain and Computation off chain
Is a network on top of a network

Advantages:
- Transaction speed
- Lower cost (ex: A tx that takes $70 on MainNet will only take $5 on Optimism)

Get started:
- Connect MetaMask: https://chainid.link/?network=optimism
- Deposit Ethereum based tokens from Ethereum MainNet across to Optimistic Ethereum

Pros:
- Use existing battle-tested Ethereum code and infrastructure where possible
- Geth as Optimism's client software.
- Optimism is developed iteratively and strives to continuously pull feedback from users
- Optimism looks like a standalone blockchain - designed as an extension to Ethereum
- Optimism is as close to Ethereum as possible
- `CanonicalTransactionChain` - Smart contract that stores optimism blocks in an append only list. Includes code that guarantees that the existing list of blocks cannot be modified
- `sequencer` - ???
  - Providing instant transaction confirmations and state updates. 
  - Constructing and executing L2 blocks. 
  - Submitting user transactions to L1
  - No mempool - Immediately accepted or rejected if the transaction is valid (i.e. pays a sufficient fee)
  - Periodically submits large batches of blocks to Ethereum
  - Cost reduction happens by spreading fixed costs over all transactions for a batch
  - Sequencer applies some basic compression techniques
  - Sequencer can provide a strong guarantee of what state will be finalized
    - Instant user experience
    - Near-real-time Uniswap price updates.
  - Users can skip the sequencer entirely and submit their transactions directly to the CanonicalTransactionChain via an Ethereum transaction
    - Resist censorship
    - Higher tx cost
- The only block producer is run by Optimism meaning it is not truly decentralized. However, there are plans to improve the protocol.
