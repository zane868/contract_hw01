"""LeetCode 88. Merge Sorted Array — 从后往前双指针，原地合并。"""

import unittest


def merge(nums1: list[int], m: int, nums2: list[int], n: int) -> None:
    """把 nums2 原地合并进 nums1（nums1 尾部是预留的 0 占位）。"""
    i, j = m - 1, n - 1
    k = m + n - 1
    while j >= 0:
        if i >= 0 and nums1[i] > nums2[j]:
            nums1[k] = nums1[i]
            i -= 1
        else:
            nums1[k] = nums2[j]
            j -= 1
        k -= 1


class TestMerge(unittest.TestCase):
    def test_basic(self):
        nums1 = [1, 2, 3, 0, 0, 0]
        merge(nums1, 3, [2, 5, 6], 3)
        self.assertEqual(nums1, [1, 2, 2, 3, 5, 6])

    def test_nums2_empty(self):
        nums1 = [1]
        merge(nums1, 1, [], 0)
        self.assertEqual(nums1, [1])

    def test_nums1_empty(self):
        nums1 = [0]
        merge(nums1, 0, [1], 1)
        self.assertEqual(nums1, [1])

    def test_nums2_all_smaller(self):
        nums1 = [4, 5, 6, 0, 0, 0]
        merge(nums1, 3, [1, 2, 3], 3)
        self.assertEqual(nums1, [1, 2, 3, 4, 5, 6])

    def test_nums2_all_larger(self):
        nums1 = [1, 2, 3, 0, 0, 0]
        merge(nums1, 3, [4, 5, 6], 3)
        self.assertEqual(nums1, [1, 2, 3, 4, 5, 6])

    def test_duplicates(self):
        nums1 = [1, 2, 2, 0, 0]
        merge(nums1, 3, [2, 2], 2)
        self.assertEqual(nums1, [1, 2, 2, 2, 2])

    def test_single_each(self):
        nums1 = [2, 0]
        merge(nums1, 1, [1], 1)
        self.assertEqual(nums1, [1, 2])


if __name__ == "__main__":
    unittest.main()
