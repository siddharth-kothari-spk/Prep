/*
 Count pairs with given sum
 Given an array of N integers, and an integer K, the task is to find the number of pairs of integers in the array whose sum is equal to K.

 Examples:

 Input: arr[] = {1, 5, 7, -1}, K = 6
 Output:  2
 Explanation: Pairs with sum 6 are (1, 5) and (7, -1).

 Input: arr[] = {1, 5, 7, -1, 5}, K = 6
 Output:  3
 Explanation: Pairs with sum 6 are (1, 5), (7, -1) & (1, 5).


 Input: arr[] = {1, 1, 1, 1}, K = 2
 Output:  6
 Explanation: Pairs with sum 2 are (1, 1), (1, 1), (1, 1), (1, 1), (1, 1).

 Input: arr[] = {10, 12, 10, 15, -1, 7, 6, 5, 4, 2, 1, 1, 1}, K = 11
 Output:  9
 Explanation: Pairs with sum 11 are (10, 1), (10, 1), (10, 1), (12, -1), (10, 1), (10, 1), (10, 1), (7, 4), (6, 5).
 */


// Solution:
/*
 1. Hash Table Approach

 This approach uses a hash table to store the frequency of each element in the array. Here's how it works:

 Initialize a hash table seen to store the count of each element.
 Iterate through the array arr.
 For each element num in the array, calculate its complement complement = k - num.
 Check if the complement complement exists in the hash table seen.
 If complement exists in seen, it means there's a pair that adds up to k. Increment a counter count for each time the complement is found.
 Add the current element num to the hash table seen (or increment its count if it already exists).
 After iterating through the entire array, return the value of the counter count.

 */
func countPairsWithHash(arr: [Int], k: Int) -> Int {
  var seen: [Int: Int] = [:]
  var count = 0
    var pairs: [(Int,Int)] = []
  for num in arr {
    let complement = k - num
    if let existingCount = seen[complement] {
      count += existingCount
        pairs.append((num, complement))
    }
    seen[num, default: 0] += 1
  }
  print(pairs)
  return count
}

print(countPairsWithHash(arr: [1, 5, 7, -1], k: 6))

/*
 2. Two Pointer Approach (Requires Sorted Array)

This approach applies only if the array is sorted. Here's the algorithm:

Sort the array arr in ascending order.
Initialize two pointers left and right to the beginning (index 0) and end (index n-1) of the array, respectively.
While left is less than right:
Calculate the current sum current_sum = arr[left] + arr[right].
If current_sum is equal to the target sum k, increment a counter count and move both pointers left one step forward and right one step backward.
If current_sum is less than k, move the left pointer left one step forward to increase the sum.
If current_sum is greater than k, move the right pointer right one step backward to decrease the sum.
After the loop terminates, return the value of the counter count.
 */

func countPairsWithTwoPointers(arr: [Int], k: Int) -> Int {
  guard !arr.isEmpty else { return 0 }
  var sortedArr = arr.sorted()
  var left = 0
  var right = sortedArr.count - 1
  var count = 0
  var pairs: [(Int,Int)] = []
    
  while left < right {
    let currentSum = sortedArr[left] + sortedArr[right]
    if currentSum == k {
      count += 1
      pairs.append((sortedArr[left], sortedArr[right]))
      left += 1
      right -= 1
    } else if currentSum < k {
      left += 1
    } else {
      right -= 1
    }
  }
  print(pairs)
  return count
}

print(countPairsWithTwoPointers(arr: [1, 5, 7, -1], k: 6))
