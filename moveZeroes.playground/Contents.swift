/*
 Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.

 Note that you must do this in-place without making a copy of the array.

  

 Example 1:

 Input: nums = [0,1,0,3,12]
 Output: [1,3,12,0,0]
 Example 2:

 Input: nums = [0]
 Output: [0]
  
 */
/*
func moveZeroes(_ nums: inout [Int]) {
    var left = 0 // Pointer to the leftmost zero
    var right = 0 // Pointer to iterate through the array
    
    // Iterate through the array
    while right < nums.count {
        // If the current element is not zero
        if nums[right] != 0 {
            // Swap the non-zero element with the leftmost zero
            nums.swapAt(left, right)
            // Move the left pointer to the next position
            left += 1
        }
        // Move the right pointer to the next position
        right += 1
    }
}
var arr = [0,1,0,3,12]
print(moveZeroes(&arr))
*/

func moveZeroes(_ nums: inout [Int]) {
    let count = nums.count
    var index = 0
    
    while index < count {
        if nums[index] == 0 {
            nums.insert(nums.remove(at: index), at: count - 1)
        }
        index += 1
    }
}

var arr = [0,1,0,3,12]
moveZeroes(&arr)
print(arr)
