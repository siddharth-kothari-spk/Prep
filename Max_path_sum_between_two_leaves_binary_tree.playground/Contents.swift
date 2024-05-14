/*
 https://www.geeksforgeeks.org/find-maximum-path-sum-two-leaves-binary-tree/
 
 To find the maximum path sum between two leaves of a binary tree, we need to consider the path that goes through the root of the tree. The idea is to find the maximum path sum between any two leaves by leveraging a recursive approach that computes the maximum path sum for each subtree.

 Here's a step-by-step algorithm to achieve this:

     Define a helper function to calculate the maximum path sum from any node to its leaf. During this calculation, also update the maximum path sum that passes through the current node.

     Use a global or static variable to keep track of the maximum path sum between two leaves.

     Traverse the tree using a depth-first search (DFS) approach to calculate the path sums.
 */

import Foundation

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
}

class BinaryTree {
    var root: TreeNode?
    
    init(_ root: TreeNode?) {
        self.root = root
    }
    
    func maxPathSumBetweenLeaves() -> Int {
        var result = Int.min
        
        func maxPathSumUtil(_ node: TreeNode?) -> Int {
            guard let node = node else {
                return 0
            }
            
            if node.left == nil && node.right == nil {
                return node.value
            }
            
            let leftSum = maxPathSumUtil(node.left)
            let rightSum = maxPathSumUtil(node.right)
            
            if let left = node.left, let right = node.right {
                result = max(result, leftSum + rightSum + node.value)
                return max(leftSum, rightSum) + node.value
            }
            
            return node.left == nil ? rightSum + node.value : leftSum + node.value
        }
        
        _ = maxPathSumUtil(root)
        return result
    }
}

/* Example usage:

# Example usage:
# Construct the binary tree
#        10
#       /  \
#      2   10
#     / \    \
#    20  1   -25
#              / \
#             3   4

*/
let root = TreeNode(10)
root.left = TreeNode(2)
root.right = TreeNode(10)
root.left?.left = TreeNode(20)
root.left?.right = TreeNode(1)
root.right?.right = TreeNode(-25)
root.right?.right?.left = TreeNode(3)
root.right?.right?.right = TreeNode(4)

let tree = BinaryTree(root)
print("Maximum path sum between two leaves is \(tree.maxPathSumBetweenLeaves())")


// May or may not go through root

class BinaryTree2 {
    var root: TreeNode?
    
    init(_ root: TreeNode?) {
        self.root = root
    }
    
    func maxPathSum() -> Int {
        var result = Int.min
        
        // Helper function to compute the maximum path sum with recursion
        @discardableResult
        func maxPathSumUtil(_ node: TreeNode?) -> Int {
            guard let node = node else {
                return 0
            }
            
            // Recursively get the maximum path sum of the left and right subtrees
            let leftSum = max(0, maxPathSumUtil(node.left))  // Ignore negative paths
            let rightSum = max(0, maxPathSumUtil(node.right)) // Ignore negative paths
            
            // Update the result if the current node forms a path with a higher sum
            result = max(result, leftSum + rightSum + node.value)
            
            // Return the maximum path sum "starting" from the current node
            return node.value + max(leftSum, rightSum)
        }
        
        // Start the recursion from the root
        _ = maxPathSumUtil(root)
        
        // Return the result, which holds the maximum path sum found
        return result
    }
}

/* Example usage:

# Example usage:
# Construct the binary tree
#        10
#       /  \
#      2   10
#     / \    \
#    20  1   -25
#              / \
#             3   4

*/
let root2 = TreeNode(10)
root2.left = TreeNode(2)
root2.right = TreeNode(10)
root2.left?.left = TreeNode(20)
root2.left?.right = TreeNode(1)
root2.right?.right = TreeNode(-25)
root2.right?.right?.left = TreeNode(3)
root2.right?.right?.right = TreeNode(4)

let tree2 = BinaryTree2(root2)
print("Maximum path sum is \(tree2.maxPathSum())")
