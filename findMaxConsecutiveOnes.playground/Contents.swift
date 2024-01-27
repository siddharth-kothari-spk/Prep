/*
 10. Find Maximum Consecutive Ones:
 * Given a binary string (a string consisting of only '0' and '1'), find the maximum number of consecutive '1' characters.
 * Example: "1101111001" should return 3 (for the consecutive '1's between the 5th and 7th positions).
 */

func findMaxConsecutiveOnes(_ s: String) -> Int {
    var maxCount = 0
    var currentCount = 0

    for char in s {
        if char == "1" {
            currentCount += 1
            maxCount = max(maxCount, currentCount)
        } else {
            currentCount = 0
        }
    }

    return maxCount
}

// Example usage:
let maxConsecutiveOnes = findMaxConsecutiveOnes("11011110011111")
print(maxConsecutiveOnes)
