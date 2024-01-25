/*
 1. Count Digits in a String:
     * Given a string, write a function to count the number of digits in the string.
     * Example: "Hello123World" should return 3.
 */

func countDigits(_ str: String) -> Int {
    //return str.reduce(0) { $0 + ($1.isNumber ? 1 : 0) }
    return str.reduce(0) { partialResult, char1 in
        partialResult + (char1.isNumber ? 1 : 0)
    }
}

// Example usage:
let digitsCount = countDigits("Hello123World")
print(digitsCount)

let digitsCount2 = countDigits("13World8_9")
print(digitsCount2)
