/*
 7. Check Anagrams:
     * Write a function to check if two strings are anagrams of each other.
     * Example: "listen" and "silent" are anagrams.
 */

func areAnagrams(_ s1: String, _ s2: String) -> Bool {
    return s1.sorted() == s2.sorted()
}

// Example usage:
let areAnagramsResult = areAnagrams("listne", "silent")
print(areAnagramsResult)
