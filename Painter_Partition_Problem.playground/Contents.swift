/*
 https://www.codingninjas.com/studio/problems/painter-s-partition-problem_1089557?topList=top-google-coding-interview-questions&problemListRedirection=true
 
 Problem statement
 Given an array/list of length ‘n’, where the array/list represents the boards and each element of the given array/list represents the length of each board. Some ‘k’ numbers of painters are available to paint these boards. Consider that each unit of a board takes 1 unit of time to paint.



 You are supposed to return the area of the minimum time to get this job done of painting all the ‘n’ boards under a constraint that any painter will only paint the continuous sections of boards.



 Example :
 Input: arr = [2, 1, 5, 6, 2, 3], k = 2

 Output: 11

 Explanation:
 First painter can paint boards 1 to 3 in 8 units of time and the second painter can paint boards 4-6 in 11 units of time. Thus both painters will paint all the boards in max(8,11) = 11 units of time. It can be shown that all the boards can't be painted in less than 11 units of time.


 Detailed explanation ( Input/output format, Notes, Images )
 Sample Input 1 :
 4 2
 10 20 30 40


 Sample Output 1 :
 60


 Explanation For Sample Input 1 :
 In this test case, we can divide the first 3 boards for one painter and the last board for the second painter.


 Sample Input 2 :
 2 2
 48 90


 Sample Output 2 :
 90


 Expected Time Complexity:
 Try to do this in O(n*log(n)).


 Constraints :
 1 <= n <= 10^5
 1 <= k <= n
 1 <= arr[i] <= 10^9

 Time Limit: 1 sec.
 
 Sol:
 
 I'd be glad to provide an algorithm for the painting boards problem, incorporating insights from the feedback and addressing potential issues:

 **Problem Statement:**

 Given an array `boards` of length `n`, where each element represents the time required to paint a board, and a number `k` of painters, find the minimum time to paint all boards under the constraint that each painter can only paint contiguous sections of boards.

 **Algorithm (Binary Search):**

 1. **Define Functions:**
    - `is_feasible(time, boards, k)`: This function checks if it's possible to paint all boards within the given `time` using `k` painters. It iterates through `boards`, keeping track of the current painter's cumulative time. If the cumulative time exceeds `time`, it means a new painter is needed, and the function returns `False`. Otherwise, it returns `True`.
 2. **Initialize Search Space:**
    - Set `low` to the maximum time in `boards` (represents the scenario where each painter works on a single board).
    - Set `high` to the sum of all times in `boards` (represents the scenario where one painter handles everything).
 3. **Binary Search Loop:**
    - While `low` is less than or equal to `high`:
       - Calculate the mid-point `time` as the average of `low` and `high`.
       - Call `is_feasible(time, boards, k)`.
          - If `is_feasible` returns `True`, it means this `time` is sufficient. Update `high` to `time - 1` (search for a potentially lower minimum time).
          - If `is_feasible` returns `False`, it means this `time` is not enough. Update `low` to `time + 1` (search for a higher time that might work).
 4. **Return Minimum Time:**
    - When the loop exits, `low` will be the minimum time required to paint all boards with `k` painters. Return `low`.

 **`is_feasible` Function Implementation (Python):**

 ```python
 def is_feasible(time, boards, k):
     current_painter_time = 0
     painters_used = 1
     for board_time in boards:
         if current_painter_time + board_time <= time:
             current_painter_time += board_time
         else:
             painters_used += 1
             current_painter_time = board_time
             if painters_used > k:
                 return False  # Exceeded allowed painters
     return True
 ```

 **Time Complexity:**

 - The binary search loop iterates at most `log n` times (considering `n` as the length of `boards`).
 - Inside the loop, `is_feasible` iterates over the `boards` array, which takes `O(n)` time in the worst case.
 - The overall time complexity becomes `O(n * log n)`.

 **Explanation:**

 1. The `is_feasible` function verifies whether all boards can be painted within `time` using `k` painters. It keeps track of the current painter's accumulated time and ensures it doesn't exceed `time`. If a new painter is needed (cumulative time exceeds `time`), the function returns `False`.
 2. The binary search loop starts with a large `high` value (total painting time) and a low value (maximum board time). It repeatedly checks if `time` is a feasible solution.
    - If `is_feasible(time, boards, k)` is `True`, it reduces the search space by looking for a potentially lower minimum time (update `high`).
    - If `is_feasible(time, boards, k)` is `False`, it increases the search space by looking for a higher time that might work (update `low`).
 3. When the loop exits, `low` contains the minimum time required to paint all boards with `k` painters.

 This algorithm offers an efficient solution (O(n * log n)) to the painting boards problem, considering the feedback to provide a clear and well-explained approach.
 */

func minTimeToPaintBoards(_ boards: [Int], _ k: Int) -> Int {
  func isFeasible(time: Int) -> Bool {
    var currentPainterTime = 0
    var paintersUsed = 1
    for boardTime in boards {
      if currentPainterTime + boardTime <= time {
        currentPainterTime += boardTime
      } else {
        paintersUsed += 1
        currentPainterTime = boardTime
        if paintersUsed > k {
          return false // Exceeded allowed painters
        }
      }
    }
    return true
  }

  var low = boards.max()! // Minimum time per board
  var high = boards.reduce(0, +) // Total painting time

  while low <= high {
    let mid = (low + high) / 2
    if isFeasible(time: mid) {
      high = mid - 1 // Search for potentially lower minimum time
    } else {
      low = mid + 1 // Search for higher time that might work
    }
  }

  return low
}

print(minTimeToPaintBoards([2, 1, 5, 6, 2, 3], 2))
