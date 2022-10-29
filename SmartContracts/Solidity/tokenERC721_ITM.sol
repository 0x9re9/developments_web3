// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
* @title TokenERC721 Simpled
* @author 0x9re9
* @notice Contract for mint NFT ERC721 with tokenUri
* @notice You can set TokenUri
*/
contract ERC721_ITM is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("myNFT", "ITM") {}

    uint public myNewItemId;

    function mintItem(address user, string memory tokenURI) external payable returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(user, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

    function burnItem(uint burnItemId) external
    {
        _burn(burnItemId);
    }

}