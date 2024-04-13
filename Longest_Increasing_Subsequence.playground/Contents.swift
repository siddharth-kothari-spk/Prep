func lengthOfLIS(_ nums: [Int]) -> Int {
  let n = nums.count
  var dp = Array(repeating: 1, count: n) // dp array to store LIS lengths

  for i in 1..<n {
      print("***********")
      print("index: \(i), num: \(nums[i]) ")
    for j in 0..<i {
        print("-----------")
        print("indexj: \(j), num: \(nums[j])")
      if nums[i] > nums[j] {
        dp[i] = max(dp[i], dp[j] + 1) // Update dp[i] with max(current value, previous LIS + 1)
          print(dp)
      }
    }
  }
  return dp.max()! // Return the maximum value in the dp array (represents the longest LIS)
}

//print(lengthOfLIS([1, 9, 3, 10, 4, 20, 2]))
//print(lengthOfLIS([36, 41, 56, 35, 44, 33, 34, 92, 43, 32, 42]))
print(lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]))

/*
 ***********
 index: 1, num: 9
 -----------
 indexj: 0, num: 10
 ***********
 index: 2, num: 2
 -----------
 indexj: 0, num: 10
 -----------
 indexj: 1, num: 9
 ***********
 index: 3, num: 5
 -----------
 indexj: 0, num: 10
 -----------
 indexj: 1, num: 9
 -----------
 indexj: 2, num: 2
 [1, 1, 1, 2, 1, 1, 1, 1]
 ***********
 index: 4, num: 3
 -----------
 indexj: 0, num: 10
 -----------
 indexj: 1, num: 9
 -----------
 indexj: 2, num: 2
 [1, 1, 1, 2, 2, 1, 1, 1]
 -----------
 indexj: 3, num: 5
 ***********
 index: 5, num: 7
 -----------
 indexj: 0, num: 10
 -----------
 indexj: 1, num: 9
 -----------
 indexj: 2, num: 2
 [1, 1, 1, 2, 2, 2, 1, 1]
 -----------
 indexj: 3, num: 5
 [1, 1, 1, 2, 2, 3, 1, 1]
 -----------
 indexj: 4, num: 3
 [1, 1, 1, 2, 2, 3, 1, 1]
 ***********
 index: 6, num: 101
 -----------
 indexj: 0, num: 10
 [1, 1, 1, 2, 2, 3, 2, 1]
 -----------
 indexj: 1, num: 9
 [1, 1, 1, 2, 2, 3, 2, 1]
 -----------
 indexj: 2, num: 2
 [1, 1, 1, 2, 2, 3, 2, 1]
 -----------
 indexj: 3, num: 5
 [1, 1, 1, 2, 2, 3, 3, 1]
 -----------
 indexj: 4, num: 3
 [1, 1, 1, 2, 2, 3, 3, 1]
 -----------
 indexj: 5, num: 7
 [1, 1, 1, 2, 2, 3, 4, 1]
 ***********
 index: 7, num: 18
 -----------
 indexj: 0, num: 10
 [1, 1, 1, 2, 2, 3, 4, 2]
 -----------
 indexj: 1, num: 9
 [1, 1, 1, 2, 2, 3, 4, 2]
 -----------
 indexj: 2, num: 2
 [1, 1, 1, 2, 2, 3, 4, 2]
 -----------
 indexj: 3, num: 5
 [1, 1, 1, 2, 2, 3, 4, 3]
 -----------
 indexj: 4, num: 3
 [1, 1, 1, 2, 2, 3, 4, 3]
 -----------
 indexj: 5, num: 7
 [1, 1, 1, 2, 2, 3, 4, 4]
 -----------
 indexj: 6, num: 101
 4
 */
