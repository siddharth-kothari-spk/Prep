/*
 Given an integer array nums, return true if there exists a triple of indices (i, j, k) such that i < j < k and nums[i] < nums[j] < nums[k]. If no such indices exists, return false.

  

 Example 1:

 Input: nums = [1,2,3,4,5]
 Output: true
 Explanation: Any triplet where i < j < k is valid.
 Example 2:

 Input: nums = [5,4,3,2,1]
 Output: false
 Explanation: No triplet exists.
 Example 3:

 Input: nums = [2,1,5,0,4,6]
 Output: true
 Explanation: The triplet (3, 4, 5) is valid because nums[3] == 0 < nums[4] == 4 < nums[5] == 6.
 */

func increasingTriplet(_ nums: [Int]) -> Bool {
    if nums.count < 3 {
        return false
    }
    
    var index1 = 0
    var index2 = 1
    var index3 = 2
    
    while index3 < nums.count {
        if nums[index1] < nums[index2] {
            if nums[index2] < nums[index3] {
                print("\(nums[index1]), \(nums[index2]), \(nums[index3])")
                return true
            }
            else {
                index1 = index3
                index2 = index3 + 1
                index3 += 2
            }
        }
        else {
            index1 = index2
            index2 = index3
            index3 += 1
        }
    }
    return false
}

print(increasingTriplet([1,2,3,4,5]))
print(increasingTriplet([5,4,3,2,1]))
print(increasingTriplet([2,1,5,0,4,6]))
