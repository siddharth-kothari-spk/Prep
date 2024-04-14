/*
 Find the first and last position of a target element in a sorted array.
 - Sample Input:
 ```
 Array: [5, 7, 7, 8, 8, 10], Target: 8
 ```
 - Expected Output:
 ```
 First Position: 3, Last Position: 4
 */
import Foundation

func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
  var firstPosition = -1
  var lastPosition = -1
  
  var left = 0
  var right = nums.count - 1
  
  // Find the first occurrence
  while left <= right {
    let mid = left + (right - left) / 2
    if nums[mid] < target {
      left = mid + 1
    } else if nums[mid] > target {
      right = mid - 1
    } else {
      firstPosition = mid
      right = mid - 1 // Continue searching for earlier occurrences
    }
  }
  
  // Find the last occurrence (if first position is found)
  if firstPosition != -1 {
    left = firstPosition
    right = nums.count - 1
    while left <= right {
      let mid = left + (right - left) / 2
      if nums[mid] < target {
        left = mid + 1
      } else if nums[mid] > target {
        right = mid - 1
      } else {
        lastPosition = mid
        left = mid + 1 // Continue searching for later occurrences
      }
    }
  }
  
  return [firstPosition, lastPosition]
}

searchRange([5, 7, 7, 8, 8, 10], 8)
searchRange([5, 7, 7, 8, 8, 10], 10)


func searchRange2(_ nums: [Int], _ target: Int) -> [Int] {
  var firstPosition = -1
  var lastPosition = -1
  
  var left = 0
  var right = nums.count - 1
  
  // Find the first occurrence
  while left <= right {
    let mid = left + (right - left) / 2
    if nums[mid] < target {
      left = mid + 1
    } else if nums[mid] > target {
      right = mid - 1
    } else {
      firstPosition = mid
      right = mid - 1 // Continue searching for earlier occurrences
    }
  }
  
  // Find the last occurrence (if first position is found)
  if firstPosition != -1 {
      // as array is sorted we can directly take out the count of target and use that to get lastPosition
      let count = nums.filter { $0 == target}.count
      lastPosition = firstPosition + (count - 1)
  }
  
  return [firstPosition, lastPosition]
}

searchRange2([5, 7, 7, 8, 8, 10], 8)
searchRange2([5, 7, 7, 8, 8, 10], 10)
