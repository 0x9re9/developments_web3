// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
* @title Vault Simpled
* @author 0x9re9
* @notice Contract for vault with simpled options
* @notice You can deposit
* @notice You can withdraw
*/
contract VaultERC20Simpled {

    /// @dev Variable
    address public tokenAddress;
    uint public totalTokenBalance;
   
    /// @dev Mapping
    /// @notice userAddress => tokenAddress => token amount
    mapping (address => mapping (address => uint256)) userTokenBalance;

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
        userTokenBalance[msg.sender][tokenAddress] += _amount;
        totalTokenBalance += _amount;
        emit tokenDepositComplete(tokenAddress, _amount);
    }


    /**
    * @dev withdrawAll fonction
    */
    function withdrawAll() public {
        require(userTokenBalance[msg.sender][tokenAddress] > 0, "You don't have funds on this vault");
        uint256 amount = userTokenBalance[msg.sender][tokenAddress];
        require(IERC20(tokenAddress).transfer(msg.sender, amount), "Transfer failed");
        userTokenBalance[msg.sender][tokenAddress] = 0;
        totalTokenBalance -= amount;
        emit tokenWithdrawComplete(tokenAddress, amount);
    }

}