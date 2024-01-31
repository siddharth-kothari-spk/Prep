/*
 Find the Index of the First Occurrence in a String
 
 Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

  

 Example 1:

 Input: haystack = "sadbutsad", needle = "sad"
 Output: 0
 Explanation: "sad" occurs at index 0 and 6.
 The first occurrence is at index 0, so we return 0.
 Example 2:

 Input: haystack = "leetcode", needle = "leeto"
 Output: -1
 Explanation: "leeto" did not occur in "leetcode", so we return -1.
  

 Constraints:

 1 <= haystack.length, needle.length <= 104
 haystack and needle consist of only lowercase English characters.
 */


// Solution: https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/solutions/1656830/accepted-solution-for-swift
import Foundation
func indexOfFirstOccurence(_ haystack: String, _ needle: String) -> Int {
    guard let range = haystack.range(of: needle) else { return -1 }
    //print(range)
    //print(range.lowerBound.utf16Offset(in: needle))
    return haystack.distance(from: haystack.startIndex, to: range.lowerBound)
}

print(indexOfFirstOccurence("sadbutsad", "sad"))
//print(strStr("test", "sad"))


