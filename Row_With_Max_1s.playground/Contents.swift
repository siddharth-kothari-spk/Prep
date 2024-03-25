/*
 https://www.geeksforgeeks.org/find-the-row-with-maximum-number-1s/
 
 Improved Approach using property of sorted rows (Time Complexity: O(m*log(n))

 If the rows in the matrix are sorted by increasing order of 1s (0s come first, then 1s), we can exploit this property to find the first occurrence of 1 in each row. Since the number of columns (n) is fixed, the number of elements to the right of the first 1 will be the number of 1s in that row.

 Steps:

 Initialize two variables:
 max_index: stores the index of the row with the maximum number of 1s (initialize to -1).
 Loop through each row i from 0 to the total number of rows (m):
 Use a search algorithm (like binary search) to find the first occurrence of 1 in the current row i. Let first_one_index be the index of the first 1.
 Calculate the number of 1s in the row: num_ones = number_of_columns - first_one_index (assuming all elements after the first 1 are 1s).
 Compare num_ones with the implicit count stored in max_index (which represents the number of 1s in the row with the current maximum):
 If num_ones is greater than the value stored in max_index:
 Update max_index with i.
 Return max_index.
 This approach reduces the time complexity for counting 1s in each row.

 Note: The second approach is only applicable if the rows are sorted by increasing order of 1s.
 */

func findRowWithMaxOnes(_ matrix: [[Int]]) -> Int {
  let rows = matrix.count
  let cols = matrix[0].count

  var maxIndex = -1

  for row in 0..<rows {
      print("row: \(matrix[row])")
    let firstOneIndex = findFirstOne(in: matrix[row])
      print("firstOneIndex: \(firstOneIndex)")
    if firstOneIndex != cols {
      let numOnes = cols - firstOneIndex
      if numOnes > maxIndex {
        maxIndex = row
      }
    }
      print("maxIndex:\(maxIndex)")
  }

  return maxIndex
}

func findFirstOne(in row: [Int]) -> Int {
  var low = 0
  var high = row.count - 1
    print("low: \(low), high: \(high)")
  while low <= high && high > 0 {
      print("******")
    let mid = (low + high) / 2
      print("mid: \(mid)")
    if row[mid] == 0 {
      low = mid + 1
    } else {
      // Move left if the element at mid is 1 but there might be a 1 on the left
      if mid > 0 && row[mid - 1] == 0 {
        return mid
      }
      high = mid - 1
        print("high: \(high)")
        if high == 0 {
            return high
        }
    }
  }

  // If no 1 is found, return the number of columns (all elements are 0)
  return row.count
}

let input: [[Int]] = [
    [0, 0, 0, 1],
    [0, 1, 1, 1],
    [1, 1, 1, 1],
    [0, 0, 0, 0]
]

findRowWithMaxOnes(input)
//findFirstOne(in:  [1, 1, 1, 1])
