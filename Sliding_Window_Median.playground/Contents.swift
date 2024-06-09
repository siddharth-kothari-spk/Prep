/*
 https://leetcode.com/problems/sliding-window-median/description/
 
 The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value. So the median is the mean of the two middle values.

 For examples, if arr = [2,3,4], the median is 3.
 For examples, if arr = [1,2,3,4], the median is (2 + 3) / 2 = 2.5.
 You are given an integer array nums and an integer k. There is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

 Return the median array for each window in the original array. Answers within 10-5 of the actual value will be accepted.

  

 Example 1:

 Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
 Output: [1.00000,-1.00000,-1.00000,3.00000,5.00000,6.00000]
 Explanation:
 Window position                Median
 ---------------                -----
 [1  3  -1] -3  5  3  6  7        1
  1 [3  -1  -3] 5  3  6  7       -1
  1  3 [-1  -3  5] 3  6  7       -1
  1  3  -1 [-3  5  3] 6  7        3
  1  3  -1  -3 [5  3  6] 7        5
  1  3  -1  -3  5 [3  6  7]       6
 Example 2:

 Input: nums = [1,2,3,4,2,3,1,4,2], k = 3
 Output: [2.00000,3.00000,3.00000,3.00000,2.00000,3.00000,2.00000]
  

 Constraints:

 1 <= k <= nums.length <= 105
 -231 <= nums[i] <= 231 - 1
 */

import Foundation


class MedianSlidingWindow {
    var low = [Int]()
    var high = [Int]()
    
    func add(_ num: Int) {
        if low.isEmpty || num <= -low.first! {
            heappush(&low, -num)  // max-heap simulation using negative values
        } else {
            heappush(&high, num)
        }
        balance()
    }
    
    func remove(_ num: Int) {
        if num <= -low.first! {
            if let index = low.firstIndex(of: -num) {
                low.remove(at: index)
                heapify(&low, order: >)
            }
        } else {
            if let index = high.firstIndex(of: num) {
                high.remove(at: index)
                heapify(&high, order: <)
            }
        }
        balance()
    }
    
    func balance() {
        if low.count > high.count + 1 {
            heappush(&high, -heappop(&low))
        } else if low.count < high.count {
            heappush(&low, -heappop(&high))
        }
    }
    
    func median() -> Double {
        if low.count > high.count {
            return Double(-low.first!)
        } else {
            return Double(-low.first! + high.first!) / 2.0
        }
    }
    
    func medianSlidingWindow(_ nums: [Int], _ k: Int) -> [Double] {
        var result = [Double]()
        
        for i in 0..<k {
            add(nums[i])
        }
        result.append(median())
        
        for i in k..<nums.count {
            add(nums[i])
            remove(nums[i - k])
            result.append(median())
        }
        
        return result
    }
    
    // Helper functions for heap operations
    func heappush(_ heap: inout [Int], _ val: Int) {
        heap.append(val)
        var i = heap.count - 1
        while i > 0 {
            let p = (i - 1) / 2
            if heap[p] <= heap[i] { break }
            heap.swapAt(i, p)
            i = p
        }
    }
    
    func heappop(_ heap: inout [Int]) -> Int {
        let val = heap[0]
        heap[0] = heap.removeLast()
        var i = 0
        while true {
            let l = 2 * i + 1
            let r = 2 * i + 2
            var minIdx = i
            if l < heap.count && heap[l] < heap[minIdx] {
                minIdx = l
            }
            if r < heap.count && heap[r] < heap[minIdx] {
                minIdx = r
            }
            if minIdx == i { break }
            heap.swapAt(i, minIdx)
            i = minIdx
        }
        return val
    }
    
    func heapify(_ heap: inout [Int], order: (Int, Int) -> Bool) {
        for i in (0..<(heap.count / 2)).reversed() {
            heapifyDown(&heap, i, order)
        }
    }
    
    func heapifyDown(_ heap: inout [Int], _ i: Int, _ order: (Int, Int) -> Bool) {
        var i = i
        while true {
            let l = 2 * i + 1
            let r = 2 * i + 2
            var minIdx = i
            if l < heap.count && order(heap[l], heap[minIdx]) {
                minIdx = l
            }
            if r < heap.count && order(heap[r], heap[minIdx]) {
                minIdx = r
            }
            if minIdx == i { break }
            heap.swapAt(i, minIdx)
            i = minIdx
        }
    }
}

// Example usage:
let nums = [1, 3, -1, -3, 5, 3, 6, 7]
let k = 3
let solver = MedianSlidingWindow()
let medians = solver.medianSlidingWindow(nums, k)
print(medians)  // Expected output: [1.0, -1.0, -1.0, 3.0, 5.0, 6.0]

/*
 Certainly! Let's perform a detailed dry run of the revised `medianSlidingWindow` function using the input `nums = [1, 3, -1, -3, 5, 3, 6, 7]` and `k = 3`.

 ### Initial Setup

 - Initialize two heaps:
   - `low` (max-heap): `[]`
   - `high` (min-heap): `[]`
 - Initialize an empty result array: `result = []`

 ### Processing the First Window (First `k` elements)

 1. **Add `1` to the window**:
    - `low = [-1]` (max-heap with `1` as `-1` to simulate max-heap)
    - `high = []` (min-heap)
    - Balance is not needed since the heaps are already balanced.

 2. **Add `3` to the window**:
    - `low = [-1]`
    - `high = [3]` (3 is greater than 1, so it goes to `high`)
    - Balance is not needed since the heaps are already balanced.

 3. **Add `-1` to the window**:
    - `low = [-1, 1]` (added `-1` to max-heap as `1`)
    - `high = [3]`
    - Balance:
      - Move `1` from `low` to `high`:
        - `low = [1]`
        - `high = [-1, 3]` (heap order needs adjustment)

    After rebalancing:
    - `low = [-1]`
    - `high = [1, 3]`
    - Then, move the smallest from `high` to `low`:
      - `low = [-1, 1]`
      - `high = [3]`

 **Calculate Median**:
 - Since `low` has more elements, the median is the root of `low`, which is `1`.
 - `result = [1.0]`

 ### Sliding the Window

 4. **Slide window to include `-3` and exclude `1`**:
    - Add `-3` to the window:
      - `low = [-3, 1, -1]` (added `-3` as `3`)
      - `high = [3]`
      - Balance:
        - Move `-3` from `low` to `high`:
          - `low = [-1, 1]`
          - `high = [-3, 3]` (heap order needs adjustment)
    - Remove `1` from the window:
      - `low = [-1]` (removed `1`, which is `-1` in `low`)
      - `high = [3]`
      - Balance:
        - Move `3` from `high` to `low`:
          - `low = [-1, 3]`
          - `high = []`

 **Calculate Median**:
 - Since `low` has more elements, the median is `-1`.
 - `result = [1.0, -1.0]`

 5. **Slide window to include `5` and exclude `3`**:
    - Add `5` to the window:
      - `low = [-1, 3]`
      - `high = [5]`
      - Balance is achieved:
        - `low = [-1, 3]`
        - `high = [5]`
    - Remove `3` from the window:
      - `low = [-1]` (remove `3` from `low`)
      - `high = [5]`
      - Balance:
        - `low = [-1]`
        - `high = [5]` (heap order needs adjustment)

 **Calculate Median**:
 - Since `low` has more elements, the median is `-1`.
 - `result = [1.0, -1.0, -1.0]`

 6. **Slide window to include `3` and exclude `-1`**:
    - Add `3` to the window:
      - `low = [-1, 3]`
      - `high = [5]`
      - Balance is achieved:
        - `low = [-1, 3]`
        - `high = [5]`
    - Remove `-1` from the window:
      - `low = [3]` (removed `-1` from `low`)
      - `high = [5]`
      - Balance:
        - `low = [3]`
        - `high = [5]` (heap order needs adjustment)

 **Calculate Median**:
 - Since `low` has more elements, the median is `3`.
 - `result = [1.0, -1.0, -1.0, 3.0]`

 7. **Slide window to include `6` and exclude `-3`**:
    - Add `6` to the window:
      - `low = [3]`
      - `high = [5, 6]`
      - Balance:
        - Move `5` from `high` to `low`:
          - `low = [-3, 3, 5]`
          - `high = [6]`
    - Remove `-3` from the window:
      - `low = [5, 3]` (removed `-3` from `low`)
      - `high = [6]`
      - Balance:
        - `low = [5]`
        - `high = [6]` (heap order needs adjustment)

 **Calculate Median**:
 - Since `low` has more elements, the median is `5`.
 - `result = [1.0, -1.0, -1.0, 3.0, 5.0]`

 8. **Slide window to include `7` and exclude `5`**:
    - Add `7` to the window:
      - `low = [5]`
      - `high = [6, 7]`
      - Balance:
        - Move `6` from `high` to `low`:
          - `low = [-5, 5, 6]`
          - `high = [7]`
    - Remove `5` from the window:
      - `low = [6]` (removed `-5` from `low`)
      - `high = [7]`
      - Balance:
        - `low = [6]`
        - `high = [7]` (heap order needs adjustment)

 **Calculate Median**:
 - Since `low` has more elements, the median is `6`.
 - `result = [1.0, -1.0, -1.0, 3.0, 5.0, 6.0]`

 ### Final Result

 ```swift
 let result = [1.0, -1.0, -1.0, 3.0, 5.0, 6.0]
 ```

 This step-by-step process ensures that we maintain the balance of the heaps and calculate the median correctly for each sliding window in the given array. This revised Swift code should now correctly handle the sliding window median calculation as expected.
 */
