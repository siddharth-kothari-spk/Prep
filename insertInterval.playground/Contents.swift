/*
 Insert Interval
 You are given an array of non-overlapping intervals intervals where intervals[i] = [starti, endi] represent the start and the end of the ith interval and intervals is sorted in ascending order by starti. You are also given an interval newInterval = [start, end] that represents the start and end of another interval.

 Insert newInterval into intervals such that intervals is still sorted in ascending order by starti and intervals still does not have any overlapping intervals (merge overlapping intervals if necessary).

 Return intervals after the insertion.

  

 Example 1:

 Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
 Output: [[1,5],[6,9]]
 Example 2:

 Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
 Output: [[1,2],[3,10],[12,16]]
 Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
 */

// Solution: https://leetcode.com/problems/insert-interval/solutions/3253589/three-steps-to-merge-intervals

/*
 breakdown of the algorithm:

     Initialization:
         Initialize an empty array newIntervals to store the merged intervals.
         Initialize a variable new to represent the new interval.

     Iterate Through Existing Intervals:
         Iterate through the existing intervals using a while loop.
         For each interval, check if its end (intervals[i][1]) is less than the start of the new interval (new[0]). If so, add the current interval to newIntervals as it does not overlap with the new interval.
         Increment the index i.

     Merge Overlapping Intervals:
         While there are still intervals left to check and the start of the current interval (intervals[i][0]) is less than or equal to the end of the new interval (new[1]):
             Merge the current interval and the new interval using the merge method.
             Update the new interval with the merged result.
             Increment the index i.

     Insert Merged Interval:
         Add the merged interval (new) to the newIntervals array.

     Append Remaining Intervals:
         While there are still intervals left in the original list, append them to newIntervals.

     Return Result:
         Return the final array newIntervals.

     Merge Helper Method:
         The merge method takes two intervals (cur and new) and returns a merged interval with the minimum start and maximum end.

 Here's the provided code with comments:
 */
class Solution {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var newIntervals = [[Int]]()
        var new = newInterval
        var i = 0
        while (i < intervals.count && intervals[i][1] < new[0]) {
            newIntervals.append(intervals[i])
            i += 1
        }
        while (i < intervals.count && intervals[i][0] <= new[1]) {
            new = merge(intervals[i], new)
            i += 1
        }
        newIntervals.append(new)
        while (i < intervals.count){
            newIntervals.append(intervals[i])
            i += 1
        }
        return newIntervals
    }

    func merge(_ cur: [Int], _ new: [Int]) -> [Int]{
        return [min(cur[0], new[0]), max(cur[1], new[1])]
    }
}

let solution = Solution()
print(solution.insert([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8]))



// Solution: https://leetcode.com/problems/insert-interval/solutions/3056622/swift-functional-style
/*
 breakdown of the algorithm:

     Base Case Check:
         If intervals is empty, return an array containing only the newInterval.

     Reduce and Enumerate:
         Use the reduce function along with enumerated to iterate through each element (tuple) of the intervals array.
         Initialize the accumulator (data) with two properties: result (array of merged intervals) and newInt (the new interval to be merged).

     Check Intersection:
         For each tuple in intervals, check if the current interval intersects with the newInt.
         If there is an intersection, merge the intervals by updating newInt to contain the minimum start and maximum end.

     Process Non-intersecting Intervals:
         If the current interval does not intersect with newInt, check if it comes after newInt. If so, add newInt to the result if it is not the initial value (-1).
         Append the current interval to the result.

     Final Check and Result:
         After processing all intervals, if newInt is not the initial value (-1), add it to the result.
         Return the final result.
 */
class Solution2 {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        intervals.isEmpty ?
            [newInterval]
        :
        intervals.enumerated().reduce(into: (
            result: [[Int]](),
            newInt: newInterval
        )) { data, tuple in
            let (start, end) = (0, 1)
            let (i, interval) = tuple
            if (interval[end] >= data.newInt[start] && interval[start] <= data.newInt[end]) {
               // new interval intersects current interval
                data.newInt = [
                        min(data.newInt[start], interval[start]),
                        max(data.newInt[end], interval[end])
                ]
            } else {
                // new interval is either before or after current interval
                if interval[start] > data.newInt[end] && data.newInt[start] != -1 {
                    data.result.append(data.newInt)
                    data.newInt[start] = -1
                }
                data.result.append(interval)
            }
            if i == intervals.count - 1 && data.newInt[start] != -1 {
                // after last interval, if haven't added new interval yet, add now.
                data.result.append(data.newInt)
            }
        }.result
    }
}

let solution2 = Solution2()
print(solution2.insert([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8]))
