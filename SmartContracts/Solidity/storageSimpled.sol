// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
* @title Simple Storage
* @author 0x9re9
* @notice Contract for simple storage value storageData
*/
contract StorageSimpled {

    /// @dev Variable
    uint storageData;

    /**
    * @dev Get storageData value
    */
    function get() public view returns(uint) {
        return storageData;
    }

    /**
    * @dev Set storageData value
    * @param _n value of variable storageData
    */
    function set(uint _n) public {
        storageData = _n;
    }

}