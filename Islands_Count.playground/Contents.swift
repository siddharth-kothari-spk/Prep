/*
 Given a 2D matrix representing land and water, count the number of islands (connected
 1s).
 - Sample Input:```
 Matrix:
 [
 [1,1,0,0,0],
 [1,1,0,0,0],
 [0,0,1,0,0],
 [0,0,0,1,1]
 ]
 ```
 - Expected Output:
 ```
 Number of Islands: 3
 */

import Foundation

func islands(_ grid: [[Int]]) -> Int {
  var rows = grid.count
  var cols = grid[0].count
  var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
  
  func dfs(_ row: Int, _ col: Int) {
    guard row >= 0 && row < rows && col >= 0 && col < cols && !visited[row][col] && grid[row][col] == 1 else { return }
    visited[row][col] = true
    
    dfs(row - 1, col) // Up
    dfs(row + 1, col) // Down
    dfs(row, col - 1) // Left
    dfs(row, col + 1) // Right
  }
  
  var islandCount = 0
  for row in 0..<rows {
    for col in 0..<cols {
      if !visited[row][col] && grid[row][col] == 1 {
        islandCount += 1
        dfs(row, col)
      }
    }
  }
  
  return islandCount
}

print(islands([
    [1,1,0,0,0],
    [1,1,0,0,0],
    [0,0,1,0,0],
    [0,0,0,1,1]
    ]))
