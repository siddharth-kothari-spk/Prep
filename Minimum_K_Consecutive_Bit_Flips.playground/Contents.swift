/*
 https://leetcode.com/problems/minimum-number-of-k-consecutive-bit-flips/description/
 You are given a binary array nums and an integer k.

 A k-bit flip is choosing a subarray of length k from nums and simultaneously changing every 0 in the subarray to 1, and every 1 in the subarray to 0.

 Return the minimum number of k-bit flips required so that there is no 0 in the array. If it is not possible, return -1.

 A subarray is a contiguous part of an array.

  

 Example 1:

 Input: nums = [0,1,0], k = 1
 Output: 2
 Explanation: Flip nums[0], then flip nums[2].
 Example 2:

 Input: nums = [1,1,0], k = 2
 Output: -1
 Explanation: No matter how we flip subarrays of size 2, we cannot make the array become [1,1,1].
 Example 3:

 Input: nums = [0,0,0,1,0,1,1,0], k = 3
 Output: 3
 Explanation:
 Flip nums[0],nums[1],nums[2]: nums becomes [1,1,1,1,0,1,1,0]
 Flip nums[4],nums[5],nums[6]: nums becomes [1,1,1,1,1,0,0,0]
 Flip nums[5],nums[6],nums[7]: nums becomes [1,1,1,1,1,1,1,1]
  

 Constraints:

 1 <= nums.length <= 105
 1 <= k <= nums.length
 */

/*
 To solve the problem of finding the minimum number of k-bit flips required to turn a binary array nums into an array of all 1s, we need to employ a sliding window technique to keep track of the flips. Here's the algorithm to achieve this:

 Initialize a Flip Counter Array: We use an array flip to keep track of the current flips affecting each position in the array.

 Sliding Window Approach: Traverse through the array while maintaining the state of flips affecting the current element.

 Flip Counting: Use a variable current_flips to keep track of the number of flips that affect the current position.

 Flip Decision: For each position, decide whether a flip is needed based on the current state and the number of flips that affect this position.

 Boundary Conditions: Ensure flips only happen if the remaining elements are sufficient for a k-length subarray.
 */

func minKBitFlips(_ nums: [Int], _ k: Int) -> Int {
    var nums = nums
    let n = nums.count
    var flip = [Int](repeating: 0, count: n) // This array will keep track of flips affecting each position
    var currentFlips = 0
    var result = 0
    
    for i in 0..<n {
        // If we're past the first k elements, remove the effect of the (i-k)th element if it was flipped
        if i >= k {
            currentFlips ^= flip[i - k]
        }
        
        // If the current element needs to be flipped
        if nums[i] == currentFlips % 2 {
            // If we don't have enough elements left to flip
            if i + k > n {
                return -1
            }
            // Flip the current position
            flip[i] = 1
            currentFlips ^= 1
            result += 1
        }
    }
    
    return result
}

// Example usage:
let nums1 = [0, 1, 0]
let k1 = 1
print(minKBitFlips(nums1, k1)) // Output: 2

let nums2 = [1, 1, 0]
let k2 = 2
print(minKBitFlips(nums2, k2)) // Output: -1

let nums3 = [0, 0, 0, 1, 0, 1, 1, 0]
let k3 = 3
print(minKBitFlips(nums3, k3)) // Output: 3


// https://www.youtube.com/watch?v=Y6ZrtZgmwRg&ab_channel=ProgrammingLivewithLarry
func minKBitFlips2(_ nums: [Int], _ k: Int) -> Int {
    var nums = nums
    let n = nums.count
    var flip = [Int](repeating: 0, count: n)
    var flips = 0
    var current = 0

    for (index, value) in nums.enumerated() {
        if flip[index] != 0 {
            current ^= 1
        }
        
        if value^current == 0 {
            flips += 1
            current ^= 1
            
            if index + k > n {
                return -1
            }
            
            if index + k < n {
                flip[index + k] = 1
            }
        }
    }
    
    return flips
}

print(minKBitFlips2(nums2, k2))
print(minKBitFlips2(nums3, k3))
