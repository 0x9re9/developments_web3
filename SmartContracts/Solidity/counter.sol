// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
* @title Counter
* @author 0x9re9
* @notice Contract for create a simple counter with button increment
*/
contract Counter {
    uint public count;
    
    /**
    * @dev Increment counter value
    */
    function increment() external {
        count += 1;
    }
}