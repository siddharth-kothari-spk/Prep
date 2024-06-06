/*
 https://leetcode.com/problems/course-schedule-iii/description/
 There are n different online courses numbered from 1 to n. You are given an array courses where courses[i] = [durationi, lastDayi] indicate that the ith course should be taken continuously for durationi days and must be finished before or on lastDayi.

 You will start on the 1st day and you cannot take two or more courses simultaneously.

 Return the maximum number of courses that you can take.

  

 Example 1:

 Input: courses = [[100,200],[200,1300],[1000,1250],[2000,3200]]
 Output: 3
 Explanation:
 There are totally 4 courses, but you can take 3 courses at most:
 First, take the 1st course, it costs 100 days so you will finish it on the 100th day, and ready to take the next course on the 101st day.
 Second, take the 3rd course, it costs 1000 days so you will finish it on the 1100th day, and ready to take the next course on the 1101st day.
 Third, take the 2nd course, it costs 200 days so you will finish it on the 1300th day.
 The 4th course cannot be taken now, since you will finish it on the 3300th day, which exceeds the closed date.
 Example 2:

 Input: courses = [[1,2]]
 Output: 1
 Example 3:

 Input: courses = [[3,2],[4,3]]
 Output: 0
  

 Constraints:

 1 <= courses.length <= 10^4
 1 <= durationi, lastDayi <= 10^4
 */

import Foundation

func scheduleCourse(_ courses: [[Int]]) -> Int {
    var result = 0
    var courses = courses.sorted { items0, items1 in
        items0[1] < items1[1]
    }
    var days = 0
    
    for course in courses {
        guard course[0] < course[1] else {
            continue
        }
        if days + course[0] < course[1] {
            days += course[0]
            result += 1
        }
    }
    print(courses)
    return result
}

print(scheduleCourse([[100,200],[200,1300],[1000,1250],[2000,3200]]))

print(scheduleCourse([[1,2]]))

print(scheduleCourse([[3,2],[4,3]]))

// Sol2:
/*
 we can use a greedy algorithm with a max-heap (priority queue) to efficiently manage the scheduling. Here's a step-by-step breakdown of the approach:

 Sort the Courses: First, sort the courses by their end dates (lastDayi). This ensures that we consider each course in the order of when they must be completed.

 Use a Max-Heap: Use a max-heap (priority queue) to keep track of the durations of the courses that have been taken so far. This helps in efficiently finding the longest duration course to drop when needed.

 Iterate Through Courses: Iterate through the sorted list of courses. For each course:

 If adding the current course's duration to the total days spent so far does not exceed its last possible day, add the course to the heap.
 If adding the course exceeds its last possible day, check if the current course's duration is less than the longest duration course in the heap. If so, replace the longest duration course with the current one (remove the longest duration course from the heap and add the current one). This replacement ensures that we always have the minimum total duration for the courses taken, maximizing the number of courses that can be taken.
 Result: The number of courses in the heap at the end of the iteration represents the maximum number of courses that can be taken.
 */

import Foundation

func scheduleCourse(_ courses: [[Int]]) -> Int {
    // Step 1: Sort courses by their last possible day
    let sortedCourses = courses.sorted { $0[1] < $1[1] }
    
    var totalDays = 0
    var maxHeap = [Int]()
    
    // Step 3: Iterate through the sorted courses
    for course in sortedCourses {
        let duration = course[0]
        let lastDay = course[1]
        
        // Step 4a: Add the course duration to the max-heap and update total days
        maxHeap.append(duration)
        totalDays += duration
        maxHeap.sort(by: >)  // Sorting to maintain max-heap property
        
        // Step 4b: Check if the total days exceed the current course's last day
        if totalDays > lastDay {
            // If so, remove the course with the longest duration
            if let maxDuration = maxHeap.first {
                totalDays -= maxDuration
                maxHeap.removeFirst()
            }
        }
    }
    
    // The number of courses in the max-heap is the answer
    return maxHeap.count
}

// Example usage:
let courses1 = [[100, 200], [200, 1300], [1000, 1250], [2000, 3200]]
print(scheduleCourse(courses1))  // Output: 3

let courses2 = [[1, 2]]
print(scheduleCourse(courses2))  // Output: 1

let courses3 = [[3, 2], [4, 3]]
print(scheduleCourse(courses3))  // Output: 0
