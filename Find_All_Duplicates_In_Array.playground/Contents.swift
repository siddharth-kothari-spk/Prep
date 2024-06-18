/*
 https://leetcode.com/problems/find-all-duplicates-in-an-array/description/
 Given an integer array nums of length n where all the integers of nums are in the range [1, n] and each integer appears once or twice, return an array of all the integers that appears twice.

 You must write an algorithm that runs in O(n) time and uses only constant extra space.

  

 Example 1:

 Input: nums = [4,3,2,7,8,2,3,1]
 Output: [2,3]
 Example 2:

 Input: nums = [1,1,2]
 Output: [1]
 Example 3:

 Input: nums = [1]
 Output: []
 */

import Foundation
func findDuplicates(_ nums: [Int]) -> [Int] {
    var dict: [Int: Int] = [:]
    
    for num in nums {
        dict[num, default: 0] += 1
    }
    return dict.keys.filter { key in
        dict[key]! > 1
    }
}

print(findDuplicates([4,3,2,7,8,2,3,1]))
print(findDuplicates([1]))
print(findDuplicates([1,1,2]))
print(findDuplicates([]))


