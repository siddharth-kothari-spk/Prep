/*
 Given a string s and an integer k, return the length of the longest substring of s such that the frequency of each character in this substring is greater than or equal to k.

 if no such substring exists, return 0.

  

 Example 1:

 Input: s = "aaabb", k = 3
 Output: 3
 Explanation: The longest substring is "aaa", as 'a' is repeated 3 times.
 Example 2:

 Input: s = "ababbc", k = 2
 Output: 5
 Explanation: The longest substring is "ababb", as 'a' is repeated 2 times and 'b' is repeated 3 times.

 */

import Foundation


func longestSubstring(_ s: String, _ k: Int) -> Int {
    func longest(_ s: [Character], _ k: Int) -> Int {
        print("-----------")
        print("s: \(s)")
        let counts = Dictionary(grouping: s, by: { $0 })
        print("counts: \(counts)")
        var len = 0
        var idx = 0
        for i in s.indices {
            if counts[s[i]]!.count < k {
                len = max(len, longest(Array(s[idx..<i]), k))
                idx = i + 1
            }
        }
        return idx == 0 ? s.count : max(len, longest(Array(s[idx...]), k))
    }
    return longest(Array(s), k)
}

// Test cases
print(longestSubstring("aaabb", 3)) // Output: 3
print(longestSubstring("ababbc", 2)) // Output: 5

/*
 Logic:
 implements a recursive function to find the longest substring in a string s where each character frequency is greater than or equal to k. Let's break down the logic:

1. longest(_:_: Int) -> Int function:

    This recursive function takes a character array (s) and the minimum frequency (k) as input and returns the length of the longest valid substring.
    It first creates a dictionary counts using Dictionary(grouping: by:). This efficiently groups characters in s by their occurrence, creating key-value pairs where the key is the character and the value is an array containing all its indices in the string.
    It initializes len to 0 to track the current longest substring length and idx to 0, which represents the starting index of the current sub-window.
 
2. Looping through Characters:

    The code iterates over the character indices (i) of the string s.
    For each character at index i:
    It checks if the count of the current character (s[i]) in the counts dictionary is less than k. This indicates that the character frequency falls below the minimum requirement.
    If the frequency is insufficient:
    It calls the longest function recursively on a sub-array of s from index idx (exclusive) to the current index i (exclusive). This essentially checks for the longest valid substring within the window from idx to the point where the frequency drops.
    It updates len to the maximum of its current value and the length returned by the recursive call. This ensures we keep track of the longest valid substring encountered so far.
    It updates idx to i + 1, effectively moving the starting index of the sub-window to the next character after the one with insufficient frequency.
 
 
3. Handling Edge Cases:

    After iterating through all characters, there are two scenarios:
    If idx is still 0, it means no character frequency dipped below k throughout the entire string s. In this case, the entire string is considered a valid substring, and the function returns the length of the string (s.count).
    If idx has been updated (meaning a character frequency dipped below k), it signifies there might be a valid substring beyond idx. Therefore, the function calls itself recursively with the remaining sub-array, starting from idx (inclusive) to the end of the string (...). It again compares this potential substring length with the previously found len and returns the maximum.
 
4. Overall Functionality:

    The outer function longestSubstring simply calls the longest function with the entire string s and the minimum frequency k as arguments.
    The recursive calls within longest break down the string into smaller sub-windows and check if they meet the frequency requirement. It keeps track of the longest valid substring throughout the process and ultimately returns its length.
 */
