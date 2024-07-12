/*
 Given a positive integer n, return the number of the integers in the range [0, n] whose binary representations do not contain consecutive ones.

  

 Example 1:

 Input: n = 5
 Output: 5
 Explanation:
 Here are the non-negative integers <= 5 with their corresponding binary representations:
 0 : 0
 1 : 1
 2 : 10
 3 : 11
 4 : 100
 5 : 101
 Among them, only integer 3 disobeys the rule (two consecutive ones) and the other 5 satisfy the rule.
 Example 2:

 Input: n = 1
 Output: 2
 Example 3:

 Input: n = 2
 Output: 3
  

 Constraints:

 1 <= n <= 10^9
 */

/*
 To solve the problem of counting numbers whose binary representations do not contain consecutive ones, we can use a dynamic programming approach. The key observation is that such numbers follow the Fibonacci sequence.

 Here's the step-by-step algorithm to solve the problem:

 Algorithm
 Convert the number to binary:
 Convert the given number n to its binary representation as a string.

 Dynamic Programming Setup:
 Create a dp array where dp[i] will store the count of valid binary numbers of length i.

 Initialize the base cases:

 dp[0] = 1 (an empty string is considered as one valid number).
 dp[1] = 2 (the valid numbers are "0" and "1").
 Fill the DP array using Fibonacci sequence:
 For i from 2 to the length of the binary representation of n:

 dp[i] = dp[i-1] + dp[i-2]
 Count the valid numbers:
 Traverse through the binary representation of n from the most significant bit to the least significant bit to count the valid numbers without consecutive ones. Use a flag to detect consecutive ones.

 Return the count:
 Return the final count of numbers whose binary representations do not contain consecutive ones.


 */

func findIntegers(_ n: Int) -> Int {
    // Step 1: Convert n to binary representation
    let binRep = String(n, radix: 2)
    print("binRep: \(binRep)")
    let length = binRep.count
    print("length: \(length)")
    
    // Step 2: Initialize dp array
    var dp = [Int](repeating: 0, count: length + 1)
    
    // Step 3: Base cases
    dp[0] = 1
    dp[1] = 2
    
    if dp.count == 2 {
        return 2
    }
    // Step 4: Fill the dp array
    for i in 2...length {
        dp[i] = dp[i - 1] + dp[i - 2]
    }
    print("dp: \(dp)")
    // Step 5: Count valid numbers
    var count = 0
    var prevBit = 0
    
    for (i, char) in binRep.enumerated() {
        print("i: \(i), char: \(char)")
        if char == "1" {
            count += dp[length - i - 1]
            if prevBit == 1 {
                return count
            }
            prevBit = 1
        } else {
            prevBit = 0
        }
    }
    
    return count + 1
}

// Example usage
print(findIntegers(5))  // Output: 5
print(findIntegers(1))  // Output: 2
print(findIntegers(2))  // Output: 3

/*
 Sure, let's do a dry run of the `findIntegers` function with `n = 5`:

 ### Dry Run of `findIntegers(5)`

 1. **Step 1: Convert `n` to binary representation**
    - `n = 5`
    - Binary representation: `binRep = "101"`

 2. **Step 2: Initialize `dp` array**
    - `length = binRep.count = 3`
    - `dp = [Int](repeating: 0, count: length + 1) = [0, 0, 0, 0]`

 3. **Step 3: Base cases**
    - `dp[0] = 1`
    - `dp[1] = 2`
    - `dp = [1, 2, 0, 0]`

 4. **Step 4: Fill the `dp` array**
    - For `i = 2`:
      - `dp[2] = dp[1] + dp[0] = 2 + 1 = 3`
    - For `i = 3`:
      - `dp[3] = dp[2] + dp[1] = 3 + 2 = 5`
    - `dp = [1, 2, 3, 5]`

 5. **Step 5: Count valid numbers**
    - Initialize `count = 0` and `prevBit = 0`
    - Iterate over the binary representation of `n`:
      - `i = 0`, `char = "1"`
        - `count += dp[length - i - 1] = count + dp[3 - 0 - 1] = 0 + 3 = 3`
        - Check if `prevBit == 1`: `prevBit = 0`, so do not return
        - Update `prevBit = 1`
      - `i = 1`, `char = "0"`
        - `prevBit = 1` (from previous step)
        - Update `prevBit = 0`
      - `i = 2`, `char = "1"`
        - `count += dp[length - i - 1] = count + dp[3 - 2 - 1] = 3 + 1 = 4`
        - Check if `prevBit == 1`: `prevBit = 0`, so do not return
        - Update `prevBit = 1`

 6. **Return the count**
    - Final count after loop: `count = 4`
    - Return `count + 1 = 4 + 1 = 5`

 ### Explanation of the Output:
 - Binary numbers ≤ 5: `0 (0)`, `1 (1)`, `2 (10)`, `4 (100)`, `5 (101)`
 - Among them, only integer `3 (11)` disobeys the rule (contains two consecutive ones).
 - Thus, the output is `5`.

 ```swift
 print(findIntegers(5))  // Output: 5
 ```

 The dry run confirms that the function correctly counts the numbers whose binary representations do not contain consecutive ones, and the expected output is `5`.
 */
