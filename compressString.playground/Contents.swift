/*
 4. String Compression:
     * Implement a function to perform basic string compression using the counts of repeated characters.
     * Example: "aabcccccaaa" should become "a2b1c5a3".
 */

func compressString(_ str: String) -> String {
    var result = ""
    var count = 1

    for i in 0..<str.count {
        let currentChar = str[str.index(str.startIndex, offsetBy: i)]
        let nextChar = (i + 1 < str.count) ? str[str.index(str.startIndex, offsetBy: i + 1)] : nil

        if currentChar == nextChar {
            count += 1
        } else {
            result.append("\(currentChar)\(count)")
            count = 1
        }
    }

    return result.count < str.count ? result : str
}

// Example usage:
let compressedString = compressString("aabcccccaaa!")
print(compressedString)
