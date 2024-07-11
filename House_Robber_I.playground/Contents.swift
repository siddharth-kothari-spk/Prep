/*
 You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

 Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

  

 Example 1:

 Input: nums = [1,2,3,1]
 Output: 4
 Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
 Total amount you can rob = 1 + 3 = 4.
 Example 2:

 Input: nums = [2,7,9,3,1]
 Output: 12
 Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
 Total amount you can rob = 2 + 9 + 1 = 12.
  

 Constraints:

 1 <= nums.length <= 100
 0 <= nums[i] <= 400
 */

/*
 we can use dynamic programming. The idea is to use a dp array where dp[i] represents the maximum amount of money you can rob from the first i+1 houses. The relationship between the elements of dp can be derived from the following logic:

 For each house i, you have two choices:

 Do not rob the current house i, so the maximum amount of money is the same as dp[i-1].
 Rob the current house i, and add the amount of money in this house to the maximum amount from the houses before the previous one (i.e., dp[i-2] + nums[i]).
 Thus, the state transition is:
 
 dp[i]=max(dp[i−1],dp[i−2]+nums[i])

 Here is the algorithm step-by-step:

 If nums is empty, return 0.
 Initialize a dp array of the same length as nums.
 Set dp[0] to nums[0].
 If there is more than one house, set dp[1] to the maximum of nums[0] and nums[1].
 Iterate through the array starting from the third house, updating the dp array with the maximum amount of money that can be robbed up to that house.
 The last element in dp will contain the maximum amount of money that can be robbed without alerting the police.
 */

func rob(_ nums: [Int]) -> Int {
    if nums.isEmpty {
        return 0
    }
    
    let n = nums.count
    if n == 1 {
        return nums[0]
    }
    if n == 2 {
        return max(nums[0], nums[1])
    }
    
    var dp = [Int](repeating: 0, count: n)
    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])
    
    for i in 2..<n {
        dp[i] = max(dp[i-1], dp[i-2] + nums[i])
    }
    
    return dp[n-1]
}

// Example usage:
let nums1 = [1, 2, 3, 1]
print(rob(nums1))  // Output: 4

let nums2 = [2, 7, 9, 3, 1]
print(rob(nums2))  // Output: 12

/*
 Sure, let's perform a dry run of the `rob` function with `nums1 = [1, 2, 3, 1]`.

 1. **Initialization:**
    - `nums = [1, 2, 3, 1]`
    - `n = nums.count = 4`

 2. **Edge Cases:**
    - Since `nums` is not empty and `n > 1`, we proceed to initialize the `dp` array.

 3. **Initial `dp` Array:**
    - `dp = [0, 0, 0, 0]`
    - Set `dp[0] = nums[0] = 1`
    - Set `dp[1] = max(nums[0], nums[1]) = max(1, 2) = 2`
    - Now `dp = [1, 2, 0, 0]`

 4. **Iterating through the array:**
    - For `i = 2`:
      - Calculate `dp[2] = max(dp[1], dp[2-2] + nums[2]) = max(2, 1 + 3) = max(2, 4) = 4`
      - Update `dp` to `[1, 2, 4, 0]`
    - For `i = 3`:
      - Calculate `dp[3] = max(dp[2], dp[3-2] + nums[3]) = max(4, 2 + 1) = max(4, 3) = 4`
      - Update `dp` to `[1, 2, 4, 4]`

 5. **Final Result:**
    - The last element in `dp` is `dp[3] = 4`
    - Return `dp[3]`

 Let's summarize the `dp` array updates at each step:

 - Initial `dp` array: `[0, 0, 0, 0]`
 - After initialization: `[1, 2, 0, 0]`
 - After iteration for `i = 2`: `[1, 2, 4, 0]`
 - After iteration for `i = 3`: `[1, 2, 4, 4]`

 Thus, the maximum amount of money that can be robbed from `nums1 = [1, 2, 3, 1]` without alerting the police is `4`.

 The dry run verifies that the Swift code correctly implements the dynamic programming approach to solve the problem.
 */
