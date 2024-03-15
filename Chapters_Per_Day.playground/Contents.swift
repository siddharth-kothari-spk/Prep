/*
 Problem statement
 Ayush is studying for ninjatest which will be held after 'N' days, And to score good marks he has to study 'M' chapters and the ith chapter requires TIME[i] seconds to study. The day in Ayush’s world has 100^100 seconds. There are some rules that are followed by Ayush while studying.

 1. He reads the chapter in a sequential order, i.e. he studies i+1th chapter only after he studies ith chapter.

 2. If he starts some chapter on a particular day he completes it that day itself.

 3. He wants to distribute his workload over 'N' days, so he wants to minimize the maximum amount of time he studies in a day.

 Your task is to find out the minimal value of the maximum amount of time for which Ayush studies in a day, in order to complete all the 'M' chapters in no more than 'N' days.

 For example

 if Ayush want to study 6 chapters in 3 days and the time that each chapter requires is as follows:
 Chapter 1 = 30
 Chapter 2 = 20
 Chapter 3 = 10
 Chapter 4 = 40
 Chapter 5 = 5
 Chapter 6 = 45

 Then he will study the chapters in the following order

 | day 1 : 1 , 2 | day 2 : 3 , 4 | day 3 : 5 , 6 |
 Here we can see that he study chapters in sequential order and the maximum time to study on a day is 50, which is the minimum possible in this case.
 Detailed explanation ( Input/output format, Notes, Images )
 Constraints:
 1 <= T <= 10
 1 <= N , M <= 10 ^ 4
 1 <= TIME[i] <= 10 ^ 9
 It is considered that there are infinite seconds in a day, on the planet where Ayush lives.

 Time limit: 1 sec.
 Sample Input 1:
 1
 3 5
 1 2 2 3 1
 Sample Output 1:
 4
 Explanation of sample input 1:
 The ayush will read the chapter as follows,
 Day 1 : 1 , 2         Time required : 3
 Day 2 : 3             Time required : 2
 Day 3 : 4 , 5         Time required : 4
 So the maximum time in a day is 4.
 Sample Input 2:
 1
 4 7
 2 2 3 3 4 4 1
 Sample Output 2:
 6
 Explanation of sample input 2:
 The ayush will read the chapter as follows,
 Day 1 : 1 , 2          Time required : 4
 Day 2 : 3 , 4          Time required : 6
 Day 3 : 5              Time required : 4
 Day 4 : 6 , 7          Time required : 5
 So the maximum time in a day is 6.
 
 
 Algo:
 Here's an algorithm to solve the Ninjatest study schedule problem for Ayush:

 **This algorithm uses Binary Search to find the minimum maximum study time.**

 **Input:**

 * `N`: Number of days available for studying (integer)
 * `M`: Number of chapters to study (integer)
 * `TIME`: Array containing time required for each chapter (array of integers)

 **Output:**

 * `min_max_time`: Minimum value of the maximum amount of time Ayush studies in a day (integer)

 **Steps:**

 1. **Sort the `TIME` array:** This ensures we consider chapters with increasing study times.
 2. **Initialize `low` and `high`:**
     * `low` = maximum time required for a single chapter (from the sorted `TIME` array)
     * `high` = total time required to study all chapters (sum of all elements in `TIME`)
 3. **Binary Search Loop:**
     * While `low` is less than or equal to `high`:
         * Calculate `mid` = (`low` + `high`) // 2
         * Check if it's possible to complete all chapters in `N` days with a maximum study time of `mid`:
             * Use a helper function `is_feasible(N, M, TIME, mid)` (explained below)
             * If `is_feasible(N, M, TIME, mid)` returns `True`:
                 * Update `min_max_time` to `mid` (as we found a feasible solution)
                 * Update `high` to `mid - 1` (since we want to find the minimum value)
             * Else (if `is_feasible` returns `False`):
                 * Update `low` to `mid + 1` (explore higher study times)
 4. **Return `min_max_time`:** This is the minimum value for maximum daily study time.

 **Helper function `is_feasible(N, M, TIME, max_time)`:**

 * This function takes the number of days (`N`), number of chapters (`M`), chapter times (`TIME`), and a potential maximum study time (`max_time`) as input.
 * It iterates through the `TIME` array, keeping track of the current day (`day`).
 * It adds the study time of each chapter to the current day's time (`day_time`).
 * If `day_time` exceeds `max_time`, it means the chapter cannot be completed within the maximum time and requires moving to the next day (`day` increments).
 * If after processing all chapters, the final `day` is greater than `N` (available days), it means the schedule is not feasible with the given `max_time`.
 * The function returns `True` if all chapters can be completed within `N` days with a maximum daily study time of `max_time`, otherwise it returns `False`.

 **Complexity:**

 * Time complexity: O(M * log(HIGH)), where M is the number of chapters and HIGH is the sum of chapter times.
 * Space complexity: O(1) (uses constant extra space).

 This algorithm uses binary search to efficiently find the minimum maximum study time. The helper function checks if a specific maximum study time allows completing all chapters within the available days.
 */


func minMaxStudyTime(days N: Int, chapters M: Int, times TIME: [Int]) -> Int {
  // Sort chapters by time (increasing order)
 // let sortedTimes = TIME.sorted()

  // Initialize low and high for binary search
    var low = TIME.max()!
  var high = TIME.reduce(0, +)
  var minMaxStudyTime = high
  while low <= high {
    let mid = (low + high) / 2

    // Check if it's possible to complete chapters with maximum time 'mid'
    if isFeasible(days: N, chapters: M, times: TIME, maxTime: mid) {
      // Update min if a feasible solution is found
      minMaxStudyTime = mid
      high = mid - 1
    } else {
      // Explore higher study times
      low = mid + 1
    }
  }

  return minMaxStudyTime
}

func isFeasible(days N: Int, chapters M: Int, times: [Int], maxTime: Int) -> Bool {
  var currentDay = 1
  var dayTime = 0

  for time in times {
    dayTime += time
    if dayTime > maxTime {
      currentDay += 1
      dayTime = time
    }
  }

  // Check if all chapters completed within N days
  return currentDay <= N
}

// Example usage
let days = 3
let chapters = 6
let times = [30, 20, 10, 40, 5, 45]

let minMaxTime = minMaxStudyTime(days: days, chapters: chapters, times: times)
print("Minimum maximum study time:", minMaxTime)
