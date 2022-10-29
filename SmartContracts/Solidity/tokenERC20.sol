// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
* @title erc20
* @author 0x9re9
* @notice Contract for create ERC20 token
*/
contract tokenErc20 is ERC20, Ownable {
    constructor(string memory _name, string memory _symbol, uint _amount, uint  _decimals) ERC20(_name, _symbol) {
        // 1 token = 1 * (10 ** decimals)
        _mint(msg.sender, _amount * 10 ** _decimals);
    }
}
