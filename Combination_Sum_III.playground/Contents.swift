/*
 https://leetcode.com/problems/combination-sum-iii/description/
 Find all valid combinations of k numbers that sum up to n such that the following conditions are true:

 Only numbers 1 through 9 are used.
 Each number is used at most once.
 Return a list of all possible valid combinations. The list must not contain the same combination twice, and the combinations may be returned in any order.

  

 Example 1:

 Input: k = 3, n = 7
 Output: [[1,2,4]]
 Explanation:
 1 + 2 + 4 = 7
 There are no other valid combinations.
 Example 2:

 Input: k = 3, n = 9
 Output: [[1,2,6],[1,3,5],[2,3,4]]
 Explanation:
 1 + 2 + 6 = 9
 1 + 3 + 5 = 9
 2 + 3 + 4 = 9
 There are no other valid combinations.
 Example 3:

 Input: k = 4, n = 1
 Output: []
 Explanation: There are no valid combinations.
 Using 4 different numbers in the range [1,9], the smallest sum we can get is 1+2+3+4 = 10 and since 10 > 1, there are no valid combination.
  

 Constraints:

 2 <= k <= 9
 1 <= n <= 60
 */

class Solution {
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var result = [[Int]]()
        
        func backtrack(_ start: Int, _ remainingK: Int, _ remainingN: Int, _ path: inout [Int]) {
//            print("***********")
//            print("start: \(start), remainingK: \(remainingK), remainingN: \(remainingK), path: \(path)")
//            print("result: \(result)")
            if remainingK == 0 && remainingN == 0 {
                result.append(path)
                return
            }
            if remainingK == 0 || remainingN < 0 {
                return
            }
            if start > 9 {
                return
            }
            for i in start...9 {
                path.append(i)
                backtrack(i + 1, remainingK - 1, remainingN - i, &path)
                path.removeLast()
            }
        }
        
        var path = [Int]()
        backtrack(1, k, n, &path)
        return result
    }
}

// Examples
let solution = Solution()
print(solution.combinationSum3(3, 7))  // Output: [[1, 2, 4]]
print(solution.combinationSum3(3, 9))  // Output: [[1, 2, 6], [1, 3, 5], [2, 3, 4]]
print(solution.combinationSum3(4, 1))  // Output: []

/*
 Explanation:
 Solution Class: Defines the main class where the function combinationSum3 is implemented.
 combinationSum3(_ k: Int, _ n: Int): This function initializes the result list and starts the backtracking process.
 backtrack(_ start: Int, _ remainingK: Int, _ remainingN: Int, _ path: inout [Int]): The recursive helper function that explores all possible combinations.
 base cases:
 If remainingK == 0 and remainingN == 0: A valid combination is found, so add the current path to the result.
 If remainingK == 0 or remainingN < 0: Terminate the current path as it's invalid.
 iteration:
 Iterate through numbers from start to 9.
 For each number i, add it to the current path, recursively call backtrack with updated parameters, and then remove i from the path (backtrack).
 */

/*
 Sure, let's walk through a dry run of the function call `solution.combinationSum3(3, 9)` step-by-step:

 ### Initial Call
 `combinationSum3(3, 9)` is called.

 - `result` is initialized as an empty list `[]`.
 - `path` is initialized as an empty list `[]`.
 - `backtrack(1, 3, 9, &path)` is called.

 ### Backtracking Process

 1. **First Level of Recursion (start=1, remainingK=3, remainingN=9)**
    - Loop from `1` to `9`.
    - **i=1**:
      - Append `1` to `path` → `path = [1]`.
      - Call `backtrack(2, 2, 8, &path)`.

 2. **Second Level of Recursion (start=2, remainingK=2, remainingN=8)**
    - Loop from `2` to `9`.
    - **i=2**:
      - Append `2` to `path` → `path = [1, 2]`.
      - Call `backtrack(3, 1, 6, &path)`.

 3. **Third Level of Recursion (start=3, remainingK=1, remainingN=6)**
    - Loop from `3` to `9`.
    - **i=3**:
      - Append `3` to `path` → `path = [1, 2, 3]`.
      - Call `backtrack(4, 0, 3, &path)`.
    - **Backtrack**: RemainingK is `0`, but RemainingN is not `0`. Remove `3` from `path` → `path = [1, 2]`.
    - **i=4**:
      - Append `4` to `path` → `path = [1, 2, 4]`.
      - Call `backtrack(5, 0, 2, &path)`.
    - **Backtrack**: RemainingK is `0`, but RemainingN is not `0`. Remove `4` from `path` → `path = [1, 2]`.
    - **i=5**:
      - Append `5` to `path` → `path = [1, 2, 5]`.
      - Call `backtrack(6, 0, 1, &path)`.
    - **Backtrack**: RemainingK is `0`, but RemainingN is not `0`. Remove `5` from `path` → `path = [1, 2]`.
    - **i=6**:
      - Append `6` to `path` → `path = [1, 2, 6]`.
      - Call `backtrack(7, 0, 0, &path)`.
    - **Success**: RemainingK is `0` and RemainingN is `0`. Add `[1, 2, 6]` to `result` → `result = [[1, 2, 6]]`.
    - Remove `6` from `path` → `path = [1, 2]`.
    - **Backtrack**: Continue with i from `7` to `9`, but they will not be valid (RemainingN will be negative).

 4. **Backtrack to Second Level (start=2, remainingK=2, remainingN=8)**
    - **Backtrack**: Remove `2` from `path` → `path = [1]`.
    - **i=3**:
      - Append `3` to `path` → `path = [1, 3]`.
      - Call `backtrack(4, 1, 5, &path)`.

 5. **Third Level of Recursion (start=4, remainingK=1, remainingN=5)**
    - Loop from `4` to `9`.
    - **i=4**:
      - Append `4` to `path` → `path = [1, 3, 4]`.
      - Call `backtrack(5, 0, 1, &path)`.
    - **Backtrack**: RemainingK is `0`, but RemainingN is not `0`. Remove `4` from `path` → `path = [1, 3]`.
    - **i=5**:
      - Append `5` to `path` → `path = [1, 3, 5]`.
      - Call `backtrack(6, 0, 0, &path)`.
    - **Success**: RemainingK is `0` and RemainingN is `0`. Add `[1, 3, 5]` to `result` → `result = [[1, 2, 6], [1, 3, 5]]`.
    - Remove `5` from `path` → `path = [1, 3]`.
    - **Backtrack**: Continue with i from `6` to `9`, but they will not be valid (RemainingN will be negative).

 6. **Backtrack to Second Level (start=2, remainingK=2, remainingN=8)**
    - **Backtrack**: Remove `3` from `path` → `path = [1]`.
    - **i=4**:
      - Append `4` to `path` → `path = [1, 4]`.
      - Call `backtrack(5, 1, 4, &path)`.

 7. **Third Level of Recursion (start=5, remainingK=1, remainingN=4)**
    - Loop from `5` to `9`.
    - **i=5**:
      - Append `5` to `path` → `path = [1, 4, 5]`.
      - Call `backtrack(6, 0, -1, &path)`.
    - **Backtrack**: RemainingN is negative. Remove `5` from `path` → `path = [1, 4]`.
    - **i=6**:
      - Append `6` to `path` → `path = [1, 4, 6]`.
      - Call `backtrack(7, 0, -2, &path)`.
    - **Backtrack**: RemainingN is negative. Remove `6` from `path` → `path = [1, 4]`.
    - **Backtrack**: Continue with i from `7` to `9`, but they will not be valid (RemainingN will be negative).

 8. **Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
    - **Backtrack**: Remove `1` from `path` → `path = []`.
    - **i=2**:
      - Append `2` to `path` → `path = [2]`.
      - Call `backtrack(3, 2, 7, &path)`.

 9. **Second Level of Recursion (start=3, remainingK=2, remainingN=7)**
    - Loop from `3` to `9`.
    - **i=3**:
      - Append `3` to `path` → `path = [2, 3]`.
      - Call `backtrack(4, 1, 4, &path)`.

 10. **Third Level of Recursion (start=4, remainingK=1, remainingN=4)**
     - Loop from `4` to `9`.
     - **i=4**:
       - Append `4` to `path` → `path = [2, 3, 4]`.
       - Call `backtrack(5, 0, 0, &path)`.
     - **Success**: RemainingK is `0` and RemainingN is `0`. Add `[2, 3, 4]` to `result` → `result = [[1, 2, 6], [1, 3, 5], [2, 3, 4]]`.
     - Remove `4` from `path` → `path = [2, 3]`.
     - **Backtrack**: Continue with i from `5` to `9`, but they will not be valid (RemainingN will be negative).

 11. **Backtrack to Second Level (start=3, remainingK=2, remainingN=7)**
     - **Backtrack**: Remove `3` from `path` → `path = [2]`.
     - **i=4**:
       - Append `4` to `path` → `path = [2, 4]`.
       - Call `backtrack(5, 1, 3, &path)`.

 12. **Third Level of Recursion (start=5, remainingK=1, remainingN=3)**
     - Loop from `5` to `9`.
     - **i=5**:
       - Append `5` to `path` → `path = [2, 4, 5]`.
       - Call `backtrack(6, 0, -2, &path)`.
     - **Backtrack**: RemainingN is negative. Remove `5` from `path` → `path = [2, 4]`.
     - **Backtrack**: Continue with i from `6` to `9`, but they will not be valid (RemainingN will be negative).

 13. **

 Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
     - **Backtrack**: Remove `2` from `path` → `path = []`.
     - **i=3**:
       - Append `3` to `path` → `path = [3]`.
       - Call `backtrack(4, 2, 6, &path)`.

 14. **Second Level of Recursion (start=4, remainingK=2, remainingN=6)**
     - Loop from `4` to `9`.
     - **i=4**:
       - Append `4` to `path` → `path = [3, 4]`.
       - Call `backtrack(5, 1, 2, &path)`.

 15. **Third Level of Recursion (start=5, remainingK=1, remainingN=2)**
     - Loop from `5` to `9`.
     - **i=5**:
       - Append `5` to `path` → `path = [3, 4, 5]`.
       - Call `backtrack(6, 0, -3, &path)`.
     - **Backtrack**: RemainingN is negative. Remove `5` from `path` → `path = [3, 4]`.
     - **Backtrack**: Continue with i from `6` to `9`, but they will not be valid (RemainingN will be negative).

 16. **Backtrack to Second Level (start=4, remainingK=2, remainingN=6)**
     - **Backtrack**: Remove `4` from `path` → `path = [3]`.
     - **i=5**:
       - Append `5` to `path` → `path = [3, 5]`.
       - Call `backtrack(6, 1, 1, &path)`.

 17. **Third Level of Recursion (start=6, remainingK=1, remainingN=1)**
     - Loop from `6` to `9`.
     - **i=6**:
       - Append `6` to `path` → `path = [3, 5, 6]`.
       - Call `backtrack(7, 0, -5, &path)`.
     - **Backtrack**: RemainingN is negative. Remove `6` from `path` → `path = [3, 5]`.
     - **Backtrack**: Continue with i from `7` to `9`, but they will not be valid (RemainingN will be negative).

 18. **Backtrack to Second Level (start=4, remainingK=2, remainingN=6)**
     - **Backtrack**: Remove `5` from `path` → `path = [3]`.
     - **i=6**:
       - Append `6` to `path` → `path = [3, 6]`.
       - Call `backtrack(7, 1, 0, &path)`.

 19. **Third Level of Recursion (start=7, remainingK=1, remainingN=0)**
     - Loop from `7` to `9`.
     - **i=7**:
       - Append `7` to `path` → `path = [3, 6, 7]`.
       - Call `backtrack(8, 0, -7, &path)`.
     - **Backtrack**: RemainingN is negative. Remove `7` from `path` → `path = [3, 6]`.
     - **Backtrack**: Continue with i from `8` to `9`, but they will not be valid (RemainingN will be negative).

 20. **Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
     - **Backtrack**: Remove `3` from `path` → `path = []`.
     - **i=4**:
       - Append `4` to `path` → `path = [4]`.
       - Call `backtrack(5, 2, 5, &path)`.

 21. **Second Level of Recursion (start=5, remainingK=2, remainingN=5)**
     - Loop from `5` to `9`.
     - **i=5**:
       - Append `5` to `path` → `path = [4, 5]`.
       - Call `backtrack(6, 1, 0, &path)`.

 22. **Third Level of Recursion (start=6, remainingK=1, remainingN=0)**
     - Loop from `6` to `9`.
     - **i=6**:
       - Append `6` to `path` → `path = [4, 5, 6]`.
       - Call `backtrack(7, 0, -6, &path)`.
     - **Backtrack**: RemainingN is negative. Remove `6` from `path` → `path = [4, 5]`.
     - **Backtrack**: Continue with i from `7` to `9`, but they will not be valid (RemainingN will be negative).

 23. **Backtrack to Second Level (start=5, remainingK=2, remainingN=5)**
     - **Backtrack**: Remove `5` from `path` → `path = [4]`.
     - **i=6**:
       - Append `6` to `path` → `path = [4, 6]`.
       - Call `backtrack(7, 1, -1, &path)`.

 24. **Third Level of Recursion (start=7, remainingK=1, remainingN=-1)**
     - Loop from `7` to `9`.
     - **Backtrack**: RemainingN is negative. Remove `6` from `path` → `path = [4]`.
     - **Backtrack**: Continue with i from `7` to `9`, but they will not be valid (RemainingN will be negative).

 25. **Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
     - **Backtrack**: Remove `4` from `path` → `path = []`.
     - **i=5**:
       - Append `5` to `path` → `path = [5]`.
       - Call `backtrack(6, 2, 4, &path)`.

 26. **Second Level of Recursion (start=6, remainingK=2, remainingN=4)**
     - Loop from `6` to `9`.
     - **i=6**:
       - Append `6` to `path` → `path = [5, 6]`.
       - Call `backtrack(7, 1, -2, &path)`.

 27. **Third Level of Recursion (start=7, remainingK=1, remainingN=-2)**
     - Loop from `7` to `9`.
     - **Backtrack**: RemainingN is negative. Remove `6` from `path` → `path = [5]`.
     - **Backtrack**: Continue with i from `7` to `9`, but they will not be valid (RemainingN will be negative).

 28. **Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
     - **Backtrack**: Remove `5` from `path` → `path = []`.
     - **i=6**:
       - Append `6` to `path` → `path = [6]`.
       - Call `backtrack(7, 2, 3, &path)`.

 29. **Second Level of Recursion (start=7, remainingK=2, remainingN=3)**
     - Loop from `7` to `9`.
     - **i=7**:
       - Append `7` to `path` → `path = [6, 7]`.
       - Call `backtrack(8, 1, -4, &path)`.

 30. **Third Level of Recursion (start=8, remainingK=1, remainingN=-4)**
     - Loop from `8` to `9`.
     - **Backtrack**: RemainingN is negative. Remove `7` from `path` → `path = [6]`.
     - **Backtrack**: Continue with i from `8` to `9`, but they will not be valid (RemainingN will be negative).

 31. **Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
     - **Backtrack**: Remove `6` from `path` → `path = []`.
     - **i=7**:
       - Append `7` to `path` → `path = [7]`.
       - Call `backtrack(8, 2, 2, &path)`.

 32. **Second Level of Recursion (start=8, remainingK=2, remainingN=2)**
     - Loop from `8` to `9`.
     - **i=8**:
       - Append `8` to `path` → `path = [7, 8]`.
       - Call `backtrack(9, 1, -6, &path)`.

 33. **Third Level of Recursion (start=9, remainingK=1, remainingN=-6)**
     - Loop

  from `9` to `9`.
     - **Backtrack**: RemainingN is negative. Remove `8` from `path` → `path = [7]`.
     - **Backtrack**: Continue with i from `9`, but it will not be valid (RemainingN will be negative).

 34. **Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
     - **Backtrack**: Remove `7` from `path` → `path = []`.
     - **i=8**:
       - Append `8` to `path` → `path = [8]`.
       - Call `backtrack(9, 2, 1, &path)`.

 35. **Second Level of Recursion (start=9, remainingK=2, remainingN=1)**
     - Loop from `9` to `9`.
     - **i=9**:
       - Append `9` to `path` → `path = [8, 9]`.
       - Call `backtrack(10, 1, -8, &path)`.

 36. **Third Level of Recursion (start=10, remainingK=1, remainingN=-8)**
     - Loop from `10` (out of range).
     - **Backtrack**: RemainingN is negative. Remove `9` from `path` → `path = [8]`.
     - **Backtrack**: Continue with i out of range.

 37. **Backtrack to First Level (start=1, remainingK=3, remainingN=9)**
     - **Backtrack**: Remove `8` from `path` → `path = []`.
     - **i=9**:
       - Append `9` to `path` → `path = [9]`.
       - Call `backtrack(10, 2, 0, &path)`.

 38. **Second Level of Recursion (start=10, remainingK=2, remainingN=0)**
     - Loop from `10` (out of range).
     - **Backtrack**: RemainingN is zero. Remove `9` from `path` → `path = []`.

 ### Conclusion

 After all recursive calls and backtracking steps are completed, the final `result` list is:

 ```swift
 [[1, 2, 6], [1, 3, 5], [2, 3, 4]]
 ```

 This matches the expected output.
 */
