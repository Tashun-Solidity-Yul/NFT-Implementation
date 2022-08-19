// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./BaseContract.sol";
import "./ERC20Token.sol";



contract ERC721Token is BaseContract, ERC721URIStorage {
    mapping(address => uint256) public timeLockMap;

    constructor(string memory name_, string memory symbol_) ERC721(name_,symbol_) {
    }

    function supportsInterface(bytes4 interfaceId) public view override(AccessControl, ERC721) returns (bool) {
        return
            interfaceId == type(IAccessControl).interfaceId ||
            interfaceId == type(IERC721).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function mintNewNFTThroughContract(address receiver) external onlyRole(ADMIN_ROLE){
        if (timeLockMap[receiver] > block.timestamp){
            revert ComeBackTomorrow();
        }
        processMint(receiver);

    }

    function processMint(address receiver) private {
        uint256 selectedURIId = getRandomUint256(getTokenId()) % uniqueTokenCount;
        _safeMint(receiver, getTokenId());
        _setTokenURI(getTokenId(), string(abi.encodePacked(uriBaseLocation, Strings.toString(selectedURIId))));
        timeLockMap[receiver] = block.timestamp + secondsForADay;
        incrementTokenId();
    }


    function getRandomUint256(uint256 input) private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, input)));
    }

}
