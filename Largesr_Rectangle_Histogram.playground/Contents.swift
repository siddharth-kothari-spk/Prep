/*
 https://www.geeksforgeeks.org/largest-rectangular-area-in-a-histogram-using-stack/
 Largest Rectangular Area in a Histogram using Stack
 Find the largest rectangular area possible in a given histogram where the largest rectangle can be made of a number of contiguous bars whose heights are given in an array. For simplicity, assume that all bars have the same width and the width is 1 unit.

 Example:

 Input: histogram = {6, 2, 5, 4, 5, 1, 6}


Sol:
 
 Here's an algorithm to find the largest rectangular area in a histogram using a stack:

 1. **Initialize:**
    - Create an empty stack.
    - Set `max_area` to 0 to track the maximum area found so far.

 2. **Iterate through the histogram:**
    For each bar `i` in the histogram:
      - While the stack is not empty and the height of the bar at the top of the stack (`stack[-1]`) is greater than or equal to the height of the current bar (`histogram[i]`), pop elements from the stack.
        - Calculate the area of the rectangle formed using the popped bar as follows:
           - `height` = height of the popped bar (`histogram[stack[-1]]`)
           - `width` = (current index `i` - index at the top of the stack before popping - 1)
           - If the stack is empty, consider `width` as `i` itself (`i - (-1) - 1 = i`).
        - Update `max_area` if the calculated area is greater than the current `max_area`.
      - Push the current index `i` onto the stack.

 3. **Process remaining bars:**
    - After iterating through the entire histogram, there might still be elements in the stack.
    - Pop elements from the stack and calculate the area using the remaining bars as follows:
       - `height` = height of the popped bar (`histogram[stack[-1]]`)
       - `width` = length of the histogram (`len(histogram)`) - index at the top of the stack before popping - 1
       - If the stack is empty, consider `width` as the length of the histogram itself (`len(histogram) - (-1) - 1 = len(histogram)`).
      - Update `max_area` if the calculated area is greater than the current `max_area`.

 4. **Return:**
    - Return the `max_area`.

 This algorithm efficiently calculates the largest rectangle by utilizing the stack to keep track of bars that can potentially form the left boundary of the rectangle. By processing bars from left to right, we can calculate the area when a shorter bar is encountered that can act as the height of the rectangle.
 */


func largestRectangleArea(_ heights: [Int]) -> Int {
  var stack = [Int]() // Store indices of bars
  var maxArea = 0

  for (i, height) in heights.enumerated() {
      print("*****")
      print("i: \(i), height: \(height)")
    while !stack.isEmpty && heights[stack.last!] >= height {
        print("stack1: \(stack)")
      let poppedIndex = stack.removeLast()
      let width = stack.isEmpty ? i : (i - stack.last!) - 1
        print("stack2: \(stack)")
        print("poppedIndex: \(poppedIndex), width: \(width)")
      let area = heights[poppedIndex] * width
      maxArea = max(maxArea, area)
        print("maxArea: \(maxArea), area: \(area)")
    }
    stack.append(i)
      print("stack3: \(stack)")
  }

  // Process remaining bars in the stack
  while !stack.isEmpty {
    let poppedIndex = stack.removeLast()
    let width = heights.count - (stack.isEmpty ? -1 : stack.last!) - 1
    let area = heights[poppedIndex] * width
    maxArea = max(maxArea, area)
  }

  return maxArea
}

print(largestRectangleArea([6, 2, 5, 4, 5, 1, 6]))
// Output = 12 (for bars 5,4,5 we have width = 3 and height = 4)

