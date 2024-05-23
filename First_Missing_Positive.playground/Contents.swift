/*
 https://leetcode.com/problems/first-missing-positive/description/
 
 Given an unsorted integer array nums. Return the smallest positive integer that is not present in nums.

 You must implement an algorithm that runs in O(n) time and uses O(1) auxiliary space.

  

 Example 1:

 Input: nums = [1,2,0]
 Output: 3
 Explanation: The numbers in the range [1,2] are all in the array.
 Example 2:

 Input: nums = [3,4,-1,1]
 Output: 2
 Explanation: 1 is in the array but 2 is missing.
 Example 3:

 Input: nums = [7,8,9,11,12]
 Output: 1
 Explanation: The smallest positive integer 1 is missing.
 
 
 Algo:
 
 Here's the step-by-step algorithm:

 Ignore non-positive numbers and numbers larger than the length of the array: Since we are looking for the smallest positive integer, any number less than or equal to zero or greater than the length of the array can be ignored.

 Rearrange the array so that each positive number x is placed at index x-1:

 Iterate through the array.
 For each number at index i, swap it with the number at the index it should be placed (i.e., nums[i] should be at index nums[i] - 1).
 Continue this process as long as the number at index i is in the range [1, n] (where n is the length of the array) and is not already in the correct position.
 Identify the first missing positive integer:

 After the rearrangement, iterate through the array again.
 The first index i for which nums[i] is not equal to i+1 is the answer.
 If all positions are correct, the missing number is n + 1:

 If every number from 1 to n is in its correct position, then the smallest missing positive number is n + 1.
 */

import Foundation

func firstMissingPositive(_ nums: [Int]) -> Int {
    var nums = nums
    
    for index in 0..<nums.count {
        let canProceed = !(nums[index] <= 0 || nums[index] >= nums.count)
        
        if canProceed && nums[nums[index] - 1] != nums[index] {
            nums.swapAt(nums[index] - 1, index)
        }
    }
    
    for index in 0..<nums.count {
        if nums[index] != index + 1 {
            return index + 1
        }
    }
    return nums.count
}

print(firstMissingPositive([1,2,0]))
print(firstMissingPositive([3,4,-1,1]))
print(firstMissingPositive([7,8,9,11,12]))

