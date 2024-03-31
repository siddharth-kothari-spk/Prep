/*
 Longest Consecutive Subsequence
 Given an array of integers, find the length of the longest sub-sequence such that elements in the subsequence are consecutive integers, the consecutive numbers can be in any order.

 Examples:

 Input: arr[] = {1, 9, 3, 10, 4, 20, 2}
 Output: 4
 Explanation: The subsequence 1, 3, 4, 2 is the longest subsequence of consecutive elements

 Input: arr[] = {36, 41, 56, 35, 44, 33, 34, 92, 43, 32, 42}
 Output: 5
 Explanation: The subsequence 36, 35, 33, 34, 32 is the longest subsequence of consecutive elements.
 */

func longestConsecutive(_ nums: [Int]) -> Int {
  var hashTable = Set<Int>()
  var longestLength = 0
  
  // Insert all elements into the hash table
  for num in nums {
    hashTable.insert(num)
  }
  
  // Iterate through the array
  for num in nums {
    // Check if the number is not the starting point of a subsequence (i.e., num-1 exists)
    if !hashTable.contains(num - 1) {
      var currentLength = 1
      var nextNum = num + 1
      
      // Iterate as long as the next number exists in the hash table
      while hashTable.contains(nextNum) {
        currentLength += 1
        nextNum += 1
      }
      
      longestLength = max(longestLength, currentLength)
    }
  }
  
  return longestLength
}

print(longestConsecutive([1, 9, 3, 10, 4, 20, 2])) // 4
print(longestConsecutive([36, 41, 56, 35, 44, 33, 34, 92, 43, 32, 42])) // 5
