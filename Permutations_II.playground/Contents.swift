/*
 https://leetcode.com/problems/permutations-ii/description/
 Given a collection of numbers, nums, that might contain duplicates, return all possible unique permutations in any order.

  

 Example 1:

 Input: nums = [1,1,2]
 Output:
 [[1,1,2],
  [1,2,1],
  [2,1,1]]
 Example 2:

 Input: nums = [1,2,3]
 Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
  

 Constraints:

 1 <= nums.length <= 8
 -10 <= nums[i] <= 10
 */
/*
 To generate all unique permutations of a collection of numbers (which may include duplicates), you can use a backtracking algorithm. The key is to avoid generating duplicate permutations by skipping over duplicate numbers during the permutation generation process.

 Here is a step-by-step algorithm:

 Sort the Input Array: Sorting the array helps in easily identifying and skipping duplicates.
 Backtracking Function: Use a backtracking function to generate permutations. Maintain a list to keep track of the current permutation and a boolean list to mark used elements.
 Skip Duplicates: Before including an element in the current permutation, check if it has already been used or if it is a duplicate of a previously used element at the same recursion depth.
 */

import Foundation

func permuteUnique(_ nums: [Int]) -> [[Int]] {
    var nums = nums.sorted()
    var result = [[Int]]()
    var path = [Int]()
    var used = Array(repeating: false, count: nums.count)
    
    func backtrack() {
        if path.count == nums.count {
            result.append(path)
            return
        }
        
        for i in 0..<nums.count {
            // Skip used elements or duplicates
            if used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) {
                continue
            }
            
            // Mark the element as used
            used[i] = true
            path.append(nums[i])
            
            // Recurse
            backtrack()
            
            // Backtrack
            path.removeLast()
            used[i] = false
        }
    }
    
    backtrack()
    return result
}

// Example usage
let nums1 = [1, 1, 2]
print(permuteUnique(nums1))

let nums2 = [1, 2, 3]
print(permuteUnique(nums2))

/*
 Sure, let's go through a dry run of the Swift code for `nums = [1, 1, 2]` to understand how the algorithm generates all unique permutations.

 ### Initial Setup
 1. **Input Array**: `nums = [1, 1, 2]`
 2. **Sorted Array**: `nums = [1, 1, 2]`
 3. **Variables**: `result = []`, `path = []`, `used = [false, false, false]`

 ### Backtracking Function Calls
 1. **First Call to `backtrack`**:
    - `path = []`, `used = [false, false, false]`
    - Loop through `nums` with index `i = 0`:
      - `nums[0] = 1`, `used[0] = false`
      - Add `1` to `path`: `path = [1]`
      - Mark `used[0] = true`: `used = [true, false, false]`
      - Call `backtrack`

 2. **Second Call to `backtrack`**:
    - `path = [1]`, `used = [true, false, false]`
    - Loop through `nums` with index `i = 0`:
      - `used[0] = true` (skip)
    - Loop through `nums` with index `i = 1`:
      - `nums[1] = 1`, `used[1] = false`
      - Add `1` to `path`: `path = [1, 1]`
      - Mark `used[1] = true`: `used = [true, true, false]`
      - Call `backtrack`

 3. **Third Call to `backtrack`**:
    - `path = [1, 1]`, `used = [true, true, false]`
    - Loop through `nums` with index `i = 0`:
      - `used[0] = true` (skip)
    - Loop through `nums` with index `i = 1`:
      - `used[1] = true` (skip)
    - Loop through `nums` with index `i = 2`:
      - `nums[2] = 2`, `used[2] = false`
      - Add `2` to `path`: `path = [1, 1, 2]`
      - Mark `used[2] = true`: `used = [true, true, true]`
      - Call `backtrack`

 4. **Fourth Call to `backtrack`**:
    - `path = [1, 1, 2]`, `used = [true, true, true]`
    - `path` length is equal to `nums` length: Add `path` to `result`: `result = [[1, 1, 2]]`
    - Backtrack: Remove last element from `path`: `path = [1, 1]`
    - Unmark `used[2] = false`: `used = [true, true, false]`
    - Return to previous call

 5. **Return to Third Call to `backtrack`**:
    - `path = [1, 1]`, `used = [true, true, false]`
    - Backtrack: Remove last element from `path`: `path = [1]`
    - Unmark `used[1] = false`: `used = [true, false, false]`
    - Loop through `nums` with index `i = 2`:
      - `nums[2] = 2`, `used[2] = false`
      - Add `2` to `path`: `path = [1, 2]`
      - Mark `used[2] = true`: `used = [true, false, true]`
      - Call `backtrack`

 6. **Fifth Call to `backtrack`**:
    - `path = [1, 2]`, `used = [true, false, true]`
    - Loop through `nums` with index `i = 0`:
      - `used[0] = true` (skip)
    - Loop through `nums` with index `i = 1`:
      - `nums[1] = 1`, `used[1] = false`
      - Add `1` to `path`: `path = [1, 2, 1]`
      - Mark `used[1] = true`: `used = [true, true, true]`
      - Call `backtrack`

 7. **Sixth Call to `backtrack`**:
    - `path = [1, 2, 1]`, `used = [true, true, true]`
    - `path` length is equal to `nums` length: Add `path` to `result`: `result = [[1, 1, 2], [1, 2, 1]]`
    - Backtrack: Remove last element from `path`: `path = [1, 2]`
    - Unmark `used[1] = false`: `used = [true, false, true]`
    - Return to previous call

 8. **Return to Fifth Call to `backtrack`**:
    - `path = [1, 2]`, `used = [true, false, true]`
    - Backtrack: Remove last element from `path`: `path = [1]`
    - Unmark `used[2] = false`: `used = [true, false, false]`
    - Return to previous call

 9. **Return to Second Call to `backtrack`**:
    - `path = [1]`, `used = [true, false, false]`
    - Backtrack: Remove last element from `path`: `path = []`
    - Unmark `used[0] = false`: `used = [false, false, false]`
    - Loop through `nums` with index `i = 1`:
      - `nums[1] = 1`, `used[1] = false`, but it is a duplicate of `nums[0]` and `used[0] = false` (skip)
    - Loop through `nums` with index `i = 2`:
      - `nums[2] = 2`, `used[2] = false`
      - Add `2` to `path`: `path = [2]`
      - Mark `used[2] = true`: `used = [false, false, true]`
      - Call `backtrack`

 10. **Seventh Call to `backtrack`**:
     - `path = [2]`, `used = [false, false, true]`
     - Loop through `nums` with index `i = 0`:
       - `nums[0] = 1`, `used[0] = false`
       - Add `1` to `path`: `path = [2, 1]`
       - Mark `used[0] = true`: `used = [true, false, true]`
       - Call `backtrack`

 11. **Eighth Call to `backtrack`**:
     - `path = [2, 1]`, `used = [true, false, true]`
     - Loop through `nums` with index `i = 0`:
       - `used[0] = true` (skip)
     - Loop through `nums` with index `i = 1`:
       - `nums[1] = 1`, `used[1] = false`
       - Add `1` to `path`: `path = [2, 1, 1]`
       - Mark `used[1] = true`: `used = [true, true, true]`
       - Call `backtrack`

 12. **Ninth Call to `backtrack`**:
     - `path = [2, 1, 1]`, `used = [true, true, true]`
     - `path` length is equal to `nums` length: Add `path` to `result`: `result = [[1, 1, 2], [1, 2, 1], [2, 1, 1]]`
     - Backtrack: Remove last element from `path`: `path = [2, 1]`
     - Unmark `used[1] = false`: `used = [true, false, true]`
     - Return to previous call

 13. **Return to Eighth Call to `backtrack`**:
     - `path = [2, 1]`, `used = [true, false, true]`
     - Backtrack: Remove last element from `path`: `path = [2]`
     - Unmark `used[0] = false`: `used = [false, false, true]`
     - Loop through `nums` with index `i = 1`:
       - `nums[1] = 1`, `used[1] = false`, but it is a duplicate of `nums[0]` and `used[0] = false` (skip)
     - Return to previous call

 14. **Return to Seventh Call to `backtrack`**:
     - `path = [2]`, `used = [false, false, true]`
     - Backtrack: Remove last element from `path`: `path = []`
     - Unmark `used[2] = false`: `

 used = [false, false, false]`
     - Return to previous call

 15. **Return to First Call to `backtrack`**:
     - `path = []`, `used = [false, false, false]`
     - End of function

 ### Final Result
 After all the recursive calls and backtracking, the final `result` contains all unique permutations of `nums = [1, 1, 2]`:
 ```
 [[1, 1, 2], [1, 2, 1], [2, 1, 1]]
 ```
 */
