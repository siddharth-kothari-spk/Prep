/*
 https://www.geeksforgeeks.org/largest-subarray-with-equal-number-of-0s-and-1s/
 Given an array containing only 0s and 1s, find the largest subarray which contains equal no of 0s and 1s. The expected time complexity is O(n).

 Examples:

 Input: arr[] = {1, 0, 1, 1, 1, 0, 0}
 Output: 1 to 6
 (Starting and Ending indexes of output subarray)

 Input: arr[] = {1, 1, 1, 1}
 Output: No such subarray

 Input: arr[] = {0, 0, 1, 1, 0}
 Output: 0 to 3 Or 1 to 4
 */

/*
 This code is a Swift function designed to solve a specific problem related to arrays of integers. The goal is to find the length of the longest contiguous subarray with an equal number of 0s and 1s. Here’s a breakdown of how the logic in the code works:

 1. **Initialization**:
     - `maxLen` keeps track of the maximum length of a subarray that satisfies the condition (equal numbers of 0s and 1s).
     - `count` is used as a balance tracker between the numbers of 0s and 1s encountered so far as we iterate through the array. A 0 decreases the count by 1, and a 1 increases it by 1.
     - `hashMap` (a dictionary in Swift) is used to remember the first index at which every `count` value is seen. The key is the `count` value, and the value is the index at which this `count` was first observed. It's initialized with a special entry where the key `0` is mapped to `-1` to handle cases where a valid subarray starts from the beginning of the input array.

 2. **Iterating through the array**:
     - The function iterates through each element of the array with its index. For each element, it updates the `count` based on whether the element is a 0 or a 1.
     - After updating the `count`, it checks if this updated count value has been seen before:
         - If yes (`if let prevIndex = hashMap[count]`), it means we've found a subarray (from `prevIndex + 1` to the current `index`) where the number of 0s and 1s are equal. This is because the `count` being the same at two different indexes implies that the number of 0s and 1s added in between these indexes must be equal (each pair of 1 and 0 cancels out). The length of this subarray is `index - prevIndex`, and we update `maxLen` if this subarray is longer than any previously found subarray.
         - If no, it stores the current index in `hashMap` against the current `count` value. This marks the first time this particular balance (difference between the number of 1s and 0s) has been seen.

 3. **Finding the Maximum Length**:
     - Throughout the iteration, `maxLen` is updated whenever a longer subarray fulfilling the condition is found. Once the entire array has been processed, `maxLen` contains the length of the longest subarray with equal numbers of 0s and 1s.

 4. **Return Value**:
     - Finally, the function returns `maxLen`, which is the answer to the problem.

 This approach efficiently solves the problem with a single pass through the input array and uses a hashmap to track the indices of cumulative counts, allowing for a quick calculation of subarray lengths that satisfy the given condition.
 */
func findMaxLength(_ nums: [Int]) -> Int {
    var maxLen = 0
    var count = 0
    var hashMap = [Int: Int]()
    hashMap[0] = -1

    for (index, num) in nums.enumerated() {
        if num == 0 {
            count -= 1
        } else {
            count += 1
        }

        if let prevIndex = hashMap[count] {
            maxLen = max(maxLen, index - prevIndex)
        } else {
            hashMap[count] = index
        }
        print(hashMap)
    }

    return maxLen
}

// Example usage:
let nums = [1, 0, 1, 1, 1, 0, 0]
print("Length of the largest subarray with equal number of 0s and 1s: \(findMaxLength(nums))")
