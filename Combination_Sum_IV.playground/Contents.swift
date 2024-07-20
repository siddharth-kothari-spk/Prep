/*
 Given an array of distinct integers nums and a target integer target, return the number of possible combinations that add up to target.

 The test cases are generated so that the answer can fit in a 32-bit integer.

  

 Example 1:

 Input: nums = [1,2,3], target = 4
 Output: 7
 Explanation:
 The possible combination ways are:
 (1, 1, 1, 1)
 (1, 1, 2)
 (1, 2, 1)
 (1, 3)
 (2, 1, 1)
 (2, 2)
 (3, 1)
 Note that different sequences are counted as different combinations.
 Example 2:

 Input: nums = [9], target = 3
 Output: 0
 
 */

/*
 To solve this problem, we can use dynamic programming. The idea is to create an array dp where dp[i] represents the number of combinations that add up to i. We initialize dp[0] to 1 because there is exactly one way to reach the target sum of 0, which is by using no numbers at all.

 We then iterate through all the numbers from 1 to the target, and for each number, we iterate through all the elements in nums. If the current number is greater than or equal to the element from nums, we add the number of ways to form the current number minus the element to dp[i].


 */


func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
    // Initialize the dp array where dp[i] is the number of combinations to make up i
    var dp = [Int](repeating: 0, count: target + 1)
    dp[0] = 1  // There's one way to make the target sum of 0, by using no numbers

    // Iterate over each number from 1 to target
    for i in 1...target {
        // Iterate over each number in the given nums array
        for num in nums {
            // If the current number i is greater than or equal to num
            if i >= num {
                dp[i] += dp[i - num]  // Add the number of ways to make up i-num to dp[i]
            }
        }
    }

    return dp[target]
}

// Example usage:
let nums1 = [1, 2, 3]
let target1 = 4
print(combinationSum4(nums1, target1))  // Output: 7

let nums2 = [9]
let target2 = 3
print(combinationSum4(nums2, target2))  // Output: 0

/*
 Sure! Let's perform a dry run of the function `combinationSum4` with the input `nums1 = [1, 2, 3]` and `target1 = 4`.

 ### Initial Setup
 - `nums = [1, 2, 3]`
 - `target = 4`
 - Initialize `dp` array: `dp = [1, 0, 0, 0, 0]` (because `dp[0] = 1`)

 ### Iteration Process
 #### For i = 1
 - For `num = 1`:
   - `i >= num` (1 >= 1), so `dp[1] += dp[1 - 1]` ⟹ `dp[1] += dp[0]` ⟹ `dp[1] = 1`
 - For `num = 2`:
   - `i < num` (1 < 2), so skip this `num`
 - For `num = 3`:
   - `i < num` (1 < 3), so skip this `num`
 - `dp` array after processing `i = 1`: `dp = [1, 1, 0, 0, 0]`

 #### For i = 2
 - For `num = 1`:
   - `i >= num` (2 >= 1), so `dp[2] += dp[2 - 1]` ⟹ `dp[2] += dp[1]` ⟹ `dp[2] = 1`
 - For `num = 2`:
   - `i >= num` (2 >= 2), so `dp[2] += dp[2 - 2]` ⟹ `dp[2] += dp[0]` ⟹ `dp[2] = 2`
 - For `num = 3`:
   - `i < num` (2 < 3), so skip this `num`
 - `dp` array after processing `i = 2`: `dp = [1, 1, 2, 0, 0]`

 #### For i = 3
 - For `num = 1`:
   - `i >= num` (3 >= 1), so `dp[3] += dp[3 - 1]` ⟹ `dp[3] += dp[2]` ⟹ `dp[3] = 2`
 - For `num = 2`:
   - `i >= num` (3 >= 2), so `dp[3] += dp[3 - 2]` ⟹ `dp[3] += dp[1]` ⟹ `dp[3] = 3`
 - For `num = 3`:
   - `i >= num` (3 >= 3), so `dp[3] += dp[3 - 3]` ⟹ `dp[3] += dp[0]` ⟹ `dp[3] = 4`
 - `dp` array after processing `i = 3`: `dp = [1, 1, 2, 4, 0]`

 #### For i = 4
 - For `num = 1`:
   - `i >= num` (4 >= 1), so `dp[4] += dp[4 - 1]` ⟹ `dp[4] += dp[3]` ⟹ `dp[4] = 4`
 - For `num = 2`:
   - `i >= num` (4 >= 2), so `dp[4] += dp[4 - 2]` ⟹ `dp[4] += dp[2]` ⟹ `dp[4] = 6`
 - For `num = 3`:
   - `i >= num` (4 >= 3), so `dp[4] += dp[4 - 3]` ⟹ `dp[4] += dp[1]` ⟹ `dp[4] = 7`
 - `dp` array after processing `i = 4`: `dp = [1, 1, 2, 4, 7]`

 ### Result
 - The value of `dp[4]` is 7, which means there are 7 combinations that add up to the target 4.

 So, the output for the input `nums1 = [1, 2, 3]` and `target1 = 4` is `7`.

 ### Explanation of Combinations
 The combinations are:
 1. (1, 1, 1, 1)
 2. (1, 1, 2)
 3. (1, 2, 1)
 4. (1, 3)
 5. (2, 1, 1)
 6. (2, 2)
 7. (3, 1)

 Therefore, `print(combinationSum4(nums1, target1))` will output `7`.
 */
