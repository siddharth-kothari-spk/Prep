/*
 9. Valid Number:
     * Implement a function to check if a given string represents a valid number.
     * Example: "3.14" and "-123" are valid numbers, but "abc" and "1a" are not.
 */

func isValidNumber(_ str: String) -> Bool {
    return Double(str) != nil
}

// Example usage:
let isNumber = isValidNumber("3. 14")
print(isNumber)
