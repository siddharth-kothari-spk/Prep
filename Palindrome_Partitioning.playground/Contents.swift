/*
 https://leetcode.com/problems/palindrome-partitioning/description/
 Given a string s, partition s such that every
 substring
  of the partition is a
 palindrome
 . Return all possible palindrome partitioning of s.

  

 Example 1:

 Input: s = "aab"
 Output: [["a","a","b"],["aa","b"]]
 Example 2:

 Input: s = "a"
 Output: [["a"]]
  

 Constraints:

 1 <= s.length <= 16
 s contains only lowercase English letters.
 */

/*
 To solve the problem of partitioning a string such that every substring of the partition is a palindrome, we can use a backtracking algorithm. Here's a step-by-step algorithm to achieve this:

 Initialize the result list: This list will store all possible palindrome partitions of the string.

 Create a helper function is_palindrome: This function will check if a given substring is a palindrome.

 Create a backtracking function backtrack(start, path):

 If the start index reaches the end of the string, append the current path (which is a valid partition) to the result list.
 Iterate over the substring starting from the start index to the end of the string.
 For each substring, check if it is a palindrome using the is_palindrome function.
 If it is a palindrome, recursively call the backtrack function with the next starting index and the updated path.
 Call the backtracking function with initial values.
 */

class Solution {
    func partition(_ s: String) -> [[String]] {
        var result = [[String]]()
        var path = [String]()
        let characters = Array(s)
        
        func isPalindrome(_ left: Int, _ right: Int) -> Bool {
            var left = left
            var right = right
            while left < right {
                if characters[left] != characters[right] {
                    return false
                }
                left += 1
                right -= 1
            }
            return true
        }
        
        func backtrack(_ start: Int) {
            if start == characters.count {
                result.append(path)
                return
            }
            for end in start..<characters.count {
                if isPalindrome(start, end) {
                    path.append(String(characters[start...end]))
                    backtrack(end + 1)
                    path.removeLast()
                }
            }
        }
        
        backtrack(0)
        return result
    }
}

// Example usage:
let solution = Solution()
print(solution.partition("aab"))  // Output: [["a","a","b"],["aa","b"]]
print(solution.partition("a"))    // Output: [["a"]]

/*
 Let's do a dry run for `solution.partition("aab")` to understand how the algorithm works step-by-step:

 ### Initial Setup:

 - `s = "aab"`
 - Convert the string to a character array: `characters = ["a", "a", "b"]`
 - Initialize `result = []` and `path = []`

 ### First Call to `backtrack(0)`:

 1. **Start Index 0**:
    - Check substring `characters[0...0]` which is `"a"`.
    - It's a palindrome, so append `"a"` to `path`, making `path = ["a"]`.
    - Recursively call `backtrack(1)`.

 ### Second Call to `backtrack(1)`:

 2. **Start Index 1**:
    - Check substring `characters[1...1]` which is `"a"`.
    - It's a palindrome, so append `"a"` to `path`, making `path = ["a", "a"]`.
    - Recursively call `backtrack(2)`.

 ### Third Call to `backtrack(2)`:

 3. **Start Index 2**:
    - Check substring `characters[2...2]` which is `"b"`.
    - It's a palindrome, so append `"b"` to `path`, making `path = ["a", "a", "b"]`.
    - Recursively call `backtrack(3)`.

 ### Fourth Call to `backtrack(3)`:

 4. **Start Index 3** (end of string):
    - `start == characters.count`, so append `path = ["a", "a", "b"]` to `result`, making `result = [["a", "a", "b"]]`.
    - Return from `backtrack(3)`, back to `backtrack(2)`.

 ### Backtrack to `backtrack(2)`:

 5. **Backtracking in `backtrack(2)`**:
    - Remove last element `"b"` from `path`, making `path = ["a", "a"]`.
    - End of iteration for `start = 2`.
    - Return from `backtrack(2)`, back to `backtrack(1)`.

 ### Backtrack to `backtrack(1)`:

 6. **Backtracking in `backtrack(1)`**:
    - Remove last element `"a"` from `path`, making `path = ["a"]`.
    - Continue to next iteration: check substring `characters[1...2]` which is `"ab"`.
    - `"ab"` is not a palindrome.
    - End of iteration for `start = 1`.
    - Return from `backtrack(1)`, back to `backtrack(0)`.

 ### Backtrack to `backtrack(0)`:

 7. **Backtracking in `backtrack(0)`**:
    - Remove last element `"a"` from `path`, making `path = []`.
    - Continue to next iteration: check substring `characters[0...1]` which is `"aa"`.
    - It's a palindrome, so append `"aa"` to `path`, making `path = ["aa"]`.
    - Recursively call `backtrack(2)`.

 ### Fifth Call to `backtrack(2)` (Second Time):

 8. **Start Index 2**:
    - Check substring `characters[2...2]` which is `"b"`.
    - It's a palindrome, so append `"b"` to `path`, making `path = ["aa", "b"]`.
    - Recursively call `backtrack(3)`.

 ### Sixth Call to `backtrack(3)` (Second Time):

 9. **Start Index 3** (end of string):
    - `start == characters.count`, so append `path = ["aa", "b"]` to `result`, making `result = [["a", "a", "b"], ["aa", "b"]]`.
    - Return from `backtrack(3)`, back to `backtrack(2)`.

 ### Backtrack to `backtrack(2)` (Second Time):

 10. **Backtracking in `backtrack(2)`**:
     - Remove last element `"b"` from `path`, making `path = ["aa"]`.
     - End of iteration for `start = 2`.
     - Return from `backtrack(2)`, back to `backtrack(0)`.

 ### Backtrack to `backtrack(0)` (Second Time):

 11. **Backtracking in `backtrack(0)`**:
     - Remove last element `"aa"` from `path`, making `path = []`.
     - End of iteration for `start = 0`.

 ### Final Result:
 The algorithm has explored all possible partitions, and the `result` list now contains all valid palindrome partitions:
 - `result = [["a", "a", "b"], ["aa", "b"]]`

 ### Output:

 The final output is:

 ```swift
 [["a","a","b"],["aa","b"]]
 ```

 This matches the expected result.
 */
