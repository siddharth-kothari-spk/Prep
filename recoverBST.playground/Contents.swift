/*
 You are given the root of a binary search tree (BST), where the values of exactly two nodes of the tree were swapped by mistake. Recover the tree without changing its structure.

  

 Example 1:


 Input: root = [1,3,null,null,2]
 Output: [3,1,null,null,2]
 Explanation: 3 cannot be a left child of 1 because 3 > 1. Swapping 1 and 3 makes the BST valid.
 Example 2:


 Input: root = [3,1,4,null,null,2]
 Output: [2,1,4,null,null,3]
 Explanation: 2 cannot be in the right subtree of 3 because 2 < 3. Swapping 2 and 3 makes the BST valid.
  

 Constraints:

 The number of nodes in the tree is in the range [2, 1000].
 -2^31 <= Node.val <= 2^31 - 1
 
 
 Follow up: A solution using O(n) space is pretty straight-forward. Could you devise a constant O(1) space solution?
 */

/*
 Solution:
 
 To recover the binary search tree (BST) without changing its structure after two nodes have been swapped, you can perform an in-order traversal of the tree. During the traversal, you can identify the two misplaced nodes and swap their values. Here's the step-by-step algorithm:

 Perform an in-order traversal of the BST.
 During the traversal, keep track of the previously visited node (prev) and the two misplaced nodes (first and second).
 If at any point the current node's value is less than the previous node's value (root.val < prev.val), then it indicates a misplaced node.
 If first is nil, assign prev to first.
 Otherwise, assign the current node to second.
 After completing the traversal, swap the values of first and second to recover the BST.
 */


class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

func recoverTree(_ root: TreeNode?) {
    var prev: TreeNode? = nil
    var first: TreeNode? = nil
    var second: TreeNode? = nil
    
    func inorderTraversal(_ root: TreeNode?) {
        guard let root = root else { return }
        
        inorderTraversal(root.left)
        
        if let prev = prev, root.val < prev.val {
            if first == nil {
                first = prev
            }
            second = root
        }
        prev = root
        
        inorderTraversal(root.right)
    }
    
    // Start the in-order traversal
    inorderTraversal(root)
    
    // Swap the values of the misplaced nodes
    if let first = first, let second = second {
        let temp = first.val
        first.val = second.val
        second.val = temp
    }
}

// Example usage:
let root1 = TreeNode(1)
root1.left = TreeNode(3)
root1.left?.right = TreeNode(2)

print("Before1:")
print(root1.val)
print(root1.left?.val as Any)
print(root1.left?.right?.val as Any)

recoverTree(root1)
print("After1:")

print(root1.val)  // Output: 3
print(root1.left?.val as Any)  // Output: 1
print(root1.left?.right?.val as Any)  // Output: 2

print("-------------")

let root2 = TreeNode(3)
root2.left = TreeNode(1)
root2.right = TreeNode(4)
root2.right?.left = TreeNode(2)


print("Before2:")
print(root2.val)
print(root2.left?.val as Any)
print(root2.right?.val as Any)
print(root2.right?.left?.val as Any)

recoverTree(root2)
print("After1:")
print(root2.val)  // Output: 2
print(root2.left?.val as Any)  // Output: 1
print(root2.right?.val as Any)  // Output: 4
print(root2.right?.left?.val as Any)  // Output: 3
