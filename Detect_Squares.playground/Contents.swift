/*
 https://leetcode.com/problems/detect-squares/description/
 You are given a stream of points on the X-Y plane. Design an algorithm that:

 Adds new points from the stream into a data structure. Duplicate points are allowed and should be treated as different points.
 Given a query point, counts the number of ways to choose three points from the data structure such that the three points and the query point form an axis-aligned square with positive area.
 An axis-aligned square is a square whose edges are all the same length and are either parallel or perpendicular to the x-axis and y-axis.

 Implement the DetectSquares class:

 DetectSquares() Initializes the object with an empty data structure.
 void add(int[] point) Adds a new point point = [x, y] to the data structure.
 int count(int[] point) Counts the number of ways to form axis-aligned squares with point point = [x, y] as described above.
  

 Example 1:


 Input
 ["DetectSquares", "add", "add", "add", "count", "count", "add", "count"]
 [[], [[3, 10]], [[11, 2]], [[3, 2]], [[11, 10]], [[14, 8]], [[11, 2]], [[11, 10]]]
 Output
 [null, null, null, null, 1, 0, null, 2]

 Explanation
 DetectSquares detectSquares = new DetectSquares();
 detectSquares.add([3, 10]);
 detectSquares.add([11, 2]);
 detectSquares.add([3, 2]);
 detectSquares.count([11, 10]); // return 1. You can choose:
                                //   - The first, second, and third points
 detectSquares.count([14, 8]);  // return 0. The query point cannot form a square with any points in the data structure.
 detectSquares.add([11, 2]);    // Adding duplicate points is allowed.
 detectSquares.count([11, 10]); // return 2. You can choose:
                                //   - The first, second, and third points
                                //   - The first, third, and fourth points
  

 Constraints:

 point.length == 2
 0 <= x, y <= 1000
 At most 3000 calls in total will be made to add and count.
 */


/*
 Algo Explanation:
 Initialization (init):

 self.pointCount: A dictionary to store the count of each point as a string key in the format "x,y".
 self.points: An array to store all points added.
 Adding Points (add):

 Convert the input point to a string key in the format "x,y".
 Increment the count of this point in self.pointCount.
 Append the point to self.points.
 Counting Squares (count):

 For the query point px and py, iterate over all points in self.points.
 Check if (x, y) can be a diagonal point of a square with (px, py) (i.e., abs(px - x) == abs(py - y) and px != x and py != y).
 If so, check if the other two points (x, py) and (px, y) exist by looking them up in self.pointCount.
 Multiply their counts and accumulate in countSquares.
 */
import Foundation

class DetectSquares {
    private var pointCount: [String: Int]
    private var points: [[Int]]
    
    init() {
        self.pointCount = [:]
        self.points = []
    }
    
    func add(_ point: [Int]) {
        let key = "\(point[0]),\(point[1])"
        self.pointCount[key, default: 0] += 1
        self.points.append(point)
    }
    
    func count(_ point: [Int]) -> Int {
        let px = point[0]
        let py = point[1]
        var countSquares = 0
        
        for p in points {
            let x = p[0]
            let y = p[1]
            
            // Check if (x, y) can form a square with (px, py)
            if abs(px - x) != abs(py - y) || px == x || py == y {
                continue
            }
            
            // Check the existence of other two points
            let count1 = pointCount["\(x),\(py)", default: 0]
            let count2 = pointCount["\(px),\(y)", default: 0]
            
            countSquares += count1 * count2
        }
        
        return countSquares
    }
}

// Example Usage
let detectSquares = DetectSquares()
detectSquares.add([3, 10])
detectSquares.add([11, 2])
detectSquares.add([3, 2])
print(detectSquares.count([11, 10]))  // Output: 1
print(detectSquares.count([14, 8]))   // Output: 0
detectSquares.add([11, 2])
print(detectSquares.count([11, 10]))  // Output: 2

/*
 Let's perform a dry run of the provided Swift code using the given example:

 ### Example Input:
 ```swift
 let detectSquares = DetectSquares()
 detectSquares.add([3, 10])
 detectSquares.add([11, 2])
 detectSquares.add([3, 2])
 print(detectSquares.count([11, 10]))  // Output: 1
 print(detectSquares.count([14, 8]))   // Output: 0
 detectSquares.add([11, 2])
 print(detectSquares.count([11, 10]))  // Output: 2
 ```

 ### Step-by-Step Dry Run:

 1. **Initialization**:
    - `detectSquares = DetectSquares()`
    - `pointCount` is an empty dictionary: `[:]`
    - `points` is an empty list: `[]`

 2. **First Add Operation**: `detectSquares.add([3, 10])`
    - `point = [3, 10]`
    - `pointCount` becomes: `["3,10": 1]`
    - `points` becomes: `[[3, 10]]`

 3. **Second Add Operation**: `detectSquares.add([11, 2])`
    - `point = [11, 2]`
    - `pointCount` becomes: `["3,10": 1, "11,2": 1]`
    - `points` becomes: `[[3, 10], [11, 2]]`

 4. **Third Add Operation**: `detectSquares.add([3, 2])`
    - `point = [3, 2]`
    - `pointCount` becomes: `["3,10": 1, "11,2": 1, "3,2": 1]`
    - `points` becomes: `[[3, 10], [11, 2], [3, 2]]`

 5. **First Count Operation**: `detectSquares.count([11, 10])`
    - `px = 11`, `py = 10`
    - Initialize `countSquares = 0`
    - Iterate over each point `(x, y)` in `points`:
      - For `(3, 10)`:
        - `x = 3`, `y = 10`
        - `abs(px - x) = abs(11 - 3) = 8`
        - `abs(py - y) = abs(10 - 10) = 0`
        - Not a diagonal, continue to next point.
      - For `(11, 2)`:
        - `x = 11`, `y = 2`
        - `abs(px - x) = abs(11 - 11) = 0`
        - `abs(py - y) = abs(10 - 2) = 8`
        - Not a diagonal, continue to next point.
      - For `(3, 2)`:
        - `x = 3`, `y = 2`
        - `abs(px - x) = abs(11 - 3) = 8`
        - `abs(py - y) = abs(10 - 2) = 8`
        - This is a diagonal.
        - Check if points `(3, 10)` and `(11, 2)` exist:
          - `count1 = pointCount["3,10"] = 1`
          - `count2 = pointCount["11,2"] = 1`
        - `countSquares += count1 * count2 = 1 * 1 = 1`
    - Output: `countSquares = 1`
    - Result: `1`

 6. **Second Count Operation**: `detectSquares.count([14, 8])`
    - `px = 14`, `py = 8`
    - Initialize `countSquares = 0`
    - Iterate over each point `(x, y)` in `points`:
      - For `(3, 10)`:
        - `x = 3`, `y = 10`
        - `abs(px - x) = abs(14 - 3) = 11`
        - `abs(py - y) = abs(8 - 10) = 2`
        - Not a diagonal, continue to next point.
      - For `(11, 2)`:
        - `x = 11`, `y = 2`
        - `abs(px - x) = abs(14 - 11) = 3`
        - `abs(py - y) = abs(8 - 2) = 6`
        - Not a diagonal, continue to next point.
      - For `(3, 2)`:
        - `x = 3`, `y = 2`
        - `abs(px - x) = abs(14 - 3) = 11`
        - `abs(py - y) = abs(8 - 2) = 6`
        - Not a diagonal, continue to next point.
    - Output: `countSquares = 0`
    - Result: `0`

 7. **Fourth Add Operation**: `detectSquares.add([11, 2])`
    - `point = [11, 2]`
    - `pointCount` becomes: `["3,10": 1, "11,2": 2, "3,2": 1]`
    - `points` becomes: `[[3, 10], [11, 2], [3, 2], [11, 2]]`

 8. **Third Count Operation**: `detectSquares.count([11, 10])`
    - `px = 11`, `py = 10`
    - Initialize `countSquares = 0`
    - Iterate over each point `(x, y)` in `points`:
      - For `(3, 10)`:
        - `x = 3`, `y = 10`
        - `abs(px - x) = abs(11 - 3) = 8`
        - `abs(py - y) = abs(10 - 10) = 0`
        - Not a diagonal, continue to next point.
      - For `(11, 2)`:
        - `x = 11`, `y = 2`
        - `abs(px - x) = abs(11 - 11) = 0`
        - `abs(py - y) = abs(10 - 2) = 8`
        - Not a diagonal, continue to next point.
      - For `(3, 2)`:
        - `x = 3`, `y = 2`
        - `abs(px - x) = abs(11 - 3) = 8`
        - `abs(py - y) = abs(10 - 2) = 8`
        - This is a diagonal.
        - Check if points `(3, 10)` and `(11, 2)` exist:
          - `count1 = pointCount["3,10"] = 1`
          - `count2 = pointCount["11,2"] = 2`
        - `countSquares += count1 * count2 = 1 * 2 = 2`
      - For `(11, 2)` again (duplicate point):
        - Same calculations as above, contributing another count.
    - Output: `countSquares = 2`
    - Result: `2`

 ### Summary of Outputs:
 1. `detectSquares.count([11, 10])` returns `1`
 2. `detectSquares.count([14, 8])` returns `0`
 3. `detectSquares.count([11, 10])` returns `2`

 This detailed dry run explains how the points are added and how the count operation checks for axis-aligned squares using the given query point and all added points.
 */
