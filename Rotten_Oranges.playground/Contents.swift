/*
 https://www.geeksforgeeks.org/minimum-time-required-so-that-all-oranges-become-rotten/
 
 Here's an algorithm to find the minimum time required for all oranges to become rotten in a matrix:

 **Algorithm:**

 1. **Data Structures:**
    - Initialize a queue to store rotten oranges.
    - Use a matrix to represent the grid of oranges.

 2. **Traverse the Matrix:**
    - Iterate through the matrix and identify:
       - Rotten oranges: Add their indexes to the queue.
       - Fresh oranges: Count the total number of fresh oranges.

 3. **Handle Edge Cases:**
    - If there are no fresh oranges (`fresh_oranges == 0`), return 0 as no rotting is required.

 4. **Breadth-First Search (BFS):**
    - While the queue is not empty:
       - Process all rotten oranges in the current level:
          - Dequeue an orange from the queue and get its neighboring positions (up, down, left, right).
          - For each neighbor:
             - If the neighbor is within the matrix bounds and is fresh, mark it as rotten:
                - Update the matrix value at the neighbor's index to 2.
                - Decrement the fresh orange count.
                - Add the neighbor's index to the queue.
       - Increment the time counter as one level of rotting is complete.

 5. **Return Result:**
    - If there are still fresh oranges after BFS traversal (`fresh_oranges > 0`), return -1 as it's impossible to rot all oranges.
    - Otherwise, return the time counter, which represents the minimum time required for all oranges to become rotten.

 **Explanation:**

 This algorithm leverages Breadth-First Search (BFS) to explore rotten oranges and their fresh neighbors layer by layer. By keeping track of fresh oranges and processing them level-by-level, we ensure that the rotting process happens in the minimum time possible. The queue ensures that all rotten oranges at a particular level are processed before moving to the next level.

 **Time Complexity:**

 O(M * N) in the worst case, where M and N are the dimensions of the matrix. This is because we traverse the entire matrix once to identify rotten oranges and potentially all the fresh oranges in the worst case.

 **Space Complexity:**

 O(M * N) due to the queue that can hold up to all oranges in the matrix in the worst case.
 */

func minTimeToRot(_ grid: inout [[Int]]) -> Int {
  let rows = grid.count
  let cols = grid[0].count
  
  var queue = [[Int]]()
  var freshOranges = 0
  
  // 1. Traverse the matrix and identify rotten oranges & fresh orange count
  for i in 0..<rows {
    for j in 0..<cols {
      if grid[i][j] == 2 {
        queue.append([i, j])
      } else if grid[i][j] == 1 {
        freshOranges += 1
      }
    }
  }
  
  // 2. Handle edge case: No fresh oranges
  if freshOranges == 0 {
    return 0
  }
  
  var time = -1
  let directions = [[-1, 0], [1, 0], [0, -1], [0, 1]] // Up, down, left, right
  
  // 3. BFS to rot oranges
  while !queue.isEmpty {
    time += 1
    let levelSize = queue.count
    for _ in 0..<levelSize {
      let rottenOrange = queue.removeFirst()
      let x = rottenOrange[0]
      let y = rottenOrange[1]
      
      for dir in directions {
        let newX = x + dir[0]
        let newY = y + dir[1]
        
        // Check if neighbor is within bounds, fresh, and not processed yet
        if newX >= 0 && newX < rows && newY >= 0 && newY < cols && grid[newX][newY] == 1 {
          grid[newX][newY] = 2
          freshOranges -= 1
          queue.append([newX, newY])
        }
      }
    }
  }
  
  // 4. Return result
  return freshOranges > 0 ? -1 : time
}

var arr = [[2, 1, 0, 2, 1], [1, 0, 1, 2, 1], [1, 0, 0, 2, 1]]
minTimeToRot(&arr)

/*
 Output: 2
 Explanation: At 0th time frame:
 {2, 1, 0, 2, 1}
 {1, 0, 1, 2, 1}
 {1, 0, 0, 2, 1}
 At 1st time frame:
 {2, 2, 0, 2, 2}
 {2, 0, 2, 2, 2}
 {1, 0, 0, 2, 2}
 At 2nd time frame:
 {2, 2, 0, 2, 2}
 {2, 0, 2, 2, 2}
 {2, 0, 0, 2, 2}
 */
