/*
 https://leetcode.com/problems/house-robber-ii/description/
 You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

 Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

  

 Example 1:

 Input: nums = [2,3,2]
 Output: 3
 Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.
 Example 2:

 Input: nums = [1,2,3,1]
 Output: 4
 Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
 Total amount you can rob = 1 + 3 = 4.
 Example 3:

 Input: nums = [1,2,3]
 Output: 3
 */

/*
 To solve the problem of robbing houses arranged in a circle without triggering the alarm, we can use a dynamic programming approach. Here's the algorithm to find the maximum amount of money you can rob:

 Base Cases:

 If the list of houses nums is empty, return 0.
 If there's only one house, return the value of that house.
 If there are two houses, return the maximum value between the two houses.
 Dynamic Programming Approach:

 Since the houses are arranged in a circle, we have two scenarios to consider:
 Robbing from the first house and not robbing the last house.
 Not robbing the first house and considering robbing the last house.
 Define Helper Function:

 Define a helper function rob_linear that solves the linear version of the problem (i.e., houses are not arranged in a circle).
 Calculate Both Scenarios:

 Use the helper function to calculate the maximum amount for both scenarios mentioned above and return the maximum of the two results.
 */

func rob(_ nums: [Int]) -> Int {
    // Helper function to solve the problem for a linear list of houses
    func robLinear(_ houses: [Int]) -> Int {
        let n = houses.count
        if n == 0 { return 0 }
        if n == 1 { return houses[0] }
        if n == 2 { return max(houses[0], houses[1]) }

        var dp = [Int](repeating: 0, count: n)
        dp[0] = houses[0]
        dp[1] = max(houses[0], houses[1])

        for i in 2..<n {
            dp[i] = max(dp[i-1], dp[i-2] + houses[i])
        }

        return dp[n-1]
    }

    // Base cases
    let count = nums.count
    if count == 0 { return 0 }
    if count == 1 { return nums[0] }
    if count == 2 { return max(nums[0], nums[1]) }

    // Case 1: Rob from the first house, not the last house
    let case1 = robLinear(Array(nums[0..<count-1]))
    
    // Case 2: Do not rob the first house, consider robbing the last house
    let case2 = robLinear(Array(nums[1..<count]))

    return max(case1, case2)
}

// Examples
print(rob([2, 3, 2]))  // Output: 3
print(rob([1, 2, 3, 1]))  // Output: 4
print(rob([1, 2, 3]))  // Output: 3

/*
 Sure, let's go through a dry run for the input `[1, 2, 3, 1]` with the provided Swift code.

 1. **Initial Input**: `[1, 2, 3, 1]`
 2. **Base Cases**:
    - `count = 4`
    - None of the base cases (`count == 0`, `count == 1`, `count == 2`) are met, so we proceed to the next step.

 3. **Define Helper Function `robLinear`**:
    - The `robLinear` function will be used to solve the problem for two linear subproblems.

 4. **Case 1: Rob from the first house, not the last house**:
    - Call `robLinear` with the subarray `[1, 2, 3]`.
    - Inside `robLinear` for `[1, 2, 3]`:
      - `n = 3`
      - Initialize `dp` array: `dp = [1, 2, 0]`
        - `dp[0] = houses[0] = 1`
        - `dp[1] = max(houses[0], houses[1]) = max(1, 2) = 2`
      - For `i = 2`:
        - `dp[2] = max(dp[1], dp[0] + houses[2]) = max(2, 1 + 3) = 4`
      - Final `dp` array: `[1, 2, 4]`
      - Return `dp[2] = 4`
    - Result for `case1 = 4`

 5. **Case 2: Do not rob the first house, consider robbing the last house**:
    - Call `robLinear` with the subarray `[2, 3, 1]`.
    - Inside `robLinear` for `[2, 3, 1]`:
      - `n = 3`
      - Initialize `dp` array: `dp = [2, 3, 0]`
        - `dp[0] = houses[0] = 2`
        - `dp[1] = max(houses[0], houses[1]) = max(2, 3) = 3`
      - For `i = 2`:
        - `dp[2] = max(dp[1], dp[0] + houses[2]) = max(3, 2 + 1) = 3`
      - Final `dp` array: `[2, 3, 3]`
      - Return `dp[2] = 3`
    - Result for `case2 = 3`

 6. **Return the maximum of both cases**:
    - `result = max(case1, case2) = max(4, 3) = 4`

 7. **Final Output**: `4`

 ### Summary of the Dry Run:

 - For the input `[1, 2, 3, 1]`, the two scenarios evaluated were:
   1. Robbing houses in the subarray `[1, 2, 3]`, which yielded a maximum of 4.
   2. Robbing houses in the subarray `[2, 3, 1]`, which yielded a maximum of 3.

 - The algorithm returns the maximum of these two results, which is 4.

 Therefore, the maximum amount of money you can rob tonight without alerting the police is `4`.
 */
