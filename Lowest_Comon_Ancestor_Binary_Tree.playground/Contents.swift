/*
 Lowest Common Ancestor in a Binary Tree
 What is Lowest Common Ancestor in Binary Tree?
 The lowest common ancestor is the lowest node in the tree that has both n1 and n2 as descendants, where n1 and n2 are the nodes for which we wish to find the LCA. Hence, the LCA of a binary tree with nodes n1 and n2 is the shared ancestor of n1 and n2 that is located farthest from the root.
 */

// Solution:
/*
 Absolutely, here's an algorithm to find the Lowest Common Ancestor (LCA) in a binary tree:

 **Recursive Approach:**

 1. **Base Case:**
     - If the current node is null, return null (no LCA found in this path).
     - If the current node is equal to either n1 or n2, return the current node (it's the LCA if the other node is also present in a subtree).

 2. **Recursive Calls:**
     - Recursively search for n1 and n2 in the left and right subtrees of the current node.
     - Let `left_lca` be the LCA found in the left subtree.
     - Let `right_lca` be the LCA found in the right subtree.

 3. **Return:**
     - If both `left_lca` and `right_lca` are not null, then the current node is the LCA (both nodes found in separate subtrees).
     - Otherwise, return whichever of `left_lca` or `right_lca` is not null (LCA found in one subtree).

 **Explanation:**

 This algorithm works by traversing the tree from the root. At each node, it checks if the node itself is either n1 or n2. If it is, then it has potentially found the LCA. Then, it recursively searches for both n1 and n2 in the left and right subtrees. The key point is that if both `left_lca` and `right_lca` are not null, it means n1 was found in one subtree and n2 in the other, and the current node is the LCA. If only one of them is not null, then the LCA lies in that subtree.

 **Time Complexity:** O(n) in the worst case, where n is the number of nodes in the tree. This is because the algorithm potentially visits every node in the tree.

 **Space Complexity:** O(h), where h is the height of the tree. This is due to the recursive calls and the creation of a call stack.

 **Here's an example implementation in Python:**

 ```python
 class TreeNode:
   def __init__(self, val):
     self.val = val
     self.left = None
     self.right = None

 def lowestCommonAncestor(root, p, q):
   """
   Finds the lowest common ancestor of nodes p and q in a binary tree.

   Args:
       root: The root node of the binary tree.
       p: The first node.
       q: The second node.

   Returns:
       The lowest common ancestor of p and q, or None if not found.
   """
   if not root:
     return None

   if root == p or root == q:
     return root

   left_lca = lowestCommonAncestor(root.left, p, q)
   right_lca = lowestCommonAncestor(root.right, p, q)

   # If both left and right subtrees found an LCA, then current node is LCA.
   if left_lca and right_lca:
     return root

   # Otherwise, return the non-null LCA from left or right subtree.
   return left_lca if left_lca else right_lca
 ```

 This code defines a `TreeNode` class to represent a node in the binary tree and then implements the `lowestCommonAncestor` function using recursion as explained above.
 */

public class TreeNode<Value> {
  public var val: Value
  public var left: TreeNode<Value>?
  public var right: TreeNode<Value>?

  public init(_ val: Value) {
    self.val = val
  }
}

func lowestCommonAncestor<Value>(_ root: TreeNode<Value>?, _ p: TreeNode<Value>, _ q: TreeNode<Value>) -> TreeNode<Value>? {
  guard let root = root else { return nil }

  // If the current node is either n1 or n2, return the current node
  if root === p {
    return p
  } else if root === q {
    return q
  }

  // Recursively search for n1 and n2 in left and right subtrees
  let leftLCA = lowestCommonAncestor(root.left, p, q)
  let rightLCA = lowestCommonAncestor(root.right, p, q)

  // If both left and right subtrees found an LCA, then current node is LCA
    if let _ = leftLCA, let _ = rightLCA {
    return root
  }

  // Otherwise, return the non-null LCA from left or right subtree
  return leftLCA ?? rightLCA
}


var root = TreeNode(1)

root.left = TreeNode(2)
root.right = TreeNode(3)

let node4 = TreeNode(4)
let node5 = TreeNode(5)
let node6 = TreeNode(6)

root.left?.left = node4
root.left?.right = node5
root.right?.left = node6
root.right?.right = TreeNode(7)

print(lowestCommonAncestor(root, node4, node5)?.val as Any)
print(lowestCommonAncestor(root, node6, node5)?.val as Any)


