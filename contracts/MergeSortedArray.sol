// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MergeSortedArray {
    function Merge(
        uint[] memory nums1,
        uint m,
        uint[] memory nums2,
        uint n
    ) public pure returns (uint[] memory) {
        int a = int(m) - 1;
        int b = int(n) - 1;
        int c = int(m + n) - 1;

        while (b >= 0) {
            if (a >= 0 && nums1[uint(a)] > nums2[uint(b)]) {
                nums1[uint(c)] = nums1[uint(a)];
                a--;
            } else {
                nums1[uint(c)] = nums2[uint(b)];
                b--;
            }
            c--;
        }

        return nums1;
    }
}
