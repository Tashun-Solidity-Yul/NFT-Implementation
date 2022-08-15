// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "./ERC721Token.sol";
import "./ERC20Token.sol";



error OperatorError();

contract ERC20AuthoritativeToken is IERC721Receiver, BaseContract {
    ERC721Token nftContract;
    ERC20Token ftContract;
    mapping(uint256 => address) originalOwners;
    mapping(uint256 => uint) stakedTime;


    constructor(ERC721Token _ERC721TokenAddress, ERC20Token _ERC20TokenAddress) {
        nftContract = _ERC721TokenAddress;
        ftContract = _ERC20TokenAddress;
    }

     function onERC721Received( address operator, address from, uint256 tokenId, bytes calldata data ) public override returns (bytes4) {
            originalOwners[tokenId]=from;
            return this.onERC721Received.selector;
        }

    function depositNFT(uint256 tokenId) external {
        nftContract.safeTransferFrom(msg.sender, address(this), tokenId);
        stakedTime[tokenId] = block.timestamp;
    }

    function withdrawNFT(uint256 tokenId) external {
        nftContract.safeTransferFrom(address(this), msg.sender, tokenId);
        withdrawReward(tokenId);
        stakedTime[tokenId] = 0;
    }

    function mintNFT() external {
        if (ftContract.balanceOf(msg.sender) < 10) {
            revert InSufficientFunds();
        }
        ftContract.transferFrom(msg.sender,address(this),10);
        nftContract.mintNewNFTThroughContract(msg.sender);
    }

    function mintExtraFungibleTokens() external onlyOwner {
       ftContract.mintExtraTokens(1000);
    }

    function mintExtraFungibleTokens(uint256 tokenCount) external payable {
      checkSufficientFunds(false, pricePerOneToken * tokenCount);
      ftContract.tranferUserNewlyCreatedTokens(msg.sender,tokenCount);
       
    }

    function withdrawReward(uint256 tokenId) public {
        if (stakedTime[tokenId]==0) {
            revert TokenNotDeposited();
        }
        uint256 countToken = stakedTime[tokenId] % secondsForADay;
        ftContract.tranferUserNewlyCreatedTokens(msg.sender, countToken * rewardPerDay);
        stakedTime[tokenId] = block.timestamp;
    }
    


}
