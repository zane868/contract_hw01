// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {MergeSortedArray} from "../contracts/MergeSortedArray.sol";

contract MergeSortedArrayTest is Test {
    MergeSortedArray merger;

    function setUp() public {
        merger = new MergeSortedArray();
    }

    function _arr6(
        uint a,
        uint b,
        uint c,
        uint d,
        uint e,
        uint f
    ) internal pure returns (uint[] memory) {
        uint[] memory r = new uint[](6);
        r[0] = a;
        r[1] = b;
        r[2] = c;
        r[3] = d;
        r[4] = e;
        r[5] = f;
        return r;
    }

    // ---- LeetCode 官方示例 ----

    // 示例 1: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3 => [1,2,2,3,5,6]
    function test_Merge_Example1() public view {
        uint[] memory nums1 = _arr6(1, 2, 3, 0, 0, 0);
        uint[] memory nums2 = new uint[](3);
        nums2[0] = 2;
        nums2[1] = 5;
        nums2[2] = 6;
        assertEq(merger.Merge(nums1, 3, nums2, 3), _arr6(1, 2, 2, 3, 5, 6));
    }

    // 示例 2: nums1 = [1], m = 1, nums2 = [], n = 0 => [1]
    function test_Merge_Example2() public view {
        uint[] memory nums1 = new uint[](1);
        nums1[0] = 1;
        uint[] memory nums2 = new uint[](0);
        uint[] memory expected = new uint[](1);
        expected[0] = 1;
        assertEq(merger.Merge(nums1, 1, nums2, 0), expected);
    }

    // 示例 3: nums1 = [0], m = 0, nums2 = [1], n = 1 => [1]
    function test_Merge_Example3() public view {
        uint[] memory nums1 = new uint[](1);
        nums1[0] = 0;
        uint[] memory nums2 = new uint[](1);
        nums2[0] = 1;
        uint[] memory expected = new uint[](1);
        expected[0] = 1;
        assertEq(merger.Merge(nums1, 0, nums2, 1), expected);
    }

    // ---- 额外边界用例 ----

    function test_Merge_Nums2AllSmaller() public view {
        assertEq(
            merger.Merge(_arr6(4, 5, 6, 0, 0, 0), 3, _arr6(1, 2, 3, 0, 0, 0), 3),
            _arr6(1, 2, 3, 4, 5, 6)
        );
    }

    function test_Merge_Nums2AllLarger() public view {
        assertEq(
            merger.Merge(_arr6(1, 2, 3, 0, 0, 0), 3, _arr6(4, 5, 6, 0, 0, 0), 3),
            _arr6(1, 2, 3, 4, 5, 6)
        );
    }

    function test_Merge_Duplicates() public view {
        assertEq(
            merger.Merge(_arr6(1, 2, 2, 0, 0, 0), 3, _arr6(2, 2, 0, 0, 0, 0), 2),
            _arr6(1, 2, 2, 2, 2, 0)
        );
    }

    function test_Merge_SingleEach() public view {
        assertEq(
            merger.Merge(_arr6(2, 0, 0, 0, 0, 0), 1, _arr6(1, 0, 0, 0, 0, 0), 1),
            _arr6(1, 2, 0, 0, 0, 0)
        );
    }
}
