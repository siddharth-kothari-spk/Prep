/*
 https://leetcode.com/problems/longest-palindromic-substring/description/
 Given a string s, return the longest
 palindromic
  
 substring
  in s.

  

 Example 1:

 Input: s = "babad"
 Output: "bab"
 Explanation: "aba" is also a valid answer.
 Example 2:

 Input: s = "cbbd"
 Output: "bb"
  

 Constraints:

 1 <= s.length <= 1000
 s consist of only digits and English letters.
 */

import Foundation

func longestPalindrome(_ s: String) -> String {
    if s.isEmpty {
        return ""
    }
    
    let chars = Array(s)
    let n = chars.count
    var start = 0
    var end = 0
    
    func expandAroundCenter(_ left: Int, _ right: Int) -> (Int, Int) {
        var l = left
        var r = right
        while l >= 0 && r < n && chars[l] == chars[r] {
            l -= 1
            r += 1
        }
        return (l + 1, r - 1)
    }
    
    for i in 0..<n {
        let (left1, right1) = expandAroundCenter(i, i)
        let (left2, right2) = expandAroundCenter(i, i + 1)
        
        if right1 - left1 > end - start {
            start = left1
            end = right1
        }
        
        if right2 - left2 > end - start {
            start = left2
            end = right2
        }
    }
    
    let result = String(chars[start...end])
    return result
}

// Example usage:
let input1 = "babad"
let output1 = longestPalindrome(input1)
print(output1) // Output: "bab" or "aba"

let input2 = "cbbd"
let output2 = longestPalindrome(input2)
print(output2) // Output: "bb"

/*
 Explanation:
 
 Initial Check: If the input string is empty, return an empty string.
 
 Convert String to Array: Convert the string into an array of characters for easy indexing.
 
 Helper Function: Define expandAroundCenter which expands around the center indices to find the longest palindromic substring centered at the given indices.
 
 Main Logic: Iterate through the string and expand around each character (for odd-length palindromes) and between each pair of characters (for even-length palindromes).
 
 Track Longest Palindrome: Keep track of the start and end indices of the longest palindromic substring found during the expansion.
 
 Return Result: Extract the longest palindromic substring using the start and end indices and return it.
 */


/*
 Sure, let's go through a dry run of the provided code using the input `s = "babad"`:

 ### Initialization:
 - `chars = ["b", "a", "b", "a", "d"]`
 - `n = 5` (length of the string)
 - `start = 0`, `end = 0`

 ### Iteration:

 #### 1. For `i = 0`:
 - **Odd-length palindrome (expand around center 0, 0):**
   - Initial: `l = 0`, `r = 0`
   - Expand: `l = -1`, `r = 1` (stop because `l < 0`)
   - Result: `left1 = 0`, `right1 = 0`
   - Update: No change in `start` and `end` as `right1 - left1 (0 - 0) <= end - start (0 - 0)`
   
 - **Even-length palindrome (expand around center 0, 1):**
   - Initial: `l = 0`, `r = 1`
   - Stop: `chars[0] != chars[1] ("b" != "a")`
   - Result: `left2 = 1`, `right2 = 0`
   - Update: No change in `start` and `end` as `right2 - left2 (0 - 1) <= end - start (0 - 0)`

 #### 2. For `i = 1`:
 - **Odd-length palindrome (expand around center 1, 1):**
   - Initial: `l = 1`, `r = 1`
   - Expand: `l = 0`, `r = 2` (chars[0] == chars[2] ("b" == "b"))
   - Expand: `l = -1`, `r = 3` (stop because `l < 0`)
   - Result: `left1 = 0`, `right1 = 2`
   - Update: `start = 0`, `end = 2` (new longest palindrome "bab")
   
 - **Even-length palindrome (expand around center 1, 2):**
   - Initial: `l = 1`, `r = 2`
   - Stop: `chars[1] != chars[2] ("a" != "b")`
   - Result: `left2 = 2`, `right2 = 1`
   - Update: No change in `start` and `end` as `right2 - left2 (1 - 2) <= end - start (2 - 0)`

 #### 3. For `i = 2`:
 - **Odd-length palindrome (expand around center 2, 2):**
   - Initial: `l = 2`, `r = 2`
   - Expand: `l = 1`, `r = 3` (chars[1] == chars[3] ("a" == "a"))
   - Expand: `l = 0`, `r = 4` (stop because `chars[0] != chars[4] ("b" != "d")`)
   - Result: `left1 = 1`, `right1 = 3`
   - Update: No change in `start` and `end` as `right1 - left1 (3 - 1) <= end - start (2 - 0)`
   
 - **Even-length palindrome (expand around center 2, 3):**
   - Initial: `l = 2`, `r = 3`
   - Stop: `chars[2] != chars[3] ("b" != "a")`
   - Result: `left2 = 3`, `right2 = 2`
   - Update: No change in `start` and `end` as `right2 - left2 (2 - 3) <= end - start (2 - 0)`

 #### 4. For `i = 3`:
 - **Odd-length palindrome (expand around center 3, 3):**
   - Initial: `l = 3`, `r = 3`
   - Expand: `l = 2`, `r = 4` (chars[2] != chars[4] ("b" != "d"))
   - Result: `left1 = 3`, `right1 = 3`
   - Update: No change in `start` and `end` as `right1 - left1 (3 - 3) <= end - start (2 - 0)`
   
 - **Even-length palindrome (expand around center 3, 4):**
   - Initial: `l = 3`, `r = 4`
   - Stop: `chars[3] != chars[4] ("a" != "d")`
   - Result: `left2 = 4`, `right2 = 3`
   - Update: No change in `start` and `end` as `right2 - left2 (3 - 4) <= end - start (2 - 0)`

 #### 5. For `i = 4`:
 - **Odd-length palindrome (expand around center 4, 4):**
   - Initial: `l = 4`, `r = 4`
   - Expand: `l = 3`, `r = 5` (stop because `r >= n`)
   - Result: `left1 = 4`, `right1 = 4`
   - Update: No change in `start` and `end` as `right1 - left1 (4 - 4) <= end - start (2 - 0)`
   
 - **Even-length palindrome (expand around center 4, 5):**
   - Initial: `l = 4`, `r = 5`
   - Stop: `r >= n`
   - Result: `left2 = 5`, `right2 = 4`
   - Update: No change in `start` and `end` as `right2 - left2 (4 - 5) <= end - start (2 - 0)`

 ### Result:
 - The longest palindromic substring found is from index `start = 0` to `end = 2`.
 - Therefore, the result is `String(chars[0...2])` which is `"bab"`.
 */
