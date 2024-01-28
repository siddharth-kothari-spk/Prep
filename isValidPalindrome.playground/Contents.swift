/*
 Valid Palindrome:

     Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
     Example: "A man, a plan, a canal: Panama" is a valid palindrome.
 */

func isValidPalindrome(_ s: String) -> Bool {
    let cleanedString = s.lowercased().filter { $0.isLetter || $0.isNumber }
    return cleanedString == String(cleanedString.reversed())
}

// Example usage:
print(isValidPalindrome("A man9, a plan, a canal: Pa9nama"))
