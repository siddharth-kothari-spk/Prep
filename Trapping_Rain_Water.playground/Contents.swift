/*
 https://leetcode.com/problems/trapping-rain-water/description/
 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.

  

 Example 1:


 Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6
 Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.
 Example 2:

 Input: height = [4,2,0,3,2,5]
 Output: 9
 */

/*
 we can use a two-pointer approach. This approach is efficient with a time complexity of
O(n) and a space complexity of O(1).

 Here is the algorithm:

 Initialize Pointers and Variables:

 left pointer at the beginning of the array (left = 0)
 right pointer at the end of the array (right = n - 1)
 left_max to keep track of the maximum height to the left of the current position, initialized to height[left]
 right_max to keep track of the maximum height to the right of the current position, initialized to height[right]
 water_trapped to accumulate the total amount of trapped water, initialized to 0
 Traverse the Array:

 While left is less than right:
 If the height at the left pointer is less than the height at the right pointer:
 If height[left] is greater than or equal to left_max, update left_max
 Else, add the difference between left_max and height[left] to water_trapped
 Move the left pointer one step to the right
 Else:
 If height[right] is greater than or equal to right_max, update right_max
 Else, add the difference between right_max and height[right] to water_trapped
 Move the right pointer one step to the left
 Return the Result:

 After the loop ends, water_trapped will contain the total amount of trapped water.
 */

func trap(_ height: [Int]) -> Int {
    guard height.count > 0 else {
        return 0
    }
    
    var left = 0
    var right = height.count - 1
    var leftMax = height[left]
    var rightMax = height[right]
    var waterTrapped = 0
    
    while left < right {
        if height[left] < height[right] {
            if height[left] >= leftMax {
                leftMax = height[left]
            } else {
                waterTrapped += leftMax - height[left]
            }
            left += 1
        } else {
            if height[right] >= rightMax {
                rightMax = height[right]
            } else {
                waterTrapped += rightMax - height[right]
            }
            right -= 1
        }
    }
    
    return waterTrapped
}

// Example Usage
let height1 = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
print(trap(height1))  // Output: 6

let height2 = [4, 2, 0, 3, 2, 5]
print(trap(height2))  // Output: 9

/*
 Certainly! Let's perform a dry run of the `trap` function with the input `height2 = [4, 2, 0, 3, 2, 5]`.

 ### Initial State:
 - `left = 0`
 - `right = 5`
 - `leftMax = height[0] = 4`
 - `rightMax = height[5] = 5`
 - `waterTrapped = 0`

 ### Iteration 1:
 - `height[left] = 4`
 - `height[right] = 5`
 - Since `height[left] < height[right]`:
   - `leftMax = max(leftMax, height[left]) = max(4, 4) = 4`
   - Water trapped at index `left = 0`: `leftMax - height[left] = 4 - 4 = 0`
   - Increment `left` by 1: `left = 1`
 - `waterTrapped = 0`

 ### Iteration 2:
 - `height[left] = 2`
 - `height[right] = 5`
 - Since `height[left] < height[right]`:
   - `leftMax = max(leftMax, height[left]) = max(4, 2) = 4`
   - Water trapped at index `left = 1`: `leftMax - height[left] = 4 - 2 = 2`
   - Increment `left` by 1: `left = 2`
 - `waterTrapped = 2`

 ### Iteration 3:
 - `height[left] = 0`
 - `height[right] = 5`
 - Since `height[left] < height[right]`:
   - `leftMax = max(leftMax, height[left]) = max(4, 0) = 4`
   - Water trapped at index `left = 2`: `leftMax - height[left] = 4 - 0 = 4`
   - Increment `left` by 1: `left = 3`
 - `waterTrapped = 2 + 4 = 6`

 ### Iteration 4:
 - `height[left] = 3`
 - `height[right] = 5`
 - Since `height[left] < height[right]`:
   - `leftMax = max(leftMax, height[left]) = max(4, 3) = 4`
   - Water trapped at index `left = 3`: `leftMax - height[left] = 4 - 3 = 1`
   - Increment `left` by 1: `left = 4`
 - `waterTrapped = 6 + 1 = 7`

 ### Iteration 5:
 - `height[left] = 2`
 - `height[right] = 5`
 - Since `height[left] < height[right]`:
   - `leftMax = max(leftMax, height[left]) = max(4, 2) = 4`
   - Water trapped at index `left = 4`: `leftMax - height[left] = 4 - 2 = 2`
   - Increment `left` by 1: `left = 5`
 - `waterTrapped = 7 + 2 = 9`

 ### Exit Condition:
 - Now, `left` equals `right` (both are 5), so the loop terminates.

 ### Final State:
 - `waterTrapped = 9`

 ### Conclusion:
 - The total amount of trapped water for `height2 = [4, 2, 0, 3, 2, 5]` is `9`.

 Thus, the function correctly calculates that 9 units of water can be trapped.
 */
