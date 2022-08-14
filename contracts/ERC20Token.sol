// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./BaseContract.sol";

contract ERC20Token is ERC20, BaseContract  {
    constructor(uint256 initialSupply) ERC20("test","test") {
        _mint(address(this), initialSupply);
    }

     function SellBack(uint256 amount) external {
        uint contractTokenBalance = balanceOf(msg.sender);
        if (contractTokenBalance >= amount) {
            _transfer(msg.sender, address(this), amount);
        } else{
            revert InSufficientTokens();
        }
        if (amount >= minimumTransfer) {
//            if the amount is met the minimum amount user is eligible for th reward
            uint rewardFactor = amount / minimumTransfer;
//            reward factor will be x factor floor value of the minimum transfer
            uint payBack = (oneEtherInWei * rewardFactor) / 2;
//            fraction of payBackShareDenominator is payed for the user as a reward depending on the reward factor
            if (address(this).balance > payBack) {
//                if the reward is possible to pay, user will be paid
                bool success = payUserEther(payBack);
                if (!success) {
                    revert InSufficientFunds();
                }
            } else {
                revert InSufficientFunds();
            }
        }
    }

    function BuyBack(uint256 amount) external payable  {
        checkSufficientFunds(false, pricePerOneToken * amount);
        uint contractTokenBalance = balanceOf(address(this));
//        check if there are tokens in the contract
        if (contractTokenBalance >= amount) {
            _transfer(address(this), msg.sender, amount);
        } else {
            revert InSufficientTokens();
        }
    }

    function mintExtraTokens(uint256 adddingSupply)external onlyRole(ADMIN_ROLE) {
         _mint(msg.sender, adddingSupply);
    }





}
