/*
 https://leetcode.com/problems/coin-change/description/
 You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

 Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

 You may assume that you have an infinite number of each kind of coin.

  

 Example 1:

 Input: coins = [1,2,5], amount = 11
 Output: 3
 Explanation: 11 = 5 + 5 + 1
 Example 2:

 Input: coins = [2], amount = 3
 Output: -1
 Example 3:

 Input: coins = [1], amount = 0
 Output: 0
  

 Constraints:

 1 <= coins.length <= 12
 1 <= coins[i] <= 231 - 1
 0 <= amount <= 104
 */

/*
 Here's an algorithm to solve the problem using dynamic programming:

 Initialization:

 Create an array dp of size amount + 1 initialized with amount + 1 (which acts as infinity for this problem).
 Set dp[0] to 0 because the minimum number of coins needed to make amount 0 is 0.
 Dynamic Programming:

 Iterate over each amount from 1 to amount.
 For each coin in coins, if the coin is less than or equal to the current amount, update dp[current amount] to the minimum of its current value and dp[current amount - coin] + 1.
 Result:

 If dp[amount] is still amount + 1, return -1 because it's not possible to make that amount with the given coins.
 Otherwise, return dp[amount].
 */

func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    guard amount > 0 else {
        return 0
    }
    // Step 1: Initialize dp array
    var dp = [Int](repeating: amount + 1, count: amount + 1)
    dp[0] = 0
    
    // Step 2: Dynamic programming
    for a in 1...amount {
        for coin in coins {
            if coin <= a {
                dp[a] = min(dp[a], dp[a - coin] + 1)
            }
        }
    }
    
    // Step 3: Return result
    return dp[amount] == amount + 1 ? -1 : dp[amount]
}

// Example usage:
print(coinChange([1, 2, 5], 11))  // Output: 3
print(coinChange([2], 3))         // Output: -1
print(coinChange([1], 0))         // Output: 0

/*
 Sure, let's do a dry run for the example `print(coinChange([1, 2, 5], 11))`.

 ### Initialization:
 - `coins` = [1, 2, 5]
 - `amount` = 11
 - `dp` = [0, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12]

 ### Dynamic Programming:
 We iterate over each amount from 1 to 11 and update the `dp` array accordingly.

 #### Amount = 1:
 - For coin = 1:
   - Since 1 <= 1, update `dp[1] = min(dp[1], dp[1 - 1] + 1) = min(12, 0 + 1) = 1`
 - `dp` = [0, 1, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12]

 #### Amount = 2:
 - For coin = 1:
   - Since 1 <= 2, update `dp[2] = min(dp[2], dp[2 - 1] + 1) = min(12, 1 + 1) = 2`
 - For coin = 2:
   - Since 2 <= 2, update `dp[2] = min(dp[2], dp[2 - 2] + 1) = min(2, 0 + 1) = 1`
 - `dp` = [0, 1, 1, 12, 12, 12, 12, 12, 12, 12, 12, 12]

 #### Amount = 3:
 - For coin = 1:
   - Since 1 <= 3, update `dp[3] = min(dp[3], dp[3 - 1] + 1) = min(12, 1 + 1) = 2`
 - For coin = 2:
   - Since 2 <= 3, update `dp[3] = min(dp[3], dp[3 - 2] + 1) = min(2, 1 + 1) = 2`
 - `dp` = [0, 1, 1, 2, 12, 12, 12, 12, 12, 12, 12, 12]

 #### Amount = 4:
 - For coin = 1:
   - Since 1 <= 4, update `dp[4] = min(dp[4], dp[4 - 1] + 1) = min(12, 2 + 1) = 3`
 - For coin = 2:
   - Since 2 <= 4, update `dp[4] = min(dp[4], dp[4 - 2] + 1) = min(3, 1 + 1) = 2`
 - `dp` = [0, 1, 1, 2, 2, 12, 12, 12, 12, 12, 12, 12]

 #### Amount = 5:
 - For coin = 1:
   - Since 1 <= 5, update `dp[5] = min(dp[5], dp[5 - 1] + 1) = min(12, 2 + 1) = 3`
 - For coin = 2:
   - Since 2 <= 5, update `dp[5] = min(dp[5], dp[5 - 2] + 1) = min(3, 2 + 1) = 3`
 - For coin = 5:
   - Since 5 <= 5, update `dp[5] = min(dp[5], dp[5 - 5] + 1) = min(3, 0 + 1) = 1`
 - `dp` = [0, 1, 1, 2, 2, 1, 12, 12, 12, 12, 12, 12]

 #### Amount = 6:
 - For coin = 1:
   - Since 1 <= 6, update `dp[6] = min(dp[6], dp[6 - 1] + 1) = min(12, 1 + 1) = 2`
 - For coin = 2:
   - Since 2 <= 6, update `dp[6] = min(dp[6], dp[6 - 2] + 1) = min(2, 2 + 1) = 2`
 - For coin = 5:
   - Since 5 <= 6, update `dp[6] = min(dp[6], dp[6 - 5] + 1) = min(2, 1 + 1) = 2`
 - `dp` = [0, 1, 1, 2, 2, 1, 2, 12, 12, 12, 12, 12]

 #### Amount = 7:
 - For coin = 1:
   - Since 1 <= 7, update `dp[7] = min(dp[7], dp[7 - 1] + 1) = min(12, 2 + 1) = 3`
 - For coin = 2:
   - Since 2 <= 7, update `dp[7] = min(dp[7], dp[7 - 2] + 1) = min(3, 2 + 1) = 2`
 - For coin = 5:
   - Since 5 <= 7, update `dp[7] = min(dp[7], dp[7 - 5] + 1) = min(2, 1 + 1) = 2`
 - `dp` = [0, 1, 1, 2, 2, 1, 2, 2, 12, 12, 12, 12]

 #### Amount = 8:
 - For coin = 1:
   - Since 1 <= 8, update `dp[8] = min(dp[8], dp[8 - 1] + 1) = min(12, 2 + 1) = 3`
 - For coin = 2:
   - Since 2 <= 8, update `dp[8] = min(dp[8], dp[8 - 2] + 1) = min(3, 2 + 1) = 3`
 - For coin = 5:
   - Since 5 <= 8, update `dp[8] = min(dp[8], dp[8 - 5] + 1) = min(3, 2 + 1) = 3`
 - `dp` = [0, 1, 1, 2, 2, 1, 2, 2, 3, 12, 12, 12]

 #### Amount = 9:
 - For coin = 1:
   - Since 1 <= 9, update `dp[9] = min(dp[9], dp[9 - 1] + 1) = min(12, 3 + 1) = 4`
 - For coin = 2:
   - Since 2 <= 9, update `dp[9] = min(dp[9], dp[9 - 2] + 1) = min(4, 2 + 1) = 3`
 - For coin = 5:
   - Since 5 <= 9, update `dp[9] = min(dp[9], dp[9 - 5] + 1) = min(3, 2 + 1) = 3`
 - `dp` = [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 12, 12]

 #### Amount = 10:
 - For coin = 1:
   - Since 1 <= 10, update `dp[10] = min(dp[10], dp[10 - 1] + 1) = min(12, 3 + 1) = 4`
 - For coin = 2:
   - Since 2 <= 10, update `dp[10] = min(dp[10], dp[10 - 2] + 1) = min(4, 3 + 1) = 4`
 - For coin = 5:
   - Since 5 <= 10, update `dp[10] = min(dp[10], dp[10 - 5] + 1) = min(4, 1 + 1) = 2`
 - `dp` = [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 12]

 #### Amount = 11:
 - For coin = 1:
   - Since 1 <= 11, update `dp[11] = min(dp[11], dp[11 - 1] + 1) = min(12, 2 + 1) = 3`
 - For coin = 2:
   - Since 2 <= 11, update `dp[11] = min(dp[11], dp[11 - 2] + 1) = min(3, 3 + 1

 ) = 3`
 - For coin = 5:
   - Since 5 <= 11, update `dp[11] = min(dp[11], dp[11 - 5] + 1) = min(3, 2 + 1) = 3`
 - `dp` = [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 3]

 ### Result:
 - `dp[11] = 3`, so the minimum number of coins needed to make amount 11 is 3.
 - The function returns `3`.

 Thus, the dry run for `print(coinChange([1, 2, 5], 11))` results in `3`, meaning the fewest number of coins needed to make up 11 is 3 (5 + 5 + 1).
 */
