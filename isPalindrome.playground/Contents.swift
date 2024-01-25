/*
 3. Check Palindrome String:
     * Write a function to check if a given string is a palindrome (reads the same backward as forward).
     * Example: "level" is a palindrome.
 */

func isPalindrome(_ str: String) -> Bool {
    let cleanedString = str.lowercased().filter { $0.isLetter }
    if str.count != cleanedString.count {
        return false
    }
    return cleanedString == String(cleanedString.reversed())
}

// Example usage:
let isPalindromeResult = isPalindrome("le vel1")
print(isPalindromeResult)

