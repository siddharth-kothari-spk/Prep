/*
 Convert a Binary Tree into its Mirror Tree (Invert Binary Tree)
 
 Here's an algorithm to convert a Binary Tree into its Mirror Tree (Invert Binary Tree):

 **Recursive Approach:**

 1. **Base Case:** If the current node (`root`) is `None` (empty tree), return.
 2. **Recursive Calls:**
     - Call the function recursively on the left subtree (`root.left`).
     - Call the function recursively on the right subtree (`root.right`).
 3. **Swap Left and Right Children:** Swap the left and right child nodes of the current node.
     - Temporary variable `temp` = `root.left`
     - `root.left` = `root.right`
     - `root.right` = `temp`

 **Explanation:**

 - The function works by traversing the tree in a post-order fashion (visit left subtree, then right subtree, and lastly the root node).
 - During the traversal, after visiting the left and right subtrees, we swap their references in the current node.
 - This swapping effectively inverts the structure of the tree, making the left subtree the mirror image of the right subtree, and vice versa.

 **Time Complexity:** O(n), where n is the number of nodes in the tree. This is because we visit each node exactly once.

 **Space Complexity:** O(h), where h is the height of the tree. This is due to the recursive calls, which use space for the call stack. In the worst case (skewed tree), the space complexity can be O(n).
*/

public class TreeNode<Value: Comparable> {
  public var val: Value
  public var left: TreeNode<Value>?
  public var right: TreeNode<Value>?

  public init(_ val: Value) {
    self.val = val
    self.left = nil
    self.right = nil
  }
    
    public static func == (lhs: TreeNode<Value>, rhs: TreeNode<Value>) -> Bool {
        lhs.val == rhs.val
    }
    
    func inOrderTraversal(node: TreeNode<Value>?) {
      guard let node = node else { return }
      inOrderTraversal(node: node.left)
        print(node.val, terminator: "->")
      inOrderTraversal(node: node.right)
    }
}

func mirrorTreeRecursive<Value>(_ root: TreeNode<Value>?) {
  guard let root = root else { return }
  mirrorTreeRecursive(root.left)
  mirrorTreeRecursive(root.right)
  swap(&root.left, &root.right)
}

let root = TreeNode(100)
root.left = TreeNode(50)
root.right = TreeNode(80)

root.left?.left = TreeNode(98)
root.left?.right = TreeNode(75)

root.right?.left = TreeNode(81)
root.right?.right = TreeNode(82)


root.left?.left?.right = TreeNode(99)

root.right?.right?.left = TreeNode(87)

root.inOrderTraversal(node: root)
//                 100
//        50                   80
//   98         75     81             82
//  X   99                         87     X

mirrorTreeRecursive(root)
print("\n")

//                 100
//        80                   50
//   82         81     75             89
// 87   X                         99     X

root.inOrderTraversal(node: root)



/*
 Iterative Approach (using Level-Order Traversal):

 Create a queue: Initialize an empty queue to store the tree nodes.
 Enqueue root: If the root node exists, add it to the queue.
 While queue is not empty:
 Dequeue node: Remove the first node from the queue.
 Swap children: If both left and right children exist, swap their references.
 Enqueue children: Add the left and right children of the dequeued node (if they exist) to the back of the queue.
 Explanation:

 This approach uses a queue to perform a level-order traversal of the tree.
 At each level, we swap the left and right children of the nodes in the queue.
 By the time we process all nodes, the entire tree will be mirrored.
 */

func mirrorTreeIterative<Value>(_ root: TreeNode<Value>?) {
  guard let root = root else { return }
  var queue = [TreeNode<Value>]()
  queue.append(root)

  while !queue.isEmpty {
    let node = queue.removeFirst()
    swap(&node.left, &node.right)
    if let left = node.left {
      queue.append(left)
    }
    if let right = node.right {
      queue.append(right)
    }
  }
}

print("\n")
root.inOrderTraversal(node: root)
mirrorTreeIterative(root)
print("\n")
root.inOrderTraversal(node: root)

