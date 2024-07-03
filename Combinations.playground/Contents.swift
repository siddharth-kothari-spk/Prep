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
//print(combine(4, 2))  // Output: [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
//print(combine(1, 1))  // Output: [[1]]

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

/*
 Let's perform a dry run for `combine(4, 2)` using the Swift code provided:

 ### Initialization:
 - `result = []`
 - `path = []`
 - Call `backtrack(1, &path)`

 ### First Level of Recursion (`start = 1`):
 1. `i = 1`
    - `path = [1]`
    - Call `backtrack(2, &path)`

 ### Second Level of Recursion (`start = 2`):
 1. `i = 2`
    - `path = [1, 2]`
    - Since `path.count == 2`, add `[1, 2]` to `result`: `result = [[1, 2]]`
    - Backtrack: `path = [1]`
 2. `i = 3`
    - `path = [1, 3]`
    - Since `path.count == 2`, add `[1, 3]` to `result`: `result = [[1, 2], [1, 3]]`
    - Backtrack: `path = [1]`
 3. `i = 4`
    - `path = [1, 4]`
    - Since `path.count == 2`, add `[1, 4]` to `result`: `result = [[1, 2], [1, 3], [1, 4]]`
    - Backtrack: `path = [1]`
 - Backtrack: `path = []`

 ### Back to First Level of Recursion (`start = 1`):
 2. `i = 2`
    - `path = [2]`
    - Call `backtrack(3, &path)`

 ### Second Level of Recursion (`start = 3`):
 1. `i = 3`
    - `path = [2, 3]`
    - Since `path.count == 2`, add `[2, 3]` to `result`: `result = [[1, 2], [1, 3], [1, 4], [2, 3]]`
    - Backtrack: `path = [2]`
 2. `i = 4`
    - `path = [2, 4]`
    - Since `path.count == 2`, add `[2, 4]` to `result`: `result = [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4]]`
    - Backtrack: `path = [2]`
 - Backtrack: `path = []`

 ### Back to First Level of Recursion (`start = 1`):
 3. `i = 3`
    - `path = [3]`
    - Call `backtrack(4, &path)`

 ### Second Level of Recursion (`start = 4`):
 1. `i = 4`
    - `path = [3, 4]`
    - Since `path.count == 2`, add `[3, 4]` to `result`: `result = [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]`
    - Backtrack: `path = [3]`
 - Backtrack: `path = []`

 ### Back to First Level of Recursion (`start = 1`):
 4. `i = 4`
    - `path = [4]`
    - Call `backtrack(5, &path)`

 ### Second Level of Recursion (`start = 5`):
 - This call ends immediately because `start` exceeds `n`.

 ### Final Result:
 - `result = [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]`

 The algorithm has now explored all possible combinations of 2 numbers from the range 1 to 4 and collected them in the result list.
 */

class Solution {
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var res: [[Int]] = []
        
        
        func backtrack(_ path: [Int], _ max: Int) {
            if path.count == k {
                res.append(path)
                return
            
            }
            
            var path = path
            if max + 1 > n { return }
            
            for i in max+1...n {
                if n - i < k - path.count - 1 {
                    continue
                }
                
                path.append(i)
                backtrack(path, i)
                path.remove(at: path.count - 1)
            }
        }
        
        backtrack([], 0)
        return res
    }
    
}

print(Solution().combine(4, 2))
