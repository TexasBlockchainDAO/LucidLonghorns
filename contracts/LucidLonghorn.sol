/*
SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./libraries/LibConstants.sol";
import "./Init.sol";

contract LucidLonghorn is ERC721, Ownable, Init {

	using SafeMath for uint256;

	constructor()
	ERC721("LucidLonghorns", "LUCL")
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
	
	/** 
	* Members, alumni, and sponsors can mint their own exclusive Lucid Longhorn by getting on the UT Blockchain whitelist
	* Whitelisting occurs randomly, and only people who consistently participate in the club are whitelisted
	* Once whitelisted, you will be able to claim your Lucid Longhorn from https://www.texasblockchain.org/dao
	**/
	function whitelist(address[] calldata accounts, uint256[] calldata tokenIds) public onlyOwner {
		for (uint32 i = 0; i < accounts.length; i++) {
			mint(address(this), tokenIds[i]);
			_approve(accounts[i], tokenIds[i]);
		}
	}

	function withdraw() public onlyOwner {
    		address payable owner = payable(address(owner()));
    		owner.transfer(address(this).balance);
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
		if (msg.value >= LibConstants.base()) {
			uint256 returnAmount = msg.value.sub(LibConstants.base());
			(bool success, ) = msg.sender.call{value: returnAmount}(new bytes(0));
        		require(success, 'ETH transfer failed');
    		}
	}

	function buyBronze() public payable {
		require(msg.value >= LibConstants.bronze(), "Not enough ETH");
		require(bronzeIndex < 1499, "No more bronze lucid longhorns for sale");
		mint(msg.sender, bronzeIndex);
		bronzeIndex++;
		if (msg.value >= LibConstants.bronze()) {
                        uint256 returnAmount = msg.value.sub(LibConstants.bronze());
                        (bool success, ) = msg.sender.call{value: returnAmount}(new bytes(0));
                        require(success, 'ETH transfer failed');
                }
	}

	function buySilver() public payable {
		require(msg.value >= LibConstants.silver(), "Not enough ETH");
		require(silverIndex < 1799, "No more silver lucid longhorns for sale");
		mint(msg.sender, silverIndex);
		silverIndex++;
		if (msg.value >= LibConstants.silver()) {
                        uint256 returnAmount = msg.value.sub(LibConstants.silver());
                        (bool success, ) = msg.sender.call{value: returnAmount}(new bytes(0));
                        require(success, 'ETH transfer failed');
                }
	}

	function buyGold() public payable {
		require(msg.value >= LibConstants.gold(), "Not enough ETH");
		require(goldIndex < 1999, "No more gold lucid longhorns for sale");
		mint(msg.sender, goldIndex);
		goldIndex++;
		if (msg.value >= LibConstants.gold()) {
                        uint256 returnAmount = msg.value.sub(LibConstants.gold());
                        (bool success, ) = msg.sender.call{value: returnAmount}(new bytes(0));
                        require(success, 'ETH transfer failed');
                }
	}

	function contractBalance() external view onlyOwner returns (uint256) {
		return address(this).balance;
	}
}
