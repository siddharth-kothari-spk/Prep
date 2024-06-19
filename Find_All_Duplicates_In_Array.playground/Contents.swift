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


// Solution 2: https://leetcode.com/problems/find-all-duplicates-in-an-array/solutions/4921988/swift-accepted-solution-easy-to-understand

class Solution {
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var res = [Int](), nums = nums

        for n in nums {
           var a = abs(n)
           if nums[a - 1] < 0 {
                res.append(n)
           }
           nums[n - 1] = -nums[n - 1]
        }

        return res
    }
}

let sol = Solution()
print(sol.findDuplicates([4,3,2,7,8,2,3,1,1]))
print(sol.findDuplicates([1]))
print(sol.findDuplicates([1,1,2]))
print(sol.findDuplicates([]))

/*
 Example Walkthrough
 Let's go through an example to illustrate the logic. Consider the input array nums = [4,3,2,7,8,2,3,1].

 Start with res = [] and nums = [4,3,2,7,8,2,3,1].

 Iteration 1 (n = 4):

 a = abs(4) = 4
 nums[3] (value is 7, positive) → mark it as negative: nums = [4, 3, 2, -7, 8, 2, 3, 1]
 Iteration 2 (n = 3):

 a = abs(3) = 3
 nums[2] (value is 2, positive) → mark it as negative: nums = [4, 3, -2, -7, 8, 2, 3, 1]
 Iteration 3 (n = -2):

 a = abs(-2) = 2
 nums[1] (value is 3, positive) → mark it as negative: nums = [4, -3, -2, -7, 8, 2, 3, 1]
 Iteration 4 (n = -7):

 a = abs(-7) = 7
 nums[6] (value is 3, positive) → mark it as negative: nums = [4, -3, -2, -7, 8, 2, -3, 1]
 Iteration 5 (n = 8):

 a = abs(8) = 8
 nums[7] (value is 1, positive) → mark it as negative: nums = [4, -3, -2, -7, 8, 2, -3, -1]
 Iteration 6 (n = 2):

 a = abs(2) = 2
 nums[1] (value is -3, negative) → duplicate found, append 2 to res: res = [2]
 Iteration 7 (n = -3):

 a = abs(-3) = 3
 nums[2] (value is -2, negative) → duplicate found, append 3 to res: res = [2, 3]
 Iteration 8 (n = -1):

 a = abs(-1) = 1
 nums[0] (value is 4, positive) → mark it as negative: nums = [-4, -3, -2, -7, 8, 2, -3, -1]
 After finishing the loop, the function returns the result array res = [2, 3], which contains the duplicates found in the input array.
 */
