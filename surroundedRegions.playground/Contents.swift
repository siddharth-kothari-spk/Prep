/*
 Given an m x n matrix board containing 'X' and 'O', capture all regions that are 4-directionally surrounded by 'X'.

 A region is captured by flipping all 'O's into 'X's in that surrounded region.

  

 Example 1:


 Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
 
 ["X","X","X","X"]
 ["X","O","O","X"]
 ["X","X","O","X"]
 ["X","O","X","X"]
 
 Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
 
 ["X","X","X","X"]
 ["X","X","X","X"]
 ["X","X","X","X"]
 ["X","O","X","X"]
 
 Explanation: Notice that an 'O' should not be flipped if:
 - It is on the border, or
 - It is adjacent to an 'O' that should not be flipped.
 The bottom 'O' is on the border, so it is not flipped.
 The other three 'O' form a surrounded region, so they are flipped.
 */


func surroundedRegions(_ board: inout [[Character]]) {
    guard !board.isEmpty else {
        return
    }
    
    let m = board.count
    let n = board[0].count
    
    // Function to perform DFS
    func dfs(_ i: Int, _ j: Int) {
        if i < 0 || i >= m || j < 0 || j >= n || board[i][j] != "O" {
            return
        }
        board[i][j] = "S" // Mark as safe
        // Check neighbors
        dfs(i + 1, j)
        dfs(i - 1, j)
        dfs(i, j + 1)
        dfs(i, j - 1)
    }
    
    // Step 1: DFS from border cells
    for i in 0..<m {
        dfs(i, 0)
        dfs(i, n - 1)
    }
    
    for j in 0..<n {
        dfs(0, j)
        dfs(m - 1, j)
    }
    
    // Step 2: Flip surrounded 'O' cells to 'X'
    for i in 0..<m {
        for j in 0..<n {
            if board[i][j] == "O" {
                board[i][j] = "X"
            }
        }
    }
    
    // Step 3: Restore safe cells
    for i in 0..<m {
        for j in 0..<n {
            if board[i][j] == "S" {
                board[i][j] = "O"
            }
        }
    }
}

// Example usage:
var board: [[Character]] = [
    ["X","X","X","X"],
    ["X","O","O","X"],
    ["X","X","O","O"],
    ["X","O","X","X"]
]

surroundedRegions(&board)
for row in board {
    print(row)
}
