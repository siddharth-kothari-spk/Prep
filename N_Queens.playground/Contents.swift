/*
 https://leetcode.com/problems/n-queens/description/
 The n-queens puzzle is the problem of placing n queens on an n x n chessboard such that no two queens attack each other.

 Given an integer n, return all distinct solutions to the n-queens puzzle. You may return the answer in any order.

 Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space, respectively.

  

 Example 1:

 Input: n = 4
 Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
 Explanation: There exist two distinct solutions to the 4-queens puzzle as shown above
 Example 2:

 Input: n = 1
 Output: [["Q"]]
  

 Constraints:

 1 <= n <= 9
 */

class Solution {
    func solveNQueens(_ n: Int) -> [[String]] {
        var result = [[String]]()
        var board = Array(repeating: Array(repeating: ".", count: n), count: n)
        
        func isSafe(_ row: Int, _ col: Int) -> Bool {
            // Check the column
            for i in 0..<row {
                if board[i][col] == "Q" {
                    return false
                }
            }
            // Check the upper left diagonal
            var i = row, j = col
            while i >= 0 && j >= 0 {
                if board[i][j] == "Q" {
                    return false
                }
                i -= 1
                j -= 1
            }
            // Check the upper right diagonal
            i = row
            j = col
            while i >= 0 && j < n {
                if board[i][j] == "Q" {
                    return false
                }
                i -= 1
                j += 1
            }
            return true
        }
        
        func solve(_ row: Int) {
            if row == n {
                var solution = [String]()
                for i in 0..<n {
                    solution.append(board[i].joined())
                }
                result.append(solution)
                return
            }
            for col in 0..<n {
                if isSafe(row, col) {
                    board[row][col] = "Q"
                    solve(row + 1)
                    board[row][col] = "." // Backtrack
                }
            }
        }
        
        solve(0)
        return result
    }
}

// Example usage:
let solution = Solution()
let n = 8
let solutions = solution.solveNQueens(n)
for solution in solutions {
    for row in solution {
        print(row)
    }
    print("---------")
}
