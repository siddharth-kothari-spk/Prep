/*
 https://leetcode.com/problems/rotate-image/description/
 You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

 You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

 Example 1:
 Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
 Output: [[7,4,1],[8,5,2],[9,6,3]]
 
 Example 2:
 Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
 Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
  
 Constraints:

 n == matrix.length == matrix[i].length
 1 <= n <= 20
 -1000 <= matrix[i][j] <= 1000
 */

/*
 To rotate an n×n 2D matrix representing an image by 90 degrees clockwise in-place, we can follow a two-step process:

 Transpose the matrix: Swap elements such that rows become columns.
 Reverse each row: Reverse the elements in each row to complete the 90-degree rotation.
 
 Here is the algorithm broken down:

 Step 1: Transpose the Matrix
 For each element at position
 (i,j) in the matrix, swap it with the element at position (j,i).

 Step 2: Reverse Each Row
 For each row in the matrix, reverse the elements in that row.

 Detailed Algorithm
 Transpose the matrix:

 Iterate through each element in the matrix. For elements above the diagonal (where
 i<j), swap matrix[i][j] with matrix[j][i].
 
 Reverse each row:
 Iterate through each row and reverse the elements in that row.
 */

func rotate(_ matrix: inout [[Int]]) {
    let n = matrix.count
    
    // Transpose the matrix
    for i in 0..<n {
        for j in i+1..<n {
            let temp = matrix[i][j]
            matrix[i][j] = matrix[j][i]
            matrix[j][i] = temp
        }
    }
    
    // Reverse each row
    for i in 0..<n {
        matrix[i].reverse()
    }
}

// Example usage:
var matrix1 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
rotate(&matrix1)
print(matrix1)  // Output: [[7, 4, 1], [8, 5, 2], [9, 6, 3]]

var matrix2 = [
    [5, 1, 9, 11],
    [2, 4, 8, 10],
    [13, 3, 6, 7],
    [15, 14, 12, 16]
]
rotate(&matrix2)
print(matrix2)  // Output: [[15, 13, 2, 5], [14, 3, 4, 1], [12, 6, 8, 9], [16, 7, 10, 11]]

/*
 Example
 For the matrix:
 [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
 ]
 
 Transpose:
 [
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9]
 ]
 
 Reverse each row:
 [
  [7, 4, 1],
  [8, 5, 2],
  [9, 6, 3]
 ]
 */
