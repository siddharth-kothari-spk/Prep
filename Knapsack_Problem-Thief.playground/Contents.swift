/*
 Imagine you're a thief planning a heist and have a backpack (knapsack) with a limited weight capacity. There are various items in the vault, each with a specific weight and value. You want to steal the items with the maximum total value that fit within your weight limit.
 */

func knapsack(_ items: [(value: Int, weight: Int)],_ capacity: Int) -> Int {
  let n = items.count

  // Create a table to store solutions to subproblems
  var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: capacity + 1), count: n + 1)

  // Build the table iteratively
  for i in 1...n {
      print("************")
      print("i: \(i)")
    let (value, weight) = items[i - 1]
    for j in 0...capacity {
      // Exclude current item if weight exceeds capacity
      if weight > j {
        dp[i][j] = dp[i - 1][j]
      } else {
        // Include or exclude current item based on higher value
        dp[i][j] = max(dp[i - 1][j], value + dp[i - 1][j - weight])
      }
    }
      print("dp[i]: \(dp[i])")
  }

  // Return the maximum value achievable
 // print(dp)
  return dp[n][capacity]
}

// v =  , , 4, 4, 5, 7, 8, 8i, w = , , , 4, 3, 9, 2, 11, 5i, and W = 15.
var input: [(Int,Int)] = [(1,4),(2,5),(3,1)]//[(2,3), (3,5), (3,7), (4,4), (4,3), (5,9), (7,2), (8,11), (8,5)]
let capacity = 5//15
print(knapsack(input, capacity))


/*
 In the Knapsack problem solved using Dynamic Programming, the extra column and row in the `dp` array serve two important purposes:

 1. **Handling Base Cases:**

   * The extra **column (index 0)** represents a knapsack with **zero weight capacity**.
   Since no item can fit in a knapsack with zero weight, all values in this column are initialized to 0. This acts as the base case for the weight dimension.

   * The extra **row (index 0)** represents a scenario with **zero items**.
   No matter the knapsack capacity, with no items, the maximum value achievable is 0. This acts as the base case for the item dimension.

   By initializing these extra elements, we ensure the `dp` table can handle any combination of items and weight capacities during the iterative build process.

 2. **Efficient Calculation of Maximum Value:**

   The core logic of the Knapsack problem with Dynamic Programming involves considering whether to include or exclude an item at each step. The extra column and row simplify this logic:

   * When the weight `j` is 0 (column 0), the only option is to exclude the current item. So, the value in `dp[i][j]` is simply copied from the previous row `dp[i-1][j]`.

   * When there are no items (`i` is 0), the only option is to use a knapsack with zero capacity. Since nothing fits, the maximum value achievable (`dp[i][j]`) is always 0 (value from row 0).

   By having these pre-defined values in the extra column and row, we can efficiently calculate the maximum value for each cell in the `dp` table by considering including or excluding the current item based on the values in the previous row and column. This simplifies the logic and avoids unnecessary checks for these special cases.

 */
