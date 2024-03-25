/*
 https://www.geeksforgeeks.org/median-of-two-sorted-arrays-of-different-sizes/
 Median of two Sorted Arrays of Different Sizes
  Given two sorted arrays, a[] and b[], the task is to find the median of these sorted arrays, where N is the number of elements in the first array, and M is the number of elements in the second array.

 This is an extension of Median of two sorted arrays of equal size problem. Here we handle arrays of unequal size also.

 Examples:

 Input: a[] = {-5, 3, 6, 12, 15}, b[] = {-12, -10, -6, -3, 4, 10}
 Output: The median is 3.
 Explanation: The merged array is: ar3[] = {-12, -10, -6, -5 , -3, 3, 4, 6, 10, 12, 15}.
 So the median of the merged array is 3


 Input: a[] = {2, 3, 5, 8}, b[] = {10, 12, 14, 16, 18, 20}
 Output: The median is 11.
 Explanation : The merged array is: ar3[] = {2, 3, 5, 8, 10, 12, 14, 16, 18, 20}
 If the number of the elements are even. So there are two middle elements.
 Take the average between the two: (10 + 12) / 2 = 11.
 
 
 Solution:
 
 Here's an efficient algorithm to find the median of two sorted arrays with different sizes:

 **Binary Search Approach (Time Complexity: O(log(min(m, n)))**

 This method leverages the fact that the arrays are sorted. It avoids creating a new merged array altogether.

 1. Define `m` and `n` as the lengths of the first and second arrays, respectively.
 2. Let `med_index` be the position of the median element in the virtually merged array (considering both arrays as one sorted sequence). We can calculate `med_index` as:
    - If (m + n) is odd: `med_index = (m + n) // 2`
    - If (m + n) is even: `med_index = (m + n) // 2 - 1` (since the median is the average of two middle elements)
 3. We'll use binary search on the first array (`arr1`). Here's the loop:
    - Initialize `low` to 0 and `high` to `m`.
    - While `low <= high`:
       - Calculate the middle index in `arr1`: `mid1 = (low + high) // 2`
       - Due to the sorted nature of the arrays, we can use the elements at `mid1` (in `arr1`) and `med_index - mid1` (in `arr2`) to find the potential median:
          - If `arr1[mid1] <= arr2[med_index - mid1]` and `(mid1 == m || arr1[mid1 + 1] >= arr2[med_index - mid1 - 1])`:
             - This condition indicates that `arr1[mid1]` is a potential median candidate because elements to its left in `arr1` and to its right in `arr2` are all less than or equal to it.
             - Set `high = mid1 - 1` to search for a smaller median in the left half of `arr1`.
          - If `arr1[mid1] > arr2[med_index - mid1]`:
             - This means the median must be in the right half of `arr1` combined with the left half of `arr2`.
             - Set `low = mid1 + 1` to continue searching in the right half.
 4. Once the loop terminates, `low` will point to the position of the median element (or the element just smaller than the median in the case of an even-sized merged array).
 5. To handle even-sized merged arrays, calculate the median as:
    - If (m + n) is even: `median = (arr1[low] + max(arr2[med_index - low - 1], arr1[m - 1])) / 2.0`
    - If (m + n) is odd: `median = arr1[low]`

 **Explanation:**

 This approach efficiently finds the median by strategically comparing elements from both arrays based on the calculated `med_index`. It avoids creating a new merged array, reducing space complexity.

 **Additional Notes:**

 - There's a variation where you can perform the binary search on the second array (`arr2`) instead, depending on the size relationship between `m` and `n`.
 - This algorithm has a time complexity of O(log(min(m, n))) due to the binary search, making it efficient for larger arrays.

 */

// courtsey: https://www.youtube.com/watch?v=LPFhl65R7ww&ab_channel=TusharRoy-CodingMadeSimple

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
  let m = nums1.count
  let n = nums2.count
    
    if m > n {
        findMedianSortedArrays(nums2, nums1)
    }

  // Handle empty arrays
  if m == 0 {
    return n % 2 == 0 ? (Double(nums2[n / 2]) + Double(nums2[n / 2 - 1])) / 2.0 : Double(nums2[n / 2])
  }
  if n == 0 {
    return m % 2 == 0 ? (Double(nums1[m / 2]) + Double(nums1[m / 2 - 1])) / 2.0 : Double(nums1[m / 2])
  }

  let medIndex = (m + n) / 2
    print("medIndex: \(medIndex)")

  var low = 0
  var high = m

  while low <= high {
      let partitionX = (low + high) / 2
      let partitionY = (low + high + 1) / 2
    let maxLeftX = partitionX == 0 ? Int.min : nums1[partitionX - 1]
    let minRightX = partitionX == m ? Int.max : nums1[partitionX]
      
      let maxLeftY = partitionY == 0 ? Int.min : nums2[partitionY - 1]
      let minRightY = partitionY == n ? Int.max : nums2[partitionY]
      
    if maxLeftX <= minRightY && maxLeftY <= minRightX {
      // Potential median found
      if (m + n) % 2 == 0 {
          return Double((max(maxLeftX, maxLeftY) + min(minRightX, minRightY)) / 2)
      } else {
        return Double(max(maxLeftX, maxLeftY))
      }
    } else if maxLeftX < minRightY {
      // Median must be in right half of arr1 and left half of arr2
      low = partitionX + 1
    } else {
      // Median must be in left half of arr1 and right half of arr2
      high = partitionX - 1
    }
  }

  return 0.0 // Should not reach here
}
let nums1 = [-5, 3, 6, 12, 15]
let nums2 = [-12, -10, -6, -3, 4, 10]
findMedianSortedArrays(nums1, nums2)

var mergedArray = [nums1, nums2].reduce([]) { partialResult, element in
    partialResult + element
}.sorted()
print(mergedArray)
