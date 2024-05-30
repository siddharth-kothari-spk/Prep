/*
 https://leetcode.com/problems/minimum-window-substring/description/?envType=problem-list-v2&envId=xi4ci4ig
 
 Given two strings s and t of lengths m and n respectively, return the minimum window
 substring
  of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".

 The testcases will be generated such that the answer is unique.

  

 Example 1:

 Input: s = "ADOBECODEBANC", t = "ABC"
 Output: "BANC"
 Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
 Example 2:

 Input: s = "a", t = "a"
 Output: "a"
 Explanation: The entire string s is the minimum window.
 Example 3:

 Input: s = "a", t = "aa"
 Output: ""
 Explanation: Both 'a's from t must be included in the window.
 Since the largest window of s only has one 'a', return empty string.
  

 Constraints:

 m == s.length
 n == t.length
 1 <= m, n <= 10^5
 s and t consist of uppercase and lowercase English letters.
  

 Follow up: Could you find an algorithm that runs in O(m + n) time?
 */

/*
 finding the minimum window substring in
𝑂
(
𝑚
+
𝑛
)
O(m+n) time, you can use the sliding window technique combined with a hash map to count characters. Here is the detailed algorithm:

Initialize Data Structures:

Use two hash maps:
tFreq to store the frequency of each character in t.
windowFreq to store the frequency of characters in the current window of s.
Use two pointers, left and right, to represent the current window in s.
Keep track of the number of characters in the current window that match the frequency of characters in t using a variable formed.
required will store the number of unique characters in t that must be present in the window with the required frequency.
Variables minLen and minWindow to store the length and position of the smallest window found.
Expand and Contract the Window:

Move the right pointer to expand the window until it contains all characters of t with the required frequency.
Once a valid window is found, move the left pointer to try to reduce the window size while still maintaining all required characters.
Check and Update:

Update minLen and minWindow whenever a smaller valid window is found.
 
 */
import Foundation

import Foundation

func minWindow(_ s: String, _ t: String) -> String {
    if t.isEmpty || s.isEmpty {
        return ""
    }
    
    var tFreq = [Character: Int]()
    for char in t {
        tFreq[char, default: 0] += 1
    }
    print("tfreq: \(tFreq)")
    var windowFreq = [Character: Int]()
    var left = s.startIndex
    var right = s.startIndex
    var formed = 0
    let required = tFreq.count
    var minLen = Int.max
    var minWindow: String = ""
    
    while right < s.endIndex {
        print("--------------")
        let char = s[right]
        windowFreq[char, default: 0] += 1
        print("windowFreq: \(windowFreq)")
        
        if let tCount = tFreq[char], windowFreq[char] == tCount {
            formed += 1
            print("formed: \(formed)")
        }
        
        while left <= right && formed == required {
            print("****************")
//            print("left: \(left)")
//            print("right: \(right)")
            let start = s.distance(from: s.startIndex, to: left)
            let end = s.distance(from: s.startIndex, to: right)
            let windowLen = end - start + 1
            
            if windowLen < minLen {
                minLen = windowLen
                minWindow = String(s[left...right])
                print("minWindow: \(minWindow)")
            }
            print("windowFreq1: \(windowFreq)")
            let leftChar = s[left]
            print("leftChar: \(leftChar)")
            windowFreq[leftChar]! -= 1
            print("windowFreq2: \(windowFreq)")
            if let tCount = tFreq[leftChar], windowFreq[leftChar]! < tCount {
                formed -= 1
                print("formed1: \(formed)")

            }
            
            left = s.index(after: left)
        }
        
        right = s.index(after: right)
    }
    
    return minWindow
}

// Example Usage
let s = "ADOBECODEBANC"
let t = "ABC"
print(minWindow(s, t))  // Output: "BANC"

