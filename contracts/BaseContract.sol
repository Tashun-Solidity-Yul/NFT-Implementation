// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./utils/UtilContract.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


contract BaseContract is UtilContract, Ownable, AccessControl {
    using Strings for uint256;
    mapping(uint256 => string) internal colorMapping;
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    uint256 private tokenId;
    string constant internal uriBaseLocation = "ipfs://bafybeier7fbra5lubfy53rvhhg56cauamnbn7ktlhkcuqjbwlpwb2xv4dm/";


    function getTokenId() public view returns (uint256) {
        return tokenId;
    }

    function incrementTokenId() internal {
        tokenId++;
    }

    // For Every Contract Admin role is granted to the Deployer
    constructor() {
        _setRoleAdmin(ADMIN_ROLE, ADMIN_ROLE);
        _grantRole(ADMIN_ROLE, msg.sender);

    }


}
