/*
 https://leetcode.com/problems/word-search/description/
 Given an m x n grid of characters board and a string word, return true if word exists in the grid.

 The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

  

 Example 1:


 Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
 Output: true
 Example 2:


 Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
 Output: true
 Example 3:


 Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
 Output: false
  

 Constraints:

 m == board.length
 n = board[i].length
 1 <= m, n <= 6
 1 <= word.length <= 15
 board and word consists of only lowercase and uppercase English letters.
  

 Follow up: Could you use search pruning to make your solution faster with a larger board?
 */

/*
 you can use a Depth-First Search (DFS) approach. Here is an algorithm to achieve that:

 Traverse each cell in the grid.
 From each cell, initiate a DFS to find the word.
 During DFS, mark the current cell as visited and check the four possible directions (up, down, left, right).
 If the next character in the word matches the character in the grid, continue the DFS.
 If the entire word is found, return true.
 If no path is found for the word, backtrack and unmark the cell as visited.
 If all cells have been checked and no path is found, return false.
 */

class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count
        let n = board[0].count
        var board = board // Make a mutable copy of the board
        let wordArray = Array(word)
        
        func dfs(_ i: Int, _ j: Int, _ k: Int) -> Bool {
            if board[i][j] != wordArray[k] {
                return false
            }
            if k == wordArray.count - 1 {
                return true
            }
            
            // Temporarily mark the cell as visited
            let temp = board[i][j]
            board[i][j] = "#"
            
            // Explore the four possible directions
            let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
            for direction in directions {
                let newI = i + direction.0
                let newJ = j + direction.1
                if newI >= 0 && newI < m && newJ >= 0 && newJ < n && board[newI][newJ] != "#" {
                    if dfs(newI, newJ, k + 1) {
                        return true
                    }
                }
            }
            
            // Restore the original value of the cell
            board[i][j] = temp
            
            return false
        }
        
        for i in 0..<m {
            for j in 0..<n {
                if dfs(i, j, 0) {
                    return true
                }
            }
        }
        
        return false
    }
}

// Example usage
let solution = Solution()
let board1: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
let word1 = "ABCCED"
print(solution.exist(board1, word1))  // Output: true

let board2: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
let word2 = "SEE"
print(solution.exist(board2, word2))  // Output: true

let board3: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
let word3 = "ABCB"
print(solution.exist(board3, word3))  // Output: false

/*
 Input
 board1:
 css
 Copy code
 [["A","B","C","E"],
  ["S","F","C","S"],
  ["A","D","E","E"]]
 word1: "ABCCED"
 Dry Run
 Initialization:

 m = 3 (number of rows)
 n = 4 (number of columns)
 wordArray = ["A", "B", "C", "C", "E", "D"] (characters in the word)
 Start DFS from cell (0,0):

 i = 0, j = 0, k = 0
 board[0][0] = "A" matches wordArray[0] = "A"
 Temporarily mark cell (0,0) as visited: boardCopy[0][0] = "#"
 Explore neighbors of (0,0):

 Directions: [(-1, 0), (1, 0), (0, -1), (0, 1)]
 Move to (1,0):
 i = 1, j = 0, k = 1
 board[1][0] = "S" does not match wordArray[1] = "B", backtrack.
 Move to (0,1):
 i = 0, j = 1, k = 1
 board[0][1] = "B" matches wordArray[1] = "B"
 Temporarily mark cell (0,1) as visited: boardCopy[0][1] = "#"
 Explore neighbors of (0,1):

 Directions: [(-1, 0), (1, 0), (0, -1), (0, 1)]
 Move to (1,1):
 i = 1, j = 1, k = 2
 board[1][1] = "F" does not match wordArray[2] = "C", backtrack.
 Move to (0,2):
 i = 0, j = 2, k = 2
 board[0][2] = "C" matches wordArray[2] = "C"
 Temporarily mark cell (0,2) as visited: boardCopy[0][2] = "#"
 Explore neighbors of (0,2):

 Directions: [(-1, 0), (1, 0), (0, -1), (0, 1)]
 Move to (1,2):
 i = 1, j = 2, k = 3
 board[1][2] = "C" matches wordArray[3] = "C"
 Temporarily mark cell (1,2) as visited: boardCopy[1][2] = "#"
 Explore neighbors of (1,2):

 Directions: [(-1, 0), (1, 0), (0, -1), (0, 1)]
 Move to (2,2):
 i = 2, j = 2, k = 4
 board[2][2] = "E" matches wordArray[4] = "E"
 Temporarily mark cell (2,2) as visited: boardCopy[2][2] = "#"
 Explore neighbors of (2,2):

 Directions: [(-1, 0), (1, 0), (0, -1), (0, 1)]
 Move to (2,1):
 i = 2, j = 1, k = 5
 board[2][1] = "D" matches wordArray[5] = "D"
 Temporarily mark cell (2,1) as visited: boardCopy[2][1] = "#"
 End of word:

 The last character of the word is found, return true.
 Summary
 The word "ABCCED" is found in the board by following the path:
 (0,0) -> (0,1) -> (0,2) -> (1,2) -> (2,2) -> (2,1)
 The algorithm returns true.
 */
