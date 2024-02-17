/*
 The demons had captured the princess and imprisoned her in the bottom-right corner of a dungeon. The dungeon consists of m x n rooms laid out in a 2D grid. Our valiant knight was initially positioned in the top-left room and must fight his way through dungeon to rescue the princess.

 The knight has an initial health point represented by a positive integer. If at any point his health point drops to 0 or below, he dies immediately.

 Some of the rooms are guarded by demons (represented by negative integers), so the knight loses health upon entering these rooms; other rooms are either empty (represented as 0) or contain magic orbs that increase the knight's health (represented by positive integers).

 To reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.

 Return the knight's minimum initial health so that he can rescue the princess.

 Note that any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.

  

 Example 1:


 Input: dungeon = [[-2,-3,3],[-5,-10,1],[10,30,-5]]
 Output: 7
 Explanation: The initial health of the knight must be at least 7 if he follows the optimal path: RIGHT-> RIGHT -> DOWN -> DOWN.
 Example 2:

 Input: dungeon = [[0]]
 Output: 1
  

 Constraints:

 m == dungeon.length
 n == dungeon[i].length
 1 <= m, n <= 200
 -1000 <= dungeon[i][j] <= 1000
 */

// Sol: https://leetcode.com/problems/dungeon-game/solutions/3770890/swift-space-efficient-solution

class Solution {
    func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        let rows = dungeon.count
        let columns = dungeon[0].count
        var dp = Array(repeating: 0, count: columns)
        print(dp)
        dp[columns-1] = min(0, dungeon[rows-1][columns-1])
        
        print(dp)

        for i in (0..<columns-1).reversed() {
            print("dp[i+1] + dungeon[rows-1][i] = \(dp[i+1] + dungeon[rows-1][i])")
            dp[i] = min(0, dp[i+1] + dungeon[rows-1][i])
        }
        
        for i in (0..<rows-1).reversed() {
            print("i = \(i)")
            print("dp[columns-1] + dungeon[i][columns-1] = \(dp[columns-1] + dungeon[i][columns-1])")
            dp[columns-1] = min(0, dp[columns-1] + dungeon[i][columns-1])
            
            for j in (0..<columns-1).reversed() {
                print("j = \(j)")
                print("dp[j], dp[j+1]) + dungeon[i][j] = \(dp[j+1] + dungeon[i][j])")
                dp[j] = min(0, max(dp[j], dp[j+1]) + dungeon[i][j])
            }
        }
        return -dp[0] + 1
    }
}

let sol = Solution()
print(sol.calculateMinimumHP([[-2,-3,3],[-5,-10,1],[10,30,-5]]))

/*
 Dry run:
 
 Let's perform a dry run of the provided code with a sample dungeon:

 css
 Copy code
 dungeon = [  [-2, -3, 3],
   [-5, -10, 1],
   [10, 30, -5]
 ]
 Initialize rows and columns variables:

 rows = 3
 columns = 3
 Create an array dp of length columns:

 dp = [0, 0, 0]
 Initialize the last element of dp:

 dp[2] = min(0, dungeon[2][2]) = min(0, -5) = -5
 Iterate over the remaining columns of the last row of the dungeon (from right to left):

 Iteration 1 (i = 1):
 dp[1] = min(0, dp[2] + dungeon[2][1]) = min(0, -5 + 30) = min(0, 25) = 0
 Iteration 2 (i = 0):
 dp[0] = min(0, dp[1] + dungeon[2][0]) = min(0, 0 + 10) = min(0, 10) = 0
 Now, dp = [0, 0, -5]

 Iterate over the remaining rows of the dungeon (from bottom to top):

 Iteration 1 (i = 1):
 dp[2] = min(0, dp[2] + dungeon[1][2]) = min(0, -5 + 1) = min(0, -4) = -4
 dp[1] = min(0, max(dp[1], dp[2]) + dungeon[1][1]) = min(0, max(0, -4) + (-10)) = min(0, -10) = -10
 dp[0] = min(0, max(dp[0], dp[1]) + dungeon[1][0]) = min(0, max(0, -10) + (-5)) = min(0, -5) = -5
 Now, dp = [0, -10, -4]

 Iteration 2 (i = 0):
 dp[2] = min(0, dp[2] + dungeon[0][2]) = min(0, -4 + 3) = min(0, -1) = -1
 dp[1] = min(0, max(dp[1], dp[2]) + dungeon[0][1]) = min(0, max(-10, -1) + (-3)) = min(0, -1) = -1
 dp[0] = min(0, max(dp[0], dp[1]) + dungeon[0][0]) = min(0, max(0, -1) + (-2)) = min(0, -1) = -1
 Now, dp = [-1, -1, -1]

 Return -dp[0] + 1 = 1

 The minimum initial health required by the knight to rescue the princess in the given dungeon is 1.
 */
