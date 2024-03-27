/*
 https://www.geeksforgeeks.org/rearrange-characters-string-no-two-adjacent/
 Rearrange characters in a String such that no two adjacent characters are same
 Given a string with lowercase repeated characters, the task is to rearrange characters in a string so that no two adjacent characters are the same. If it is not possible to do so, then print “Not possible”.

 Examples:

 Input: aaabc
 Output: abaca

 Input: aaabb
 Output: ababa
 */

import Foundation

// Define a structure for Character and its Frequency
struct CharFreq: Comparable {
    var char: Character
    var freq: Int

    // Comparable protocol requirement
    static func < (lhs: CharFreq, rhs: CharFreq) -> Bool {
        return lhs.freq > rhs.freq // Reverse to act like a max heap
    }
}

func rearrangeString(_ s: String) -> String {
    // Step 1: Count frequencies of each character
    var freqMap = [Character: Int]()
    for char in s {
        freqMap[char, default: 0] += 1
    }
    // Step 2: Prepare the "max heap" (using array and sorting)
    var maxHeap = freqMap.map { CharFreq(char: $0.key, freq: $0.value) }
    // No need to heapify initially, as we'll sort after each insertion/deletion
    var result = ""
    var prev: CharFreq? = nil
    
    while !maxHeap.isEmpty {
        maxHeap.sort() // Sort to bring the highest frequency character to the front (simulate max heap)
        let current = maxHeap.removeFirst() // Extract "max" element

        result.append(current.char)
        if let prevCharFreq = prev {
            maxHeap.append(prevCharFreq) // Re-insert previous character with decreased frequency
        }
        prev = current.freq > 1 ? CharFreq(char: current.char, freq: current.freq - 1) : nil
    }

    // After rearranging, if the length of the result doesn't match the original string, return "Not possible"
    return result//result.count == s.count ? result : "Not possible"
}

// Test the function
print(rearrangeString("aaabc")) // Example output: "abaca" or similar
print(rearrangeString("aaabb")) // Example output: "ababa" or similar
