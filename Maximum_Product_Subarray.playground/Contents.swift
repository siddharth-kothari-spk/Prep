/*
 https://leetcode.com/problems/maximum-product-subarray/description/
 Given an integer array nums, find a
 subarray
  that has the largest product, and return the product.

 The test cases are generated so that the answer will fit in a 32-bit integer.

  

 Example 1:

 Input: nums = [2,3,-2,4]
 Output: 6
 Explanation: [2,3] has the largest product 6.
 Example 2:

 Input: nums = [-2,0,-1]
 Output: 0
 Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
  

 Constraints:

 1 <= nums.length <= 2 * 104
 -10 <= nums[i] <= 10
 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
 */

/*
 To solve the problem of finding the subarray with the largest product in an integer array, we can use a dynamic programming approach. The key is to keep track of the maximum and minimum products up to the current index because a negative number can turn a large negative product into a large positive product and vice versa.

 Here is the algorithm to achieve this:

 Initialize three variables: max_product, min_product, and result. Set both max_product and min_product to the first element of the array. Set result to the same value as well.
 Iterate through the array starting from the second element.
 For each element, update max_product and min_product as follows:
 If the current element is negative, swap max_product and min_product because multiplying by a negative number flips the signs.
 Update max_product to be the maximum of the current element itself or the product of max_product with the current element.
 Update min_product to be the minimum of the current element itself or the product of min_product with the current element.
 Update result to be the maximum of result and max_product.
 Return result.
 */

func maxProduct(_ nums: [Int]) -> Int {
    if nums.isEmpty {
        return 0
    }
    
    var maxProduct = nums[0]
    var minProduct = nums[0]
    var result = nums[0]
    
    for i in 1..<nums.count {
        let num = nums[i]
        
        if num < 0 {
            swap(&maxProduct, &minProduct)
        }
        
        maxProduct = max(num, maxProduct * num)
        minProduct = min(num, minProduct * num)
        
        result = max(result, maxProduct)
    }
    
    return result
}

// Example usage:
let nums1 = [2, 3, -2, 4]
print(maxProduct(nums1))  // Output: 6

let nums2 = [-2, 0, -1]
print(maxProduct(nums2))  // Output: 0

/*
 Let's perform a dry run of the provided Swift code with `nums1 = [2, 3, -2, 4]`.

 ### Initial State:
 - `maxProduct = nums[0] = 2`
 - `minProduct = nums[0] = 2`
 - `result = nums[0] = 2`

 ### Iteration through the array:

 1. **Iteration 1 (`i = 1`, `num = 3`):**
    - `num` is not negative, so no swap is needed.
    - Update `maxProduct`:
      ```swift
      maxProduct = max(num, maxProduct * num) = max(3, 2 * 3) = 6
      ```
    - Update `minProduct`:
      ```swift
      minProduct = min(num, minProduct * num) = min(3, 2 * 3) = 3
      ```
    - Update `result`:
      ```swift
      result = max(result, maxProduct) = max(2, 6) = 6
      ```

    Current values:
    - `maxProduct = 6`
    - `minProduct = 3`
    - `result = 6`

 2. **Iteration 2 (`i = 2`, `num = -2`):**
    - `num` is negative, so swap `maxProduct` and `minProduct`:
      ```swift
      swap(&maxProduct, &minProduct) // maxProduct = 3, minProduct = 6
      ```
    - Update `maxProduct`:
      ```swift
      maxProduct = max(num, maxProduct * num) = max(-2, 3 * -2) = -2
      ```
    - Update `minProduct`:
      ```swift
      minProduct = min(num, minProduct * num) = min(-2, 6 * -2) = -12
      ```
    - `result` remains unchanged:
      ```swift
      result = max(result, maxProduct) = max(6, -2) = 6
      ```

    Current values:
    - `maxProduct = -2`
    - `minProduct = -12`
    - `result = 6`

 3. **Iteration 3 (`i = 3`, `num = 4`):**
    - `num` is not negative, so no swap is needed.
    - Update `maxProduct`:
      ```swift
      maxProduct = max(num, maxProduct * num) = max(4, -2 * 4) = 4
      ```
    - Update `minProduct`:
      ```swift
      minProduct = min(num, minProduct * num) = min(4, -12 * 4) = -48
      ```
    - Update `result`:
      ```swift
      result = max(result, maxProduct) = max(6, 4) = 6
      ```

    Final values:
    - `maxProduct = 4`
    - `minProduct = -48`
    - `result = 6`

 ### Conclusion:
 The maximum product subarray for `nums1 = [2, 3, -2, 4]` is `[2, 3]` with a product of `6`, which matches the `result`. The function correctly identifies this and returns `6`.
 */
