/*
SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Init {

	uint256 internal bronzeIndex;

	uint256 internal silverIndex;

	uint256 internal goldIndex;

	uint256 internal legendaryIndex;

	/**
	* Bronze is more expensive and more rare -- 200 total
	* Silver is reserved for big donators -- 50 total
	* Gold is the highest and rarest tier -- 20 total
        * Legendary is reserved for only the biggest sponsors -- 5 total
	**/
	constructor() {
		bronzeIndex = 0;
		silverIndex = 200;
		goldIndex = 250;
		legendaryIndex = 270;
	}
}
