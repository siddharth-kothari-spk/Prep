/*
 Find all unique quadruplets in an array that add up to a specific target.
 - Sample Input:
 ```
 Array: [1, 0, -1, 0, -2, 2], Target: 0
 ```
 - Expected Output:
 ```
 Quadruplets: [[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]
 */

func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
  var quadruplets = [[Int]]()
  let sortedNums = nums.sorted() // Sort the array
    
  for i in 0..<sortedNums.count - 3 {
      
    guard sortedNums[i] <= target / 4 else { break } // Optimization: Skip if element is too large
      
    for j in i + 1..<sortedNums.count - 2 {
        
      guard sortedNums[j] <= (target - sortedNums[i]) / 2 else { break } // Optimization: Skip if jth element is too large
        
      let remainingTarget = target - sortedNums[i] - sortedNums[j]
      var low = j + 1
      var high = sortedNums.count - 1
      
      while low < high {

        let sum = sortedNums[low] + sortedNums[high]
          
        if sum == remainingTarget {
          quadruplets.append([sortedNums[i], sortedNums[j], sortedNums[low], sortedNums[high]])
            
            while low < high && sortedNums[low] == sortedNums[low + 1] {
                low += 1
            } // Skip duplicates in the middle
            
            while low < high && sortedNums[high] == sortedNums[high - 1] {
                high -= 1
            } // Skip duplicates at the end
            
              low += 1
              high -= 1
        } else if sum < remainingTarget {
            low += 1 // need to move towards higher number
        } else {
            high -= 1 // need to move towards lower number
        }
      }
    }
  }
  
  return quadruplets
}


print(fourSum([1, 0, -1, 0, -2, 2], 0))
