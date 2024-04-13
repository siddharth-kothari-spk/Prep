/*
 Determine if a 9x9 Sudoku board is valid.
 - Sample Input:
 ```
 Sudoku Board:
 [
 [5,3,.,.,7,.,.,.,.],
 [6,.,.,1,9,5,.,.,.],
 [.,9,8,.,.,.,.,6,.],
 [8,.,.,.,6,.,.,.,3],
 [4,.,.,8,.,3,.,.,1],
 [7,.,.,.,2,.,.,.,6],
 [.,6,.,.,.,.,2,8,.],
 [.,.,.,4,1,9,.,.,5],
 [.,.,.,.,8,.,.,7,9]
 ]
 ```
 - Expected Output:
 ```
 Valid Sudoku: true
 */


func isValidSudoku2(_ board: [[Character]]) -> Bool {
    var rows = Array(repeating: Set<Character>(), count: 9)
    var columns = Array(repeating: Set<Character>(), count: 9)
    var subgrids = Array(repeating: Set<Character>(), count: 9)
    
    for i in 0..<9 {
        for j in 0..<9 {
            let char = board[i][j]
            if char == "." {
                continue
            }
            // Check row
            if rows[i].contains(char) {
                print(" \(char) present in row \(i), \(rows[i])")
                return false
            }
            rows[i].insert(char)
            
            // Check column
            if columns[j].contains(char) {
                print(" \(char) present in column \(j), \(columns[j])")
                return false
            }
            columns[j].insert(char)
            
            // Check subgrid
            let subgridIndex = (i / 3) * 3 + j / 3
            if subgrids[subgridIndex].contains(char) {
                print(" \(char) present in subgrid \(subgridIndex), \(subgrids[subgridIndex])")
                return false
            }
            subgrids[subgridIndex].insert(char)
        }
    }
    return true
}

// Test case
var sudokuBoard: [[Character]] = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","1"]
]

print("Valid Sudoku:", isValidSudoku2(sudokuBoard))

sudokuBoard = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]
print("Valid Sudoku:", isValidSudoku2(sudokuBoard))
