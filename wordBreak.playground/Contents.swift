/*
 Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

 Note that the same word in the dictionary may be reused multiple times in the segmentation.

  

 Example 1:

 Input: s = "leetcode", wordDict = ["leet","code"]
 Output: true
 Explanation: Return true because "leetcode" can be segmented as "leet code".
 Example 2:

 Input: s = "applepenapple", wordDict = ["apple","pen"]
 Output: true
 Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
 Note that you are allowed to reuse a dictionary word.
 Example 3:

 Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
 Output: false

 */

/*
 Solution:
 you can use dynamic programming. Here's the algorithm:

Initialize a dynamic programming array dp of size n + 1, where n is the length of the input string s. Set dp[0] = true, indicating that an empty string can be segmented into words from the dictionary.
Iterate through each position i in the string s from 1 to n.
For each position i, iterate through each word in the word dictionary.
If the substring from 0 to i (inclusive) can be segmented into words from the dictionary AND the substring from i to the end of the string is in the dictionary, set dp[i] to true.
If dp[n] is true after the iteration, return true; otherwise, return false.

 */


func wordBreak(_ s: String, _ wordArray: [String]) -> Bool {
    let n = s.count
    var dp = [Bool](repeating: false, count: n + 1)
    dp[0] = true
    
    print(dp)
    print("--------")
    for i in 1...n {
        print("#\(i)")
        for word in wordArray {
            
            let wordLength = word.count
            //print("wordLength: \(wordLength)")
            if i >= wordLength {
                print("////////")
                print("word: \(word)")
                let startIndex = s.index(s.startIndex, offsetBy: i - wordLength)
                let endIndex = s.index(s.startIndex, offsetBy: i)
                let subStr = String(s[startIndex..<endIndex])
                print("subStr: \(subStr)")
                print("dp[i - wordLength]: \(dp[i - wordLength])")
                if dp[i - wordLength] && subStr == word {
                    dp[i] = true
                    print("updated dp: \(dp)")
                    break
                }
                print("////////")
            }
        }
    }
    
    return dp[n]
}

// Example usage:
/*
let s1 = "leetcode"
let wordArr1 = ["leet", "code"]
print(wordBreak(s1, wordArr1))  // Output: true
*/

let s2 = "applepenapple"
let wordArr2 = ["apple", "pen"]
print(wordBreak(s2, wordArr2))  // Output: true
/*
let s3 = "catsandog"
let wordDict3 = ["cats", "dog", "sand", "and", "cat"]
print(wordBreak(s3, wordDict3))  // Output: false
*/

// Solution 2: https://leetcode.com/problems/word-break/solutions/1938500/100-fastest-swift-solution-time-o-n-2-space-o-n
/*
 This method, `wordBreak(_:wordArray:)`, takes a string `s` and an array of words `wordArray` as input and returns a boolean indicating whether the string `s` can be segmented into words from the `wordArray`. It uses dynamic programming to solve the problem efficiently.

 Here's a breakdown of the logic:

 1. Initialize a dynamic programming array `dp` of size `s.count + 1` to store intermediate results. Each element of `dp` represents whether the substring up to that index (inclusive) can be segmented into words from the `wordArray`. Set `dp[0] = true` to indicate that an empty string can always be segmented into words from the `wordArray`.

 2. Convert the input string `s` into an array of characters `chars` for easier manipulation.

 3. Create a set `wordSet` from the `wordArray` to efficiently check whether a given substring is a valid word.

 4. Iterate over the indices of the string `s` from 1 to its length (`s.count`). This represents the end index of the current substring being considered.

 5. For each index `i`, iterate over all indices `j` less than `i`. This represents the start index of the current substring being considered.

 6. For each pair of indices `(i, j)`, check if `dp[j]` is true, indicating that the substring up to index `j` can be segmented into words from the `wordArray`, and if the substring from index `j` to `i` is present in the `wordSet`. If both conditions are met, set `dp[i] = true`, indicating that the substring up to index `i` can be segmented into words from the `wordArray`.

 7. Once all substrings have been processed, return the value of `dp[s.count]`, which represents whether the entire string `s` can be segmented into words from the `wordArray`.

 This approach efficiently determines whether the input string `s` can be segmented into words from the `wordArray` by leveraging dynamic programming and efficiently checking for valid substrings using a set. The time complexity of this algorithm is O(n^2), where n is the length of the input string `s`.
 */

class Solution {
    // - Complexity:
    //   - time: O(n ^ 2), where n is the length of s.
    //   - space: O(n), where n is the length of s.
    
    func wordBreak(_ s: String, _ wordArray: [String]) -> Bool {
        var dp = [Bool](repeating: false, count: s.count+1)
        dp[0] = true

        let chars = Array(s)
        let wordSet = Set(wordArray)

        for i in 1...s.count {
            for j in 0..<i {
                guard dp[j], wordSet.contains(String(chars[j..<i])) else { continue }
                dp[i] = true
                break
            }
        }

        return dp[s.count]
    }

}

let sol = Solution()

print(sol.wordBreak(s2, wordArr2))


