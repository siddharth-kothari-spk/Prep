

/*
 Solution 2: using stack previous Smaller and next Smaller
 */
import Foundation

struct Stack<Element> {
  private var items: [Element] = []
  
  public mutating func push(_ element: Element) {
    items.append(element)
  }
  
  public mutating func pop() -> Element? {
    return items.popLast()
  }
  
  public func peek() -> Element? {
    return items.last
  }
  
  public var isEmpty: Bool {
    return items.isEmpty
  }
    
    func description() {
        print("*****")
        for item in items {
            print(item)
        }
        print("------")
    }
}

func largestAreaHistogram(_ heights: [Int]) -> Int {
    
    var maxArea: Int = 0
    var previousSmall: [Int] = []
    var nextSmall: [Int] = []
    
    previousSmall = previousSmallArray(heights)
    print(previousSmall)
    nextSmall = nextSmallArray(heights)
    print(nextSmall)
    
    for index in 0..<heights.count {
        var currentArea = (nextSmall[index] - previousSmall[index] - 1) * heights[index]
        maxArea = max(maxArea, currentArea)
    }
    return maxArea
}

func previousSmallArray(_ heights: [Int]) -> [Int] {
    var previousSmall: [Int] = Array(repeating: Int.max, count: heights.count)
    var stack: Stack<Int> = Stack()
    
    for index in 0..<heights.count {
        while !stack.isEmpty && heights[stack.peek()!] >= heights[index] {
            stack.pop()
        }
        if stack.isEmpty {
            previousSmall[index] = -1
        }
        else {
            previousSmall[index] = stack.peek()!
        }
        stack.push(index)
    }
    return previousSmall
}

func nextSmallArray(_ heights: [Int]) -> [Int] {
    var nextSmall: [Int] = Array(repeating: Int.max, count: heights.count)
    var stack: Stack<Int> = Stack()
    
    for index in (0..<heights.count).reversed() {
        while !stack.isEmpty && heights[stack.peek()!] >= heights[index] {
            stack.pop()
        }
        if stack.isEmpty {
            nextSmall[index] = heights.count
        }
        else {
            nextSmall[index] = stack.peek()!
        }
        stack.push(index)
    }
    return nextSmall
}

largestAreaHistogram([6, 2, 5, 4, 5, 1, 6])
//largestAreaHistogram([4,2,1,5,6,3,2,4,2])
