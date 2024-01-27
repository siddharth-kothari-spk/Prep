/*
 8. Remove Duplicates from String:
     * Given a string, remove the duplicate characters and return the modified string.
     * Example: "programming" should become "progamin".
 */

func removeDuplicates(_ str: String) -> String {
    var uniqueChars: Set<Character> = []
    return str.filter { uniqueChars.insert($0).inserted }
}

// Example usage:
let stringWithoutDuplicates = removeDuplicates("kotharikothari")
print(stringWithoutDuplicates)
