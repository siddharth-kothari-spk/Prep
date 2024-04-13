/*
 Find all unique triplets in an array that add up to a specific target.
 - Sample Input:
 ```
 Array: [-1, 0, 1, 2, -1, -4]
 ```
 - Expected Output:
 ```
 Triplets: [[-1, 0, 1], [-1, -1, 2]]
 */

func threeSum(_ nums: [Int], _ target: Int) -> [[Int]] {
  var triplets = [[Int]]()
  let sortedNums = nums.sorted() // Sort the array
  
  for i in 0..<sortedNums.count - 2 {
    guard sortedNums[i] <= 0 else { break } // Optimization: Skip positive numbers after 0 as the sum will only decrease
    
    var low = i + 1
    var high = sortedNums.count - 1
    
    while low < high {
      let sum = sortedNums[i] + sortedNums[low] + sortedNums[high]
      if sum == target {
        triplets.append([sortedNums[i], sortedNums[low], sortedNums[high]])
        while low < high && sortedNums[low] == sortedNums[low + 1] { low += 1 } // Skip duplicates in the middle
        while low < high && sortedNums[high] == sortedNums[high - 1] { high -= 1 } // Skip duplicates in the end
        low += 1
        high -= 1
      } else if sum < target {
        low += 1
      } else {
        high -= 1
      }
    }
  }
  
  return triplets
}


print(threeSum([-1, 0, 1, 2, -1, -4], 0))
