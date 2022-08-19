// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "./ERC721Token.sol";
import "./ERC20Token.sol";



error OperatorError();

contract ERC20AuthoritativeToken is IERC721Receiver, BaseContract {
    ERC721Token private nftContract;
    ERC20Token private ftContract;
    mapping(uint256 => address) private originalOwners;
    mapping(uint256 => uint256) private stakedTime;


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
        // Check if there is sufficient Amount
        if (ftContract.balanceOf(msg.sender) < nftPriceWithoutDecimals * 10 ** ftContract.decimals())
        {
            revert InSufficientFunds();
        }
        ftContract.transferFrom(msg.sender,address(this), nftPriceWithoutDecimals * 10 ** ftContract.decimals());
        nftContract.mintNewNFTThroughContract(msg.sender);
    }

    function sellFungibleTokens() external payable {
        // dust is taken by the contract
        uint256 eligibleTokens = msg.value / pricePerOneToken;
        // If authoritative token has enough supply it will transfer
        if (ftContract.balanceOf(address(this)) > eligibleTokens * 10 ** ftContract.decimals())
        {
            ftContract.transferFrom(msg.sender, address(this), nftPriceWithoutDecimals * 10 ** ftContract.decimals());
        }
        else
        {
            ftContract.transferUserNewlyCreatedTokens(msg.sender, eligibleTokens);
        }
    }

    function withdrawReward(uint256 tokenId) public {
        if (stakedTime[tokenId]==0)
        {
            revert TokenNotDeposited();
        }
        uint256 countToken = stakedTime[tokenId] % secondsForADay;
        ftContract.transferUserNewlyCreatedTokens(msg.sender, countToken * rewardPerDay);
        stakedTime[tokenId] = stakedTime[tokenId] + secondsForADay * countToken;
    }

    function getFundsToOwnersAccount() external onlyOwner {
        if (address(this).balance > 0)
        {
            payable(msg.sender).transfer(address(this).balance);
        }
    }
    function addFundsToContract() external payable {

    }
    


}
