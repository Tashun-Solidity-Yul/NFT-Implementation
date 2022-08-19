// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

    error Unauthorized();
    error InvalidInputDetected();
    error InSufficientFunds();
    error InSufficientTokens();
    error AddressBlacklisted();
    error DataIsImmutable();
    error SaleIsOver();
    error ComeBackTomorrow();
    error TokenNotDeposited();



contract UtilContract {
    uint256 immutable payBackShareDenominator = 2;
    uint256 immutable secondsForADay = 24 * 60 *60;
    uint256 immutable tokenFeePerMint = 10;
    uint256 immutable rewardPerDay = 10;
    uint256 immutable uniqueTokenCount = 10;
    uint256 immutable oneEtherInWei = 1 * 10 ** 18;
    uint256 immutable minimumTransfer = 1_000 * 10 **18;
    uint256 immutable pricePerOneToken = 1_000_000_000_000_000;
    uint256 immutable initialSalesSupply = 10_000_000 * 10**18;
    uint256 immutable payBackFactor = 0.5 ether;
    uint256 immutable nftPriceWithoutDecimals = 10;
    mapping(address => bool) internal blacklistMap;

    function checkSufficientFunds(uint256 fundLimit) internal view {
        if (msg.value < fundLimit) {
            revert InSufficientFunds();
        }
    }

    function validateAddress(address validatingAddress) internal pure {
         if (validatingAddress != address(0)) {
           revert InvalidInputDetected();
       }
    }

    function payUserEther(uint256 returningEther) internal returns (bool success){
        success = false;
        if (returningEther > 0 && returningEther < type(uint256).max) {
                (success,) = (msg.sender).call{value: returningEther}("");
        }
    }
}