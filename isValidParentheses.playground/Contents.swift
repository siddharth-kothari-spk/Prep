/*
 5. Valid Parentheses:
     * Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
     * Example: "()[]{}" is valid, but "([)]" is not.
 */

func isValidParentheses(_ s: String) -> Bool {
    var stack: [Character] = []

    for char in s {
        if "({[".contains(char) {
            stack.append(char)
        } else if let last = stack.last, isValidPair(last, char) {
            stack.removeLast()
        } else {
            return false
        }
    }

    return stack.isEmpty
}

func isValidPair(_ left: Character, _ right: Character) -> Bool {
    return (left == "(" && right == ")") ||
           (left == "{" && right == "}") ||
           (left == "[" && right == "]")
}

// Example usage:
let isValid = isValidParentheses("(()[]{})")
print(isValid)
