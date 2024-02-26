/*
 Given an n x n matrix where each of the rows and columns is sorted in ascending order, return the kth smallest element in the matrix.

 Note that it is the kth smallest element in the sorted order, not the kth distinct element.

 You must find a solution with a memory complexity better than O(n2).

  

 Example 1:

 Input: matrix = [[1,5,9],[10,11,13],[12,13,15]], k = 8
 Output: 13
 Explanation: The elements in the matrix are [1,5,9,10,11,12,13,13,15], and the 8th smallest number is 13
 Example 2:

 Input: matrix = [[-5]], k = 1
 Output: -5
 */

func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
    var flat = matrix.flatMap{$0}.sorted()
    print(flat)
    return flat[k-1]
}

print(kthSmallest([[1,5,9],[10,11,13],[12,13,15]], 8))
print(kthSmallest([[-5]], 1))


// Solution2: https://leetcode.com/problems/kth-smallest-element-in-a-sorted-matrix/solutions/885112/yet-another-swift-solution

class Solution {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        let rowCount = matrix.count, columnCount = rowCount > 0 ? matrix[0].count : 0
        var left = matrix[0][0], right = matrix[rowCount - 1][columnCount - 1]
        while left < right {
            let middle = (left + right) / 2
            var j = columnCount - 1, count = 0
            for i in 0..<rowCount {
                while j >= 0 && matrix[i][j] > middle {
                    j -= 1
                }
                if j < 0 { break }
                count += j + 1
            }
            if count < k {
                left = middle + 1
            } else {
                right = middle
            }
        }
        return left
    }
}

let sol = Solution()
print(sol.kthSmallest([[1,5,9],[10,11,13],[12,13,15]], 8))
