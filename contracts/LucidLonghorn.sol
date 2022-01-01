/*
SPDX-License-Identifier: MIT
*/

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract LucidLonghorn is Ownable, ERC721 {

	constructor()
	ERC721("LucidLonghorn", "LUCL")
	{}

	function mint(address account) public returns (bool) {
		_mint(account, 1);
		return true;
	}

	function transfer(address recipient, uint256 tokenId) public returns (bool) {
		_transfer(msg.sender, recipient, tokenId);
	}
}
