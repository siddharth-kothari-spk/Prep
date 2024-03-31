/*
 Kth smallest element in a row-wise and column-wise sorted 2D array
 Given an n x n matrix, where every row and column is sorted in non-decreasing order. Find the kth smallest element in the given 2D array.

 Example,

 Input:k = 3 and array =
         10, 20, 30, 40
         15, 25, 35, 45
         24, 29, 37, 48
         32, 33, 39, 50
 Output: 20
 Explanation: The 3rd smallest element is 20
 Input:k = 7 and array =
         10, 20, 30, 40
         15, 25, 35, 45
         24, 29, 37, 48
         32, 33, 39, 50
 Output: 30
 Explanation: The 7th smallest element is 30
 */


// Solution:
/*
 Here's an algorithm to find the Kth smallest element in a row-wise and column-wise sorted 2D array:

 **Algorithm:**

 1. **Min-Heap:** Create a Min-Heap (priority queue with minimum element at the top).
 2. **Initialize Heap:**
     - Iterate through the first row of the matrix and add each element along with its corresponding row and column indices to the Min-Heap.
 3. **Loop for K elements:**
     - Run a loop **K** times:
         - Extract the minimum element (**min_element**) from the Min-Heap. This is the current Kth smallest element seen so far.
         - Get the row and column indices of **min_element**.
         - If **K == 1** (reached the Kth element), return **min_element**.
         - Add the next element from the same column (element at `row_index + 1, column_index`) to the Min-Heap if it exists (i.e., not exceeding the matrix bounds).
         - Re-arrange the Min-Heap using the `min-heapify` operation to maintain the min element at the top.

 **Explanation:**

 - The Min-Heap prioritizes smaller elements. By iterating through the first row (smallest elements in each column) and adding them to the heap, we get a starting point for finding the Kth smallest element.
 - In each iteration, we extract the minimum element from the heap (current Kth smallest) and replace it with the next element from the same column (potentially smaller element) if it exists.
 - Re-arranging the heap ensures the smallest element remains on top after each replacement.

 **Time Complexity:**

 - Creating the initial heap with `n` elements takes O(n * log(n)) time due to heap insertions.
 - The loop iterates `K` times, and each iteration involves extracting the minimum (log(n)) and potentially adding a new element (log(n)) along with heap re-arrangement (log(n)). This results in O(K * log(n)) time complexity.
 - Overall time complexity: O(n * log(n) + K * log(n)) ≈ O(n * log(n)) for large `n`.

 **Space Complexity:**

 - The Min-Heap uses O(n) space to store elements.

 **Example:**

 Consider the input matrix:

 ```
 10, 20, 30, 40
 15, 25, 35, 45
 24, 29, 37, 48
 32, 33, 39, 50
 ```

 For K=3:

 1. Min-Heap: {10 (row 0, col 0)}
 2. Extract min: 10, K becomes 2.
 3. Add next element from same column (15). Min-Heap: {15 (row 1, col 0), 20 (row 0, col 1)}
 4. Extract min: 15, K becomes 1.
 5. Add next element (20). However, we stop here as K becomes 1 (reached the 3rd smallest element).

 The output is 20.

 */


func findKthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
  guard !matrix.isEmpty else { return -1 } // Handle empty matrix case

  let n = matrix.count

  // Min-heap to store elements with their row and column indices
  var minHeap: [(element: Int, row: Int, col: Int)] = []

  // Add elements from the first row to the min-heap
  for col in 0..<n {
    minHeap.append((element: matrix[0][col], row: 0, col: col))
  }

  // Build the initial min-heap (O(n log n))
  minHeap.sort { $0.element < $1.element }
  // Loop for K elements (O(K log n))
 
  for index in 0..<k {
      print("**** index: \(index)")
    //guard let minElement = minHeap.popFirst() else { return -1 }
      guard !minHeap.isEmpty else { return -1 }
      let minElement = minHeap.removeFirst()
      print("minElement: \(minElement)")
    if index == k-1 {
      return minElement.element
    }

    // Add next element from the same column (if it exists)
    let nextRow = minElement.row + 1
    if nextRow < n {
      minHeap.append((element: matrix[nextRow][minElement.col], row: nextRow, col: minElement.col))
    }

    // Re-arrange the min-heap (log n)
    minHeap.sort { $0.element < $1.element }
      print(minHeap)
  }

  return -1 // Should not reach here if K is valid
}

var arr : [[Int]] = [
[10, 20, 30, 40],
[15, 25, 35, 45],
[24, 29, 37, 48],
[32, 33, 39, 50]
]
print(findKthSmallest(arr, 5))





