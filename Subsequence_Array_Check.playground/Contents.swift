/*
 Given two non-empty arrays of integers, write a function that determines whether the second array is a subsequence of the first one.
 A subsequence of an array is a set of numbers that aren't necessarily adjacent in the array but that are in the same order as they appear in the array. For instance, the numbers [1, 3, 4] form a subsequence of the array [1, 2, 3, 4], and so do the numbers [2, 4] - Note that a single number in an array and the array itself are both valid subsequences of the array.
 
 Sample Input:
 array = [15, 1, 22, 25, 6, -1, 8, 10]
 sequence = [1, 6, -1, 10]
 
 Sample Output:
 true
 */

// Solution 1

func subsequenceCheck(_ parent: [Int], _ subseq: [Int]) -> Bool {
    
    var result = true
    
    // 1. elemenst preent in parentArr
    
    for num in subseq {
        if !parent.contains(num) {
            return false
        }
    }
    
    var index = 0
    
    for num in subseq {
        for (i, value) in parent.enumerated() {
            if value == num {
                if i < index {
                    return false
                }
                index = i
            }
        }
    }
    
//    let filterArr = parent.filter { num in
//        subseq.contains(num)
//    }
//    print(filterArr)
//    return subseq == filterArr
    
    
    return true
}

subsequenceCheck([15, 1, 22, 25, 6, -1, 8, 10], [1, 6, -1, 10])
subsequenceCheck([15, 1, 22, 25, 6, -1, 8, 10], [-1, 6, -1, 10])

// Solution 2

func isSubsequence(_ array: [Int], _ sequence: [Int]) -> Bool {
    var arrayIndex = 0
    var sequenceIndex = 0
    
    while arrayIndex < array.count && sequenceIndex < sequence.count {
        if array[arrayIndex] == sequence[sequenceIndex] {
            sequenceIndex += 1
        }
        arrayIndex += 1
    }
    
    return sequenceIndex == sequence.count
}

// Test the function
let array = [15, 1, 22, 25, 6, -1, 8, 10]
let sequence = [1, 6, -1, 10]
print(isSubsequence(array, sequence))
