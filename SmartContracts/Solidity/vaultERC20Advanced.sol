// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
* @title VaultERC20 Advanced
* @author 0x9re9
* @notice Contract for vault with advanced options
* @notice You can deposit
* @notice You can deposit with locktime
* @notice You can withdraw all
* @notice You can withdraw amount
*/
contract VaultERC20Advanced {

    /// @dev Variable
    address public tokenAddress;
    uint public totalTokenBalance;

    /// @dev Structure
    struct Deposit {
        uint amount;
        uint locktimeMinute;
    }

    /// @dev Mapping
    /// @notice userAddress => tokenAddress => token amount
    mapping (address => mapping (address => Deposit)) userTokenBalance;

    /// @dev Event
    event tokenDepositComplete(address tokenAddress, uint256 amount);
    event tokenWithdrawComplete(address tokenAddress, uint256 amount);

    /// @dev Variable
    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }


    /**
    * @dev Deposit fonction
    * @param _amount value of variable storageData
    */
    function deposit( uint256 _amount) public  {
        require(IERC20(tokenAddress).balanceOf(msg.sender) >= _amount, "No enought Token amount for deposit");
        require(IERC20(tokenAddress).approve(address(this), _amount));
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amount));
        userTokenBalance[msg.sender][tokenAddress].amount += _amount;
        userTokenBalance[msg.sender][tokenAddress].locktimeMinute = block.timestamp;
        totalTokenBalance += _amount;
        emit tokenDepositComplete(tokenAddress, _amount);
    }


    /**
    * @dev Deposit with locktime fonction
    * @param _amount value of variable storageData
    * @param _locktimeMinute value of locktime in minutes
    */
    function depositWithLockTime(uint256 _amount, uint256 _locktimeMinute) public  {
        require(IERC20(tokenAddress).balanceOf(msg.sender) >= _amount, "No enought Token amount for deposit");
        require(IERC20(tokenAddress).approve(address(this), _amount));
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amount));
        userTokenBalance[msg.sender][tokenAddress].amount += _amount;
        userTokenBalance[msg.sender][tokenAddress].locktimeMinute = block.timestamp + _locktimeMinute * 60;
        totalTokenBalance += _amount;
        emit tokenDepositComplete(tokenAddress, _amount);
    }


    /**
    * @dev WithdrawAll fonction
    */
    function withdrawAll() public {
        require(userTokenBalance[msg.sender][tokenAddress].amount > 0, "You don't have funds on this vault");
        require(block.timestamp >= userTokenBalance[msg.sender][tokenAddress].locktimeMinute, "You need waiting");
        uint256 amount = userTokenBalance[msg.sender][tokenAddress].amount;
        require(IERC20(tokenAddress).transfer(msg.sender, amount), "Transfer failed");
        userTokenBalance[msg.sender][tokenAddress].amount = 0;
        userTokenBalance[msg.sender][tokenAddress].locktimeMinute = 0;
        totalTokenBalance -= amount;
        emit tokenWithdrawComplete(tokenAddress, amount);
    }


    /**
    * @dev withdrawAmount fonction
    * @param _amount value of variable storageData
    */
    function withdrawAmount(uint256 _amount) public {
        require(userTokenBalance[msg.sender][tokenAddress].amount >= _amount, "You don't have funds on this vault");
        require(block.timestamp >= userTokenBalance[msg.sender][tokenAddress].locktimeMinute, "You need waiting");
        require(IERC20(tokenAddress).transfer(msg.sender, _amount), "Transfer failed");
        userTokenBalance[msg.sender][tokenAddress].amount -= _amount;
        totalTokenBalance -= _amount;
        emit tokenWithdrawComplete(tokenAddress, _amount);
    }


    /**
    * @dev locktimeGetValue fonction
    */
    function locktimeGetValue() external view returns (uint) {
        return userTokenBalance[msg.sender][tokenAddress].locktimeMinute;
    }


    /**
    * @dev locktimeGetWaitingValue fonction
    */
    function locktimeGetWaitingValue() external view returns (uint) {
        return userTokenBalance[msg.sender][tokenAddress].locktimeMinute - block.timestamp;
    }

}