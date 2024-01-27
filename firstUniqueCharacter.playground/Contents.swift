/*
 6. Find First Non-Repeating Character:
     * Given a string, find the first non-repeating character and return its index.
     * Example: "leetcode" should return 0 (since 'l' is the first non-repeating character).
 */

func firstUniqueCharacter(_ s: String) -> Int {
    var charCount: [Character: Int] = [:]

    for char in s {
        charCount[char, default: 0] += 1
    }

    for (index, char) in s.enumerated() {
        if charCount[char] == 1 {
            return index
        }
    }

    return -1
}

// Example usage:
let firstNonRepeating = firstUniqueCharacter("eetcodelt")
print(firstNonRepeating)
