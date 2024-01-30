/*
 Container With Most Water
 
 You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).

 Find two lines that together with the x-axis form a container, such that the container contains the most water.

 Return the maximum amount of water a container can store.

 Notice that you may not slant the container.

  

 Example 1:


 Input: height = [1,8,6,2,5,4,8,3,7]
 Output: 49
 Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
 Example 2:

 Input: height = [1,1]
 Output: 1
  

 Constraints:

 n == height.length
 2 <= n <= 105
 0 <= height[i] <= 104
 */

/*
 Solution: https://leetcode.com/problems/container-with-most-water/solutions/3441091/best-swift-solution-easy-to-understand
 Approach
 The two pointers are initialized to the first and last indices of the array respectively.

 In each iteration of the while loop, the area between the two vertical lines is calculated by multiplying the minimum height between the two lines with the distance between them. The minimum height is chosen because the area of the container is limited by the shorter of the two lines.

 The maximum area is then updated by comparing it with the area calculated in the current iteration.

 The pointers are then moved towards each other by incrementing the lower pointer if the height at that index is less than the height at the higher pointer, or by decrementing the higher pointer if the opposite is true. This is because we can only increase the area by moving the pointer with the shorter height towards the center, as moving the pointer with the larger height would only decrease the distance between the two lines and result in a smaller area.
 */

func containerWithMostWater(_ heights: [Int]) -> Int {
    var start = 0
    var end = heights.count - 1
    var mostWater = 0
    
    while start < end {
        let area = min(heights[start], heights[end]) * (end - start)
        mostWater = max(area, mostWater)
        
        if heights[start] < heights[end] {
            start += 1
        }
        else {
            end -= 1
        }
    }
    return mostWater
    
}

print(containerWithMostWater([1,8,6,2,5,4,8,3,7]))
