/*
 You are given n balloons, indexed from 0 to n - 1. Each balloon is painted with a number on it represented by an array nums. You are asked to burst all the balloons.

 If you burst the ith balloon, you will get nums[i - 1] * nums[i] * nums[i + 1] coins. If i - 1 or i + 1 goes out of bounds of the array, then treat it as if there is a balloon with a 1 painted on it.

 Return the maximum coins you can collect by bursting the balloons wisely.

  

 Example 1:

 Input: nums = [3,1,5,8]
 Output: 167
 Explanation:
 nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
 coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167
 Example 2:

 Input: nums = [1,5]
 Output: 10
  
 */

// Sol: https://leetcode.com/problems/burst-balloons/solutions/892552/for-those-who-are-not-able-to-understand-any-solution-with-diagram

func maxCoins(_ nums: [Int]) -> Int {
    let n = nums.count
    var nums = [1] + nums + [1] // Add imaginary balloons at both ends
    var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 2), count: n + 2) // Initialize dp array
print("loop1---------")
    for length in stride(from: 1, through: n, by: 1) { // Length of subarray
        print("loop2------------")
        print("length: \(length)")
        for start in stride(from: 1, through: n - length + 1, by: 1) { // Start index of subarray
            print("start: \(start)")
            let end = start + length - 1 // End index of subarray
            print("end: \(end)")
            for k in stride(from: start, through: end, by: 1) { // Last balloon to burst
                print("loop3-------------")
                print("k: \(k)")
                let coins = nums[start - 1] * nums[k] * nums[end + 1]
                print("coins: \(coins)")
                print(dp)
                dp[start][end] = max(dp[start][end], dp[start][k - 1] + dp[k + 1][end] + coins)
                print(dp)
            }
        }
    }

    return dp[1][n] // Maximum coins obtained by bursting all balloons
}

// Test cases
//print(maxCoins([3, 1, 5, 8])) // Output: 167
print(maxCoins([1, 5])) // Output: 10


