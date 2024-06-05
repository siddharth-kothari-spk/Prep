/*
 https://leetcode.com/problems/substring-with-concatenation-of-all-words/description/
 You are given a string s and an array of strings words. All the strings of words are of the same length.

 A concatenated string is a string that exactly contains all the strings of any permutation of words concatenated.

 For example, if words = ["ab","cd","ef"], then "abcdef", "abefcd", "cdabef", "cdefab", "efabcd", and "efcdab" are all concatenated strings. "acdbef" is not a concatenated string because it is not the concatenation of any permutation of words.
 Return an array of the starting indices of all the concatenated substrings in s. You can return the answer in any order.

  

 Example 1:

 Input: s = "barfoothefoobarman", words = ["foo","bar"]

 Output: [0,9]

 Explanation:

 The substring starting at 0 is "barfoo". It is the concatenation of ["bar","foo"] which is a permutation of words.
 The substring starting at 9 is "foobar". It is the concatenation of ["foo","bar"] which is a permutation of words.

 Example 2:

 Input: s = "wordgoodgoodgoodbestword", words = ["word","good","best","word"]

 Output: []

 Explanation:

 There is no concatenated substring.

 Example 3:

 Input: s = "barfoofoobarthefoobarman", words = ["bar","foo","the"]

 Output: [6,9,12]

 Explanation:

 The substring starting at 6 is "foobarthe". It is the concatenation of ["foo","bar","the"].
 The substring starting at 9 is "barthefoo". It is the concatenation of ["bar","the","foo"].
 The substring starting at 12 is "thefoobar". It is the concatenation of ["the","foo","bar"].

  

 Constraints:

 1 <= s.length <= 104
 1 <= words.length <= 5000
 1 <= words[i].length <= 30
 s and words[i] consist of lowercase English letters.
 */

/*
 We can use the sliding window approach combined with hashing for efficient substring matching. Here's an algorithm to achieve that:

Algorithm:
Input Validation:

If s is empty or words is empty, return an empty list.
Initialize Variables:

word_length to store the length of each word in words.
num_words to store the number of words in words.
concat_length to store the total length of the concatenated string, which is word_length * num_words.
words_counter to store the frequency count of each word in words using a dictionary.
An empty list result to store the starting indices of valid concatenated substrings.
Sliding Window:

Iterate through the string s from index 0 to len(s) - concat_length + 1.
For each starting index i, create a temporary dictionary seen_words to keep track of the words seen in the current window.
Extract substrings of length word_length from the current starting index and check if they match the words in words.
Update seen_words and validate if the current window contains a valid concatenated string.
Check Valid Concatenation:

If seen_words matches words_counter, add the starting index i to the result.
Return the Result:

Return the result list containing the starting indices of all valid concatenated substrings.
 */


import Foundation

func findSubstring(_ s: String, _ words: [String]) -> [Int] {
    guard !s.isEmpty, !words.isEmpty else {
        return []
    }
    
    let wordLength = words[0].count
    let numWords = words.count
    let concatLength = wordLength * numWords
    
    if s.count < concatLength {
        return []
    }
    
    var wordsCounter = [String: Int]()
    for word in words {
        wordsCounter[word, default: 0] += 1
    }
    
    var result = [Int]()
    let sArray = Array(s)
    
    for i in 0...(sArray.count - concatLength) {
        var seenWords = [String: Int]()
        var j = 0
        
        while j < numWords {
            let wordStartIndex = i + j * wordLength
            let wordEndIndex = wordStartIndex + wordLength
            let word = String(sArray[wordStartIndex..<wordEndIndex])
            
            if wordsCounter[word] != nil {
                seenWords[word, default: 0] += 1
                
                if seenWords[word]! > wordsCounter[word]! {
                    break
                }
            } else {
                break
            }
            j += 1
        }
        
        if j == numWords {
            result.append(i)
        }
    }
    
    return result
}

// Example usage:
let s1 = "barfoothefoobarman"
let words1 = ["foo", "bar"]
print(findSubstring(s1, words1))  // Output: [0, 9]

let s2 = "wordgoodgoodgoodbestword"
let words2 = ["word", "good", "best", "word"]
print(findSubstring(s2, words2))  // Output: []

let s3 = "barfoofoobarthefoobarman"
let words3 = ["bar", "foo", "the"]
print(findSubstring(s3, words3))  // Output: [6, 9, 12]

/*
 dry run for the given example:

Example:
String: s3 = "barfoofoobarthefoobarman"
Words: words3 = ["bar", "foo", "the"]
Step-by-Step Dry Run:
Initialization:

wordLength = 3 (since "bar", "foo", and "the" have length 3)
numWords = 3 (there are 3 words in the list)
concatLength = 3 * 3 = 9 (length of the concatenated string we need to find)
wordsCounter = ["bar": 1, "foo": 1, "the": 1] (count of each word in words3)
Convert s3 to an array of characters: sArray = Array(s3)
Initialize result = [] (to store starting indices of valid concatenated substrings)
Sliding Window:

Iterate over each possible starting index i in s3 from 0 to sArray.count - concatLength which is 0 to 24 - 9 = 15.
Iteration Details:
Iteration i = 0:

Initialize seenWords = [:]
Check substring starting at index 0:
j = 0: word = "bar" (sArray[0..<3]), seenWords = ["bar": 1]
j = 1: word = "foo" (sArray[3..<6]), seenWords = ["bar": 1, "foo": 1]
j = 2: word = "foo" (sArray[6..<9]), seenWords = ["bar": 1, "foo": 2] (Invalid, "foo" count exceeds), break out early.
Iteration i = 1 to i = 2:

For these indices, initial substrings "arf", "rfo" are not valid words, so break out early.
Iteration i = 3:

Initialize seenWords = [:]
Check substring starting at index 3:
j = 0: word = "foo" (sArray[3..<6]), seenWords = ["foo": 1]
j = 1: word = "foo" (sArray[6..<9]), seenWords = ["foo": 2] (Invalid, "foo" count exceeds), break out early.
Iteration i = 4 to i = 5:

For these indices, initial substrings "oofo", "ofoo" are not valid words, so break out early.
Iteration i = 6:

Initialize seenWords = [:]
Check substring starting at index 6:
j = 0: word = "foo" (sArray[6..<9]), seenWords = ["foo": 1]
j = 1: word = "bar" (sArray[9..<12]), seenWords = ["foo": 1, "bar": 1]
j = 2: word = "the" (sArray[12..<15]), seenWords = ["foo": 1, "bar": 1, "the": 1] (valid)
Add index 6 to result.
Iteration i = 7 to i = 8:

For these indices, initial substrings "oob", "oba" are not valid words, so break out early.
Iteration i = 9:

Initialize seenWords = [:]
Check substring starting at index 9:
j = 0: word = "bar" (sArray[9..<12]), seenWords = ["bar": 1]
j = 1: word = "the" (sArray[12..<15]), seenWords = ["bar": 1, "the": 1]
j = 2: word = "foo" (sArray[15..<18]), seenWords = ["bar": 1, "the": 1, "foo": 1] (valid)
Add index 9 to result.
Iteration i = 10 to i = 11:

For these indices, initial substrings "art", "rth" are not valid words, so break out early.
Iteration i = 12:

Initialize seenWords = [:]
Check substring starting at index 12:
j = 0: word = "the" (sArray[12..<15]), seenWords = ["the": 1]
j = 1: word = "foo" (sArray[15..<18]), seenWords = ["the": 1, "foo": 1]
j = 2: word = "bar" (sArray[18..<21]), seenWords = ["the": 1, "foo": 1, "bar": 1] (valid)
Add index 12 to result.
Iteration i = 13 to i = 15:

For these indices, initial substrings "hef", "efo", "foo" do not complete valid concatenations with remaining words.
Result:
The final result = [6, 9, 12] as these are the starting indices where valid concatenated substrings are found.
Conclusion:
The output is [6, 9, 12] since valid concatenated substrings are found starting at these indices.
 */

