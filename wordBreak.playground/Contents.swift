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
