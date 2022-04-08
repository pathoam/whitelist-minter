// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "@openzeppelin/contracts/access/AccessControl.sol";

error WhitelistError();

contract NFTMinter is ERC1155, AccessControl {
    // AccessControl roles
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    uint256 public constant SHARES = 0;
    uint256 public constant MINTER = 1;

    uint256 public shares_outstanding = 0;

    mapping(uint256 => bytes) private _minters_data;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() public ERC1155("https://carbonis.com/api/token/{id}.json") {
        //url can be replaced by ipfs hash or other similar reference
        _mint(msg.sender, SHARES, 1, "");
    }

    // function newMinter(string memory tokenURI, uint256 amount)
    //    public returns(uint256) {
    //        uint256 newItemId = _tokenIds.current();
    //        _mint(msg.sender, newItemId, amount, "");
    //        _setTokenUri(newItemId, tokenURI);
    //        _tokenIds.increment();
    //        return newItemId;
    //    }

    function throwError() external pure {
        revert WhitelistError();
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
