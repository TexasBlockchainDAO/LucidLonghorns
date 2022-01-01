/*
SPDX-License-Identifier: MIT
*/

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

abstract contract ILucid is IERC721 {

	function mint(address recipient, uint256 tokenId) public virtual returns (bool);
}
