/*
 https://www.geeksforgeeks.org/find-a-tour-that-visits-all-stations/
 
 Given information about N petrol pumps (say arr[]) that are present in a circular path. The information consists of the distance of the next petrol pump from the current one (in arr[i][1]) and the amount of petrol stored in that petrol pump (in arr[i][0]). Consider a truck with infinite capacity that consumes 1 unit of petrol to travel 1 unit distance. The task is to find the index of the first starting point such that the truck can visit all the petrol pumps and come back to that starting point.

 Note: Return -1 if no such tour exists.

 Examples:

 Input: arr[] = {{4, 6}, {6, 5}, {7, 3}, {4, 5}}.
 Output: 1
 Explanation: If started from 1st index then a circular tour can be covered.


 Input: arr[] {{6, 4}, {3, 6}, {7, 3}}
 Output: 2

Solution:
 Here's an algorithm to find the first circular tour that visits all petrol pumps:

 **Algorithm:**

 1. Initialize two variables:
     - `start`: Set to 0 (starting index of the current tour).
     - `end`: Set to 1 (index of the next pump in the current tour).
 2. Create a variable `curr_petrol` to store the current petrol level in the truck (initially 0).
 3. Iterate while `start` is less than `N` (number of petrol pumps):
     - Calculate the available petrol: `available_petrol = arr[start][0] - arr[start][1]`.
     - If `available_petrol` is less than 0:
         - Update `start`: `start = start + 1` (move to the next pump).
         - Reset `curr_petrol` to 0.
     - Otherwise:
         - Add `available_petrol` to `curr_petrol`.
         - If `end` is equal to `N`:
             - We've reached the end of the circle. Check if `curr_petrol` is non-negative.
                 - If `curr_petrol` is non-negative, a circular tour is possible. Return `start`.
                 - Otherwise, reset `start`: `start = start + 1`, `curr_petrol` to 0, and move `end` to the next pump (`end = (end + 1) % N`).
         - Otherwise, simply move to the next pump: `end = (end + 1) % N`.
 4. If the loop finishes without returning a value, it means no circular tour is possible. Return -1.

 **Explanation:**

 - The algorithm iterates through all pumps, keeping track of the current petrol level and the starting point of the current tour.
 - It checks if the available petrol at each pump is sufficient to reach the next one. If not, it moves to the next pump and resets the current petrol level.
 - If enough petrol is available, the algorithm proceeds to the next pump. If it reaches the end of the circle, it checks if the current petrol level is non-negative. This ensures the truck has enough petrol to complete the circle back to the starting point.
 - If no such starting point is found during the loop, it means no circular tour is possible.

 This algorithm uses a time complexity of O(N) and a space complexity of O(1).

 


// not working:
 
func findCircularTour(_ arr: [[Int]]) -> Int {
  var start = 0
  var end = 1
  var currPetrol = 0

  let N = arr.count
  
  while start < N {
    let availablePetrol = arr[start][0] - arr[start][1]
    currPetrol += availablePetrol
    
    if currPetrol < 0 {
      start += 1
      currPetrol = 0
    } else {
      if end == N {
        if currPetrol >= 0 {
          return start
        } else {
          start += 1
          currPetrol = 0
          end = (end + 1) % N
        }
      } else {
        end = (end + 1) % N
      }
    }
  }
  
  return -1
}

findCircularTour([[4, 6], [6, 5], [7, 3], [4, 5]])

*/




func circuit(_ arr: [(Int, Int)]) -> Int {
    
    let allGas = arr.reduce(0) { partialResult, gasStationTuple in
        partialResult + gasStationTuple.0
    }
    
    let allCost = arr.reduce(0) { partialResult, gasStationTuple in
        partialResult + gasStationTuple.1
    }
    
    guard allGas >= allCost else { return -1 }
    
    var value = 0, gasSum = 0, costSum = 0
    
    for (index, tuple) in arr.enumerated() {
        gasSum += tuple.0
        costSum += tuple.1
        
        if gasSum < costSum {
            value = (index + 1) % arr.count
            gasSum = 0
            costSum = 0
        }
    }
    return value
}

print(circuit([(4, 6), (6, 5), (7, 3), (4, 5)])) // 1

print(circuit([(6, 4), (3, 6), (7, 3)])) // 2

print(circuit([(4, 6), (5, 8)])) // -1
