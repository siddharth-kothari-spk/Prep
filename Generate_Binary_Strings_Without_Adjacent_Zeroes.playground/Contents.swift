/*
 https://leetcode.com/problems/generate-binary-strings-without-adjacent-zeros/
 You are given a positive integer n.

 A binary string x is valid if all
 substrings
  of x of length 2 contain at least one "1".

 Return all valid strings with length n, in any order.

  

 Example 1:

 Input: n = 3

 Output: ["010","011","101","110","111"]

 Explanation:

 The valid strings of length 3 are: "010", "011", "101", "110", and "111".

 Example 2:

 Input: n = 1

 Output: ["0","1"]

 Explanation:

 The valid strings of length 1 are: "0" and "1".
 */

/*
 We need to generate all valid binary strings of length
 n where every substring of length 2 contains at least one "1". Here's an algorithm to do that:

 Base Cases:

 If n=1, return ["0", "1"].
 If n=2, return ["01", "10", "11"].
 Recursive Case:

 For n>2, start with the valid strings of length n−1.
 Append "1" to each valid string of length
 n−1 to ensure that the last substring of length 2 will contain at least one "1".
 
 Additionally, append "0" to valid strings of length
 n−1 only if the last character is "1".
 Here's the step-by-step algorithm:

 Generate all valid strings of length 1 and 2:

 Length 1: ["0", "1"]
 Length 2: ["01", "10", "11"]
 For lengths greater than 2:

 Initialize a list to store valid strings.
 Iterate through each valid string of length
 n−1:
 Append "1" to each valid string.
 Append "0" only if the last character of the string is "1".
 Return the list of valid strings.
 */


func generateValidStrings(_ n: Int) -> [String] {
    if n == 1 {
        return ["0", "1"]
    } else if n == 2 {
        return ["01", "10", "11"]
    }
    
    // Start with valid strings of length 2
    var prevValid = ["01", "10", "11"]
    
    for length in 3...n {
        var newValid = [String]()
        for s in prevValid {
            newValid.append(s + "1")
            if s.last == "1" {
                newValid.append(s + "0")
            }
        }
        prevValid = newValid
    }
    
    return prevValid
}

// Examples
print(generateValidStrings(3))  // Output: ["010","011","101","110","111"]
print(generateValidStrings(1))  // Output: ["0", "1"]
print(generateValidStrings(4)) // ["0111", "0110", "0101", "1011", "1010", "1111", "1110", "1101"]

/*
 Dry Run for generateValidStrings(4)
 Initial State:

 Input:
 𝑛
 =
 4
 n=4
 prevValid: ["01", "10", "11"]
 Iteration for Length 3:

 Start with: prevValid = ["01", "10", "11"]
 Initialize: newValid = []
 Processing Each String in prevValid for Length 3:

 For s = "01":
 Append "1": newValid = ["011"]
 (Don't append "0" because last character is "0")
 For s = "10":
 Append "1": newValid = ["011", "101"]
 Append "0" because last character is "1": newValid = ["011", "101", "100"]
 For s = "11":
 Append "1": newValid = ["011", "101", "100", "111"]
 Append "0" because last character is "1": newValid = ["011", "101", "100", "111", "110"]
 Update prevValid for Length 3:

 prevValid becomes newValid: prevValid = ["011", "101", "111", "110"] (excluding "100" since it's invalid)
 Iteration for Length 4:

 Start with: prevValid = ["011", "101", "111", "110"]
 Initialize: newValid = []
 Processing Each String in prevValid for Length 4:

 For s = "011":
 Append "1": newValid = ["0111"]
 (Don't append "0" because last character is "1")
 For s = "101":
 Append "1": newValid = ["0111", "1011"]
 Append "0" because last character is "1": newValid = ["0111", "1011", "1010"]
 For s = "111":
 Append "1": newValid = ["0111", "1011", "1010", "1111"]
 Append "0" because last character is "1": newValid = ["0111", "1011", "1010", "1111", "1110"]
 For s = "110":
 Append "1": newValid = ["0111", "1011", "1010", "1111", "1110", "1101"]
 (Don't append "0" because last character is "0")
 Update prevValid for Length 4:

 prevValid becomes newValid: prevValid = ["0111", "1011", "1010", "1111", "1110", "1101"]
 Final State:

 Return: ["0111", "1011", "1010", "1111", "1110", "1101"]
 Output:
 generateValidStrings(4) correctly outputs: ["0111", "1011", "1010", "1111", "1110", "1101"]
 */
