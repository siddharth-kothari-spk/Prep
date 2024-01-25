/*
  Reverse Words in a String:
     * Given a string containing words separated by spaces, reverse the order of words.
     * Example: "Hello World" should become "World Hello".
 */

import Foundation
func reverseWords(_ str: String) -> String {
    let words = str.components(separatedBy: " ")
    let reversedWords = words.reversed()
    return reversedWords.joined(separator: " ")
}

// Example usage:
let reversedString = reverseWords("Hello World")
print(reversedString)
