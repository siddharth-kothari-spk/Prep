/*
 Rotate a given NxN matrix by 90 degrees in place.
 - Sample Input:
 ```
 Matrix:
 [
 [1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]
 ]```
 - Expected Output:
 ```
 Rotated Matrix:
 [
 [7, 4, 1],
 [8, 5, 2],
 [9, 6, 3]
 ]
 ```
 */


func rotateMatrix(_ matrix: inout [[Int]]) {
    let n = matrix.count
    // Transpose the matrix
    for i in 0..<n {
        for j in i..<n {
            let temp = matrix[i][j]
            matrix[i][j] = matrix[j][i]
            matrix[j][i] = temp
            
         //   swap(&matrix[i][j], &matrix[j][i]) 
            // error: Overlapping accesses to 'matrix', but modification requires exclusive access; consider copying to a local variable
        }
    }
    print("transpose:")
    for row in matrix {
        print(row)
    }
    // Reverse each row
    for i in 0..<n {
        matrix[i].reverse()
    }
}

// Sample Input
var matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

// Rotate the matrix
rotateMatrix(&matrix)

// Print the rotated matrix
print("Rotated Matrix:")
for row in matrix {
    print(row)
}
