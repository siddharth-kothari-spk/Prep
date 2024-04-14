/*
 search in a rotated sorted array.
 - Sample Input:
 ```
 Rotated Array: [15, 18, 21, 3, 6, 8, 12]
 Target: 8
 */

func searchRotatedArray(array: [Int], target: Int) -> Int? {
  var lowerBound = 0
  var upperBound = array.count - 1

  while lowerBound <= upperBound {
    let midIndex = (lowerBound + upperBound) / 2
    let midValue = array[midIndex]

    if midValue == target {
      return midIndex
    }

    // Check if the left half is sorted (including the middle element)
    if array[lowerBound] <= midValue {
      if target < midValue {
        upperBound = midIndex - 1
      } else {
        lowerBound = midIndex + 1
      }
    } else { // Right half is sorted
      if target > midValue {
        lowerBound = midIndex + 1
      } else {
        upperBound = midIndex - 1
      }
    }
  }

  return nil // Target not found
}

searchRotatedArray(array: [15, 18, 21, 3, 6, 8, 12], target: 8)
searchRotatedArray(array: [15, 18, 21, 3, 6, 8, 12], target: 15) // does not work.
searchRotatedArray(array: [15, 18, 21, 3, 6, 8, 12], target: 6)
searchRotatedArray(array: [15, 18, 21, 3, 6, 8, 12], target: 3)




func searchInRotatedArray(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    
    while left <= right {
        let mid = left + (right - left) / 2
        
        if nums[mid] == target {
            return mid
        }
        
        // Determine the normally ordered half
        if nums[left] <= nums[mid] { // Left half is normally ordered
            if target >= nums[left] && target < nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else { // Right half is normally ordered
            if target > nums[mid] && target <= nums[right] {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    return -1
}
/*
 Let's perform a dry run of the function `searchInRotatedArray` using the rotated array `[15, 18, 21, 3, 6, 8, 12]` and the target `21`. Here’s how each step would proceed:

 ### Initial Setup:
 - `rotatedArray = [15, 18, 21, 3, 6, 8, 12]`
 - `target = 21`
 - `left = 0`
 - `right = 6` (since the array has 7 elements, indices range from 0 to 6)

 ### Iteration Steps:

 1. **Calculate the middle index:**
    - `mid = left + (right - left) / 2 = 0 + (6 - 0) / 2 = 3`

 2. **Value at mid and condition checks:**
    - `nums[mid] = nums[3] = 3`
    - Since `nums[3]` is not equal to `21`, we check which half is sorted.
    - `nums[left] <= nums[mid]` fails since `15` (nums[left]) is not less than or equal to `3` (nums[mid]). So, the left half is not sorted.
    - The right half (`mid` to `right`) must be sorted because this is a rotated sorted array, so at least one half must be sorted.

 3. **Decide the search area:**
    - Check if the target is within the sorted half (`mid` to `right`):
      - Since `21` is greater than `3` (nums[mid]) and less than `12` (nums[right]), the condition `target > nums[mid] && target <= nums[right]` also fails.
    - Hence, the search continues on the left half. We adjust the right pointer:
      - `right = mid - 1 = 3 - 1 = 2`

 4. **Recalculate the middle index:**
    - `mid = left + (right - left) / 2 = 0 + (2 - 0) / 2 = 1`

 5. **Value at mid and condition checks:**
    - `nums[mid] = nums[1] = 18`
    - `nums[mid]` is not `21`. We check if the left half (`left` to `mid`) is sorted.
    - `nums[left] <= nums[mid]` holds since `15` (nums[left]) is less than `18` (nums[mid]), so this half is sorted.

 6. **Decide the search area again:**
    - Since `21` is greater than `18` (nums[mid]), the target must be in the right part of this sub-array (though in this case, it is just the next element). Update the `left` pointer:
      - `left = mid + 1 = 1 + 1 = 2`

 7. **Recalculate the middle index:**
    - `mid = left + (right - left) / 2 = 2 + (2 - 2) / 2 = 2`

 8. **Check value at mid:**
    - `nums[mid] = nums[2] = 21`
    - The element at `mid` is equal to the target `21`.

 ### Conclusion:
 The target `21` is found at index `2`. The function would return `2` indicating the position of `21` in the array. This confirms that the logic in our function successfully navigates through a rotated sorted array to find a specified target.
 */

// Example usage
let rotatedArray = [15, 18, 21, 3, 6, 8, 12]
let target = 21
let index = searchInRotatedArray(rotatedArray, target)
if index != -1 {
    print("Target \(target) found at index \(index).")
} else {
    print("Target \(target) not found in the array.")
}
