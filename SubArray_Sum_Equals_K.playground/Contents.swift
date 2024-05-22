// https://leetcode.com/problems/subarray-sum-equals-k/description/

/*
 Given an array of integers nums and an integer k, return the total number of subarrays whose sum equals to k.

 A subarray is a contiguous non-empty sequence of elements within an array.

  

 Example 1:

 Input: nums = [1,1,1], k = 2
 Output: 2
 Example 2:

 Input: nums = [1,2,3], k = 3
 Output: 2
  

 Constraints:

 1 <= nums.length <= 2 * 10^4
 -1000 <= nums[i] <= 1000
 -10^7 <= k <= 10^7
 */


/*
 Algo:
 
 Initialize Variables:
     count to store the number of subarrays that sum up to kk.
     current_sum to store the cumulative sum of elements up to the current index.
     prefix_sums (a dictionary) to store the frequency of cumulative sums encountered so far. Initialize it with {0: 1} to handle the case where a subarray starting from the beginning equals kk.

 Iterate Through the Array:
     For each element in the array, update the current_sum by adding the current element to it.
     Check if current_sum - k exists in the prefix_sums. If it does, it means there is a subarray (or subarrays) ending at the current index which sums up to kk. Add the frequency of current_sum - k to count.
     Update the prefix_sums with the current current_sum. If current_sum is already in the dictionary, increment its value. Otherwise, set its value to 1.

 Return the Result:
     The count will hold the total number of subarrays whose sum equals kk.
 */

/*
 Example 1:

     Input: nums = [1,1,1], k = 2
     Steps:
         Initialize: count = 0, current_sum = 0, prefix_sums = {0: 1}
         Iterate through the array:
             current_sum becomes 1 (after adding the first 1), update prefix_sums to {0: 1, 1: 1}
             current_sum becomes 2 (after adding the second 1), current_sum - k (2 - 2 = 0) is in prefix_sums (frequency 1), so count becomes 1, update prefix_sums to {0: 1, 1: 1, 2: 1}
             current_sum becomes 3 (after adding the third 1), current_sum - k (3 - 2 = 1) is in prefix_sums (frequency 1), so count becomes 2, update prefix_sums to {0: 1, 1: 1, 2: 1, 3: 1}
         Output: count = 2

 Example 2:

     Input: nums = [1,2,3], k = 3
     Steps:
         Initialize: count = 0, current_sum = 0, prefix_sums = {0: 1}
         Iterate through the array:
             current_sum becomes 1 (after adding 1), update prefix_sums to {0: 1, 1: 1}
             current_sum becomes 3 (after adding 2), current_sum - k (3 - 3 = 0) is in prefix_sums (frequency 1), so count becomes 1, update prefix_sums to {0: 1, 1: 1, 3: 1}
             current_sum becomes 6 (after adding 3), current_sum - k (6 - 3 = 3) is in prefix_sums (frequency 1), so count becomes 2, update prefix_sums to {0: 1, 1: 1, 3: 1, 6: 1}
         Output: count = 2
 */

func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    var currentSum = 0
    var prefixSums: [Int: Int] = [0: 1]
    
    for num in nums {
        currentSum += num
        
        if let prefixCount = prefixSums[currentSum - k] {
            count += prefixCount
        }
        
        prefixSums[currentSum, default: 0] += 1
    }
    print(prefixSums)
    return count
}

// Example Usage:
let nums1 = [1, 1, 1]
let k1 = 2
print(subarraySum(nums1, k1)) // Output: 2

let nums2 = [1, 2, 3]
let k2 = 3
print(subarraySum(nums2, k2)) // Output: 2


let nums3 = [1, 2, 3, -1, 0, 5]
let k3 = 2
print(subarraySum(nums3, k3))
