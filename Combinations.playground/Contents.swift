/*
 https://leetcode.com/problems/combinations/description/
 Given two integers n and k, return all possible combinations of k numbers chosen from the range [1, n].

 You may return the answer in any order.

  

 Example 1:

 Input: n = 4, k = 2
 Output: [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
 Explanation: There are 4 choose 2 = 6 total combinations.
 Note that combinations are unordered, i.e., [1,2] and [2,1] are considered to be the same combination.
 Example 2:

 Input: n = 1, k = 1
 Output: [[1]]
 Explanation: There is 1 choose 1 = 1 total combination.
  

 Constraints:

 1 <= n <= 20
 1 <= k <= n
 
 */

func combine(_ n: Int, _ k: Int) -> [[Int]] {
    var result = [[Int]]()
    
    func backtrack(_ start: Int, _ path: inout [Int]) {
        if path.count == k {
            result.append(Array(path))
            return
        }
        
        for i in start...n {
            path.append(i)
            backtrack(i + 1, &path)
            path.removeLast()
        }
    }
    
    var path = [Int]()
    backtrack(1, &path)
    return result
}

// Example usage
print(combine(4, 2))  // Output: [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
print(combine(1, 1))  // Output: [[1]]

/*
 Explanation:
 combine(_ n: Int, _ k: Int) -> [[Int]]: This is the main function that initializes the result array and starts the backtracking process.
 backtrack(_ start: Int, _ path: inout [Int]):
 Base case: If the length of the current path is equal to
 𝑘
 k, a valid combination is found, so it's added to the result array.
 Recursive case: Iterate from start to
 𝑛
 n and for each number:
 Add the number to path.
 Recursively call backtrack with the next starting number and the updated path.
 Remove the last number to backtrack and try the next number in the range.
 */
