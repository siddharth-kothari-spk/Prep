/*
 
 https://www.geeksforgeeks.org/inversion-count-in-array-using-merge-sort/
 
 Here's the algorithm for finding the inversion count in an array using Merge Sort:

 **Inversion Count:**

 An inversion in an array A[0..n-1] is a pair (i, j) where i < j and A[i] > A[j]. The inversion count is the total number of inversions in the array.

 **Merge Sort (modified to count inversions):**

 1. Divide the array into two halves (left and right subarrays) recursively until each subarray has only one element. In this case, there will be no inversions within a subarray of size 1.
 2. Conquer: In the merge step, count the inversions while merging the sorted left and right subarrays back together.
 3. Combine: This is where we modify the standard Merge Sort algorithm to count inversions.

 **Merge function with Inversion Counting:**

 - Take two sorted subarrays `left` and `right` as input.
 - Use two pointers `i` and `j` to iterate through `left` and `right` subarrays, respectively.
 - Initialize a variable `count` to store the inversion count.
   - While both `i` and `j` are within their respective subarray boundaries:
     - If `left[i] <= right[j]`, then simply add the elements from the left subarray to the merged output (no inversions). Increment `i`.
     - Else (if `left[i] > right[j]`), this creates an inversion. All the remaining elements in the left subarray `left[i+1..len(left)]` will be greater than `right[j]`. So, increment the count by the length of the remaining elements in the left subarray (`len(left) - i`). Then, increment `j` to move to the next element in the right subarray.
 -  After merging both subarrays, append any remaining elements from either subarray (whichever elements weren't processed yet due to the pointer reaching the end).

 **Overall Process:**

 1. Call the modified Merge Sort function with the entire array as input.
 2. The `count` variable maintained within the `merge` function will hold the total inversion count for the entire array after processing all subarrays.

 This approach leverages the divide-and-conquer strategy of Merge Sort and efficiently calculates the inversions while merging the sorted subarrays.

 */

func mergeSortAndCountInversions(_ array: [Int]) -> (sortedArray: [Int], inversionCount: Int) {
  guard array.count > 1 else { return (array, 0) }

  let middleIndex = array.count / 2
    // left sub array
  let (left, leftInversions) = mergeSortAndCountInversions(Array(array[0..<middleIndex]))
    // right sub array
  let (right, rightInversions) = mergeSortAndCountInversions(Array(array[middleIndex..<array.count]))
    
  let (merged, mergeInversions) = mergeAndCountSplitInversions(left, right)

  return (merged, leftInversions + rightInversions + mergeInversions)
}

func mergeAndCountSplitInversions(_ left: [Int], _ right: [Int]) -> ([Int], Int) {
  var leftIndex = 0
  var rightIndex = 0
  var mergedArray = [Int]()
  var inversionCount = 0

  while leftIndex < left.count && rightIndex < right.count {
    if left[leftIndex] <= right[rightIndex] {
      mergedArray.append(left[leftIndex])
      leftIndex += 1
    } else {
      mergedArray.append(right[rightIndex])
      rightIndex += 1
      inversionCount += left.count - leftIndex // Count inversions here
    }
  }

  mergedArray.append(contentsOf: left[leftIndex..<left.count])
  mergedArray.append(contentsOf: right[rightIndex..<right.count])

  return (mergedArray, inversionCount)
}

// Example usage
let inputArray = [8, 4, 2, 1]
let (sortedArray, inversionCount) = mergeSortAndCountInversions(inputArray)
print("Sorted Array: \(sortedArray)")
print("Inversion Count: \(inversionCount)")
