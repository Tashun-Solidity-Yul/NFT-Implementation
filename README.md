# Hardhat ERC721 Token based implementation
Implementation of a ERC721 and a ERC20, Able to deposit NFTs and can earn the ERC20 with the time.

Used the following implementations in openzeppelin

1. AccessControl
2. Ownable
3. String Libraries
4. Base64
5. Counters
6. ERC20
7. ERC721URIStorage
8. SafeMath

# How to Deploy the Contracts

 1. Deploy ERC721Token and ERC20Token first and take the contract addresses
 2. Deploy ERC20AuthoritativeToken Using the above contract addresses as Arguments
 3. ERC721Token ERC20Token admin role should be given to the ERC20AuthoritativeToken address
 4. Now a User can Mint ERC20 Tokens then can mint ERC721 tokens

NOTE: User Should be given the contract sufficient mint fee as the allowance Before minting the NFT  

Test Data ->
```
https://testnets.opensea.io/assets/rinkeby/0xd516584af3b353e3ef2800cbe997be20aaf458b2/0

https://rinkeby.etherscan.io/address/0x90a71747814b2de1d1250051f5eed171aa365df9#code
https://rinkeby.etherscan.io/address/0xd516584af3b353e3ef2800cbe997be20aaf458b2#code
https://rinkeby.etherscan.io/address/0x53c10175cff64a3b88c0c769432cebfaab709779
```


Authoritative Token
https://rinkeby.etherscan.io/address/0xd3fb7be89b882949e7c8bd5fd395383e4c4969c6#readContract

ERC20 Token
https://rinkeby.etherscan.io/address/0xbbb44a8f8097fec8ec91749dcc8f76137d8374b2#readContract

ERC721 Token
https://rinkeby.etherscan.io/address/0x50987b4046e4e5521a8f88e4526022ba1ced6da4#readContract

Minted NFT
https://testnets.opensea.io/assets/rinkeby/0x50987b4046e4e5521a8f88e4526022ba1ced6da4/0