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

// Alternative sol
// https://leetcode.com/problems/sudoku-solver/solutions/1351806/solution-swift-sudoku-solver/

class Solution {
    internal typealias Char = Character
    func solveSudoku(_ board: inout [[Char]]) -> Bool {
        guard board.count != 0 || board[0].count != 0 else { return false }
        return helper(&board)
    }
    
    private func helper(_ board: inout [[Char]]) -> Bool {
        for r in 0..<board.count {
            for c in 0..<board[0].count where board[r][c] == "." {
                for n in 1...9 where isValid(board, Char("\(n)"), r, c) {
                    board[r][c] = Char("\(n)")
                    if helper(&board) {
                        return true
                    } else {
                        board[r][c] = "."
                    }
                }
                return false
            }
        }
        return true
    }
    
    // Special thanks to @punk9595 for the optimization suggestion
    private func isValid(_ board: [[Char]], _ ch: Char, _ r: Int,  _ c: Int) -> Bool {
        for i in 0...8 {
            if board[r][i] == ch || board[i][c] == ch { return false }
            if board[(r / 3) * 3 + i / 3][(c / 3) * 3 + i % 3] == ch { return false }
        }
        return true
    }
}

let sol = Solution()
print(sol.solveSudoku(&sudokuBoard))
