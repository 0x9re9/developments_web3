// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
* @title Advanced Storage
* @author 0x9re9
* @notice Contract for advance storage value storageData
* @notice Need set value on deloy, no value by default
* @notice Can't set value 5 (require)
* @notice Can send event (emit)
*/
contract StorageAdvanced {

    /// @dev Variable
    uint storageData;

    /// @dev Event
    event sendN(uint _n);

    /// @dev Constructor
    constructor(uint _n) payable {
        set(_n);
    }

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
        require(uint(_n) != 5, "You can't set 5");
        storageData = _n;
        emit sendN(_n);
    }

}