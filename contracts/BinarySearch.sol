// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract BinarySearch {
    function search(int[] memory input, int target) public pure returns (int) {
        //[-1, 0, 3, 5, 9, 12,16,18,20,33,50,55]
        uint left = 0;
        uint right = input.length;

        while (left < right) {
            uint mid = left + (right - left) / 2;
            if (input[mid] == target) {
                return int(mid);
            } else if (input[mid] < target) {
                left = mid + 1;
            } else if (input[mid] > target) {
                right = mid;
            }
        }

        return -1;
    }
}
