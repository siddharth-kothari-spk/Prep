func lengthOfLIS(_ nums: [Int]) -> Int {
  let n = nums.count
  var dp = Array(repeating: 1, count: n) // dp array to store LIS lengths

  for i in 1..<n {
    for j in 0..<i {
      if nums[i] > nums[j] {
        dp[i] = max(dp[i], dp[j] + 1) // Update dp[i] with max(current value, previous LIS + 1)
      }
    }
  }
  print(dp)
  return dp.max()! // Return the maximum value in the dp array (represents the longest LIS)
}

print(lengthOfLIS([1, 9, 3, 10, 4, 20, 2]))
print(lengthOfLIS([36, 41, 56, 35, 44, 33, 34, 92, 43, 32, 42]))
print(lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]))
