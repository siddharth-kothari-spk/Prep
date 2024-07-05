/*
 https://leetcode.com/problems/combination-sum-ii/description/
 Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sum to target.

 Each number in candidates may only be used once in the combination.

 Note: The solution set must not contain duplicate combinations.

  

 Example 1:

 Input: candidates = [10,1,2,7,6,1,5], target = 8
 Output:
 [
 [1,1,6],
 [1,2,5],
 [1,7],
 [2,6]
 ]
 Example 2:

 Input: candidates = [2,5,2,1,2], target = 5
 Output:
 [
 [1,2,2],
 [5]
 ]
  

 Constraints:

 1 <= candidates.length <= 100
 1 <= candidates[i] <= 50
 1 <= target <= 30
 */

class Solution {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var results = [[Int]]()
        var path = [Int]()
        let sortedCandidates = candidates.sorted()
        
        func backtrack(_ start: Int, _ target: Int) {
            if target == 0 {
                results.append(path)
                return
            }
            for i in start..<sortedCandidates.count {
                if i > start && sortedCandidates[i] == sortedCandidates[i - 1] { // skip duplicates
                    continue
                }
                if sortedCandidates[i] > target { // no need to continue if the candidate is greater than the target
                    break
                }
                path.append(sortedCandidates[i])
                backtrack(i + 1, target - sortedCandidates[i])
                path.removeLast()
            }
        }
        
        backtrack(0, target)
        return results
    }
}

// Example usage:
let solution = Solution()
let candidates1 = [10, 1, 2, 7, 6, 1, 5]
let target1 = 8
print(solution.combinationSum2(candidates1, target1))
// Output: [[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]]

let candidates2 = [2, 5, 2, 1, 2]
let target2 = 5
print(solution.combinationSum2(candidates2, target2))
// Output: [[1, 2, 2], [5]]

/*
 Explanation:
 Sorting: The candidates array is sorted to handle duplicates and make it easier to break out of the loop when the candidate exceeds the target.
 Backtracking function:
 Parameters:
 start: The index to start from in the candidates array.
 target: The remaining sum we need to achieve.
 Base Case: If target becomes 0, the current path is appended to results.
 Iterate through candidates:
 Skip the same element if it was already considered (i > start && sortedCandidates[i] == sortedCandidates[i - 1]).
 If the current candidate is greater than the remaining target, break the loop (since further elements will also be greater, given the sorted order).
 Otherwise, recursively call backtrack with the updated parameters (i + 1 for the next start index, target - sortedCandidates[i] for the new target).
 */

/*
 Sure, I'll walk you through a dry run of the Swift code for `let candidates2 = [2, 5, 2, 1, 2]` and `let target2 = 5`.

 ### Initial Setup:
 - `candidates2 = [2, 5, 2, 1, 2]`
 - `target2 = 5`
 - After sorting: `sortedCandidates = [1, 2, 2, 2, 5]`

 ### Call to `backtrack(0, 5)`:
 - `start = 0`
 - `target = 5`
 - `path = []`
 - `results = []`

 ### Iteration 1 (`i = 0`):
 - Include `1` in `path`:
   - `path = [1]`
   - New target: `5 - 1 = 4`
   - Call `backtrack(1, 4)`:

 ### Call to `backtrack(1, 4)`:
 - `start = 1`
 - `target = 4`
 - `path = [1]`
 - `results = []`

 ### Iteration 1 (`i = 1`):
 - Include `2` in `path`:
   - `path = [1, 2]`
   - New target: `4 - 2 = 2`
   - Call `backtrack(2, 2)`:

 ### Call to `backtrack(2, 2)`:
 - `start = 2`
 - `target = 2`
 - `path = [1, 2]`
 - `results = []`

 ### Iteration 1 (`i = 2`):
 - Include `2` in `path`:
   - `path = [1, 2, 2]`
   - New target: `2 - 2 = 0`
   - Call `backtrack(3, 0)`:

 ### Call to `backtrack(3, 0)`:
 - `start = 3`
 - `target = 0`
 - `path = [1, 2, 2]`
 - `results = []`
 - Target is 0, append `path` to `results`: `results = [[1, 2, 2]]`
 - Return to previous call (`backtrack(2, 2)`)

 ### Backtrack to `backtrack(2, 2)`:
 - `path = [1, 2]`
 - Continue iteration (`i = 3`):
   - Skip as `sortedCandidates[3]` is duplicate of `sortedCandidates[2]`

 ### Continue iteration (`i = 4`):
 - Include `5` in `path`:
   - `path = [1, 5]`
   - New target: `2 - 5 = -3` (target negative, discard this path)
   - Backtrack

 ### Backtrack to `backtrack(1, 4)`:
 - `path = [1]`
 - Continue iteration (`i = 2`):
   - Skip as `sortedCandidates[2]` is duplicate of `sortedCandidates[1]`

 ### Continue iteration (`i = 3`):
 - Skip as `sortedCandidates[3]` is duplicate of `sortedCandidates[1]`

 ### Continue iteration (`i = 4`):
 - Include `5` in `path`:
   - `path = [5]`
   - New target: `5 - 5 = 0`
   - Call `backtrack(5, 0)`:

 ### Call to `backtrack(5, 0)`:
 - `start = 5`
 - `target = 0`
 - `path = [5]`
 - `results = [[1, 2, 2]]`
 - Target is 0, append `path` to `results`: `results = [[1, 2, 2], [5]]`
 - Return to previous call (`backtrack(0, 5)`)

 ### Backtrack to `backtrack(0, 5)`:
 - `path = []`
 - Continue iteration (`i = 1`):
   - Include `2` in `path`:
     - `path = [2]`
     - New target: `5 - 2 = 3`
     - Call `backtrack(2, 3)`:

 ### Call to `backtrack(2, 3)`:
 - `start = 2`
 - `target = 3`
 - `path = [2]`
 - `results = [[1, 2, 2], [5]]`

 ### Iteration 1 (`i = 2`):
 - Include `2` in `path`:
   - `path = [2, 2]`
   - New target: `3 - 2 = 1`
   - Call `backtrack(3, 1)`:

 ### Call to `backtrack(3, 1)`:
 - `start = 3`
 - `target = 1`
 - `path = [2, 2]`
 - `results = [[1, 2, 2], [5]]`

 ### Iteration 1 (`i = 3`):
 - Skip as `sortedCandidates[3]` is duplicate of `sortedCandidates[2]`

 ### Continue iteration (`i = 4`):
 - Include `5` in `path`:
   - `path = [2, 5]`
   - New target: `1 - 5 = -4` (target negative, discard this path)
   - Backtrack

 ### Backtrack to `backtrack(2, 3)`:
 - `path = [2]`
 - Continue iteration (`i = 3`):
   - Skip as `sortedCandidates[3]` is duplicate of `sortedCandidates[2]`

 ### Continue iteration (`i = 4`):
 - Include `5` in `path`:
   - `path = [5]`
   - New target: `3 - 5 = -2` (target negative, discard this path)
   - Backtrack

 ### Backtrack to `backtrack(0, 5)`:
 - `path = []`
 - Continue iteration (`i = 2`):
   - Skip as `sortedCandidates[2]` is duplicate of `sortedCandidates[1]`

 ### Continue iteration (`i = 3`):
   - Skip as `sortedCandidates[3]` is duplicate of `sortedCandidates[1]`

 ### Continue iteration (`i = 4`):
   - Include `5` in `path`:
     - `path = [5]`
     - New target: `5 - 5 = 0`
     - Call `backtrack(5, 0)`:

 ### Call to `backtrack(5, 0)`:
 - `start = 5`
 - `target = 0`
 - `path = [5]`
 - `results = [[1, 2, 2], [5]]`
 - Target is 0, append `path` to `results`: `results = [[1, 2, 2], [5]]`
 - Return to previous call (`backtrack(0, 5)`)

 ### Final Result:
 - `results = [[1, 2, 2], [5]]`

 The final output will be:

 ```swift
 [[1, 2, 2], [5]]
 ```
 */
