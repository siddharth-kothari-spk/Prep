/*
 
 https://leetcode.com/problems/squares-of-a-sorted-array/description/
 
 Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.

  

 Example 1:

 Input: nums = [-4,-1,0,3,10]
 Output: [0,1,9,16,100]
 Explanation: After squaring, the array becomes [16,1,0,9,100].
 After sorting, it becomes [0,1,9,16,100].
 Example 2:

 Input: nums = [-7,-3,2,3,11]
 Output: [4,9,9,49,121]
 */

import Foundation

class Solution {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var left = 0
        var right = nums.count - 1
        
        var result: [Int] = [Int]()
        
        while left <= right {
            if abs(nums[left]) > abs(nums[right]) {
                result.append(nums[left] * nums[left])
                left += 1
            }
            else {
                result.append(nums[right] * nums[right])
                right -= 1
            }
        }
        return result.reversed()
    }
}

let sol = Solution()
print(sol.sortedSquares([-4,-1,0,3,10]))

print(sol.sortedSquares([-7,-3,2,3,11]))

print(sol.sortedSquares([2,3,11]))

