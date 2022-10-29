// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
* @title CheckAddress
* @author 0x9re9
* @notice Contract for checking type addresss : smart contract address or user address (EOA)
*/
contract CheckAddress {

    address public addressOwner = msg.sender;
    address public addressContract = address(this);

    function checkAddress(address _address) public view returns (string memory) {
        uint length;
        assembly {
            length:= extcodesize(_address)
        }
        if (length>0) {
            return "This is a smart contract address !";
        }
        return "This is an user address !";
    }

}