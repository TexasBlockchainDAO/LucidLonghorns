/*
SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LucidLonghorn is ERC721, Ownable {

	constructor()
	ERC721("LucidLonghorn", "LUCL")
	{}

	function mint(address account, uint256 tokenId) public returns (bool) {
		_mint(account, tokenId);
		return true;
	}

	function transfer(address sender, address recipient, uint256 tokenId) public returns (bool) {
		_transfer(sender, recipient, tokenId);
		return true;
	}

	function whitelist(address[] calldata accounts, uint256[] calldata tokenIds) public onlyOwner returns (bool) {
		for (uint32 i = 0; i < accounts.length; i++) {
			mint(address(this), tokenIds[i]);
			_approve(accounts[i], tokenIds[i]);
		}
		return true;
	}

	function claim(uint256 tokenId) public returns (bool) {
		require (isApprovedOrOwner(msg.sender, tokenId), "Not approved to take this longhorn");
		transfer(address(this), msg.sender, tokenId);
		return true;
	}

	function isApprovedOrOwner(address account, uint256 tokenId) public view returns (bool) {
		return _isApprovedOrOwner(account, tokenId);
	}
}
