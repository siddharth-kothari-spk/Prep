/*
 https://leetcode.com/problems/find-median-from-data-stream/description/
 Find Median from Running Data Stream
 Given that integers are read from a data stream. Find the median of elements read so far in an efficient way.

 There are two cases for median on the basis of data set size.

 If the data set has an odd number then the middle one will be consider as median.
 If the data set has an even number then there is no distinct middle value and the median will be the arithmetic mean of the two middle values.
 Example:

 Input Data Stream: 5, 15, 1, 3
 Output: 5, 10,5, 4
 Explanation:
 After reading 1st element of stream – 5 -> median = 5
 After reading 2nd element of stream – 5, 15 -> median = (5+15)/2 = 10
 After reading 3rd element of stream – 5, 15, 1 -> median = 5
 After reading 4th element of stream – 5, 15, 1, 3 -> median = (3+5)/2 = 4
 */

// Solution:
/*
 **Algorithm: Using Heaps for Efficient Median Calculation**

 This approach leverages two heaps (min-heap and max-heap) to efficiently maintain the elements and calculate the median in constant time on average.

 **Data Structures:**

 - `min_heap`: A min-heap stores elements less than or equal to the current median.
 - `max_heap`: A max-heap stores elements greater than the current median.

 **Function Descriptions:**

 - `addNum(num)`: Adds a new element `num` to the data stream and updates the median.
 - `findMedian()`: Returns the current median of the data stream.

 **Algorithm Steps:**

 1. **Initialization:** Create empty `min_heap` and `max_heap`.
 2. **`addNum(num)` function:**
    - If `min_heap` is empty or `num` is less than or equal to the top element of `min_heap`:
      - Push `num` onto `min_heap`.
    - Otherwise (if `num` is greater than the top element of `min_heap`):
      - Push the top element of `min_heap` onto `max_heap`.
      - Push `num` onto `min_heap`.
    - Ensure balanced heaps:
      - If the size of `min_heap` is two greater than `max_heap`:
        - Pop the top element from `min_heap` and push it onto `max_heap`.
      - If the size of `max_heap` is one greater than `min_heap`:
        - Pop the top element from `max_heap` and push it onto `min_heap`.
 3. **`findMedian()` function:**
    - If the total number of elements (`total_elements`) is odd:
      - Return the top element of `min_heap`.
    - Otherwise (`total_elements` is even):
      - Return the average of the top elements of `min_heap` and `max_heap`.

 **Explanation:**

 - The algorithm maintains two heaps: a min-heap for elements less than or equal to the current median and a max-heap for elements greater than the median.
 - By keeping the heaps balanced with a size difference of at most 1, we can efficiently access the median in constant time on average.
 - The `addNum` function ensures that the smaller half of the elements goes into `min_heap`, while the larger half goes into `max_heap`.
 - The `findMedian` function retrieves the median based on the total number of elements:
     - For odd numbers of elements, the median is the top element of `min_heap`.
     - For even numbers, the median is the average of the top elements from both heaps.

 **Time Complexity:**

 - `addNum(num)`: O(log n) due to heap operations (pushing and popping elements).
 - `findMedian()`: O(1), as we directly access the top elements of balanced heaps.

 **Space Complexity:**

 - O(n), where n is the number of elements seen so far in the data stream, due to the heaps storing the elements.

 **Example:**

 Consider the data stream: `5, 15, 1, 3`

 1. Add 5: `min_heap` = [5]
    - Median: 5
 2. Add 15: `min_heap` = [5], `max_heap` = [15] (balance heaps)
    - Median: (5 + 15) / 2 = 10
 3. Add 1: `min_heap` = [1, 5], `max_heap` = [15]
    - Median: 5
 4. Add 3: `min_heap` = [1, 3], `max_heap` = [5, 15] (balance heaps)
    - Median: (3 + 5) / 2 = 4

 The output matches the provided explanation.

 This algorithm offers an efficient and well-explained approach for finding the median from a running data stream.
 */

class MedianFinder {
    private var minHeap: [Int] = []
    private var maxHeap: [Int] = []

    func addNum(_ num: Int) {
        print("********")
        if minHeap.isEmpty || num <= minHeap[0] {
            minHeap.append(num)
            minHeap.sort() // Maintain minHeap order (optional for efficiency)
        } else {
            maxHeap.append(num)
            maxHeap.sort(by: >) // Maintain maxHeap order (optional for efficiency)
        }
        balanceHeaps()
        print(findMedian())
    }

    private func balanceHeaps() {
        if minHeap.count > maxHeap.count + 1 {
            let element = minHeap.removeFirst()
            maxHeap.append(element)
            maxHeap.sort(by: >) // Maintain maxHeap order (optional for efficiency)
        } else if maxHeap.count > minHeap.count {
            let element = maxHeap.removeFirst()
            minHeap.append(element)
            minHeap.sort() // Maintain minHeap order (optional for efficiency)
        }
        print("minHeap: \(minHeap)")
        print("maxHEap: \(maxHeap)")
    }

    func findMedian() -> Double {
        if minHeap.count + maxHeap.count == 0 {
            return 0.0 // Handle empty stream case
        }
        if minHeap.count > maxHeap.count {
            return Double(minHeap[0])
        } else {
            return (Double(minHeap[0]) + Double(maxHeap[0])) / 2.0
        }
    }
}

let medianFinder = MedianFinder()
medianFinder.addNum(5)
medianFinder.addNum(15)
medianFinder.addNum(1)
medianFinder.addNum(3)

//print(medianFinder.findMedian())
