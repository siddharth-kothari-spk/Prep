/*
 https://www.geeksforgeeks.org/sliding-window-maximum-maximum-of-all-subarrays-of-size-k/
 
 Given an array and an integer K, find the maximum for each and every contiguous subarray of size K.

 Examples :

 Input: arr[] = {1, 2, 3, 1, 4, 5, 2, 3, 6}, K = 3
 Output: 3 3 4 5 5 5 6
 Explanation: Maximum of 1, 2, 3 is 3
                        Maximum of 2, 3, 1 is 3
                        Maximum of 3, 1, 4 is 4
                        Maximum of 1, 4, 5 is 5
                        Maximum of 4, 5, 2 is 5
                        Maximum of 5, 2, 3 is 5
                        Maximum of 2, 3, 6 is 6

 Input: arr[] = {8, 5, 10, 7, 9, 4, 15, 12, 90, 13}, K = 4
 Output: 10 10 10 15 15 90 90
 Explanation: Maximum of first 4 elements is 10, similarly for next 4
                        elements (i.e from index 1 to 4) is 10, So the sequence
                        generated is 10 10 10 15 15 90 90
 
 I'd be glad to provide algorithms for finding the Sliding Window Maximum (Maximum of all subarrays of size K) in two efficient approaches:

 **1. Naive Nested Loops Approach (Time Complexity: O(nk))**

 This straightforward approach iterates through the array using nested loops. The outer loop iterates from the beginning of the array to the end minus the window size (k-1). The inner loop iterates through the current window of size k and finds the maximum element within that window.

 ```
 function findMaxInWindow(arr, k) {
   const result = [];
   for (let i = 0; i <= arr.length - k; i++) {
     let max = arr[i];
     for (let j = i + 1; j < i + k; j++) {
       max = Math.max(max, arr[j]);
     }
     result.push(max);
   }
   return result;
 }
 ```

 **2. Optimized Approach using Deque (Time Complexity: O(n))**

 This approach leverages a Deque (Double-Ended Queue) to maintain a queue of elements with decreasing values within the current window. The Deque helps efficiently keep track of the maximum element in the window.

 ```
 function findMaxInWindowDeque(arr, k) {
   const result = [];
   const deque = [];

   // Initialize the Deque for the first window
   for (let i = 0; i < k; i++) {
     while (deque.length > 0 && arr[i] >= arr[deque[deque.length - 1]]) {
       deque.pop(); // Remove smaller elements from the back
     }
     deque.push(i);
   }

   // Process the remaining windows
   for (let i = k; i < arr.length; i++) {
     // Add the current element to the Deque
     while (deque.length > 0 && arr[i] >= arr[deque[deque.length - 1]]) {
       deque.pop();
     }
     deque.push(i);

     // Check if the front element is outside the current window
     if (deque[0] <= i - k) {
       deque.shift(); // Remove elements that are no longer in the window
     }

     // Get the maximum element from the front of the Deque
     result.push(arr[deque[0]]);
   }

   return result;
 }
 ```

 **Explanation of the Deque Approach:**

 1. **Initialization:** In the first window, the Deque is populated with indices of elements in decreasing order using a loop. This ensures that the front element of the Deque always points to the maximum element in the current window.
 2. **Sliding the Window:** As the window moves to the right, new elements are added to the Deque. Before adding, elements with smaller values are removed from the back to maintain the decreasing order.
 3. **Removing Elements Outside the Window:** If the front element's index falls outside the current window (i.e., it's k positions behind the current index), it's removed using `deque.shift()`.
 4. **Finding Maximum:** The maximum element for each window is readily available as the front element of the Deque, and it's appended to the `result` array.

 **Choosing the Right Approach:**

 - For smaller arrays or when K is close to the array size, the naive approach might be sufficient.
 - For larger arrays or when K is much smaller than the array size, the Deque approach is significantly more efficient due to its linear time complexity (O(n)).
 */


func findMaxInWindowDeque(_ arr: [Int], _ k: Int) -> [Int] {
  var result = [Int]()
  var deque = [Int]()

  // Initialize the Deque for the first window
  for i in 0..<k {
    while deque.count > 0 && arr[i] >= arr[deque.last!] {
      deque.removeLast()
    }
    deque.append(i)
  }
    print("deque1: \(deque)")
  // Process the remaining windows
  for i in k..<arr.count {
      print("****: i: \(i)")
    // Add the current element to the Deque
    while deque.count > 0 && arr[i] >= arr[deque.last!] {
      deque.removeLast()
    }
    deque.append(i)
      print("deque2: \(deque)")

    // Check if the front element is outside the current window
    if deque.first! <= i - k {
      deque.removeFirst()
    }
      print("deque3: \(deque)")

    // Get the maximum element from the front of the Deque
    result.append(arr[deque.first!])
      print("result: \(result)")
  }

  return result
}
let arr = [1, 2, 3, 1, 4, 5, 2, 3, 6]
let k = 3

let dequeResult = findMaxInWindowDeque(arr, k)

print(dequeResult) // Output: [3, 3, 4, 5, 5, 5, 6]

/*
 deque1: [2]
 ****: i: 3
 deque2: [2, 3]
 deque3: [2, 3]
 result: [3]
 ****: i: 4
 deque2: [4]
 deque3: [4]
 result: [3, 4]
 ****: i: 5
 deque2: [5]
 deque3: [5]
 result: [3, 4, 5]
 ****: i: 6
 deque2: [5, 6]
 deque3: [5, 6]
 result: [3, 4, 5, 5]
 ****: i: 7
 deque2: [5, 7]
 deque3: [5, 7]
 result: [3, 4, 5, 5, 5]
 ****: i: 8
 deque2: [8]
 deque3: [8]
 result: [3, 4, 5, 5, 5, 6]
 [3, 4, 5, 5, 5, 6]
 */


import Foundation

func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    var deque = [Int]()
    var result = [Int]()
    
    for i in 0..<nums.count {
        // Remove elements not within the sliding window
        if !deque.isEmpty && deque.first! < i - k + 1 {
            deque.removeFirst()
        }
        
        // Remove elements from the deque that are smaller than the current element
        while !deque.isEmpty && nums[deque.last!] < nums[i] {
            deque.removeLast()
        }
        
        // Add the current element's index to the deque
        deque.append(i)
        
        // Once the first window is done, add the maximum to the result list
        if i >= k - 1 {
            result.append(nums[deque.first!])
        }
    }
    
    return result
}

// Example usage
let nums = [1, 3, -1, -3, 5, 3, 6, 7]
let output = maxSlidingWindow(nums, 3)
print(output)  // Output: [3, 3, 5, 5, 6, 7]
