/*
 Compute the product of an array except for the element at each index.
 - Sample Input:
 ```
 Array: [1, 2, 3, 4]
 ```
 - Expected Output:
 ```
 Result: [24, 12, 8, 6]
 */

func productExceptSelf(_ nums: [Int]) -> [Int] {
  var result = Array(repeating: 1, count: nums.count) // Initialize result array with 1s
  
  var leftProduct = 1
  for i in 0..<nums.count {
      print("index: \(i) , num: \(nums[i])")
    result[i] = leftProduct // Store left product before current element
    leftProduct *= nums[i] // Update left product for next iteration
      print("result[i]: \(result[i])")
      print("leftProduct: \(leftProduct)")
  }
  print(result)
    print("*********")
  var rightProduct = 1
  for i in (0..<nums.count).reversed() {
      print("index: \(i) , num: \(nums[i])")
    result[i] *= rightProduct // Multiply with right product after current element
    rightProduct *= nums[i] // Update right product for previous iteration
      print("result[i]: \(result[i])")
      print("rightProduct: \(rightProduct)")
  }
  
  return result
}

print(productExceptSelf([1, 2, 3, 4]))

/*
 dry run for the input array `[1, 2, 3, 4]`.

 Initialization:
 - `result` array: `[1, 1, 1, 1]`
 - `leftProduct` = 1
 - `rightProduct` = 1

 Left Product Calculation:
 - Iteration 1 (index 0):
   - `result[0] = leftProduct`: `result` becomes `[1, 1, 1, 1]`
   - `leftProduct *= nums[0]`: `leftProduct` becomes 1

 - Iteration 2 (index 1):
   - `result[1] = leftProduct`: `result` becomes `[1, 1, 1, 1]`
   - `leftProduct *= nums[1]`: `leftProduct` becomes 2

 - Iteration 3 (index 2):
   - `result[2] = leftProduct`: `result` becomes `[1, 1, 2, 1]`
   - `leftProduct *= nums[2]`: `leftProduct` becomes 6

 - Iteration 4 (index 3):
   - `result[3] = leftProduct`: `result` becomes `[1, 1, 2, 6]`
   - `leftProduct *= nums[3]`: `leftProduct` becomes 24

 Right Product Calculation:
 - Iteration 1 (index 3):
   - `result[3] *= rightProduct`: `result` becomes `[1, 1, 2, 6]`
   - `rightProduct *= nums[3]`: `rightProduct` becomes 4

 - Iteration 2 (index 2):
   - `result[2] *= rightProduct`: `result` becomes `[1, 1, 8, 6]`
   - `rightProduct *= nums[2]`: `rightProduct` becomes 12

 - Iteration 3 (index 1):
   - `result[1] *= rightProduct`: `result` becomes `[1, 12, 8, 6]`
   - `rightProduct *= nums[1]`: `rightProduct` becomes 24

 - Iteration 4 (index 0):
   - `result[0] *= rightProduct`: `result` becomes `[24, 12, 8, 6]`
   - `rightProduct *= nums[0]`: `rightProduct` becomes 24

 Final `result` array: `[24, 12, 8, 6]`

 So, the output array for the input `[1, 2, 3, 4]` would be `[24, 12, 8, 6]`.
 */
