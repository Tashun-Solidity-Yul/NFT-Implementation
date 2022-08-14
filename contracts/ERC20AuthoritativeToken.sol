// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "./ERC721Token.sol";
import "hardhat/console.sol";

error OperatorError();

contract ERC20AuthoritativeToken is IERC721Receiver {
    ERC721Token nftContract;
    mapping(uint256 => address) originalOwners;


    constructor(ERC721Token _address){
        nftContract = _address;
    }

     function onERC721Received( address operator, address from, uint256 tokenId, bytes calldata data ) public override returns (bytes4) {
            originalOwners[tokenId]=from;
            return this.onERC721Received.selector;
        }

    function depositNFT(uint256 tokenId) external {
        nftContract.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    function withdrawNFT(uint256 tokenId) external {
        nftContract.safeTransferFrom(address(this), msg.sender, tokenId);
    }


}
