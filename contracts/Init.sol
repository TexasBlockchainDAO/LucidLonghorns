/*
SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Init {

	uint256 internal baseIndex;

	uint256 internal bronzeIndex;

	uint256 internal silverIndex;

	uint256 internal goldIndex;

	/**
	* Base is the cheapest, and the most common purchasable NFT -- 1000 total
	* Bronze is more expensive and more rare -- 500 total
	* Silver is reserved for big donators -- 300 total
	* Gold is the highest and rarest tier -- 200 total
	**/
	constructor() {
		baseIndex = 0;
		bronzeIndex = 1000;
		silverIndex = 1500;
		goldIndex = 1800;
	}
}
