/*
 https://www.codingninjas.com/studio/problems/order-of-people-heights_1170764?topList=top-google-coding-interview-questions&problemListRedirection=true
 
 Problem statement
 There are ‘N’ people numbered from 0 to N - 1, standing in a queue. You are given two arrays ‘Height’ and ‘Infront‘ consisting of ‘N’ non-negative integers. ‘Height[i]’ gives the height of the ith person, and ‘Infront[i]’ gives the number of persons who are taller than the ith person and standing in front of the ith person.

 Your task is to find out the actual order of people in a queue. You should print ‘N’ integers where the ‘ith’ integer is the height of the person who should be at the ith position from the start of the queue.

 Note :

 1. Consider that all elements in array ‘Height’ are unique.
 2. It is guaranteed that a valid order always exists for the given array ‘Height’ and ‘Infront’.
 Example :

 Let there are 6 people, their heights are given by array  ‘Height’ :  [5, 3, 2, 6, 1, 4],  and the number of people in front of them is given by array ‘Infront’: [0, 1, 2, 0, 3, 2]

 Thus the actual order of people’s height in the queue will be [5, 3, 2, 1, 6, 4]

 In this order, the first person in a queue i.e a person with a height of 5, has no person in front of them who is taller than him.
 The second person in a queue i.e a person with a height of 3 has 1 person (person with height 5) in front of them who is taller than him.
 The third person in a queue i.e a person with a height of 2 has 2 people (people with height 5 and 3) in front of them who are taller than him.
 The fourth person in a queue i.e a person with a height of 1 has 3 people (people with height 5, 3, 2) in front of them who are taller than him.
 The fifth person in a queue i.e a person with a height of 6 has no person in front of them who is taller than him.
 The sixth person in a queue i.e a person with a height of 4 has 2 people (people with height 5, and 6) in front of them who are taller than him.

 We can observe this is the only possible order that is possible according to the array ‘Infront’.
 Detailed explanation ( Input/output format, Notes, Images )

 Constraints :
 1 <= T <= 50
 1  <= N <=  10^4
 1 <= Height[i] <= 10^9
 0 <= Infront[i] < ‘N’

 Where ‘T’ is the total number of test cases, ‘N’ is the number of people in the queue, Height[i], and Infront[i] respectively are height and number of people in front of ith who are taller than him.

 Time limit: 1 sec
 Sample Input 1 :
 2
 5
 5 4 3 2 1
 0 0 0 0 0
 6
 5 3 2 6 1 4
 0 1 2 0 3 2
 Sample Output 1 :
 1 2 3 4 5
 5 3 2 1 6 4
 Explanation Of Sample Input 1 :
 Test case 1:
 There is no person in front of any person who is taller than him, Thus all of them must be present in the queue in increasing order of their height.

 Test case 2:
 See the problem statement for an explanation.
 Sample Input 2 :
 2
 2
 2 3
 1 0
 5
 1 2 3 4 5
 4 3 2 1 0
 Sample Output 2 :
 3 2
 5 4 3 2 1


 Hints:
 Sort people by their height.
 */


/*
 Solution:
 
 Here's an algorithm to solve the queue order problem:

 **Algorithm:**

 1. **Initialize:**
     - `result`: An empty array to store the final order of heights. (size N)
     - `indegree`: An array of size N to store the in-degree of each person (number of people taller in front).

 2. **Fill in-degree:**
     - Loop through the `Infront` array (i = 0 to N-1):
         - `result[i]` = -1 (initially unknown)
         - `indegree[i]` = `Infront[i]`

 3. **Find people with no one taller in front:**
     - Use a queue `q` to store these people.
     - Loop through the `indegree` array:
         - If `indegree[i] == 0`, enqueue `i` in `q`.

 4. **Process the queue:**
     - While `q` is not empty:
         - Dequeue a person `i` from `q`.
         - Add `Height[i]` to `result[i]`. (This person's position is confirmed)
         - Loop through the people `j` who are shorter than `i` (based on `Height`):
             - Decrement `indegree[j]` (one less person taller in front).
             - If `indegree[j] == 0`, enqueue `j` in `q`.

 5. **Check for validity:**
     - If after processing the queue, any element in `result` is still -1, it implies there's a contradiction and no valid order exists.

 **Explanation:**

 - The `indegree` array helps track how many people are taller in front of each person.
 - We prioritize people with no one taller by adding them to the queue first.
 - While processing the queue, we update the `indegree` of shorter people and add them to the queue if they become eligible (no taller people in front).
 - Finally, we check if all positions are filled in `result`. If not, it means the information provided is inconsistent.

 **Time Complexity:**

 - The algorithm has a time complexity of O(N), where N is the number of people. This is because we iterate through the arrays and the queue a constant number of times.

 **Implementation:**

 This algorithm can be implemented in various programming languages. The core logic remains the same, with adjustments for specific data structures and syntax.

 */

import Foundation
func findOrder(height: [Int], infront: [Int]) -> [Int]? {
  let n = height.count
  var result = Array(repeating: -1, count: n)
  var indegree = [Int](repeating: 0, count: n)
    print("result: \(result)")
    print("indegree: \(indegree)")

  // Fill in-degree
  for i in 0..<n {
    indegree[i] = infront[i]
  }
    print("indegree: \(indegree)")
    
  // Find people with no one taller in front
  var queue = Queue<Int>()
  for i in 0..<n {
    if indegree[i] == 0 {
        queue.enqueue(_value: i)
    }
  }
    print("queue: \(queue)")

  // Process the queue
  while !queue.isEmpty {
    guard let i = queue.dequeue() else { return nil }
      print("i: \(i)")
    result[i] = height[i]
      print("height: \(height)")
    for j in 0..<n where height[i] > height[j] {
        print("j: \(j)")
        print("indegree[j]: \(indegree[j])")
      indegree[j] -= 1
        print("indegree[j]: \(indegree[j])")
      if indegree[j] == 0 {
          queue.enqueue(_value: j)
          print("queue: \(queue)")
      }
    }
  }

  // Check for validity
  if result.contains(-1) {
    return nil
  }
    print("RESULT: \(result)")
  return result
}

struct Queue<T>: CustomStringConvertible {

    private var elements: [T] = []

    public init() {}

    var isEmpty: Bool {
        elements.isEmpty
    }

    var peek: T? {
        elements.first
    }

    var description: String {
        if isEmpty {
            return "Queue is empty ..."
        }

        return "-- Queue start ----\n" +
            elements.map({"\($0)"}).joined(separator: " -> ") +
            "\n---- Queue End----"
    }

    mutating func enqueue(_value: T) {
        elements.append(_value)
    }

    mutating func dequeue() -> T? {
        isEmpty ? nil : elements.removeFirst()
    }
}

var res = findOrder(height: [5, 3, 2, 6, 1, 4], infront: [0, 1, 2, 0, 3, 2])
print(res as Any)
/*
res = findOrder(height: [5,4,3,2,1], infront: [0,0,0,0,0])
print(res as Any)

res = findOrder(height: [2,3], infront: [1,0])
print(res as Any)

res = findOrder(height: [1,2,3,4,5], infront: [4,3,2,1,0])
print(res as Any)
*/
