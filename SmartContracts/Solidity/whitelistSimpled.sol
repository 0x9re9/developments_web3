// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
* @title Simple Whitelist
* @author 0x9re9
* @notice Contract for simple whitelist address
* @notice You can add address 1 time
*/
contract WhitelistSimpled {

    /// @dev Structure
    struct WhiteList {
        bool isWhitelist;
    }

    /// @dev Mapping
    mapping (address => WhiteList) whiteLists;


    /**
    * @dev Add whitelist address
    */
    function addWhitelist(address _addr) external {
        require(whiteLists[_addr].isWhitelist != true, 'Already whitelisted');
        whiteLists[_addr].isWhitelist = true;
    }

    /**
    * @dev Get status of address
    */
    function getStatus(address _addr) external view returns (WhiteList memory) {
        return whiteLists[_addr];
    }

}