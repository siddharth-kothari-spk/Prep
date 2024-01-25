func findLongestSubarrayBySum(_ targetSum: Int, _ nums: [Int]) -> [Int] {
    var start = 0
    var currentSum = 0
    var maxLength = 0
    var result: [Int] = []

    for end in 0..<nums.count {
        currentSum += nums[end]

        while currentSum > targetSum {
            currentSum -= nums[start]
            start += 1
        }

        if currentSum == targetSum && (result.isEmpty || end - start > maxLength) {
            maxLength = end - start
            result = [start + 1, end + 1]  // Adding 1 to indices to match the 1-based indexing
        }
    }

    return result.isEmpty ? [-1] : result
}

// Example usage
let target = 12
let nums = [1, 2, 3, 7, 5]
let result = findLongestSubarrayBySum(target, nums)
print(result)

