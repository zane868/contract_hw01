// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {BinarySearch} from "../contracts/BinarySearch.sol";
contract BinarySearchTest is Test {
    BinarySearch searcher;

    function setUp() public {
        searcher = new BinarySearch();
    }

    function test_Search_ZeroInMultipleElements() public view {
        // 准备有序数组和目标值
        int[] memory input = new int[](10);
        input[0] = -1;
        input[1] = 0;
        input[2] = 3;
        input[3] = 5;
        input[4] = 9;
        input[5] = 12;
        input[6] = 15;
        input[7] = 18;
        input[8] = 21;
        input[9] = 33;
        // 调用查找函数
        int result = searcher.search(input, 0);
        // 目标值 0 位于下标 1
        assertEq(result, 1);
    }

    function test_Search_AllPositions() public view {
        int[] memory input = _sampleArray();
        for (uint i = 0; i < input.length; i++) {
            assertEq(searcher.search(input, input[i]), int(i));
        }
    }

    function test_Search_MissingBetweenElements() public view {
        assertEq(searcher.search(_sampleArray(), 2), -1);
    }

    function test_Search_BelowMinimum() public view {
        assertEq(searcher.search(_sampleArray(), -10), -1);
    }

    function test_Search_AboveMaximum() public view {
        assertEq(searcher.search(_sampleArray(), 13), -1);
    }

    function test_Search_EmptyArray() public view {
        int[] memory input = new int[](0);
        assertEq(searcher.search(input, 5), -1);
    }

    function test_Search_SingleElement() public view {
        int[] memory input = new int[](1);
        input[0] = 5;
        assertEq(searcher.search(input, 5), 0);
        assertEq(searcher.search(input, 4), -1);
        assertEq(searcher.search(input, 6), -1);
    }

    function test_Search_TwoElements() public view {
        int[] memory input = new int[](2);
        input[0] = -3;
        input[1] = 7;
        assertEq(searcher.search(input, -3), 0);
        assertEq(searcher.search(input, 7), 1);
        assertEq(searcher.search(input, 0), -1);
    }

    function test_Search_OddLength() public view {
        int[] memory input = new int[](3);
        input[0] = -9;
        input[1] = -5;
        input[2] = -1;
        for (uint i = 0; i < input.length; i++) {
            assertEq(searcher.search(input, input[i]), int(i));
        }
        assertEq(searcher.search(input, -4), -1);
    }

    function _sampleArray() private pure returns (int[] memory input) {
        input = new int[](6);
        input[0] = -1;
        input[1] = 0;
        input[2] = 3;
        input[3] = 5;
        input[4] = 9;
        input[5] = 12;
    }
}
