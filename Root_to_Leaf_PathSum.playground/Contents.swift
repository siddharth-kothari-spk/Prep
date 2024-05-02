/*
 https://www.geeksforgeeks.org/root-to-leaf-path-sum-equal-to-a-given-number/
 Given a binary tree and a number, return true if the tree has a root-to-leaf path such that adding up all the values along the path equals the given number. Return false if no such path can be found
 */

/*
 inding a root-to-leaf path in a binary tree where the sum of the values along the path equals a given number, we can use a recursive approach. This algorithm will traverse the tree, maintaining the sum of the nodes along the current path. When a leaf node (a node with no children) is reached, it will check if the current sum equals the target sum.

 Here’s a step-by-step algorithm using recursion:

     Define the function: Create a function hasPathSum that takes the root of the binary tree and the target sum as arguments.
     Check for an empty tree: If the root is None (i.e., the tree is empty), return False as no path exists.
     Recursive check:
         Subtract the value of the current node from the target sum.
         If the current node is a leaf (no left or right child) and the updated target sum is 0, return True.
         Recursively call the function for the left and right children of the current node.
         Return True if any recursive call returns True.
     Edge cases: Consider trees with negative values, multiple paths with the same sum, or paths that don't end at a leaf but meet the required sum before reaching a leaf.
 */

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
    guard let root = root else {
        return false
    }

    // Calculate the remaining sum by subtracting the node's value from the target sum
    let remainingSum = sum - root.value
    
    // Check if the current node is a leaf (no left or right child)
    if root.left == nil && root.right == nil {
        // Check if the remaining sum is zero at the leaf
        return remainingSum == 0
    }
    
    // Recursively check the left and right subtrees
    return hasPathSum(root.left, remainingSum) || hasPathSum(root.right, remainingSum)
}

// Example usage
let root = TreeNode(5,
                    TreeNode(4,
                             TreeNode(11,
                                      TreeNode(7),
                                      TreeNode(2)
                                     )
                            ),
                    TreeNode(8,
                             TreeNode(13),
                             TreeNode(4, nil,
                                      TreeNode(1)
                                     )
                            )
)

let targetSum = 22
print(hasPathSum(root, targetSum))  // Output: True
