/*
 https://leetcode.com/problems/word-search-ii/description/
 Given an m x n board of characters and a list of strings words, return all words on the board.

 Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

  

 Example 1:


 Input: board = [["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], words = ["oath","pea","eat","rain"]
 Output: ["eat","oath"]
 */

/*
 To solve the problem of finding all words from a given list that can be constructed on an m x n board of characters, we'll use a combination of backtracking and Trie (prefix tree) data structure. The Trie will help us efficiently search for the words, while backtracking will allow us to explore all possible paths on the board.

 Here is the step-by-step algorithm:

 Algorithm
 Build a Trie:

 Insert all the words from the list into a Trie. This will help in efficiently checking if a sequence of characters forms a valid prefix or word.
 Backtracking on the Board:

 For each cell on the board, start a Depth-First Search (DFS) if the cell's character is a prefix in the Trie.
 During the DFS, mark the cell as visited and explore all four possible directions (up, down, left, right).
 If a word is found (i.e., it exists in the Trie), add it to the result list and remove it from the Trie to avoid duplicates.
 Unmark the cell after exploring to allow other paths to use it.
 Edge Cases:

 If the board or words list is empty, return an empty list.
 */
import Foundation

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord: Bool = false
}

class Trie {
    let root: TrieNode
    
    init() {
        root = TrieNode()
    }
    
    func insert(_ word: String) {
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.isEndOfWord = true
    }
    
    func searchPrefix(_ prefix: String) -> TrieNode? {
        var node = root
        for char in prefix {
            if let childNode = node.children[char] {
                node = childNode
            } else {
                return nil
            }
        }
        return node
    }
}

class Solution {
    var board: [[Character]] = []
    var result: Set<String> = []
    
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        self.board = board
        
        // Step 1: Build the Trie
        let trie = Trie()
        for word in words {
            trie.insert(word)
        }
        
        // Step 2: Backtracking to find all words
        for row in 0..<board.count {
            for col in 0..<board[0].count {
                if let _ = trie.root.children[board[row][col]] {
                    backtrack(row, col, trie.root, "")
                }
            }
        }
        
        return Array(result)
    }
    
    func backtrack(_ row: Int, _ col: Int, _ parent: TrieNode, _ path: String) {
        let letter = board[row][col]
        guard let currNode = parent.children[letter] else { return }
        
        // Check if we find a word
        var newPath = path + String(letter)
        if currNode.isEndOfWord {
            result.insert(newPath)
            currNode.isEndOfWord = false  // Avoid duplicate entries
        }
        
        // Mark the cell as visited
        board[row][col] = "#"
        
        // Explore the neighbors in 4 directions: up, down, left, right
        let directions: [(Int, Int)] = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (dx, dy) in directions {
            let newRow = row + dx
            let newCol = col + dy
            if newRow >= 0 && newRow < board.count && newCol >= 0 && newCol < board[0].count {
                if board[newRow][newCol] != "#" {
                    backtrack(newRow, newCol, currNode, newPath)
                }
            }
        }
        
        // Restore the cell
        board[row][col] = letter
    }
}

// Example usage
let board: [[Character]] = [
    ["o", "a", "a", "n"],
    ["e", "t", "a", "e"],
    ["i", "h", "k", "r"],
    ["i", "f", "l", "v"]
]
let words = ["oath", "pea", "eat", "rain"]
let solution = Solution()
print(solution.findWords(board, words))  // Output: ["oath", "eat"]

/*
 let's do a dry run for the word "oath" using the given board and the provided Swift implementation.

 Given Input
 Board:
 css
 Copy code
 [["o","a","a","n"],
  ["e","t","a","e"],
  ["i","h","k","r"],
  ["i","f","l","v"]]
 Words: ["oath","pea","eat","rain"]
 Steps
 Build the Trie:

 Insert "oath", "pea", "eat", "rain" into the Trie.
 The Trie structure after inserting "oath":

 root
  |
  o - TrieNode
    |
    a - TrieNode
      |
      t - TrieNode
        |
        h - TrieNode (isEndOfWord = true)
 
 Search on the Board:

 Initialize result as an empty set.
 Backtrack Search:

 Start iterating over the board:
 Row 0, Column 0 (cell contains 'o') is the starting point since 'o' is in the Trie's root children.
 Backtracking for "oath"
 Initial Call:

 backtrack(row: 0, col: 0, parent: root, path: "")
 Current cell: (0,0) -> 'o'
 path = "o"
 Mark as visited: board[0][0] = '#'
 Explore neighbors:
 Up (not valid)
 Down (1,0) -> 'e' (not in Trie children of 'o')
 Left (not valid)
 Right (0,1) -> 'a'
 Next Call:

 backtrack(row: 0, col: 1, parent: node_o, path: "o")
 Current cell: (0,1) -> 'a'
 path = "oa"
 Mark as visited: board[0][1] = '#'
 Explore neighbors:
 Up (not valid)
 Down (1,1) -> 't'
 Left (0,0) -> already visited
 Right (0,2) -> 'a' (not in Trie children of 'a')
 Next Call:

 backtrack(row: 1, col: 1, parent: node_oa, path: "oa")
 Current cell: (1,1) -> 't'
 path = "oat"
 Mark as visited: board[1][1] = '#'
 Explore neighbors:
 Up (0,1) -> already visited
 Down (2,1) -> 'h'
 Left (1,0) -> 'e' (not in Trie children of 't')
 Right (1,2) -> 'a' (not in Trie children of 't')
 Next Call:

 backtrack(row: 2, col: 1, parent: node_oat, path: "oat")
 Current cell: (2,1) -> 'h'
 path = "oath"
 Mark as visited: board[2][1] = '#'

 Word found: "oath"

 Add "oath" to the result set.
 Mark node h as not end of word to avoid duplicates.
 Explore neighbors:

 Up (1,1) -> already visited
 Down (3,1) -> 'f' (not in Trie children of 'h')
 Left (2,0) -> 'i' (not in Trie children of 'h')
 Right (2,2) -> 'k' (not in Trie children of 'h')
 Backtrack and Restore Cells:

 Restore cell (2,1) -> 'h'
 Restore cell (1,1) -> 't'
 Restore cell (0,1) -> 'a'
 Restore cell (0,0) -> 'o'
 Final State
 Result Set: ["oath"]
 */
