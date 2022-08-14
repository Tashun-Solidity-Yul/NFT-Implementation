// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./utils/UtilContract.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

error OwnerInvalid();


contract BaseContract is UtilContract, Ownable, AccessControl {
    // string  constant internal svgMetaData1 = "<svg version='1.1' xmlns='http://www.w3.org/2000/svg'xmlns:xlink='http://www.w3.org/1999/xlink'viewBox='0 0 3 2'preserveAspectRatio='xMidYMid'><g fill='none' stroke='black' stroke-width='0.02'><circle cx='1' cy='1' r='0.5' fill=";
    // string  constant internal svgMetaData2 = "/><ellipse cx='0.75' cy='0.85' rx='0.05' ry='0.04' fill=";
    // string  constant internal svgMetaData3 = "/><ellipse cx='1.25' cy='0.85' rx='0.05' ry='0.04' fill=";
    // string  constant internal svgMetaData4 = "/><polygon points='1,0.9 1.1,1.1 0.9,1.1' fill=";
    // string  constant internal svgMetaData5 = "/><path d='M0.75,1.25 L1.25,1.25 A0.5,0.5 0 0 1 0.75,1.25' fill=";
    // string  constant internal svgMetaData6 = "/></g></svg>";
    // using Counters for Counters.Counter;
    // Counters.Counter internal tokenId;
    mapping(uint => string) internal colorMapping;
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    using Strings for uint256;
    uint256 private tokenId;
    string constant internal uriBaseLocation = "ipfs://bafybeier7fbra5lubfy53rvhhg56cauamnbn7ktlhkcuqjbwlpwb2xv4dm/";


    function getTokenId() public view returns (uint256) {
        return tokenId;
    }

    function incrementTokenId() internal {
         tokenId++;
    }
    

    // uint finalMappingKey = 0;

    constructor() {
        // colorMapping[0] = "green";
        // colorMapping[1] = "red";
        // colorMapping[2] = "blue";
        // colorMapping[3] = "yellow";
        // colorMapping[4] = "white";
        // finalMappingKey = 4;
        _setRoleAdmin(DEFAULT_ADMIN_ROLE , ADMIN_ROLE );
         _grantRole(ADMIN_ROLE, address(this) );

    }

    // function addColorMapping(string calldata color) internal onlyOwner {
    //     finalMappingKey += 1;
    //     colorMapping[finalMappingKey] = color;
    // } 
    

}
