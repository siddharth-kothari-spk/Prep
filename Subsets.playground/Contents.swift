/*
 https://leetcode.com/problems/subsets/description/
 Given an integer array nums of unique elements, return all possible
 subsets
  (the power set).

 The solution set must not contain duplicate subsets. Return the solution in any order.

  

 Example 1:

 Input: nums = [1,2,3]
 Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
 Example 2:

 Input: nums = [0]
 Output: [[],[0]]
  

 Constraints:

 1 <= nums.length <= 10
 -10 <= nums[i] <= 10
 All the numbers of nums are unique.
 */

/*
Algo:  recursive backtracking approach. Here is a step-by-step algorithm to achieve this:

 Initialization:

 Create a result list to store all the subsets.
 Define a helper function that will be used for backtracking.
 Backtracking Function:

 The function takes two parameters: the current subset being constructed and the starting index for the elements to be added to the current subset.
 Add the current subset to the result list.
 Iterate through the elements of the array starting from the given index.
 For each element, add it to the current subset.
 Recursively call the backtracking function with the updated subset and the next index.
 Remove the last element from the current subset (backtrack) to explore other possibilities.
 Execution:

 Initialize the backtracking process by calling the helper function with an empty subset and the starting index 0.
 */

class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        
        func backtrack(_ start: Int, _ currentSubset: inout [Int]) {
            // Add the current subset to the result list
            result.append(currentSubset)
            
            // Iterate over the elements starting from the current index
            for i in start..<nums.count {
                // Include the current element in the subset
                currentSubset.append(nums[i])
                // Recursively call the function with the next starting index
                backtrack(i + 1, &currentSubset)
                // Backtrack by removing the last element added
                currentSubset.removeLast()
            }
        }
        
        // Start the backtracking process with an empty subset
        var currentSubset = [Int]()
        backtrack(0, &currentSubset)
        
        return result
    }
}

// Example 1
let nums1 = [1, 2, 3]
let solution1 = Solution()
print(solution1.subsets(nums1))  // Output: [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

// Example 2
let nums2 = [0]
let solution2 = Solution()
print(solution2.subsets(nums2))  // Output: [[], [0]]

/*
 Sure, let's go through a dry run of the Swift function `subsets` with `nums1 = [1, 2, 3]`.

 ### Dry Run

 #### Initial Call
 - `subsets([1, 2, 3])`
   - `result = []`
   - `currentSubset = []`
   - Call `backtrack(0, &currentSubset)`

 #### First Call to `backtrack`
 - `backtrack(0, &currentSubset)`
   - Add `currentSubset` (which is `[]`) to `result`
   - `result = [[]]`
   - Loop `i` from 0 to 2

 ##### Iteration 1: i = 0
 - Add `nums[0]` (which is `1`) to `currentSubset`
   - `currentSubset = [1]`
   - Call `backtrack(1, &currentSubset)`

 ###### Second Call to `backtrack`
 - `backtrack(1, &currentSubset)`
   - Add `currentSubset` (which is `[1]`) to `result`
   - `result = [[], [1]]`
   - Loop `i` from 1 to 2

 ###### Iteration 1: i = 1
 - Add `nums[1]` (which is `2`) to `currentSubset`
   - `currentSubset = [1, 2]`
   - Call `backtrack(2, &currentSubset)`

 ####### Third Call to `backtrack`
 - `backtrack(2, &currentSubset)`
   - Add `currentSubset` (which is `[1, 2]`) to `result`
   - `result = [[], [1], [1, 2]]`
   - Loop `i` from 2 to 2

 ####### Iteration 1: i = 2
 - Add `nums[2]` (which is `3`) to `currentSubset`
   - `currentSubset = [1, 2, 3]`
   - Call `backtrack(3, &currentSubset)`

 ######## Fourth Call to `backtrack`
 - `backtrack(3, &currentSubset)`
   - Add `currentSubset` (which is `[1, 2, 3]`) to `result`
   - `result = [[], [1], [1, 2], [1, 2, 3]]`
   - Loop ends (since `start = 3` is beyond the end of `nums`)
 - Backtrack by removing last element from `currentSubset`
   - `currentSubset = [1, 2]`
 - Return to third call

 ####### End of Loop
 - Backtrack by removing last element from `currentSubset`
   - `currentSubset = [1]`
 - Return to second call

 ###### Iteration 2: i = 2
 - Add `nums[2]` (which is `3`) to `currentSubset`
   - `currentSubset = [1, 3]`
   - Call `backtrack(3, &currentSubset)`

 ####### Fifth Call to `backtrack`
 - `backtrack(3, &currentSubset)`
   - Add `currentSubset` (which is `[1, 3]`) to `result`
   - `result = [[], [1], [1, 2], [1, 2, 3], [1, 3]]`
   - Loop ends (since `start = 3` is beyond the end of `nums`)
 - Backtrack by removing last element from `currentSubset`
   - `currentSubset = [1]`
 - Return to second call

 ###### End of Loop
 - Backtrack by removing last element from `currentSubset`
   - `currentSubset = []`
 - Return to first call

 ##### Iteration 2: i = 1
 - Add `nums[1]` (which is `2`) to `currentSubset`
   - `currentSubset = [2]`
   - Call `backtrack(2, &currentSubset)`

 ###### Sixth Call to `backtrack`
 - `backtrack(2, &currentSubset)`
   - Add `currentSubset` (which is `[2]`) to `result`
   - `result = [[], [1], [1, 2], [1, 2, 3], [1, 3], [2]]`
   - Loop `i` from 2 to 2

 ###### Iteration 1: i = 2
 - Add `nums[2]` (which is `3`) to `currentSubset`
   - `currentSubset = [2, 3]`
   - Call `backtrack(3, &currentSubset)`

 ####### Seventh Call to `backtrack`
 - `backtrack(3, &currentSubset)`
   - Add `currentSubset` (which is `[2, 3]`) to `result`
   - `result = [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3]]`
   - Loop ends (since `start = 3` is beyond the end of `nums`)
 - Backtrack by removing last element from `currentSubset`
   - `currentSubset = [2]`
 - Return to sixth call

 ###### End of Loop
 - Backtrack by removing last element from `currentSubset`
   - `currentSubset = []`
 - Return to first call

 ##### Iteration 3: i = 2
 - Add `nums[2]` (which is `3`) to `currentSubset`
   - `currentSubset = [3]`
   - Call `backtrack(3, &currentSubset)`

 ###### Eighth Call to `backtrack`
 - `backtrack(3, &currentSubset)`
   - Add `currentSubset` (which is `[3]`) to `result`
   - `result = [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]`
   - Loop ends (since `start = 3` is beyond the end of `nums`)
 - Backtrack by removing last element from `currentSubset`
   - `currentSubset = []`
 - Return to first call

 #### End of Loop
 - Return from `subsets`

 Final `result`:
 ```
 [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
 ```

 This dry run shows how the algorithm generates each subset step-by-step by recursively including and then backtracking on each element.
 */
