/*
 https://leetcode.com/problems/spiral-matrix/description/
 Given an m x n matrix, return all elements of the matrix in spiral order.

 Example 1:
 Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
 Output: [1,2,3,6,9,8,7,4,5]
 
 Example 2:
 Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
 Output: [1,2,3,4,8,12,11,10,9,5,6,7]
  

 Constraints:

 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 10
 -100 <= matrix[i][j] <= 100
 */

/*
 we can follow an algorithm that continuously moves in a spiral pattern and collects the elements in that order. The basic steps are:

 1.Initialize boundaries for the matrix: top, bottom, left, and right.
 2.Traverse the matrix in the order of right, down, left, and up, updating the boundaries after each direction is completely traversed.
 3.Continue this process until all elements are traversed.
 
 Here's the step-by-step algorithm and its implementation in Python:

 Step-by-Step Algorithm
 
 1.Initialize Boundaries:

     top = 0
     bottom = m - 1
     left = 0
     right = n - 1
 
 2. Spiral Traversal:

     While top <= bottom and left <= right:
          Traverse from left to right along the top row, then increment top.
          Traverse from top to bottom along the right column, then decrement right.
          If top <= bottom, traverse from right to left along the bottom row, then decrement bottom.
          If left <= right, traverse from bottom to top along the left column, then increment left.
 
 3. Collect the Elements:

     During each traversal, collect the elements in a list.
 */

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var result = [Int]()
    
    if matrix.isEmpty || matrix[0].isEmpty {
        return result
    }
    
    var top = 0
    var bottom = matrix.count - 1
    var left = 0
    var right = matrix[0].count - 1
    
    while top <= bottom && left <= right {
        // Traverse from left to right along the top row
        for col in stride(from: left, through: right, by: 1) {
            result.append(matrix[top][col])
        }
        top += 1
        
        // Traverse from top to bottom along the right column
        for row in stride(from: top, through: bottom, by: 1) {
            result.append(matrix[row][right])
        }
        right -= 1
        
        if top <= bottom {
            // Traverse from right to left along the bottom row
            for col in stride(from: right, through: left, by: -1) {
                result.append(matrix[bottom][col])
            }
            bottom -= 1
        }
        
        if left <= right {
            // Traverse from bottom to top along the left column
            for row in stride(from: bottom, through: top, by: -1) {
                result.append(matrix[row][left])
            }
            left += 1
        }
    }
    
    return result
}

let matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

let result = spiralOrder(matrix)
print(result)  // Output: [1, 2, 3, 6, 9, 8, 7, 4, 5]

/*
 Sure, let's do a dry run of the Swift implementation with the provided matrix:

 ```swift
 let matrix = [
     [1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]
 ]

 let result = spiralOrder(matrix)
 print(result)  // Output: [1, 2, 3, 6, 9, 8, 7, 4, 5]
 ```

 ### Dry Run

 #### Initial State:
 - `matrix`: `[[1, 2, 3], [4, 5, 6], [7, 8, 9]]`
 - `result`: `[]`
 - `top`: `0`
 - `bottom`: `2`
 - `left`: `0`
 - `right`: `2`

 #### First Iteration:
 1. Traverse from left to right along the top row:
    - `result`: `[1, 2, 3]`
    - Increment `top`: `top = 1`
 2. Traverse from top to bottom along the right column:
    - `result`: `[1, 2, 3, 6, 9]`
    - Decrement `right`: `right = 1`
 3. Traverse from right to left along the bottom row:
    - `result`: `[1, 2, 3, 6, 9, 8, 7]`
    - Decrement `bottom`: `bottom = 1`
 4. Traverse from bottom to top along the left column:
    - `result`: `[1, 2, 3, 6, 9, 8, 7, 4]`
    - Increment `left`: `left = 1`

 #### Second Iteration:
 1. Traverse from left to right along the top row:
    - `result`: `[1, 2, 3, 6, 9, 8, 7, 4, 5]`
    - Increment `top`: `top = 2`

 At this point, `top (2) > bottom (1)` and `left (1) > right (1)`, so the while loop condition `top <= bottom && left <= right` is false, and the loop terminates.

 ### Final State:
 - `result`: `[1, 2, 3, 6, 9, 8, 7, 4, 5]`

 The final result is `[1, 2, 3, 6, 9, 8, 7, 4, 5]`, which is the matrix elements in spiral order.
 */
