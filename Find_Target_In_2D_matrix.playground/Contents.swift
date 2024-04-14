/*
 search for a target value in a 2D matrix with properties that each row is sorted in ascending order and the first element in each row is greater than the last element in the previous row
 
 Matrix:
 [
 [1, 4, 7, 11],
 [2, 5, 8, 12],
 [3, 6, 9, 16],
 [10, 13, 14, 17]
 ]
 Target: 5
 ```
 - Expected Output:
 ```
 Found: true
 */

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
  var row = 0
  var col = matrix[0].count - 1 // Start from top right corner

  while row < matrix.count && col >= 0 {
      print("row: \(row), col: \(col), val= \(matrix[row][col])")
    if matrix[row][col] == target {
      return true
    } else if matrix[row][col] < target {
      row += 1 // Move down (target might be in a lower row)
    } else {
      col -= 1 // Move left (target might be in a previous column)
    }
  }
  
  return false // Target not found
}

searchMatrix([
    [1, 4, 7, 11],
    [2, 5, 8, 12],
    [3, 6, 9, 16],
    [10, 13, 14, 17]
    ], 5)
