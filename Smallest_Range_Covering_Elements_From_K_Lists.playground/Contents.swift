/*
 https://leetcode.com/problems/smallest-range-covering-elements-from-k-lists/description/
 You have k lists of sorted integers in non-decreasing order. Find the smallest range that includes at least one number from each of the k lists.

 We define the range [a, b] is smaller than range [c, d] if b - a < d - c or a < c if b - a == d - c.

  

 Example 1:

 Input: nums = [[4,10,15,24,26],[0,9,12,20],[5,18,22,30]]
 Output: [20,24]
 Explanation:
 List 1: [4, 10, 15, 24,26], 24 is in range [20,24].
 List 2: [0, 9, 12, 20], 20 is in range [20,24].
 List 3: [5, 18, 22, 30], 22 is in range [20,24].
 Example 2:

 Input: nums = [[1,2,3],[1,2,3],[1,2,3]]
 Output: [1,1]
  

 Constraints:

 nums.length == k
 1 <= k <= 3500
 1 <= nums[i].length <= 50
 -10^5 <= nums[i][j] <= 10^5
 nums[i] is sorted in non-decreasing order.
 */

/*
 use a min-heap (priority queue) to efficiently track and compare the smallest elements of each list, and a max variable to keep track of the maximum element among the current elements in the heap. The key idea is to maintain the smallest range that includes at least one number from each of the k lists as you iterate through the elements of the lists.

 Here's the step-by-step algorithm:

 Initialize a min-heap to keep track of the smallest current elements from each list.
 Initialize a variable max_val to keep track of the maximum value among the current elements in the min-heap.
 Push the first element of each list into the min-heap along with the index of the element and the index of the list it came from. Update max_val to be the maximum of these first elements.
 Initialize the range to be [min_element, max_val], where min_element is the smallest element in the min-heap.
 While the min-heap contains k elements:
 Pop the smallest element from the min-heap.
 Update the range if the current range [min_element, max_val] is smaller than the previously recorded range.
 If the popped element has a next element in its list, push the next element into the min-heap and update max_val.
 If any list is exhausted (i.e., no more elements to push from the list of the popped element), break the loop.
 Return the smallest range found.
 */

import Foundation

func smallestRange(_ nums: [[Int]]) -> [Int] {
    
    // Initialize a minHeap to keep track of the smallest current elements from each list
    var minHeap = [(value: Int, row: Int, idx: Int)]()
    
    //Initialize a variable maxVal to keep track of the maximum value among the current elements in the minHeap.
    var maxVal = Int.min
    
    // Push the first element of each list into the min-heap along with the index of the element and the index of the list it came from. Update maxVal to be the maximum of these first elements.
    for i in 0..<nums.count {
        let value = nums[i][0]
        minHeap.append((value, i, 0))
        maxVal = max(maxVal, value)
    }

    minHeap.sort { value1, value2 in
        value1.value < value2.value
    }
    
    //  Initialize the range to be [minElement, maxVal], where min_element is the smallest element in the minHeap.
    var minRange = [minHeap[0].value, maxVal]
    
    //  While the minHeap contains k elements:
    while true {
        // Pop the smallest element from the minHeap
        let minElement = minHeap.removeFirst()
        
        // Update the range if the current range [minElement, maxVal] is smaller than the previously recorded range.
        if maxVal - minElement.value < minRange[1] - minRange[0] ||
            (maxVal - minElement.value == minRange[1] - minRange[0] && minElement.value < minRange[0]) {
            minRange = [minElement.value, maxVal]
        }
        
        // If the popped element has a next element in its list, push the next element into the minHeap and update maxVal.
        if minElement.idx + 1 < nums[minElement.row].count {
            let nextValue = nums[minElement.row][minElement.idx + 1]
            minHeap.append((nextValue, minElement.row, minElement.idx + 1))
            maxVal = max(maxVal, nextValue)
            minHeap.sort { value1, value2 in
                value1.value < value2.value
            }
        }
        else {
            // If any list is exhausted (i.e., no more elements to push from the list of the popped element), break the loop.
            break
        }
    }

    // Return the smallest range found
    return minRange
}

// Example usage
let nums1 = [[4, 10, 15, 24, 26], [0, 9, 12, 20], [5, 18, 22, 30]]
print(smallestRange(nums1))  // Output: [20, 24]

let nums2 = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
print(smallestRange(nums2))  // Output: [1, 1]

/*
 Let's go through a dry run of the provided Swift code for the input [[4, 10, 15, 24, 26], [0, 9, 12, 20], [5, 18, 22, 30]].

 Initial Setup
 nums = [[4, 10, 15, 24, 26], [0, 9, 12, 20], [5, 18, 22, 30]]
 minHeap = [(4, 0, 0), (0, 1, 0), (5, 2, 0)]
 maxVal = 5
 minRange = [-∞, ∞]
 
 Step-by-Step Execution
 Build the initial heap:

 minHeap is sorted: [(0, 1, 0), (4, 0, 0), (5, 2, 0)]
 
 First iteration:

 Extract minimum: (0, 1, 0) (element 0 from list 1)
 Current range: [0, 5]
 Update minRange: [-∞, ∞] -> [0, 5]
 Push next element from list 1: (9, 1, 1)
 minHeap: [(4, 0, 0), (5, 2, 0), (9, 1, 1)]
 Update maxVal: 9
 
 Second iteration:

 Extract minimum: (4, 0, 0) (element 4 from list 0)
 Current range: [4, 9]
 Update minRange: [0, 5] -> [4, 9]
 Push next element from list 0: (10, 0, 1)
 minHeap: [(5, 2, 0), (9, 1, 1), (10, 0, 1)]
 Update maxVal: 10
 
 Third iteration:

 Extract minimum: (5, 2, 0) (element 5 from list 2)
 Current range: [5, 10]
 Update minRange: [4, 9] -> [5, 10]
 Push next element from list 2: (18, 2, 1)
 minHeap: [(9, 1, 1), (10, 0, 1), (18, 2, 1)]
 Update maxVal: 18
 
 Fourth iteration:

 Extract minimum: (9, 1, 1) (element 9 from list 1)
 Current range: [9, 18]
 minRange remains [5, 10]
 Push next element from list 1: (12, 1, 2)
 minHeap: [(10, 0, 1), (18, 2, 1), (12, 1, 2)]
 maxVal remains 18
 
 Fifth iteration:

 Extract minimum: (10, 0, 1) (element 10 from list 0)
 Current range: [10, 18]
 minRange remains [5, 10]
 Push next element from list 0: (15, 0, 2)
 minHeap: [(12, 1, 2), (18, 2, 1), (15, 0, 2)]
 maxVal remains 18
 
 Sixth iteration:

 Extract minimum: (12, 1, 2) (element 12 from list 1)
 Current range: [12, 18]
 minRange remains [5, 10]
 Push next element from list 1: (20, 1, 3)
 minHeap: [(15, 0, 2), (18, 2, 1), (20, 1, 3)]
 Update maxVal: 20
 
 Seventh iteration:

 Extract minimum: (15, 0, 2) (element 15 from list 0)
 Current range: [15, 20]
 minRange remains [5, 10]
 Push next element from list 0: (24, 0, 3)
 minHeap: [(18, 2, 1), (20, 1, 3), (24, 0, 3)]
 Update maxVal: 24
 
 Eighth iteration:

 Extract minimum: (18, 2, 1) (element 18 from list 2)
 Current range: [18, 24]
 minRange remains [5, 10]
 Push next element from list 2: (22, 2, 2)
 minHeap: [(20, 1, 3), (24, 0, 3), (22, 2, 2)]
 maxVal remains 24
 
 Ninth iteration:

 Extract minimum: (20, 1, 3) (element 20 from list 1)
 Current range: [20, 24]
 Update minRange: [5, 10] -> [20, 24]
 Push next element from list 1: No more elements
 minHeap: [(22, 2, 2), (24, 0, 3)]
 The loop ends because list 1 is exhausted.
 
 Final Output
 The smallest range found is [20, 24], which includes at least one number from each of the k lists.
 */
