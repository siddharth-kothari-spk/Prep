/*
 https://www.geeksforgeeks.org/check-if-an-array-contains-all-elements-of-a-given-range/
 
*/

func containsAllRangeElements(_ arr: [Int], _ A: Int, _ B: Int) -> Bool {
  guard A <= B else {
    return false // Invalid range where lower bound is greater than upper bound
  }

  let adjustedRange = B - A + 1
    print("adjustedRange: \(adjustedRange)")

  var freqCounter = [Int](repeating: 0, count: adjustedRange)

  for num in arr {
      
    if 0 <= num - A && num - A <= adjustedRange {
      let index = num - A
        print("num:\(num), num - A: \(num - A)")
      // Handle duplicate elements by marking once only
      if freqCounter[index] == 0 {
        freqCounter[index] = 1
      } else {
        return false // Early exit if a duplicate is encountered
      }
    }
  }
 print(freqCounter)
  // Check if all elements in the adjusted range were encountered
  return freqCounter.allSatisfy { $0 == 1 }
}

// Example usage
let arr = [-1, 4, 5, -2, 7, 8, -3] // [1, 4, 5, 2, 7, 8, 3]
let A = -3 // 2
let B = -1 // 5

if containsAllRangeElements(arr, A, B) {
  print("Yes")
} else {
  print("No")
}

