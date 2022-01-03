/*
SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./libraries/LibConstants.sol";
import "./Init.sol";

contract LucidLonghorn is ERC721, Ownable, Init {

	constructor()
	ERC721("LucidLonghorn", "LUCL")
	{}

	function mint(address account, uint256 tokenId) private returns (bool) {
		_mint(account, tokenId);
		return true;
	}

	function transfer(address recipient, uint256 tokenId) public returns (bool) {
		_transfer(msg.sender, recipient, tokenId);
		return true;
	}

	function internalTransfer(address recipient, uint256 tokenId) private {
		_transfer(address(this), recipient, tokenId);
	}

	function whitelist(address[] calldata accounts, uint256[] calldata tokenIds) public onlyOwner {
		for (uint32 i = 0; i < accounts.length; i++) {
			mint(address(this), tokenIds[i]);
			_approve(accounts[i], tokenIds[i]);
		}
	}

	function claim(uint256 tokenId) public {
		require (isApprovedOrOwner(msg.sender, tokenId), "Not approved to take this longhorn");
		internalTransfer(msg.sender, tokenId);
	}

	function isApprovedOrOwner(address account, uint256 tokenId) public view returns (bool) {
		return _isApprovedOrOwner(account, tokenId);
	}

	function buyBase() public payable {
		require(msg.value >= LibConstants.base(), "Not enough ETH");
		require(baseIndex < 999, "No more base lucid longhorns for sale.");
		mint(msg.sender, baseIndex);
		baseIndex++;
	}

	function buyBronze() public payable {
		require(msg.value >= LibConstants.bronze(), "Not enough ETH");
		require(bronzeIndex < 1499, "No more bronze lucid longhorns for sale");
		mint(msg.sender, bronzeIndex);
		bronzeIndex++;
	}

	function buySilver() public payable {
		require(msg.value >= LibConstants.silver(), "Not enough ETH");
		require(silverIndex < 1799, "No more silver lucid longhorns for sale");
		mint(msg.sender, silverIndex);
		silverIndex++;
	}

	function buyGold() public payable {
		require(msg.value >= LibConstants.gold(), "Not enough ETH");
		require(goldIndex < 1999, "No more gold lucid longhorns for sale");
		mint(msg.sender, goldIndex);
		goldIndex++;
	}
}
