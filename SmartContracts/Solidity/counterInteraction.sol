// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface ICounter {
    function count() external view returns (uint);
    function increment() external;
}

/**
* @title Counter Interaction
* @author 0x9re9
* @notice Contract for interact with simple counter contract
*/
contract CounterInteraction {
    address counterAddr;

    /// @dev Constructor
    constructor(address _counterAddress) payable {
        setCounterAddr(_counterAddress);
    }

    /**
    * @dev Set counter address
    * @param _counter is counter owner address
    */
    function setCounterAddr(address _counter) public payable {
       counterAddr = _counter;
    }

    /**
    * @dev Get counter value
    */
    function getCount() external view returns (uint) {
        return ICounter(counterAddr).count();
    }

}