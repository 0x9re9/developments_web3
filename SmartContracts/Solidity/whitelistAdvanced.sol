// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
* @title Advanced Whitelist
* @author 0x9re9
* @notice Contract for advanced whitelist address
* @notice You can open or close list
* @notice You can whitelist or blacklist address
* @notice You can set max number whitelist address
*/
contract WhitelistAdvanced {

    /// @dev Variable
    uint public maxWhitelist = 5;
    uint public nbWhitelisted;
    uint public nbBlacklisted;
    bool public ListStatus;

    /// @dev Structure
    struct AddrList {
        string isStatus;
    }

    /// @dev Enum
    enum AddrStatus {
        whitelist,
        blacklist
    }

    /// @dev Mapping
    mapping (address => AddrList) addrLists;

    /// @dev Event
    event AddrStatusEvent(address _addr, string _status);
    event CountListed(uint _nbWhitelisted, uint _nbBlacklisted);

    /// @dev Constructor
    constructor() payable {
        addOwnerWhitelist(msg.sender);
    }


    /**
    * @dev Open list status
    */
    function openList() external returns (bool) {
        require(ListStatus == false, 'Already opened');
        ListStatus = true;
        return ListStatus;
    }


    /**
    * @dev Close list status
    */
    function closeList() external returns (bool) {
        require(ListStatus == true, 'Already closed');
        ListStatus = false;
        return ListStatus;
    }


    /**
    * @dev Get status of address
    */
    function getStatus(address _addr) external view returns (AddrList memory) {
        return addrLists[_addr];
    }


    /**
    * @dev Add owner whitelist address
    */
    function addOwnerWhitelist(address _addr) internal {
        require(keccak256(abi.encodePacked(addrLists[_addr].isStatus)) != keccak256(abi.encodePacked('whitelist')), 'Already whitelisted');
        addrLists[_addr].isStatus = 'whitelist';
        nbWhitelisted++;
        emit AddrStatusEvent(_addr, 'whitelisted');
        emit CountListed(nbWhitelisted, nbBlacklisted);
    }


    /**
    * @dev Add whitelist address
    */
    function addWhitelist(address _addr) external {
        require(ListStatus == true, 'List is not open.');
        require(nbWhitelisted <= maxWhitelist, 'The limit of the list has been reached.');
        require(keccak256(abi.encodePacked(addrLists[_addr].isStatus)) != keccak256(abi.encodePacked('whitelist')), 'Already whitelisted');
        if(keccak256(abi.encodePacked(addrLists[_addr].isStatus)) == keccak256(abi.encodePacked('blacklist'))) {
            nbBlacklisted--;
        }
        nbWhitelisted++;
        addrLists[_addr].isStatus = 'whitelist';
        emit AddrStatusEvent(_addr, 'whitelisted');
        emit CountListed(nbWhitelisted, nbBlacklisted);
    }


    /**
    * @dev Add blacklist address
    */
    function addBlacklist(address _addr) external {
        require(ListStatus == true, 'List is not open.');
        require(keccak256(abi.encodePacked(addrLists[_addr].isStatus)) != keccak256(abi.encodePacked('blacklist')), 'Already blacklisted');
        if(keccak256(abi.encodePacked(addrLists[_addr].isStatus)) == keccak256(abi.encodePacked('whitelist'))) {
            nbWhitelisted--;
        }
        nbBlacklisted++;
        addrLists[_addr].isStatus = 'blacklist';
        emit AddrStatusEvent(_addr, 'blacklisted');
        emit CountListed(nbWhitelisted, nbBlacklisted);
    }


    /**
    * @dev Set status of address
    */
    function setMaxWhitelist(uint _maxWhitelist) external {
        maxWhitelist = _maxWhitelist;
    }



}