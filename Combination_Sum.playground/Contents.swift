/*
 https://leetcode.com/problems/combination-sum/description/
 Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order.

 The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the
 frequency
  of at least one of the chosen numbers is different.

 The test cases are generated such that the number of unique combinations that sum up to target is less than 150 combinations for the given input.

  

 Example 1:

 Input: candidates = [2,3,6,7], target = 7
 Output: [[2,2,3],[7]]
 Explanation:
 2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple times.
 7 is a candidate, and 7 = 7.
 These are the only two combinations.
 Example 2:

 Input: candidates = [2,3,5], target = 8
 Output: [[2,2,2,2],[2,3,3],[3,5]]
 Example 3:

 Input: candidates = [2], target = 1
 Output: []
  

 Constraints:

 1 <= candidates.length <= 30
 2 <= candidates[i] <= 40
 All elements of candidates are distinct.
 1 <= target <= 40
 */

/*
 To solve this problem, you can use a backtracking approach. Backtracking is a general algorithm for finding all (or some) solutions to some computational problems, notably constraint satisfaction problems, that incrementally builds candidates to the solutions. Here's a step-by-step breakdown of the algorithm:

 Sort the candidates: This is not strictly necessary, but it can help to avoid redundant calculations and can make the implementation simpler.
 Initialize the results list: This will store all the unique combinations that sum up to the target.
 Define the backtracking function:
 This function will take the current combination, the remaining target, and the start index as arguments.
 If the remaining target is zero, it means we found a valid combination, so we add it to the results list.
 If the remaining target is less than zero, it means the current combination exceeds the target, so we return to explore other possibilities.
 Otherwise, we iterate over the candidates starting from the start index to avoid using the same combination in different orders.
 For each candidate, add it to the current combination and recursively call the backtracking function with the updated combination and remaining target.
 */

func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var results = [[Int]]()
    
    func backtrack(_ remain: Int, _ comb: inout [Int], _ start: Int) {
        if remain == 0 {
            results.append(comb)
            return
        } else if remain < 0 {
            return
        }
        
        for i in start..<candidates.count {
            comb.append(candidates[i])
            backtrack(remain - candidates[i], &comb, i)
            comb.removeLast()
        }
    }
    
    var combination = [Int]()
    backtrack(target, &combination, 0)
    
    return results
}

// Example usage:
let candidates1 = [2, 3, 6, 7]
let target1 = 7
print(combinationSum(candidates1, target1))  // Output: [[2, 2, 3], [7]]

let candidates2 = [2, 3, 5]
let target2 = 8
print(combinationSum(candidates2, target2))  // Output: [[2, 2, 2, 2], [2, 3, 3], [3, 5]]

let candidates3 = [2]
let target3 = 1
print(combinationSum(candidates3, target3))  // Output: []


/*
 Explanation
 combinationSum(::):

 This function initializes the results array and calls the backtrack function with the initial parameters.
 backtrack(::):

 remain: the remaining sum needed to reach the target.
 comb: the current combination of numbers.
 start: the index in candidates to start adding numbers from, to avoid using the same combination in a different order.
 Base case:

 If remain is 0, a valid combination has been found and it is added to the results array.
 If remain is less than 0, the current combination exceeds the target, so the function returns.
 Recursive case:

 Iterate over the candidates starting from start.
 Add the candidate to the current combination.
 Recursively call the backtracking function with the updated combination and remaining target.
 Remove the last candidate from the combination (backtracking).
 */

/*
 Sure, let's do a dry run of the `combinationSum` function for the `candidates2 = [2, 3, 5]` and `target2 = 8` input.

 ### Initial Call
 - **candidates**: `[2, 3, 5]`
 - **target**: `8`
 - **results**: `[]` (initially empty)

 ### First call to `backtrack`
 - **remain**: `8`
 - **comb**: `[]`
 - **start**: `0`

 ### Iteration 1 (start = 0, candidate = 2)
 - **comb**: `[2]`
 - **remain**: `6`

 #### Recursion into backtrack (remain = 6, comb = [2], start = 0)
 - **comb**: `[2, 2]`
 - **remain**: `4`

 ##### Recursion into backtrack (remain = 4, comb = [2, 2], start = 0)
 - **comb**: `[2, 2, 2]`
 - **remain**: `2`

 ###### Recursion into backtrack (remain = 2, comb = [2, 2, 2], start = 0)
 - **comb**: `[2, 2, 2, 2]`
 - **remain**: `0`
 - **Action**: Add `[2, 2, 2, 2]` to results

 - **results**: `[[2, 2, 2, 2]]`
 - **Backtrack**: Remove last `2`, comb = `[2, 2, 2]`, remain = `2`

 ##### Iteration 2 (start = 1, candidate = 3)
 - **comb**: `[2, 2, 2, 3]`
 - **remain**: `-1` (invalid)

 - **Backtrack**: Remove last `3`, comb = `[2, 2, 2]`, remain = `2`

 ##### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[2, 2, 2, 5]`
 - **remain**: `-3` (invalid)

 - **Backtrack**: Remove last `5`, comb = `[2, 2, 2]`, remain = `2`

 ###### Backtrack: Remove last `2`, comb = `[2, 2]`, remain = `4`

 ##### Iteration 2 (start = 1, candidate = 3)
 - **comb**: `[2, 2, 3]`
 - **remain**: `1`

 ###### Recursion into backtrack (remain = 1, comb = [2, 2, 3], start = 1)
 - **comb**: `[2, 2, 3, 3]`
 - **remain**: `-2` (invalid)

 - **Backtrack**: Remove last `3`, comb = `[2, 2, 3]`, remain = `1`

 ###### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[2, 2, 3, 5]`
 - **remain**: `-4` (invalid)

 - **Backtrack**: Remove last `5`, comb = `[2, 2, 3]`, remain = `1`

 ###### Backtrack: Remove last `3`, comb = `[2, 2]`, remain = `4`

 ##### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[2, 2, 5]`
 - **remain**: `-1` (invalid)

 - **Backtrack**: Remove last `5`, comb = `[2, 2]`, remain = `4`

 ###### Backtrack: Remove last `2`, comb = `[2]`, remain = `6`

 #### Iteration 2 (start = 1, candidate = 3)
 - **comb**: `[2, 3]`
 - **remain**: `3`

 ##### Recursion into backtrack (remain = 3, comb = [2, 3], start = 1)
 - **comb**: `[2, 3, 3]`
 - **remain**: `0`
 - **Action**: Add `[2, 3, 3]` to results

 - **results**: `[[2, 2, 2, 2], [2, 3, 3]]`
 - **Backtrack**: Remove last `3`, comb = `[2, 3]`, remain = `3`

 ###### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[2, 3, 5]`
 - **remain**: `-2` (invalid)

 - **Backtrack**: Remove last `5`, comb = `[2, 3]`, remain = `3`

 ###### Backtrack: Remove last `3`, comb = `[2]`, remain = `6`

 #### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[2, 5]`
 - **remain**: `1`

 ##### Recursion into backtrack (remain = 1, comb = [2, 5], start = 2)
 - **comb**: `[2, 5, 5]`
 - **remain**: `-4` (invalid)

 - **Backtrack**: Remove last `5`, comb = `[2, 5]`, remain = `1`

 ##### Backtrack: Remove last `5`, comb = `[2]`, remain = `6`

 ###### Backtrack: Remove last `2`, comb = `[]`, remain = `8`

 ### Iteration 2 (start = 1, candidate = 3)
 - **comb**: `[3]`
 - **remain**: `5`

 #### Recursion into backtrack (remain = 5, comb = [3], start = 1)
 - **comb**: `[3, 3]`
 - **remain**: `2`

 ##### Recursion into backtrack (remain = 2, comb = [3, 3], start = 1)
 - **comb**: `[3, 3, 3]`
 - **remain**: `-1` (invalid)

 - **Backtrack**: Remove last `3`, comb = `[3, 3]`, remain = `2`

 ##### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[3, 3, 5]`
 - **remain**: `-3` (invalid)

 - **Backtrack**: Remove last `5`, comb = `[3, 3]`, remain = `2`

 ##### Backtrack: Remove last `3`, comb = `[3]`, remain = `5`

 #### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[3, 5]`
 - **remain**: `0`
 - **Action**: Add `[3, 5]` to results

 - **results**: `[[2, 2, 2, 2], [2, 3, 3], [3, 5]]`
 - **Backtrack**: Remove last `5`, comb = `[3]`, remain = `5`

 #### Backtrack: Remove last `3`, comb = `[]`, remain = `8`

 ### Iteration 3 (start = 2, candidate = 5)
 - **comb**: `[5]`
 - **remain**: `3`

 #### Recursion into backtrack (remain = 3, comb = [5], start = 2)
 - **comb**: `[5, 5]`
 - **remain**: `-2` (invalid)

 - **Backtrack**: Remove last `5`, comb = `[5]`, remain = `3`

 #### Backtrack: Remove last `5`, comb = `[]`, remain = `8`

 ### Final Results
 - `results`: `[[2, 2, 2, 2], [2, 3, 3], [3, 5]]`

 The dry run shows the step-by-step process of finding all unique combinations that sum up to the target `8` using the candidates `[2, 3, 5]`.
 */
