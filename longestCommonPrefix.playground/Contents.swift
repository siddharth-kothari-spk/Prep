/*
 Longest Common Prefix:

     Write a function to find the longest common prefix string amongst an array of strings.
     Example: ["flower", "flow", "flight"] should return "fl".
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
