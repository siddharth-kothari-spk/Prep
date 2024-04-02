/*
 https://www.geeksforgeeks.org/zigzag-tree-traversal/
 ZigZag Tree Traversal
 Write a function to print ZigZag order traversal of a binary tree
 
 
 Algorithm

 ZigZag Traversal is a variant of level-order traversal where you visit nodes level by level but alternate the direction of visit in each level. So, for the first level, you visit from left to right, for the second level from right to left, and so on.

 Here's how the algorithm works:

 We use two stacks to keep track of nodes at different levels. One stack (stack1) will hold nodes for the current level, and the other stack (stack2) will hold nodes for the next level.
 We initialize leftToRight variable as True to indicate left to right traversal for the first level.
 While there are nodes in either stack1 or stack2:
 If leftToRight is True:
 Pop nodes from stack1 and print their data.
 Push children of the popped node (left child first, then right child) onto stack2 following the right-to-left order.
 Else:
 Pop nodes from stack2 and print their data.
 Push children of the popped node (right child first, then left child) onto stack1 following the left-to-right order.
 Toggle leftToRight for the next level.
 */


class TreeNode: Equatable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
    
  var val: Int
  var left: TreeNode?
  var right: TreeNode?

  init(_ val: Int) {
    self.val = val
  }
}

func zigzagLevelOrder(_ root: TreeNode?) -> [Int] {
  guard let root = root else { return [] }

    var stack1: Stack<TreeNode> = Stack()  // Stack for current level
    var stack2: Stack<TreeNode> = Stack() // Stack for next level
  var result = [Int]()  // Stores level order traversal
  var leftToRight = true  // Flag to indicate traversal direction

    stack1.push(root)
    
  while !stack1.isEmpty || !stack2.isEmpty {
    if leftToRight {
      var level = [Int]()
      while !stack1.isEmpty {
          if let node = stack1.pop() {
              level.append(node.val)
              if let leftChild = node.left {
                  stack2.push(leftChild)
              }
              if let rightChild = node.right {
                stack2.push(rightChild)
              }
          }
      }
      result.append(contentsOf: level)
      leftToRight = false
    } else {
      var level = [Int]()
      while !stack2.isEmpty {
          if let node = stack2.pop() {
              level.append(node.val)
              if let rightChild = node.right {
                stack1.push(rightChild)
              }
              if let leftChild = node.left {
                stack1.push(leftChild)
              }
          }
      }
        result.append(contentsOf: level)
      leftToRight = true
    }
  }

  return result
}

protocol Stackable {
  associatedtype Element
  
  mutating func push(_ element: Element)
  func peek() -> Element?
  mutating func pop() -> Element?
  var isEmpty: Bool { get }
}

extension Stackable {
  var isEmpty: Bool {
    return peek() == nil
  }
}

struct Stack<Element>: Stackable where Element: Equatable {
  private var storage: [Element] = []
  
  mutating func push(_ element: Element) {
    storage.append(element)
  }
  
  func peek() -> Element? {
    return storage.last
  }
  
  mutating func pop() -> Element? {
    return storage.popLast()
  }
}

extension Stack: Equatable {
  static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool {
    return lhs.storage == rhs.storage
  }
}

extension Stack: CustomStringConvertible {
  var description: String {
    return "\(storage)"
  }
}

extension Stack: ExpressibleByArrayLiteral {
  init(arrayLiteral elements: Self.Element...) {
    storage = elements
  }
}


var root: TreeNode = TreeNode(1)

root.left = TreeNode(2)
root.right = TreeNode(3)

root.left?.left = TreeNode(4)
root.left?.right = TreeNode(5)
root.right?.left = TreeNode(6)
root.right?.right = TreeNode(7)

root.left?.left?.left = TreeNode(8)
root.left?.left?.right = TreeNode(9)
root.left?.right?.left = TreeNode(10)
root.left?.right?.right = TreeNode(11)
root.right?.left?.left = TreeNode(12)
root.right?.left?.right = TreeNode(13)
root.right?.right?.left = TreeNode(14)
root.right?.right?.right = TreeNode(15)

print(zigzagLevelOrder(root))
