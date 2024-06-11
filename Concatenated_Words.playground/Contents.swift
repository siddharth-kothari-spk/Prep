/*
 https://leetcode.com/problems/concatenated-words/description/
 Given an array of strings words (without duplicates), return all the concatenated words in the given list of words.

 A concatenated word is defined as a string that is comprised entirely of at least two shorter words (not necessarily distinct) in the given array.

  

 Example 1:

 Input: words = ["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"]
 Output: ["catsdogcats","dogcatsdog","ratcatdogcat"]
 Explanation: "catsdogcats" can be concatenated by "cats", "dog" and "cats";
 "dogcatsdog" can be concatenated by "dog", "cats" and "dog";
 "ratcatdogcat" can be concatenated by "rat", "cat", "dog" and "cat".
 Example 2:

 Input: words = ["cat","dog","catdog"]
 Output: ["catdog"]
  

 Constraints:

 1 <= words.length <= 10^4
 1 <= words[i].length <= 30
 words[i] consists of only lowercase English letters.
 All the strings of words are unique.
 1 <= sum(words[i].length) <= 10^5
 */


/*
 To solve the problem of finding all concatenated words in a given list of unique words, we can use a dynamic programming approach with a trie (prefix tree) to efficiently check whether a word can be formed by concatenating other words from the list. Here's a step-by-step algorithm:

 Step-by-Step Algorithm
 Trie Node Definition: Define a trie node structure to store characters and a boolean indicating the end of a word.

 Build Trie: Insert all the words into the trie for quick lookup.

 Dynamic Programming Helper Function: Create a helper function to determine if a word can be segmented into smaller words using the trie.

 Iterate Over Words: Use the helper function to check each word in the list and collect the concatenated words.
 */

class TrieNode {
    var children: [Character: TrieNode]
    var isEndOfWord: Bool

    init() {
        self.children = [:]
        self.isEndOfWord = false
    }
}

class Solution {
    let root = TrieNode()
    
    func insert(_ word: String) {
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.isEndOfWord = true
    }
    
    func canForm(_ word: String, _ index: Int, _ count: Int) -> Bool {
        var node = root
        let n = word.count
        let chars = Array(word)
        
        for i in index..<n {
            if node.children[chars[i]] == nil {
                return false
            }
            node = node.children[chars[i]]!
            if node.isEndOfWord {
                if i == n - 1 {
                    return count >= 1 // Ensure at least two words are used
                }
                if canForm(word, i + 1, count + 1) {
                    return true
                }
            }
        }
        return false
    }
    
    func findAllConcatenatedWordsInADict(_ words: [String]) -> [String] {
        // Insert all words into the trie
        for word in words {
            insert(word)
        }
        
        var concatenatedWords: [String] = []
        for word in words {
            if canForm(word, 0, 0) {
                concatenatedWords.append(word)
            }
        }
        
        return concatenatedWords
    }
}

// Example usage:
let words = ["cat", "cats", "catsdogcats", "dog", "dogcatsdog", "hippopotamuses", "rat", "ratcatdogcat"]
let solution = Solution()
print(solution.findAllConcatenatedWordsInADict(words)) // Output: ["catsdogcats", "dogcatsdog", "ratcatdogcat"]

/*
 Certainly! Let's perform a dry run of the provided Swift code with the input `let words = ["cat", "cats", "catsdogcats", "dog", "dogcatsdog", "hippopotamuses", "rat", "ratcatdogcat"]`. This dry run will illustrate how the algorithm processes each word to identify concatenated words.

 ### Step-by-Step Dry Run

 1. **Inserting Words into Trie**:
    - Insert `"cat"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
      ```
    - Insert `"cats"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
                └─ s (end)
      ```
    - Insert `"catsdogcats"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
                └─ s (end)
                   └─ d
                      └─ o
                         └─ g
                            └─ c
                               └─ a
                                  └─ t
                                     └─ s (end)
      ```
    - Insert `"dog"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
                └─ s (end)
                   └─ d
                      └─ o
                         └─ g
                            └─ c
                               └─ a
                                  └─ t
                                     └─ s (end)
       └─ d
          └─ o
             └─ g (end)
      ```
    - Insert `"dogcatsdog"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
                └─ s (end)
                   └─ d
                      └─ o
                         └─ g
                            └─ c
                               └─ a
                                  └─ t
                                     └─ s (end)
       └─ d
          └─ o
             └─ g (end)
                └─ c
                   └─ a
                      └─ t
                         └─ s
                            └─ d
                               └─ o
                                  └─ g (end)
      ```
    - Insert `"hippopotamuses"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
                └─ s (end)
                   └─ d
                      └─ o
                         └─ g
                            └─ c
                               └─ a
                                  └─ t
                                     └─ s (end)
       └─ d
          └─ o
             └─ g (end)
                └─ c
                   └─ a
                      └─ t
                         └─ s
                            └─ d
                               └─ o
                                  └─ g (end)
       └─ h
          └─ i
             └─ p
                └─ p
                   └─ o
                      └─ p
                         └─ o
                            └─ t
                               └─ a
                                  └─ m
                                     └─ u
                                        └─ s
                                           └─ e
                                              └─ s (end)
      ```
    - Insert `"rat"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
                └─ s (end)
                   └─ d
                      └─ o
                         └─ g
                            └─ c
                               └─ a
                                  └─ t
                                     └─ s (end)
       └─ d
          └─ o
             └─ g (end)
                └─ c
                   └─ a
                      └─ t
                         └─ s
                            └─ d
                               └─ o
                                  └─ g (end)
       └─ h
          └─ i
             └─ p
                └─ p
                   └─ o
                      └─ p
                         └─ o
                            └─ t
                               └─ a
                                  └─ m
                                     └─ u
                                        └─ s
                                           └─ e
                                              └─ s (end)
       └─ r
          └─ a
             └─ t (end)
      ```
    - Insert `"ratcatdogcat"`: Trie becomes:
      ```
      root
       └─ c
          └─ a
             └─ t (end)
                └─ s (end)
                   └─ d
                      └─ o
                         └─ g
                            └─ c
                               └─ a
                                  └─ t
                                     └─ s (end)
       └─ d
          └─ o
             └─ g (end)
                └─ c
                   └─ a
                      └─ t
                         └─ s
                            └─ d
                               └─ o
                                  └─ g (end)
       └─ h
          └─ i
             └─ p
                └─ p
                   └─ o
                      └─ p
                         └─ o
                            └─ t
                               └─ a
                                  └─ m
                                     └─ u
                                        └─ s
                                           └─ e
                                              └─ s (end)
       └─ r
          └─ a
             └─ t (end)
                └─ c
                   └─ a
                      └─ t
                         └─ d
                            └─ o
                               └─ g
                                  └─ c
                                     └─ a
                                        └─ t (end)
      ```

 2. **Checking Each Word**:
    - Check `"cat"`: Not formed by concatenation. (Single word)
    - Check `"cats"`: Not formed by concatenation. (Single word)
    - Check `"catsdogcats"`:
      - `"cats"` (end of word)
      - Remaining: `"dogcats"`:
        - `"dog"` (end of word)
        - Remaining: `"cats"`:
          - `"cats"` (end of word)
          - End reached with 3 segments
      - Result: `true`
    - Check `"dog"`: Not formed by concatenation. (Single word)
    - Check `"dogcatsdog"`:
      - `"dog"` (end of word)
      - Remaining: `"catsdog"`:
        - `"cats"` (end of word)
        - Remaining: `"dog"`:
          - `"dog"` (end of word)
          - End reached with 3 segments
      - Result: `true`
    - Check `"hippopotamuses"`: Not formed by concatenation. (Single word)
    - Check `"rat"`: Not formed by concatenation. (Single word)
    - Check `"ratcatdogcat"`:
      - `"rat"` (end of word)
      - Remaining: `"catdogcat"`:
        - `"cat"` (end of word)
        - Remaining: `"dogcat"`:
          - `"dog"` (end of word)
          - Remaining: `"cat"`:
            - `"cat"` (end of word)
            - End reached with 4 segments
      - Result: `true`

 3. **Result**:
    - Concatenated words: `["catsdogcats", "dogcatsdog", "ratcatdogcat"]`

 ### Summary

 1. **Trie Construction**: Inserted all words into the trie for efficient prefix checks.
 2. **Checking Concatenation**: Used recursive checking to see if each word could be segmented into at least two smaller words.
 3. **Result Collection**: Collected all words that were successfully segmented into concatenated words.

 This dry run demonstrates the detailed process and ensures the correctness of the solution.
 */
