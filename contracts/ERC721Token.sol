// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./BaseContract.sol";


contract ERC721Token is ERC721URIStorage, BaseContract {

    

    constructor(string memory name_, string memory symbol_) ERC721(name_,symbol_) {
    }


    function mintNewNFT() payable external {
        uint256 selectedURIId = getRandomUint256(getTokenId()) % 10;
        _safeMint(msg.sender, getTokenId());
        _setTokenURI(getTokenId(), string(abi.encodePacked(uriBaseLocation, Strings.toString(selectedURIId))));
         incrementTokenId();

    }


    function getRandomUint256(uint256 input) private view returns (uint) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, input)));
    }
    
       function transferNFTOwnership(address from, address to, uint256 tokenId) private{

       }

}
