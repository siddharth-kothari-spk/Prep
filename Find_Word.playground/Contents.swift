/*
 Given a 2D board and a word, determine if the word exists in the board.
 - Sample Input:```
 Board:
 [
 ["A","B","C","E"],
 ["S","F","C","S"],
 ["A","D","E","E"]
 ]
 Word: "ABCCED"
 ```
 - Expected Output:
 ```
 Word Exists: true
 */

func exist(_ board: [[Character]], _ str: String) -> Bool {
    var board =  board
    let rows = board.count
    let cols = board[0].count
    let word: [Character] = Array(str)
    
    func dfs(_ i: Int, _ j: Int, _ index: Int) -> Bool {
        if index == word.count {
            return true // Entire word is found
        }
        
        if i < 0 || i >= rows || j < 0 || j >= cols || board[i][j] != word[index] {
            return false // Out of bounds or letter doesn't match
        }
        
        let temp = board[i][j]
        board[i][j] = "#" // Mark as visited
        
        // Explore neighbors
        if dfs(i+1, j, index+1) || dfs(i-1, j, index+1) || dfs(i, j+1, index+1) || dfs(i, j-1, index+1) {
            return true
        }
        
        board[i][j] = temp // Backtrack
        return false
    }
    
    for i in 0..<rows {
        for j in 0..<cols {
            if dfs(i, j, 0) {
                return true
            }
        }
    }
    
    return false
}

// Example usage
let board: [[Character]] = [
    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"]
]
let word = "ABCCED"
print("Word Exists: \(exist(board, word))")

