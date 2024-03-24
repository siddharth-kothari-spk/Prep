/*
 https://www.geeksforgeeks.org/length-of-the-longest-valid-substring/
 
 Length of the longest valid substring
 Given a string consisting of opening and closing parenthesis, find the length of the longest valid parenthesis substring.

 Examples:

 Input: ((()
 Output : 2
 Explanation : ()
 Input: )()())
 Output : 4
 Explanation: ()()
 Input:  ()(()))))
 Output: 6
 Explanation:  ()(())
 
 */

/*
 Algorithm

     Initialize: Create a stack to store the indices of the characters and push -1 onto the stack to serve as a base for the next valid substring.
     Iterate: Loop through the string, for each character:
         If the character is '(', push its index onto the stack.
         If the character is ')':
             Pop the top element from the stack. This represents the start of a potentially valid substring.
             If the stack becomes empty after popping, push the current index onto the stack. This means there was no matching opening '(' for this ')', and the next potential valid substring starts after this index.
             If the stack is not empty, calculate the length of the current valid substring by subtracting the current index by the top element of the stack. If this length is greater than the current longest length, update the longest length.
     Return: After iterating through the string, return the longest length found.
 */
import Foundation

func longestValidParentheses(_ s: String) -> Int {
    var maxLen = 0
    var stack: [Int] = [-1]  // Initialize stack with base value
    let chars = Array(s)     // Convert string to character array for easier indexing

    for (i, char) in chars.enumerated() {
        print("*****")
        print("stack: \(stack)")
        print("i: \(i), char: \(char)")
        if char == "(" {
            stack.append(i)  // Push the index of '(' onto the stack
        } else {
            print("before pop: \(stack)")
            _ = stack.popLast()  // Pop the matching '(' index
            print("after pop: \(stack)")

            if stack.isEmpty {
                stack.append(i)  // No matching '(', reset base for next valid substring
                print(" if stack empty: \(stack)")
            } else {
                // Calculate length of current valid substring
                print("i: \(i), stack.last!: \(stack.last!)")
                let currentLen = i - stack.last!
                // Update maxLen if currentLen is greater
                print("maxLen: \(maxLen), currentLen: \(currentLen)")
                maxLen = max(maxLen, currentLen)
            }
        }
    }
    return maxLen
}

// Example usage
var s =  "()(()))))" // 6
//print(longestValidParentheses(s))

s = "(()))())(" // 4
print(longestValidParentheses(s))

s = "((()" // 2
//print(longestValidParentheses(s))
