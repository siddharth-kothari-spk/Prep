/*
 Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.

 You must write an algorithm that runs in O(n) time.

  

 Example 1:

 Input: nums = [100,4,200,1,3,2]
 Output: 4
 Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
 Example 2:

 Input: nums = [0,3,7,2,5,8,4,6,0,1]
 Output: 9

 */

/*
 Solution: https://leetcode.com/problems/longest-consecutive-sequence/solutions/3430669/simple-swift-o-n-solution-easy-to-understand
 
 To solve this problem, we can take the following approach:

 Convert the given array into a set. This reduces the time complexity of searching for elements in the array from O(n)O(n)O(n) to O(1)O(1)O(1).
 Initialize a variable longestStreak to 0, which will store the length of the longest consecutive sequence that we find.
 Iterate over the elements in the set.
 For each element, check if the set contains the previous integer num - 1. If it does not, then this num is the starting point of a consecutive sequence.
 Initialize two variables currentNum and currentStreak to the value of num and 1 respectively. currentStreak represents the length of the current consecutive sequence that we are examining.
 While the set contains the next integer currentNum + 1, increment currentNum and currentStreak.
 If the currentStreak is greater than the longestStreak, update the value of longestStreak to currentStreak.
 Repeat steps 4 to 7 for all elements in the set.
 Return the value of longestStreak.
 Complexity
 The time complexity of the given solution is O(n)O(n)O(n), where nnn is the number of elements in the input array.

 The space complexity of the given solution is O(n)O(n)O(n) where nnn is the number of elements in the input array.


 */

class Solution {
    func longestConsecutiveSequence(_ nums: [Int]) -> Int {
        let set = Set(nums)
        print("Set: \(set)")
        var longestStreak = 0

        for num in set {
            print("-------------")
            print("num = \(num)")
            if !set.contains(num - 1) {
                
                var currentNum = num
                var currentStreak = 1

                print("currentNum = \(currentNum)")
                print("currentStreak = \(currentStreak)")
                while set.contains(currentNum + 1) {
                    print("set2: \(set)")
                    currentNum += 1
                    currentStreak += 1
                    print("currentNum2 = \(currentNum)")
                    print("currentStreak2 = \(currentStreak)")
                }

                longestStreak = max(longestStreak, currentStreak)
                print("longestStreak = \(longestStreak)")
            }
        }

        return longestStreak
    }
}

let sol = Solution()
print(sol.longestConsecutiveSequence([100,4,200,1,3,2]))
