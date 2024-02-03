/*
 You are given an m x n integer matrix matrix with the following two properties:

 Each row is sorted in non-decreasing order.
 The first integer of each row is greater than the last integer of the previous row.
 Given an integer target, return true if target is in matrix or false otherwise.

 You must write a solution in O(log(m * n)) time complexity.

  

 Example 1:


 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
 Output: true
 Example 2:


 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
 Output: false
  

 Constraints:

 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 100
 -10^4 <= matrix[i][j], target <= 10^4
 */

// Solution:
class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        var result = false
        var testArray: [Int] = []
        
        for testArr in matrix {
            if testArr[0] <= target && testArr[testArr.count - 1] >= target {
                testArray = testArr
                break
            }
        }
        result = testArray.contains(target)
        return result
    }
}

let sol = Solution()
print(sol.searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13))
print(sol.searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3))

// Solution2: binary search approach https://leetcode.com/problems/search-a-2d-matrix/solutions/3088083/binary-search-approach

class Solution2 {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard let width = matrix.first?.count else { return false }
        let height = matrix.count
        var left = 0
        var right = (height * width) - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            let heightPos = (mid / width)
            let widthPos = mid % width
            
            if matrix[heightPos][widthPos] > target {
                right = mid - 1
            } else if matrix[heightPos][widthPos] < target {
                left = mid + 1
            } else {
                return true
            }
        }

        return false
    }
}

let sol2 = Solution2()
print(sol2.searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13))
print(sol2.searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3))
