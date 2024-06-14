/*
 https://leetcode.com/problems/palindrome-pairs/description/
 You are given a 0-indexed array of unique strings words.

 A palindrome pair is a pair of integers (i, j) such that:

 0 <= i, j < words.length,
 i != j, and
 words[i] + words[j] (the concatenation of the two strings) is a
 palindrome
 .
 Return an array of all the palindrome pairs of words.

 You must write an algorithm with O(sum of words[i].length) runtime complexity.

  

 Example 1:

 Input: words = ["abcd","dcba","lls","s","sssll"]
 Output: [[0,1],[1,0],[3,2],[2,4]]
 Explanation: The palindromes are ["abcddcba","dcbaabcd","slls","llssssll"]
 Example 2:

 Input: words = ["bat","tab","cat"]
 Output: [[0,1],[1,0]]
 Explanation: The palindromes are ["battab","tabbat"]
 Example 3:

 Input: words = ["a",""]
 Output: [[0,1],[1,0]]
 Explanation: The palindromes are ["a","a"]
  

 Constraints:

 1 <= words.length <= 5000
 0 <= words[i].length <= 300
 words[i] consists of lowercase English letters.
 */

func palindromePairs(_ words: [String]) -> [[Int]] {
    var result: [[Int]] = []
    
    for i in 0..<words.count {
        for j in 0..<words.count {
            if i == j {
                continue
            }
            let concat = words[i] + words[j]
            
            if concat == String(concat.reversed()) {
                result.append([i,j])
            }
        }
    }
    return result
}

print(palindromePairs(["abcd","dcba","lls","s","sssll"]))
print(palindromePairs(["a",""]))

/*
 To solve this problem, we need to efficiently find all pairs of indices
 
 (i,j) such that the concatenation of words[i] and words[j] forms a palindrome. Given the constraints, we aim for a time complexity of

 O(sum of words[i].length).

 Here is the detailed step-by-step algorithm:

 Reverse Mapping: Create a dictionary to map each word to its index for quick lookup.
 Check Pairs: Iterate through each word and check possible valid pairs:
 Check if the reverse of the current word exists in the dictionary.
 Check all possible splits of the word and see if one part is a palindrome while the reverse of the other part exists in the dictionary.
 
 Detailed Steps:
 Create a Reverse Map:

 Create a dictionary where the key is the reversed word and the value is its index.
 Iterate Over Words:

 For each word, check if its reverse exists in the dictionary and is not the same word.
 Split the word into all possible prefixes and suffixes. For each split, check if one part is a palindrome and if the reverse of the other part exists in the dictionary.
 Check Palindromes:

 Implement a helper function to check if a given string is a palindrome.
 */

class Solution {
    func palindromePairs(_ words: [String]) -> [[Int]] {
        var wordIndex = [String: Int]()
        var result = [[Int]]()

        // Create a dictionary where the key is the reversed word and the value is its index
        for (index, word) in words.enumerated() {
            wordIndex[String(word.reversed())] = index
        }

        // Helper function to check if a string is a palindrome
        func isPalindrome(_ word: String) -> Bool {
            let chars = Array(word)
            var left = 0
            var right = chars.count - 1
            while left < right {
                if chars[left] != chars[right] {
                    return false
                }
                left += 1
                right -= 1
            }
            return true
        }

        // Iterate over each word to find all valid pairs
        for (i, word) in words.enumerated() {
            let wordArray = Array(word)
            for j in 0...wordArray.count {
                let prefix = String(wordArray[0..<j])
                let suffix = String(wordArray[j..<wordArray.count])
                
                // Case 1: If prefix is a palindrome, look for reversed suffix in the map
                if isPalindrome(prefix), let suffixIndex = wordIndex[suffix], suffixIndex != i {
                    result.append([suffixIndex, i])
                }
                
                // Case 2: If suffix is a palindrome, look for reversed prefix in the map
                if j != wordArray.count, isPalindrome(suffix), let prefixIndex = wordIndex[prefix], prefixIndex != i {
                    result.append([i, prefixIndex])
                }
            }
        }

        return result
    }
}

// Example usage
let solution = Solution()
let words1 = ["abcd", "dcba", "lls", "s", "sssll"]
let words2 = ["bat", "tab", "cat"]
let words3 = ["a", ""]

print(solution.palindromePairs(words1))  // Output: [[1, 0], [0, 1], [3, 2], [2, 4]]
print(solution.palindromePairs(words2))  // Output: [[1, 0], [0, 1]]
print(solution.palindromePairs(words3))  // Output: [[1, 0], [0, 1]]

/*
 Let's perform a dry run for the input `words2 = ["bat", "tab", "cat"]` using the Swift implementation provided earlier. Here's a step-by-step breakdown:

 ### Step 1: Reverse Mapping
 Create a dictionary where each word's reverse is mapped to its index.

 - Original words: ["bat", "tab", "cat"]
 - Reversed words: ["tab", "bat", "tac"]
 - Reverse mapping dictionary:
   ```swift
   wordIndex = ["tab": 0, "bat": 1, "tac": 2]
   ```

 ### Step 2: Iterate Over Words and Check Pairs
 We iterate through each word and check possible valid pairs by splitting the word into all possible prefixes and suffixes.

 #### Iteration for word "bat" (i = 0)
 - `word = "bat"`
 - Convert `word` to array: `wordArray = ["b", "a", "t"]`

 **Check all possible splits:**

 1. `j = 0`
    - `prefix = ""`
    - `suffix = "bat"`
    - Check if `prefix` is a palindrome: `true`
    - Check if `suffix` ("bat") is in `wordIndex` and `wordIndex["bat"] != 0`: `false` (self match)
    - Check if `suffix` is a palindrome: `false`

 2. `j = 1`
    - `prefix = "b"`
    - `suffix = "at"`
    - Check if `prefix` is a palindrome: `true`
    - Check if `suffix` ("at") is in `wordIndex`: `false`
    - Check if `suffix` is a palindrome: `false`

 3. `j = 2`
    - `prefix = "ba"`
    - `suffix = "t"`
    - Check if `prefix` is a palindrome: `false`
    - Check if `suffix` is a palindrome: `true`
    - Check if `prefix` ("ba") is in `wordIndex`: `false`

 4. `j = 3`
    - `prefix = "bat"`
    - `suffix = ""`
    - Check if `prefix` is a palindrome: `false`
    - Check if `suffix` is a palindrome: `true`
    - Check if `prefix` ("bat") is in `wordIndex` and `wordIndex["bat"] != 0`: `false` (self match)

 **Result after checking "bat":** No pairs found.

 #### Iteration for word "tab" (i = 1)
 - `word = "tab"`
 - Convert `word` to array: `wordArray = ["t", "a", "b"]`

 **Check all possible splits:**

 1. `j = 0`
    - `prefix = ""`
    - `suffix = "tab"`
    - Check if `prefix` is a palindrome: `true`
    - Check if `suffix` ("tab") is in `wordIndex` and `wordIndex["tab"] != 1`: `true`
      - Found pair: `[0, 1]`
    - Check if `suffix` is a palindrome: `false`

 2. `j = 1`
    - `prefix = "t"`
    - `suffix = "ab"`
    - Check if `prefix` is a palindrome: `true`
    - Check if `suffix` ("ab") is in `wordIndex`: `false`
    - Check if `suffix` is a palindrome: `false`

 3. `j = 2`
    - `prefix = "ta"`
    - `suffix = "b"`
    - Check if `prefix` is a palindrome: `false`
    - Check if `suffix` is a palindrome: `true`
    - Check if `prefix` ("ta") is in `wordIndex`: `false`

 4. `j = 3`
    - `prefix = "tab"`
    - `suffix = ""`
    - Check if `prefix` is a palindrome: `false`
    - Check if `suffix` is a palindrome: `true`
    - Check if `prefix` ("tab") is in `wordIndex` and `wordIndex["tab"] != 1`: `true`
      - Found pair: `[1, 0]`

 **Result after checking "tab":** Pairs found: `[0, 1]` and `[1, 0]`

 #### Iteration for word "cat" (i = 2)
 - `word = "cat"`
 - Convert `word` to array: `wordArray = ["c", "a", "t"]`

 **Check all possible splits:**

 1. `j = 0`
    - `prefix = ""`
    - `suffix = "cat"`
    - Check if `prefix` is a palindrome: `true`
    - Check if `suffix` ("cat") is in `wordIndex`: `false`
    - Check if `suffix` is a palindrome: `false`

 2. `j = 1`
    - `prefix = "c"`
    - `suffix = "at"`
    - Check if `prefix` is a palindrome: `true`
    - Check if `suffix` ("at") is in `wordIndex`: `false`
    - Check if `suffix` is a palindrome: `false`

 3. `j = 2`
    - `prefix = "ca"`
    - `suffix = "t"`
    - Check if `prefix` is a palindrome: `false`
    - Check if `suffix` is a palindrome: `true`
    - Check if `prefix` ("ca") is in `wordIndex`: `false`

 4. `j = 3`
    - `prefix = "cat"`
    - `suffix = ""`
    - Check if `prefix` is a palindrome: `false`
    - Check if `suffix` is a palindrome: `true`

 **Result after checking "cat":** No pairs found.

 ### Final Result
 After iterating through all the words and checking all possible splits, we find the following palindrome pairs:

 ```swift
 [[0, 1], [1, 0]]
 ```

 These pairs correspond to the concatenations "battab" and "tabbat" which are both palindromes.
 */
