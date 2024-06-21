/*
 https://leetcode.com/problems/set-matrix-zeroes/description/
 Given an m x n integer matrix matrix, if an element is 0, set its entire row and column to 0's.

 You must do it in place.

  

 Example 1:


 Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
 Output: [[1,0,1],[0,0,0],[1,0,1]]
 Example 2:


 Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
 Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
  

 Constraints:

 m == matrix.length
 n == matrix[0].length
 1 <= m, n <= 200
 -2^31 <= matrix[i][j] <= 2^31 - 1
  

 Follow up:

 A straightforward solution using O(mn) space is probably a bad idea.
 A simple improvement uses O(m + n) space, but still not the best solution.
 Could you devise a constant space solution?
 */

/*
 Algorithm
 
 Initial Check: If the matrix is empty, return immediately.
 
 1.Determine Zero Rows and Columns:
  Use the first row and first column to mark the rows and columns that need to be zeroed.
  Use two boolean variables to keep track of whether the first row and the first column need to be zeroed initially.
 
 2.Mark Zero Rows and Columns:
  Iterate through the matrix starting from the second row and second column.
  If an element is 0, set the corresponding element in the first row and first column to 0.
 
 3.Zero Marked Rows and Columns:
  Iterate through the matrix again starting from the second row and second column.
  If the corresponding element in the first row or first column is 0, set the current element to 0.
 
 4.Zero the First Row and First Column if Needed:
  If the initial boolean variables indicate that the first row or first column needs to be zeroed, zero them.
 */

func setZeroes(_ matrix: inout [[Int]]) {
    let m = matrix.count
    let n = matrix[0].count

    var firstRowHasZero = false
    var firstColumnHasZero = false

    // Check if the first row has any zeroes
    for j in 0..<n {
        if matrix[0][j] == 0 {
            firstRowHasZero = true
            break
        }
    }

    // Check if the first column has any zeroes
    for i in 0..<m {
        if matrix[i][0] == 0 {
            firstColumnHasZero = true
            break
        }
    }

    // Use the first row and first column to mark zero rows and columns
    for i in 1..<m {
        for j in 1..<n {
            if matrix[i][j] == 0 {
                matrix[i][0] = 0
                matrix[0][j] = 0
            }
        }
    }

    // Zero out cells based on marks in the first row and first column
    for i in 1..<m {
        for j in 1..<n {
            if matrix[i][0] == 0 || matrix[0][j] == 0 {
                matrix[i][j] = 0
            }
        }
    }

    // Zero out the first row if needed
    if firstRowHasZero {
        for j in 0..<n {
            matrix[0][j] = 0
        }
    }

    // Zero out the first column if needed
    if firstColumnHasZero {
        for i in 0..<m {
            matrix[i][0] = 0
        }
    }
}

// Example usage:
var matrix1 = [[1,1,1],[1,0,1],[1,1,1]]
setZeroes(&matrix1)
print(matrix1) // Output: [[1,0,1],[0,0,0],[1,0,1]]

var matrix2 = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
setZeroes(&matrix2)
print(matrix2) // Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]

/*
 Sure, let's go through a dry run of the algorithm for the input matrix \([[0, 1, 2, 0], [3, 4, 5, 2], [1, 3, 1, 5]]\).

 ### Initial Matrix
 ```
 [0, 1, 2, 0]
 [3, 4, 5, 2]
 [1, 3, 1, 5]
 ```

 ### Step 1: Check if the first row and first column have any zeroes
 - `firstRowHasZero`: True (since matrix[0][0] and matrix[0][3] are 0)
 - `firstColumnHasZero`: True (since matrix[0][0] is 0)

 ### Step 2: Use the first row and first column to mark zero rows and columns
 - Iterate through the matrix starting from the second row and second column.

 **Iteration 1 (i=1, j=1):**
 - matrix[1][1] = 4 (not 0)
   
 **Iteration 2 (i=1, j=2):**
 - matrix[1][2] = 5 (not 0)

 **Iteration 3 (i=1, j=3):**
 - matrix[1][3] = 2 (not 0)

 **Iteration 4 (i=2, j=1):**
 - matrix[2][1] = 3 (not 0)

 **Iteration 5 (i=2, j=2):**
 - matrix[2][2] = 1 (not 0)

 **Iteration 6 (i=2, j=3):**
 - matrix[2][3] = 5 (not 0)

 - After this step, the matrix remains the same because no new zeroes were found:

 ```
 [0, 1, 2, 0]
 [3, 4, 5, 2]
 [1, 3, 1, 5]
 ```

 ### Step 3: Zero out cells based on marks in the first row and first column
 - Iterate through the matrix starting from the second row and second column.

 **Iteration 1 (i=1, j=1):**
 - matrix[1][0] = 3 (not 0), matrix[0][1] = 1 (not 0)
   
 **Iteration 2 (i=1, j=2):**
 - matrix[1][0] = 3 (not 0), matrix[0][2] = 2 (not 0)

 **Iteration 3 (i=1, j=3):**
 - matrix[1][0] = 3 (not 0), matrix[0][3] = 0 (set matrix[1][3] to 0)

 **Iteration 4 (i=2, j=1):**
 - matrix[2][0] = 1 (not 0), matrix[0][1] = 1 (not 0)

 **Iteration 5 (i=2, j=2):**
 - matrix[2][0] = 1 (not 0), matrix[0][2] = 2 (not 0)

 **Iteration 6 (i=2, j=3):**
 - matrix[2][0] = 1 (not 0), matrix[0][3] = 0 (set matrix[2][3] to 0)

 - After this step, the matrix is updated to:

 ```
 [0, 1, 2, 0]
 [3, 4, 5, 0]
 [1, 3, 1, 0]
 ```

 ### Step 4: Zero out the first row and first column if needed
 - Since `firstRowHasZero` is True, zero out the first row:

 ```
 [0, 0, 0, 0]
 [3, 4, 5, 0]
 [1, 3, 1, 0]
 ```

 - Since `firstColumnHasZero` is True, zero out the first column:

 ```
 [0, 0, 0, 0]
 [0, 4, 5, 0]
 [0, 3, 1, 0]
 ```

 ### Final Matrix
 ```
 [0, 0, 0, 0]
 [0, 4, 5, 0]
 [0, 3, 1, 0]
 ```

 This is the final result after running the algorithm.
 */


/*
 Sure, let's go through a dry run of the algorithm for the input matrix \([[1, 1, 1], [1, 0, 1], [1, 1, 1]]\).

 ### Initial Matrix
 ```
 [1, 1, 1]
 [1, 0, 1]
 [1, 1, 1]
 ```

 ### Step 1: Check if the first row and first column have any zeroes
 - `firstRowHasZero`: False (no zeroes in the first row)
 - `firstColumnHasZero`: False (no zeroes in the first column)

 ### Step 2: Use the first row and first column to mark zero rows and columns
 - Iterate through the matrix starting from the second row and second column.

 **Iteration 1 (i=1, j=1):**
 - matrix[1][1] = 0 (set matrix[1][0] to 0 and matrix[0][1] to 0)

 **Iteration 2 (i=1, j=2):**
 - matrix[1][2] = 1 (not 0)

 **Iteration 3 (i=2, j=1):**
 - matrix[2][1] = 1 (not 0)

 **Iteration 4 (i=2, j=2):**
 - matrix[2][2] = 1 (not 0)

 - After this step, the matrix is updated to:

 ```
 [1, 0, 1]
 [0, 0, 1]
 [1, 1, 1]
 ```

 ### Step 3: Zero out cells based on marks in the first row and first column
 - Iterate through the matrix starting from the second row and second column.

 **Iteration 1 (i=1, j=1):**
 - matrix[1][0] = 0 or matrix[0][1] = 0 (set matrix[1][1] to 0)

 **Iteration 2 (i=1, j=2):**
 - matrix[1][0] = 0 or matrix[0][2] = 1 (set matrix[1][2] to 0)

 **Iteration 3 (i=2, j=1):**
 - matrix[2][0] = 1 or matrix[0][1] = 0 (set matrix[2][1] to 0)

 **Iteration 4 (i=2, j=2):**
 - matrix[2][0] = 1 or matrix[0][2] = 1 (not 0)

 - After this step, the matrix is updated to:

 ```
 [1, 0, 1]
 [0, 0, 0]
 [1, 0, 1]
 ```

 ### Step 4: Zero out the first row and first column if needed
 - Since `firstRowHasZero` is False, the first row remains the same.
 - Since `firstColumnHasZero` is False, the first column remains the same.

 ### Final Matrix
 ```
 [1, 0, 1]
 [0, 0, 0]
 [1, 0, 1]
 ```

 This is the final result after running the algorithm.
 */
