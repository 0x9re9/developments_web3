// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
* @title erc20_MKT
* @author 0x9re9
* @notice Contract for create ERC20 token MKT
*/
contract ERC20_MKT is ERC20, Ownable {

    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 4000 *10 ** decimals());
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

}