# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
GAS_REPORT=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
# How to Deploy the Contracts

 1. Deploy ERC721Token and ERC20Token first and take the contract addresses
 2. Deploy ERC20AuthoritativeToken Using the above contract addresses as Arguments
 3. ERC721Token ERC20Token admin role should be given to the ERC20AuthoritativeToken address
 4. Now a User can Mint ERC20 Tokens then can mint ERC721 tokens

NOTE: User Should be given the contract sufficient mint fee as the allowance Before minting the NFT  

Test Data ->
https://testnets.opensea.io/assets/rinkeby/0xd516584af3b353e3ef2800cbe997be20aaf458b2/0

https://rinkeby.etherscan.io/address/0x90a71747814b2de1d1250051f5eed171aa365df9#code
https://rinkeby.etherscan.io/address/0xd516584af3b353e3ef2800cbe997be20aaf458b2#code
https://rinkeby.etherscan.io/address/0x53c10175cff64a3b88c0c769432cebfaab709779