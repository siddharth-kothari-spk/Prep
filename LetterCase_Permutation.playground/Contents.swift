/*
 https://leetcode.com/problems/letter-case-permutation/description/
 Given a string s, you can transform every letter individually to be lowercase or uppercase to create another string.

 Return a list of all possible strings we could create. Return the output in any order.

  

 Example 1:

 Input: s = "a1b2"
 Output: ["a1b2","a1B2","A1b2","A1B2"]
 Example 2:

 Input: s = "3z4"
 Output: ["3z4","3Z4"]
  

 Constraints:

 1 <= s.length <= 12
 s consists of lowercase English letters, uppercase English letters, and digits.
 */

/*
 To solve this problem, we can use a backtracking approach. The idea is to explore all possible combinations of lowercase and uppercase transformations for each letter in the string. We'll use a recursive function to generate these combinations.

 Here's the algorithm:

 Initialize an empty list result to store all possible strings.
 Define a recursive function backtrack(index, path):
 If index is equal to the length of the input string s, append the current combination path to result.
 Otherwise, if the current character at index is a letter, recursively call backtrack for both lowercase and uppercase versions of this character.
 If the current character at index is a digit, simply append it to path and recursively call backtrack with the next index.
 Start the backtracking process from the first character of the string with an empty path.
 Return the result list.
 */


class Solution {
    func letterCasePermutation(_ s: String) -> [String] {
        var result = [String]()
        
        func backtrack(_ index: Int, _ path: String) {
            if index == s.count {
                result.append(path)
                return
            }
            
            let currentIndex = s.index(s.startIndex, offsetBy: index)
            let currentChar = s[currentIndex]
            
            if currentChar.isLetter {
                // Explore the path with lowercase letter
                backtrack(index + 1, path + currentChar.lowercased())
                // Explore the path with uppercase letter
                backtrack(index + 1, path + currentChar.uppercased())
            } else {
                // If it's a digit, just add it to the path
                backtrack(index + 1, path + String(currentChar))
            }
        }
        
        // Start backtracking from the first character with an empty path
        backtrack(0, "")
        
        return result
    }
}

// Example usage
let solution = Solution()

let s1 = "a1b2"
print(solution.letterCasePermutation(s1))  // Output: ["a1b2","a1B2","A1b2","A1B2"]

let s2 = "3z4"
print(solution.letterCasePermutation(s2))  // Output: ["3z4","3Z4"]

/*
 Sure, let's do a dry run of the `letterCasePermutation` function with the input `s1 = "a1b2"`.

 ### Dry Run

 **Initial Call:**
 - `s = "a1b2"`
 - `result = []`
 - Call `backtrack(0, "")`

 ### First Level of Recursion

 1. **First Call to `backtrack`:**
    - `index = 0`
    - `path = ""`
    - `currentChar = "a"`
    - `currentChar.isLetter` is `true`

 2. **Branch 1: Lowercase "a"**
    - Call `backtrack(1, "a")`

 3. **Branch 2: Uppercase "A"**
    - Call `backtrack(1, "A")`

 ### Second Level of Recursion

 #### Branch 1: Lowercase "a"

 1. **Call to `backtrack(1, "a")`:**
    - `index = 1`
    - `path = "a"`
    - `currentChar = "1"`
    - `currentChar.isLetter` is `false`
    - Call `backtrack(2, "a1")`

 #### Branch 2: Uppercase "A"

 2. **Call to `backtrack(1, "A")`:**
    - `index = 1`
    - `path = "A"`
    - `currentChar = "1"`
    - `currentChar.isLetter` is `false`
    - Call `backtrack(2, "A1")`

 ### Third Level of Recursion

 #### Branch 1: Lowercase "a" -> "a1"

 1. **Call to `backtrack(2, "a1")`:**
    - `index = 2`
    - `path = "a1"`
    - `currentChar = "b"`
    - `currentChar.isLetter` is `true`

 2. **Branch 1: Lowercase "b"**
    - Call `backtrack(3, "a1b")`

 3. **Branch 2: Uppercase "B"**
    - Call `backtrack(3, "a1B")`

 #### Branch 2: Uppercase "A" -> "A1"

 4. **Call to `backtrack(2, "A1")`:**
    - `index = 2`
    - `path = "A1"`
    - `currentChar = "b"`
    - `currentChar.isLetter` is `true`

 5. **Branch 1: Lowercase "b"**
    - Call `backtrack(3, "A1b")`

 6. **Branch 2: Uppercase "B"**
    - Call `backtrack(3, "A1B")`

 ### Fourth Level of Recursion

 #### Branch 1: Lowercase "a" -> "a1" -> "a1b"

 1. **Call to `backtrack(3, "a1b")`:**
    - `index = 3`
    - `path = "a1b"`
    - `currentChar = "2"`
    - `currentChar.isLetter` is `false`
    - Call `backtrack(4, "a1b2")`

 #### Branch 2: Lowercase "a" -> "a1" -> "a1B"

 2. **Call to `backtrack(3, "a1B")`:**
    - `index = 3`
    - `path = "a1B"`
    - `currentChar = "2"`
    - `currentChar.isLetter` is `false`
    - Call `backtrack(4, "a1B2")`

 #### Branch 3: Uppercase "A" -> "A1" -> "A1b"

 3. **Call to `backtrack(3, "A1b")`:**
    - `index = 3`
    - `path = "A1b"`
    - `currentChar = "2"`
    - `currentChar.isLetter` is `false`
    - Call `backtrack(4, "A1b2")`

 #### Branch 4: Uppercase "A" -> "A1" -> "A1B"

 4. **Call to `backtrack(3, "A1B")`:**
    - `index = 3`
    - `path = "A1B"`
    - `currentChar = "2"`
    - `currentChar.isLetter` is `false`
    - Call `backtrack(4, "A1B2")`

 ### Fifth Level of Recursion

 1. **Call to `backtrack(4, "a1b2")`:**
    - `index = 4`
    - `path = "a1b2"`
    - `index == s.count`, so add "a1b2" to `result`

 2. **Call to `backtrack(4, "a1B2")`:**
    - `index = 4`
    - `path = "a1B2"`
    - `index == s.count`, so add "a1B2" to `result`

 3. **Call to `backtrack(4, "A1b2")`:**
    - `index = 4`
    - `path = "A1b2"`
    - `index == s.count`, so add "A1b2" to `result`

 4. **Call to `backtrack(4, "A1B2")`:**
    - `index = 4`
    - `path = "A1B2"`
    - `index == s.count`, so add "A1B2" to `result`

 ### Result

 After all recursive calls complete, the `result` array will contain all possible combinations:

 ```swift
 ["a1b2", "a1B2", "A1b2", "A1B2"]
 ```

 This covers all transformations of each letter in the input string `s1 = "a1b2"`.
 */
