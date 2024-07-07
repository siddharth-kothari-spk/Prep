/*
 https://leetcode.com/problems/target-sum/description/
 You are given an integer array nums and an integer target.

 You want to build an expression out of nums by adding one of the symbols '+' and '-' before each integer in nums and then concatenate all the integers.

 For example, if nums = [2, 1], you can add a '+' before 2 and a '-' before 1 and concatenate them to build the expression "+2-1".
 Return the number of different expressions that you can build, which evaluates to target.

  

 Example 1:

 Input: nums = [1,1,1,1,1], target = 3
 Output: 5
 Explanation: There are 5 ways to assign symbols to make the sum of nums be target 3.
 -1 + 1 + 1 + 1 + 1 = 3
 +1 - 1 + 1 + 1 + 1 = 3
 +1 + 1 - 1 + 1 + 1 = 3
 +1 + 1 + 1 - 1 + 1 = 3
 +1 + 1 + 1 + 1 - 1 = 3
 Example 2:

 Input: nums = [1], target = 1
 Output: 1
 */

func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
    var dp = [Int: Int]()
    dp[0] = 1

    for num in nums {
        var nextDp = [Int: Int]()
        for (sum, count) in dp {
            let sumPlus = sum + num
            let sumMinus = sum - num

            nextDp[sumPlus, default: 0] += count
            nextDp[sumMinus, default: 0] += count
        }
        dp = nextDp
    }

    return dp[target, default: 0]
}

// Example usage:
let nums1 = [1, 1, 1, 1, 1]
let target1 = 3
print(findTargetSumWays(nums1, target1))  // Output: 5

let nums2 = [1]
let target2 = 1
print(findTargetSumWays(nums2, target2))  // Output: 1

/*
 Sure, let's do a dry run of the `findTargetSumWays` function for `nums1 = [1, 1, 1, 1, 1]` and `target1 = 3`.

 ### Initialization:

 - Initialize `dp` with `[0: 1]`. This means there is one way to achieve a sum of 0 with no elements.

 ### Iteration through `nums`:

 #### Iteration 1 (num = 1):
 - `dp` before processing: `[0: 1]`
 - Process `sum = 0`:
   - `sumPlus = 0 + 1 = 1`
   - `sumMinus = 0 - 1 = -1`
   - Update `nextDp`: `[1: 1, -1: 1]`
 - Update `dp` to `nextDp`: `[1: 1, -1: 1]`

 #### Iteration 2 (num = 1):
 - `dp` before processing: `[1: 1, -1: 1]`
 - Process `sum = 1`:
   - `sumPlus = 1 + 1 = 2`
   - `sumMinus = 1 - 1 = 0`
   - Update `nextDp`: `[2: 1, 0: 1]`
 - Process `sum = -1`:
   - `sumPlus = -1 + 1 = 0`
   - `sumMinus = -1 - 1 = -2`
   - Update `nextDp`: `[2: 1, 0: 2, -2: 1]`
 - Update `dp` to `nextDp`: `[2: 1, 0: 2, -2: 1]`

 #### Iteration 3 (num = 1):
 - `dp` before processing: `[2: 1, 0: 2, -2: 1]`
 - Process `sum = 2`:
   - `sumPlus = 2 + 1 = 3`
   - `sumMinus = 2 - 1 = 1`
   - Update `nextDp`: `[3: 1, 1: 1]`
 - Process `sum = 0`:
   - `sumPlus = 0 + 1 = 1`
   - `sumMinus = 0 - 1 = -1`
   - Update `nextDp`: `[3: 1, 1: 3, -1: 2]`
 - Process `sum = -2`:
   - `sumPlus = -2 + 1 = -1`
   - `sumMinus = -2 - 1 = -3`
   - Update `nextDp`: `[3: 1, 1: 3, -1: 3, -3: 1]`
 - Update `dp` to `nextDp`: `[3: 1, 1: 3, -1: 3, -3: 1]`

 #### Iteration 4 (num = 1):
 - `dp` before processing: `[3: 1, 1: 3, -1: 3, -3: 1]`
 - Process `sum = 3`:
   - `sumPlus = 3 + 1 = 4`
   - `sumMinus = 3 - 1 = 2`
   - Update `nextDp`: `[4: 1, 2: 1]`
 - Process `sum = 1`:
   - `sumPlus = 1 + 1 = 2`
   - `sumMinus = 1 - 1 = 0`
   - Update `nextDp`: `[4: 1, 2: 4, 0: 3]`
 - Process `sum = -1`:
   - `sumPlus = -1 + 1 = 0`
   - `sumMinus = -1 - 1 = -2`
   - Update `nextDp`: `[4: 1, 2: 4, 0: 6, -2: 3]`
 - Process `sum = -3`:
   - `sumPlus = -3 + 1 = -2`
   - `sumMinus = -3 - 1 = -4`
   - Update `nextDp`: `[4: 1, 2: 4, 0: 6, -2: 4, -4: 1]`
 - Update `dp` to `nextDp`: `[4: 1, 2: 4, 0: 6, -2: 4, -4: 1]`

 #### Iteration 5 (num = 1):
 - `dp` before processing: `[4: 1, 2: 4, 0: 6, -2: 4, -4: 1]`
 - Process `sum = 4`:
   - `sumPlus = 4 + 1 = 5`
   - `sumMinus = 4 - 1 = 3`
   - Update `nextDp`: `[5: 1, 3: 1]`
 - Process `sum = 2`:
   - `sumPlus = 2 + 1 = 3`
   - `sumMinus = 2 - 1 = 1`
   - Update `nextDp`: `[5: 1, 3: 5, 1: 4]`
 - Process `sum = 0`:
   - `sumPlus = 0 + 1 = 1`
   - `sumMinus = 0 - 1 = -1`
   - Update `nextDp`: `[5: 1, 3: 5, 1: 10, -1: 6]`
 - Process `sum = -2`:
   - `sumPlus = -2 + 1 = -1`
   - `sumMinus = -2 - 1 = -3`
   - Update `nextDp`: `[5: 1, 3: 5, 1: 10, -1: 10, -3: 4]`
 - Process `sum = -4`:
   - `sumPlus = -4 + 1 = -3`
   - `sumMinus = -4 - 1 = -5`
   - Update `nextDp`: `[5: 1, 3: 5, 1: 10, -1: 10, -3: 5, -5: 1]`
 - Update `dp` to `nextDp`: `[5: 1, 3: 5, 1: 10, -1: 10, -3: 5, -5: 1]`

 ### Final result:

 - `dp[target]` or `dp[3] = 5`

 Thus, there are 5 ways to assign symbols to the numbers `[1, 1, 1, 1, 1]` to achieve the target sum of 3.
 */


/*
 Certainly! Let's walk through the dry run using the Swift code:



 ### Dry Run for `nums1 = [1, 1, 1, 1, 1]` and `target1 = 3`

 #### Initialization:
 - `dp` is initialized with `[0: 1]`.

 #### Iteration 1 (num = 1):
 - `dp` before processing: `[0: 1]`
 - Initialize `nextDp` as `[:]`.

 - Process `sum = 0`:
   - `sumPlus = 0 + 1 = 1`
   - `sumMinus = 0 - 1 = -1`
   - Update `nextDp`: `nextDp[1] = nextDp.get(1, 0) + dp[0]` -> `nextDp[1] = 0 + 1 = 1`
   - Update `nextDp`: `nextDp[-1] = nextDp.get(-1, 0) + dp[0]` -> `nextDp[-1] = 0 + 1 = 1`
 - `nextDp` now: `[1: 1, -1: 1]`
 - Update `dp` to `nextDp`: `[1: 1, -1: 1]`

 #### Iteration 2 (num = 1):
 - `dp` before processing: `[1: 1, -1: 1]`
 - Initialize `nextDp` as `[:]`.

 - Process `sum = 1`:
   - `sumPlus = 1 + 1 = 2`
   - `sumMinus = 1 - 1 = 0`
   - Update `nextDp`: `nextDp[2] = nextDp.get(2, 0) + dp[1]` -> `nextDp[2] = 0 + 1 = 1`
   - Update `nextDp`: `nextDp[0] = nextDp.get(0, 0) + dp[1]` -> `nextDp[0] = 0 + 1 = 1`
 - `nextDp` now: `[2: 1, 0: 1]`

 - Process `sum = -1`:
   - `sumPlus = -1 + 1 = 0`
   - `sumMinus = -1 - 1 = -2`
   - Update `nextDp`: `nextDp[0] = nextDp.get(0, 0) + dp[-1]` -> `nextDp[0] = 1 + 1 = 2`
   - Update `nextDp`: `nextDp[-2] = nextDp.get(-2, 0) + dp[-1]` -> `nextDp[-2] = 0 + 1 = 1`
 - `nextDp` now: `[2: 1, 0: 2, -2: 1]`
 - Update `dp` to `nextDp`: `[2: 1, 0: 2, -2: 1]`

 #### Iteration 3 (num = 1):
 - `dp` before processing: `[2: 1, 0: 2, -2: 1]`
 - Initialize `nextDp` as `[:]`.

 - Process `sum = 2`:
   - `sumPlus = 2 + 1 = 3`
   - `sumMinus = 2 - 1 = 1`
   - Update `nextDp`: `nextDp[3] = nextDp.get(3, 0) + dp[2]` -> `nextDp[3] = 0 + 1 = 1`
   - Update `nextDp`: `nextDp[1] = nextDp.get(1, 0) + dp[2]` -> `nextDp[1] = 0 + 1 = 1`
 - `nextDp` now: `[3: 1, 1: 1]`

 - Process `sum = 0`:
   - `sumPlus = 0 + 1 = 1`
   - `sumMinus = 0 - 1 = -1`
   - Update `nextDp`: `nextDp[1] = nextDp.get(1, 0) + dp[0]` -> `nextDp[1] = 1 + 2 = 3`
   - Update `nextDp`: `nextDp[-1] = nextDp.get(-1, 0) + dp[0]` -> `nextDp[-1] = 0 + 2 = 2`
 - `nextDp` now: `[3: 1, 1: 3, -1: 2]`

 - Process `sum = -2`:
   - `sumPlus = -2 + 1 = -1`
   - `sumMinus = -2 - 1 = -3`
   - Update `nextDp`: `nextDp[-1] = nextDp.get(-1, 0) + dp[-2]` -> `nextDp[-1] = 2 + 1 = 3`
   - Update `nextDp`: `nextDp[-3] = nextDp.get(-3, 0) + dp[-2]` -> `nextDp[-3] = 0 + 1 = 1`
 - `nextDp` now: `[3: 1, 1: 3, -1: 3, -3: 1]`
 - Update `dp` to `nextDp`: `[3: 1, 1: 3, -1: 3, -3: 1]`

 ### Detailed Explanation:
 - When processing `sum = 2`:
   - `sumPlus = 3`, so `nextDp[3]` becomes `1`.
   - `sumMinus = 1`, so `nextDp[1]` becomes `1`.

 - When processing `sum = 0`:
   - `sumPlus = 1`, so `nextDp[1]` is updated from `1` to `3` because there are two ways to reach `0` from previous steps.
   - `sumMinus = -1`, so `nextDp[-1]` becomes `2`.

 - When processing `sum = -2`:
   - `sumPlus = -1`, so `nextDp[-1]` is updated from `2` to `3` because there is one way to reach `-2` from previous steps.
   - `sumMinus = -3`, so `nextDp[-3]` becomes `1`.

 By the end of the third iteration, the values for `nextDp` correctly reflect all possible ways to sum up to each key using three `1`s. This process continues for all elements in `nums`.

 Finally, the number of ways to get the target sum `3` is found in `dp[3]`, which is `5`.
 */
