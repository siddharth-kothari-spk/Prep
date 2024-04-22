/*
 Maximum Path Sum in a Binary Tree
 Given a binary tree, find the maximum path sum. The path may start and end at any node in the tree.

 Example:

 Input: Root of below tree

        1
       / \
     2   3


 Output: 6
 
 
 To solve the problem of finding the maximum path sum in a binary tree, where the path may start and end at any node, you can use a recursive approach. The main idea is to compute, for each node, the maximum path sum that includes the node itself and possibly one or both of its children.
 
 Algorithm Overview

     Recursive Function: Define a recursive function that computes two things for each node:
         The maximum path sum including the node and possibly extending down one or both of its children. This value is used to potentially update the global maximum path sum.
         The maximum sum of a path that starts at the node and goes down one branch (either left or right). This is the value returned to the parent because a path cannot bend more than once.

     Global Variable: Use a global variable to keep track of the maximum path sum encountered during the recursion.

     Node Structure: Each node of the binary tree contains an integer value and pointers to its left and right children.

     Edge Cases: Handle edge cases where the tree is empty or nodes have negative values.

 Detailed Steps

     Base Case: If the current node is null, return 0. Paths through null nodes do not contribute to any sum.

     Recursive Descent: Recursively find the maximum path sums from the left and right children.

     Local Computation:
         Calculate the maximum path sum passing through the current node using the formula: node.value + max(left_max, 0) + max(right_max, 0). Here, max(left_max, 0) and max(right_max, 0) ensure that you only consider positive contributions from the children.
         Update the global maximum path sum if the computed local sum is greater than the current global maximum.

     Return Value:
         For the current node's parent, the maximum sum that includes the current node and extends down one branch is node.value + max(max(left_max, 0), max(right_max, 0)). This ensures continuity of the path upwards.

     Initialize and Call the Helper:
         Start the recursion from the root and initialize the global maximum sum to a very small number to handle trees with all negative values.
 */

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func maxPathSum(_ root: TreeNode?) -> Int {
    var maxSum = Int.min

    @discardableResult
    func maxGain(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }

        // Max sum on the left and right sub-trees of node
        let leftGain = max(maxGain(node.left), 0)  // Only add positive gains
        let rightGain = max(maxGain(node.right), 0)  // Only add positive gains

        // Price to start a new path where `node` is the highest point
        let priceNewPath = node.val + leftGain + rightGain

        // Update global maxSum if it's better to start a new path
        maxSum = max(maxSum, priceNewPath)

        // For recursion: return the max gain if continue the same path
        return node.val + max(leftGain, rightGain)
    }

    _ = maxGain(root)
    return maxSum
}

// Construct the example tree:
//       1
//      / \
//     2   3
let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)

// Calculate the maximum path sum
let result = maxPathSum(root)
print(result)  // Output: 6

let root2 = TreeNode(10)
root2.left = TreeNode(2)
root2.right = TreeNode(10)

root2.left?.left = TreeNode(20)
root2.left?.right = TreeNode(1)

root2.right?.right = TreeNode(-25)

root2.right?.right?.left = TreeNode(3)
root2.right?.right?.right = TreeNode(4)

print(maxPathSum(root2))


