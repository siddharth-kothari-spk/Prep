/*
 https://leetcode.com/problems/permutations/description/
 Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

 Example 1:
 Input: nums = [1,2,3]
 Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
 
 Example 2:
 Input: nums = [0,1]
 Output: [[0,1],[1,0]]
 
 Example 3:
 Input: nums = [1]
 Output: [[1]]
 */

func permute(_ nums: [Int]) -> [[Int]] {
    var results = [[Int]]()
    var nums = nums
    
    func backtrack(_ first: Int) {
        if first == nums.count {
            results.append(nums)
            return
        }
        for i in first..<nums.count {
            nums.swapAt(first, i)
            backtrack(first + 1)
            nums.swapAt(first, i)
        }
    }
    
    backtrack(0)
    return results
}

// Example 1
let nums1 = [1, 2, 3]
print(permute(nums1))
// Output: [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]

// Example 2
let nums2 = [0, 1]
print(permute(nums2))
// Output: [[0, 1], [1, 0]]

// Example 3
let nums3 = [1]
print(permute(nums3))
// Output: [[1]]

/*
 Explanation:
 Define the permute function:

 This function initializes an empty array results to store the permutations.
 The nums array is passed by reference to the backtrack function to be modified directly.
 Define the backtrack function:

 This recursive function generates permutations by swapping elements.
 The base case is when first equals the length of nums, indicating a complete permutation, which is then appended to results.
 The loop iterates through each element starting from the first position, swapping elements to generate new permutations, and then swapping back to restore the original order.
 Generate permutations:

 The backtrack function is initially called with first = 0.
 The function swaps elements, recursively calls itself to generate further permutations, and then swaps back to continue generating other permutations.
 */

/*
 Sure, let's go through a dry run of the Swift `permute` function with `nums1 = [1, 2, 3]` step by step to see how the permutations are generated.

 ### Initial State:
 - `results` = []
 - `nums` = [1, 2, 3]

 ### Step-by-Step Execution:

 1. **First Call to `backtrack` (first = 0):**
    - `first` = 0
    - Loop from `i = 0` to `i < 3`

 2. **First Iteration (i = 0):**
    - Swap `nums[0]` and `nums[0]` → [1, 2, 3]
    - Call `backtrack(1)`
    
 3. **Second Call to `backtrack` (first = 1):**
    - `first` = 1
    - Loop from `i = 1` to `i < 3`

 4. **First Iteration (i = 1):**
    - Swap `nums[1]` and `nums[1]` → [1, 2, 3]
    - Call `backtrack(2)`

 5. **Third Call to `backtrack` (first = 2):**
    - `first` = 2
    - Loop from `i = 2` to `i < 3`

 6. **First Iteration (i = 2):**
    - Swap `nums[2]` and `nums[2]` → [1, 2, 3]
    - Call `backtrack(3)`

 7. **Fourth Call to `backtrack` (first = 3):**
    - `first` = 3
    - `first` equals `nums.count`, so append [1, 2, 3] to `results`
    - `results` = [[1, 2, 3]]
    - Return to previous call

 8. **Backtrack (undo swap):**
    - Swap `nums[2]` and `nums[2]` → [1, 2, 3]
    - Loop ends, return to previous call

 9. **Second Iteration (i = 2):**
    - Swap `nums[1]` and `nums[2]` → [1, 3, 2]
    - Call `backtrack(2)`

 10. **Fifth Call to `backtrack` (first = 2):**
     - `first` = 2
     - Loop from `i = 2` to `i < 3`

 11. **First Iteration (i = 2):**
     - Swap `nums[2]` and `nums[2]` → [1, 3, 2]
     - Call `backtrack(3)`

 12. **Sixth Call to `backtrack` (first = 3):**
     - `first` = 3
     - `first` equals `nums.count`, so append [1, 3, 2] to `results`
     - `results` = [[1, 2, 3], [1, 3, 2]]
     - Return to previous call

 13. **Backtrack (undo swap):**
     - Swap `nums[2]` and `nums[2]` → [1, 3, 2]
     - Loop ends, return to previous call

 14. **Backtrack (undo swap):**
     - Swap `nums[1]` and `nums[2]` → [1, 2, 3]
     - Loop ends, return to previous call

 15. **Second Iteration (i = 1):**
     - Swap `nums[0]` and `nums[1]` → [2, 1, 3]
     - Call `backtrack(1)`

 16. **Seventh Call to `backtrack` (first = 1):**
     - `first` = 1
     - Loop from `i = 1` to `i < 3`

 17. **First Iteration (i = 1):**
     - Swap `nums[1]` and `nums[1]` → [2, 1, 3]
     - Call `backtrack(2)`

 18. **Eighth Call to `backtrack` (first = 2):**
     - `first` = 2
     - Loop from `i = 2` to `i < 3`

 19. **First Iteration (i = 2):**
     - Swap `nums[2]` and `nums[2]` → [2, 1, 3]
     - Call `backtrack(3)`

 20. **Ninth Call to `backtrack` (first = 3):**
     - `first` = 3
     - `first` equals `nums.count`, so append [2, 1, 3] to `results`
     - `results` = [[1, 2, 3], [1, 3, 2], [2, 1, 3]]
     - Return to previous call

 21. **Backtrack (undo swap):**
     - Swap `nums[2]` and `nums[2]` → [2, 1, 3]
     - Loop ends, return to previous call

 22. **Second Iteration (i = 2):**
     - Swap `nums[1]` and `nums[2]` → [2, 3, 1]
     - Call `backtrack(2)`

 23. **Tenth Call to `backtrack` (first = 2):**
     - `first` = 2
     - Loop from `i = 2` to `i < 3`

 24. **First Iteration (i = 2):**
     - Swap `nums[2]` and `nums[2]` → [2, 3, 1]
     - Call `backtrack(3)`

 25. **Eleventh Call to `backtrack` (first = 3):**
     - `first` = 3
     - `first` equals `nums.count`, so append [2, 3, 1] to `results`
     - `results` = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1]]
     - Return to previous call

 26. **Backtrack (undo swap):**
     - Swap `nums[2]` and `nums[2]` → [2, 3, 1]
     - Loop ends, return to previous call

 27. **Backtrack (undo swap):**
     - Swap `nums[1]` and `nums[2]` → [2, 1, 3]
     - Loop ends, return to previous call

 28. **Backtrack (undo swap):**
     - Swap `nums[0]` and `nums[1]` → [1, 2, 3]
     - Loop ends, return to previous call

 29. **Third Iteration (i = 2):**
     - Swap `nums[0]` and `nums[2]` → [3, 2, 1]
     - Call `backtrack(1)`

 30. **Twelfth Call to `backtrack` (first = 1):**
     - `first` = 1
     - Loop from `i = 1` to `i < 3`

 31. **First Iteration (i = 1):**
     - Swap `nums[1]` and `nums[1]` → [3, 2, 1]
     - Call `backtrack(2)`

 32. **Thirteenth Call to `backtrack` (first = 2):**
     - `first` = 2
     - Loop from `i = 2` to `i < 3`

 33. **First Iteration (i = 2):**
     - Swap `nums[2]` and `nums[2]` → [3, 2, 1]
     - Call `backtrack(3)`

 34. **Fourteenth Call to `backtrack` (first = 3):**
     - `first` = 3
     - `first` equals `nums.count`, so append [3, 2, 1] to `results`
     - `results` = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1]]
     - Return to previous call

 35. **Backtrack (undo swap):**
     - Swap `nums[2]` and `nums[2]` → [3

 , 2, 1]
     - Loop ends, return to previous call

 36. **Second Iteration (i = 2):**
     - Swap `nums[1]` and `nums[2]` → [3, 1, 2]
     - Call `backtrack(2)`

 37. **Fifteenth Call to `backtrack` (first = 2):**
     - `first` = 2
     - Loop from `i = 2` to `i < 3`

 38. **First Iteration (i = 2):**
     - Swap `nums[2]` and `nums[2]` → [3, 1, 2]
     - Call `backtrack(3)`

 39. **Sixteenth Call to `backtrack` (first = 3):**
     - `first` = 3
     - `first` equals `nums.count`, so append [3, 1, 2] to `results`
     - `results` = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]
     - Return to previous call

 40. **Backtrack (undo swap):**
     - Swap `nums[2]` and `nums[2]` → [3, 1, 2]
     - Loop ends, return to previous call

 41. **Backtrack (undo swap):**
     - Swap `nums[1]` and `nums[2]` → [3, 2, 1]
     - Loop ends, return to previous call

 42. **Backtrack (undo swap):**
     - Swap `nums[0]` and `nums[2]` → [1, 2, 3]
     - Loop ends, return to previous call

 The function completes with `results` containing all permutations:
 - `results` = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]

 ### Final Output:
 ```swift
 [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]
 ```
 */
