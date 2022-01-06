/*
SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

library LibConstants {

	uint64 private constant BASE_VALUE = 50000000000000000;

	uint64 private constant BRONZE_VALUE = 100000000000000000;

	uint64 private constant SILVER_VALUE = 500000000000000000;

	uint64 private constant GOLD_VALUE = 1000000000000000000;

	function base() external pure returns (uint64) {
		return BASE_VALUE;
	}

	function bronze() external pure returns (uint64) {
		return BRONZE_VALUE;
	}

	function silver() external pure returns (uint64) {
		return SILVER_VALUE;
	}

	function gold() external pure returns (uint64) {
		return GOLD_VALUE;
	}
}
