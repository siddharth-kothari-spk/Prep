/*
 Print Left View of a Binary Tree
 
 Given a Binary Tree, the task is to print the left view of the Binary Tree. The left view of a Binary Tree is a set of leftmost nodes for every level.

 Examples:

 Input:
                    4
                 /   \
               5     2
                    /   \
                 3     1
               /  \
            6    7

 Output: 4 5 3 6
 */

// Solution 1:
/*
 Level Order Traversal

 This approach uses a queue to perform a level-order traversal of the tree. We keep track of the current level during the traversal. For each level, we only print the first node encountered.

 Algorithm:

 1.Create a queue to store tree nodes.
 
 2.Enqueue the root node (if it exists).
 
 3.While the queue is not empty:
  a.Dequeue a node from the queue.
  b.If the current level is greater than the previously visited level (or it's the first node), print the node's value.
  c.Increment the current level.
  d.Enqueue the node's left child (if it exists).
  e.Enqueue the node's right child (if it exists).
 

class TreeNode: Equatable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.val == rhs.val
    }
    
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(_ val: Int) {
    self.val = val
//    self.left = nil
//    self.right = nil
  }
}

func leftViewLevelOrder(_ root: TreeNode?) {
  guard let root = root else { return }
    var queue: Queue<TreeNode> = Queue()
  queue.enqueue(root)
  var currentLevel = 0
  var previousLevel = -1
  
  while !queue.isEmpty {
    let node = queue.dequeue()!
    if currentLevel > previousLevel {
      print(node.val)
      previousLevel = currentLevel
    }
      currentLevel += 1
      if let leftChild = node.left {
        queue.enqueue(leftChild)
      }
      if let rightChild = node.right {
        queue.enqueue(rightChild)
      }
  }
}


protocol Queueable {
    associatedtype Element
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    func peek() -> Element?
    var isEmpty: Bool { get }
}

extension Queueable {
    var isEmpty: Bool {
        return peek() == nil
    }
}

struct Queue<Element>: Queueable where Element: Equatable {
    
    private var storage: [Element] = []
    
    mutating func enqueue(_ element: Element) {
      storage.append(element)
    }
    
    mutating func dequeue() -> Element? {
        storage.removeFirst()
    }
    
    func peek() -> Element? {
        storage.last
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

print(leftViewLevelOrder(root))
//         1
//   2           3
// 4    5     6     7
//8 9 10 11 12 13 14 15
*/


// Solution 2:
/*
 Recursive Approach (Modified Preorder Traversal)

 This method utilizes a modified preorder traversal. We keep track of the current level during the recursion. For each node, we first visit the left child and then the right child. However, we only print the node's value if the current level is not yet seen in a previous call (i.e., it's the first node visited at that level).

 Algorithm:

 Define a function leftView(node, level, visitedLevel):
  If the node is None, return.
  If level is greater than visitedLevel:
    Update visitedLevel to level.
    Print the node's value.
  Recursively call leftView on the left child with incremented level.
  Recursively call leftView on the right child with the same level.
 */

class TreeNode: Equatable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.val == rhs.val
    }
    
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(_ val: Int) {
    self.val = val
  }
}

func leftView(_ root: TreeNode?, level: Int, visitedLevel: inout Int) {
  guard let node = root else { return }
  if level > visitedLevel {
    visitedLevel = level
    print(node.val)
  }
  leftView(node.left, level: level + 1, visitedLevel: &visitedLevel)
  leftView(node.right, level: level, visitedLevel: &visitedLevel)
}

func leftViewIterative(_ root: TreeNode?) {
  var visitedLevel = -1
  leftView(root, level: 0, visitedLevel: &visitedLevel)
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

print(leftViewIterative(root))
