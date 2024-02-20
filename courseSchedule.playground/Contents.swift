/*
 There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

 For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
 Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

  

 Example 1:

 Input: numCourses = 2, prerequisites = [[1,0]]
 Output: [0,1]
 Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
 Example 2:

 Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
 Output: [0,2,1,3]
 Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
 So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
 Example 3:

 Input: numCourses = 1, prerequisites = []
 Output: [0]
 */

// Solution: https://leetcode.com/problems/course-schedule-ii/solutions/3468058/swift-solution-topological-sort-beats-92-9

func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
    
    var dict: [Int: [Int]] = [:]
    var deg: [Int] = Array(repeating: 0, count: numCourses)
    
    for arr in prerequisites {
        dict[arr[1], default: []].append(arr[0])
        deg[arr[0]] += 1
    }
    print("dict: \(dict)")
    print("deg: \(deg)")
    
    var zeroDeg: [Int] = [Int]()
    
    for courseNum in 0..<numCourses {
        if deg[courseNum] == 0 {
            zeroDeg.append(courseNum)
        }
    }
    
    print("zeroDeg: \(zeroDeg)")
    
    var sortedDeg: [Int] = [Int]()
    
    while !zeroDeg.isEmpty {
        print("----")
        let preDeg = zeroDeg.removeFirst()
        sortedDeg.append(preDeg)
        print("preDeg: \(preDeg)")
        print("sortedDeg: \(sortedDeg)")
        
        for course in dict[preDeg] ?? []{
            print("course: \(course)")
            deg[course] -= 1
            if deg[course] == 0 {
                zeroDeg.append(course)
            }
            print("deg: \(deg)")
            print("zeroDeg: \(zeroDeg)")
        }
    }
    
    return sortedDeg.count == numCourses ? sortedDeg : []
}

print(findOrder(4, [[1,0],[2,0],[3,1],[3,2]]))
