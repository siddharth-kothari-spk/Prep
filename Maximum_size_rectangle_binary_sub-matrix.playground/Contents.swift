/*
 https://www.geeksforgeeks.org/maximum-size-rectangle-binary-sub-matrix-1s/
 */

/*
 Algo
 
 function maximalRectangle(matrix):
     if matrix is empty:
         return 0
     maxArea = 0
     height = array of zeros with length equal to the number of columns in matrix
     for each row in matrix:
         for j in range(length of row):
             if matrix[row][j] == 1:
                 height[j] += 1
             else:
                 height[j] = 0
         maxArea = max(maxArea, largestRectangleArea(height))
     return maxArea

 function largestRectangleArea(heights):
     stack = empty stack
     maxArea = 0
     for i in range(length of heights):
         while stack is not empty and heights[i] < heights[stack.peek()]:
             height = heights[stack.pop()]
             width = i if stack is empty else i - stack.peek() - 1
             maxArea = max(maxArea, height * width)
         stack.push(i)
     while stack is not empty:
         height = heights[stack.pop()]
         width = length of heights if stack is empty else length of heights - stack.peek() - 1
         maxArea = max(maxArea, height * width)
     return maxArea

 */


import Foundation

func maximalRectangle(_ matrix: [[Int]]) -> Int {
    guard !matrix.isEmpty else { return 0 }
    var maxArea = 0
    var heights = [Int](repeating: 0, count: matrix[0].count)
    
    print("maxArea: \(maxArea), heights: \(heights)")
    for row in matrix {
        print("******")
        print("row: \(row)")
        for (j, val) in row.enumerated() {
            if val == 1 {
                heights[j] += 1
            } else {
                heights[j] = 0
            }
        }
        print("heights: \(heights)")
        maxArea = max(maxArea, largestRectangleArea(heights))
        print("maxArea: \(maxArea)")
    }
    return maxArea
}

func largestRectangleArea(_ heights: [Int]) -> Int {
    print("largestRectangleArea")
    var stack: [Int] = []
    var maxArea = 0
    let heights = heights + [0] // Append a zero to handle remaining bars.
    print("heights2: \(heights)")
    for i in 0..<heights.count {
        print("i: \(i)")
        print("heights[i]: \(heights[i])")
        print("stack: \(stack)")
        while !stack.isEmpty && heights[i] < heights[stack.last!] {
            let height = heights[stack.removeLast()]
            let width = stack.isEmpty ? i : i - stack.last! - 1
            print("height: \(height), width: \(width)")
            maxArea = max(maxArea, height * width)
        }
        stack.append(i)
    }
    print("maxArea return: \(maxArea)")
    return maxArea
}

// Example usage:
var matrix = [
    [1, 0, 1, 0, 0],
    [1, 0, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 0, 0, 1, 0]
]

//print(maximalRectangle(matrix))

matrix = [[1,1,1],
          [1,1,0]]
print(maximalRectangle(matrix))

/*
func maximalRectangle(_ matrix: [[Int]]) -> Int {
  guard !matrix.isEmpty else { return 0 }
  let rows = matrix.count
  let cols = matrix[0].count
  var dp = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)

  // Initialize first row
  for col in 0..<cols {
    dp[0][col] = matrix[0][col] == 1 ? 1 : 0
  }

  var maxArea = 0
  for row in 1..<rows {
    for col in 0..<cols {
      if matrix[row][col] == 1 {
        dp[row][col] = min(dp[row - 1][col], dp[row][col - 1], 1) + 1
        maxArea = max(maxArea, dp[row][col] * cols)
      } else {
        dp[row][col] = 0
      }
    }
  }
  return maxArea
}

let input: [[Int]] = [
    [ 0, 1, 1, 0 ],
    [ 1, 1, 1, 1 ],
    [ 1, 1, 1, 1 ],
    [ 1, 1, 0, 0 ],
]

print(maximalRectangle(input))
*/
