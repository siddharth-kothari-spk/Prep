/*
 Boundary Traversal of a Binary Tree
 
 Boundary Traversal of binary tree
 Given a binary tree, print boundary nodes of the binary tree Anti-Clockwise starting from the root.

  The boundary includes

 left boundary (nodes on left excluding leaf nodes)
 leaves (consist of only the leaf nodes)
 right boundary (nodes on right excluding leaf nodes)
 The left boundary is defined as the path from the root to the left-most node. The right boundary is defined as the path from the root to the right-most node. If the root doesn’t have left subtree or right subtree, then the root itself is left boundary or right boundary. Note this definition only applies to the input binary tree, and not apply to any subtrees.
 The left-most node is defined as a leaf node you could reach when you always firstly travel to the left subtree if it exists. If not, travel to the right subtree. Repeat until you reach a leaf node.
 The right-most node is also defined in the same way with left and right exchanged.
 
 */

// Solution:

/*
 algorithm performs the boundary traversal in three steps:

 Left Boundary: It starts from the root and goes down the left side of the tree, printing only non-leaf nodes. If a node doesn't have a left child, it moves to the right child in the next iteration. This continues until a null node is reached.

 Leaf Nodes: It performs a regular in-order traversal (left, root, right) but only prints leaf nodes.

 Right Boundary (Reverse): It uses a stack to traverse the right side of the tree in a similar way to the left boundary. However, it pushes non-leaf nodes onto the stack instead of printing them directly. Finally, it pops elements from the stack and prints them to achieve a bottom-up, right-to-left order for the right boundary.

 This approach ensures an anti-clockwise traversal of the boundary nodes of the binary tree.
 */

class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?

  init(_ val: Int) {
    self.val = val
//    self.left = nil
//    self.right = nil
  }
}

func boundaryTraversal(_ root: TreeNode?) {
  guard let root = root else { return }

  // Print root if it's not a leaf node
  if !isLeaf(root) {
    print(root.val, terminator: " ")
  }

  // Left boundary (excluding leaf nodes)
 // leftBoundary(root.left)

  // Print all leaf nodes (left to right)
  leafNodes(root)

  // Right boundary (excluding leaf nodes) in reverse order
 // rightBoundary(root.right)
}

func isLeaf(_ node: TreeNode?) -> Bool {
  return node?.left == nil && node?.right == nil
}

func leftBoundary(_ node: TreeNode?) {
    var node = node
  while node != nil {
    if !isLeaf(node) {
        print(node?.val, terminator: " ")
    }
      if let left = node?.left {
      node = left
    } else if let right = node?.right {
      node = right
    }
  }
}

func leafNodes(_ node: TreeNode?) {
  if let node = node {
    leafNodes(node.left)
    if isLeaf(node) {
      print(node.val, terminator: " ")
    }
    leafNodes(node.right)
  }
}

func rightBoundary(_ node: TreeNode?) {
  var stack = [Int]()
    var node = node
  while node != nil {
    if !isLeaf(node) {
      stack.append(node!.val)
    }
    if let right = node?.right {
      node = right
    } else if let left = node?.left {
      node = left
    }
  }

  // Print right boundary in reverse order
  while !stack.isEmpty {
    print(stack.removeLast(), terminator: " ")
  }
}


let root = TreeNode(20)

root.left = TreeNode(8)
root.right = TreeNode(22)

root.left?.left = TreeNode(4)
root.left?.right = TreeNode(12)

root.right?.right = TreeNode(25)

root.left?.right?.left = TreeNode(10)
root.left?.right?.right = TreeNode(14)

print(boundaryTraversal(root))
