/*
SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

library LibConstants {

	uint64 private constant BRONZE_VALUE = 100000000000000000;

	uint64 private constant SILVER_VALUE = 250000000000000000;

	uint64 private constant GOLD_VALUE = 1000000000000000000;

	uint64 private constant LEGENDARY_VALUE = 3000000000000000000;

	uint128 private constant MAX_VALUE = 20000000000000000000;

	function bronze() internal pure returns (uint64) {
		return BRONZE_VALUE;
	}

	function silver() internal pure returns (uint64) {
		return SILVER_VALUE;
	}

	function gold() internal pure returns (uint64) {
		return GOLD_VALUE;
	}

	function legendary() internal pure returns (uint64) {
		return LEGENDARY_VALUE;
	}

	function maxLegendary() internal pure returns (uint128) {
		return MAX_VALUE;
	}
}
