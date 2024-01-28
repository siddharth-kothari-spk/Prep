/*
 Longest Common Prefix:

     Write a function to find the longest common prefix string amongst an array of strings.
     Example: ["flower", "flow", "flight"] should return "fl".
 
 Here's the breakdown of the algorithm:

     The function starts by checking if the array strs is empty. If it is, an empty string is returned since there is no common prefix.
     It then initializes the firstStr variable with the first string in the array.
     The function uses nested loops to compare characters at the same index in each string with the corresponding character in firstStr.
     If a character mismatch is found or if the index exceeds the length of a string, the function returns the common prefix found so far.
     If no mismatch is found, the loop continues until all strings in the array are considered.
     Finally, the common prefix found is returned.

 This algorithm is efficient, and its time complexity is primarily determined by the length of the shortest string in the array.
 */

func longestCommonPrefix(_ strs: [String]) -> String {
    guard let firstStr = strs.first else { return "" }

    for (i, char) in firstStr.enumerated() {
        for str in strs.dropFirst() {
            if i == str.count || str[str.index(str.startIndex, offsetBy: i)] != char {
                return String(firstStr.prefix(i))
            }
        }
    }

    return firstStr
}

// Example usage:
let commonPrefix = longestCommonPrefix(["flower", "flow", "flight"])
print(commonPrefix)
