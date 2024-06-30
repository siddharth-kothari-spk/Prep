/*
 https://leetcode.com/problems/subsets-ii/description/
 Given an integer array nums that may contain duplicates, return all possible
 subsets
  (the power set).

 The solution set must not contain duplicate subsets. Return the solution in any order.

  

 Example 1:

 Input: nums = [1,2,2]
 Output: [[],[1],[1,2],[1,2,2],[2],[2,2]]
 Example 2:

 Input: nums = [0]
 Output: [[],[0]]
  

 Constraints:

 1 <= nums.length <= 10
 -10 <= nums[i] <= 10
 */


func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    var res: [[Int]] = []
    var subset: [Int] = []
    let nums = nums.sorted()
    
    func backtrack(_ start: Int) {
        res.append(subset)
        
        for i in start..<nums.count {
            if i > start && nums[i] == nums[i - 1] {
                continue
            }
            subset.append(nums[i])
            backtrack(i + 1)
            subset.removeLast()
        }
    }
    
    backtrack(0)
    return res
}

// Example usage:
let nums1 = [1, 2, 2]
print(subsetsWithDup(nums1))  // Output: [[], [1], [1, 2], [1, 2, 2], [2], [2, 2]]

let nums2 = [0]
print(subsetsWithDup(nums2))  // Output: [[], [0]]

/*
 Sure! Let's do a dry run for `nums1 = [1, 2, 2]` using the provided Swift implementation.

 ### Initial Setup
 - Input array: `nums1 = [1, 2, 2]`
 - Sorted array: `nums = [1, 2, 2]`
 - Result array: `res = []`
 - Current subset: `subset = []`

 ### Backtracking Steps

 1. **First Call to `backtrack(0)`**
    - `start = 0`
    - Add current subset `[]` to `res`: `res = [[]]`

 2. **Loop from `i = 0` to `2`**
    - **First Iteration (`i = 0`):**
      - Add `nums[0]` (`1`) to `subset`: `subset = [1]`
      - Call `backtrack(1)`

 3. **Second Call to `backtrack(1)`**
    - `start = 1`
    - Add current subset `[1]` to `res`: `res = [[], [1]]`

 4. **Loop from `i = 1` to `2`**
    - **First Iteration (`i = 1`):**
      - Add `nums[1]` (`2`) to `subset`: `subset = [1, 2]`
      - Call `backtrack(2)`

 5. **Third Call to `backtrack(2)`**
    - `start = 2`
    - Add current subset `[1, 2]` to `res`: `res = [[], [1], [1, 2]]`

 6. **Loop from `i = 2` to `2`**
    - **First Iteration (`i = 2`):**
      - Add `nums[2]` (`2`) to `subset`: `subset = [1, 2, 2]`
      - Call `backtrack(3)`

 7. **Fourth Call to `backtrack(3)`**
    - `start = 3` (base case: `start` equals `nums.count`)
    - Add current subset `[1, 2, 2]` to `res`: `res = [[], [1], [1, 2], [1, 2, 2]]`
    - Backtrack (remove last element from `subset`): `subset = [1, 2]`

 8. **Back to Third Call**
    - **End of loop** (i.e., `i` has iterated through all elements)
    - Backtrack (remove last element from `subset`): `subset = [1]`

 9. **Back to Second Call**
    - **Second Iteration (`i = 2`):**
      - Skip because `nums[2]` is the same as `nums[1]` and `i > start`
    - **End of loop**
    - Backtrack (remove last element from `subset`): `subset = []`

 10. **Back to First Call**
     - **Second Iteration (`i = 1`):**
       - Add `nums[1]` (`2`) to `subset`: `subset = [2]`
       - Call `backtrack(2)`

 11. **Fifth Call to `backtrack(2)`**
     - `start = 2`
     - Add current subset `[2]` to `res`: `res = [[], [1], [1, 2], [1, 2, 2], [2]]`

 12. **Loop from `i = 2` to `2`**
     - **First Iteration (`i = 2`):**
       - Add `nums[2]` (`2`) to `subset`: `subset = [2, 2]`
       - Call `backtrack(3)`

 13. **Sixth Call to `backtrack(3)`**
     - `start = 3` (base case: `start` equals `nums.count`)
     - Add current subset `[2, 2]` to `res`: `res = [[], [1], [1, 2], [1, 2, 2], [2], [2, 2]]`
     - Backtrack (remove last element from `subset`): `subset = [2]`

 14. **Back to Fifth Call**
     - **End of loop**
     - Backtrack (remove last element from `subset`): `subset = []`

 15. **Back to First Call**
     - **Third Iteration (`i = 2`):**
       - Skip because `nums[2]` is the same as `nums[1]` and `i > start`
     - **End of loop**

 ### Result
 The final result `res` is `[[], [1], [1, 2], [1, 2, 2], [2], [2, 2]]`, which contains all unique subsets of the input array `[1, 2, 2]`.

 This dry run shows how the backtracking algorithm generates all possible subsets while avoiding duplicates by skipping over repeated elements.
 */
