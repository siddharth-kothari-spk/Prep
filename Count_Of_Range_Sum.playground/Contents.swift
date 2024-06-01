/*
 https://leetcode.com/problems/count-of-range-sum/description/
 Given an integer array nums and two integers lower and upper, return the number of range sums that lie in [lower, upper] inclusive.

 Range sum S(i, j) is defined as the sum of the elements in nums between indices i and j inclusive, where i <= j.

  

 Example 1:

 Input: nums = [-2,5,-1], lower = -2, upper = 2
 Output: 3
 Explanation: The three ranges are: [0,0], [2,2], and [0,2] and their respective sums are: -2, -1, 2.
 Example 2:

 Input: nums = [0], lower = 0, upper = 0
 Output: 1
  

 Constraints:

 1 <= nums.length <= 10^5
 -231 <= nums[i] <= 231 - 1
 -10^5 <= lower <= upper <= 10^5
 The answer is guaranteed to fit in a 32-bit integer.
 */

/*
 Algo:
 To solve the problem of counting range sums that lie within a given range
 [lower, upper]
 [lower,upper], we can use a sophisticated approach involving prefix sums and a modified merge sort. The key insight is that we can leverage the merge sort algorithm to efficiently count the number of valid range sums while sorting the prefix sums. Here's the detailed algorithm:

 Prefix Sums Calculation:

 Calculate the prefix sums for the array. The prefix sum array prefix_sums allows us to compute the sum of any subarray
 [
 𝑖
 ,
 𝑗
 ]
 [i,j] as
 prefix_sums
 [
 𝑗
 +
 1
 ]
 −
 prefix_sums
 [
 𝑖
 ]
 prefix_sums[j+1]−prefix_sums[i].
 Using Merge Sort for Counting:

 We use a modified merge sort to count the number of valid range sums while sorting the prefix sums. During the merge step, for each prefix sum, we count how many of the previous prefix sums (in the sorted order) form a valid range sum when subtracted from the current prefix sum.
 Detailed Steps:

 Initialize the prefix sums array with an extra initial value of 0.
 Define a recursive function to perform merge sort and count the valid range sums.
 Within the merge step of the merge sort, for each prefix sum, use a two-pointer technique to count the number of valid prefix sums that form a valid range sum when subtracted from the current prefix sum.

 */

class Solution {
    func countRangeSum(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        func mergeSort(_ lo: Int, _ hi: Int) -> Int {
            if lo == hi {
                return 0
            }
            let mid = (lo + hi) / 2
            var count = mergeSort(lo, mid) + mergeSort(mid + 1, hi)
            var i = mid + 1
            var j = mid + 1
            var k = mid + 1
            var temp: [Int] = []

            for left in lo...mid {
                while i <= hi && prefixSums[i] - prefixSums[left] < lower {
                    i += 1
                }
                while j <= hi && prefixSums[j] - prefixSums[left] <= upper {
                    j += 1
                }
                while k <= hi && prefixSums[k] < prefixSums[left] {
                    temp.append(prefixSums[k])
                    k += 1
                }
                temp.append(prefixSums[left])
                count += j - i
            }

            while k <= hi {
                temp.append(prefixSums[k])
                k += 1
            }

            for idx in 0..<temp.count {
                prefixSums[lo + idx] = temp[idx]
            }

            return count
        }

        var prefixSums: [Int] = [0]
        for num in nums {
            prefixSums.append(prefixSums.last! + num)
        }

        return mergeSort(0, prefixSums.count - 1)
    }
}

// Example usage:
let solution = Solution()
let nums = [-2, 5, -1]
let lower = -2
let upper = 2
print(solution.countRangeSum(nums, lower, upper))  // Output: 3

/*
 Let's do a dry run of the Swift implementation for the given input:

 swift
 Copy code
 let nums = [-2, 5, -1]
 let lower = -2
 let upper = 2
 Step-by-Step Execution:
 Prefix Sum Calculation:

 Initialize prefixSums with [0].
 For num = -2, update prefixSums to [0, -2].
 For num = 5, update prefixSums to [0, -2, 3].
 For num = -1, update prefixSums to [0, -2, 3, 2].
 Final prefixSums array: [0, -2, 3, 2].
 Merge Sort with Counting:

 Call mergeSort(0, 3).
 First Level of Recursion:

 mergeSort(0, 1):

 mergeSort(0, 0): Returns 0 (base case).
 mergeSort(1, 1): Returns 0 (base case).
 Merge step:
 Left half: [-2] (from prefixSums[0] to prefixSums[1]).
 Right half: [0] (from prefixSums[1] to prefixSums[1]).
 Compare -2 and 0:
 While merging:
 prefixSums[i] - prefixSums[lo] < lower:
 i moves from 1 to 2 (no increment as -2 - (-2) = 0 which is not < -2).
 prefixSums[j] - prefixSums[lo] <= upper:
 j moves from 1 to 2 (no increment as -2 - (-2) = 0 which is <= 2).
 prefixSums[k] < prefixSums[lo]:
 k remains 1.
 count becomes 1 - 1 = 0.
 Append -2 to temp, temp = [-2].
 Append 0 to temp, temp = [-2, 0].
 Update prefixSums[0...1] to [-2, 0].
 Returns 0.
 mergeSort(2, 3):

 mergeSort(2, 2): Returns 0 (base case).
 mergeSort(3, 3): Returns 0 (base case).
 Merge step:
 Left half: [3] (from prefixSums[2] to prefixSums[3]).
 Right half: [2] (from prefixSums[3] to prefixSums[3]).
 Compare 3 and 2:
 While merging:
 prefixSums[i] - prefixSums[lo] < lower:
 i moves from 3 to 4 (no increment as 2 - 3 = -1 which is not < -2).
 prefixSums[j] - prefixSums[lo] <= upper:
 j moves from 3 to 4 (increment as 2 - 3 = -1 which is <= 2).
 prefixSums[k] < prefixSums[lo]:
 k moves from 3 to 4.
 count becomes 1 - 1 = 0.
 Append 2 to temp, temp = [2].
 Append 3 to temp, temp = [2, 3].
 Update prefixSums[2...3] to [2, 3].
 Returns 0.
 Merge step for mergeSort(0, 3):

 Left half: [-2, 0] (from prefixSums[0] to prefixSums[1]).
 Right half: [2, 3] (from prefixSums[2] to prefixSums[3]).
 Compare -2, 0 with 2, 3:
 For prefixSums[0] = -2:
 While merging:
 prefixSums[i] - prefixSums[0] < lower:
 i moves from 2 to 2.
 prefixSums[j] - prefixSums[0] <= upper:
 j moves from 2 to 4 (increment as 2 - (-2) = 4 and 3 - (-2) = 5 both are <= 2).
 prefixSums[k] < prefixSums[lo]:
 k remains 2.
 count becomes 4 - 2 = 2.
 Append -2 to temp, temp = [-2].
 For prefixSums[1] = 0:
 While merging:
 prefixSums[i] - prefixSums[1] < lower:
 i moves from 2 to 2.
 prefixSums[j] - prefixSums[1] <= upper:
 j moves from 2 to 4 (increment as 2 - 0 = 2 and 3 - 0 = 3 both are <= 2).
 prefixSums[k] < prefixSums[1]:
 k moves from 2 to 4.
 count becomes 4 - 2 = 2.
 Append 0 to temp, temp = [-2, 0].
 Append 2, 3 to temp, temp = [-2, 0, 2, 3].
 Update prefixSums[0...3] to [-2, 0, 2, 3].
 Returns 3.
 Final Result:

 The countRangeSum function returns 3, indicating there are 3 range sums within the range [-2, 2].
 Summary:
 The range sums within the given bounds are:

 Subarray [0, 0] with sum -2
 Subarray [2, 2] with sum -1
 Subarray [0, 2] with sum 2
 Thus, the output is 3.
 */
