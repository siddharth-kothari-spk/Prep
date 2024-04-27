/*
 Maximum sum of nodes in Binary tree
 
 Given a binary tree with a value associated with each node, we need to choose a subset of these nodes such that the sum of selected nodes is maximum under a constraint that no two chosen nodes in the subset should be directly connected, that is, if we have taken a node in our sum then we can’t take any of its children in consideration and vice versa
 */

/*
 the approach can be broken down into considering two scenarios for each node:

     Include the current node: If a node is included in the sum, then its immediate children must be excluded.
     Exclude the current node: If a node is excluded from the sum, then the maximum sum for each of its children is independently calculated, and their results can be freely included in the sum.

 For each node, we will compute two values:

     inc: The maximum sum when the node itself is included.
     exc: The maximum sum when the node itself is excluded.

 Algorithm:

 The algorithm can be implemented by defining a recursive function that traverses the tree and computes the inc and exc values for each node. Here’s a step-by-step breakdown:

     Base Case: If the current node is null, return (0, 0) since there is no contribution to the sum from a null node.
     Recursive Call: Recursively compute the inc and exc values for the left child and the right child of the current node.
     Calculate inc for the current node:
         This will be the sum of the node's value and the exc values of its left and right children (because if we include this node, we cannot include its children).
     Calculate exc for the current node:
         This is the maximum of either including or excluding each child. Hence, it will be computed as the sum of the maximums of inc and exc for both children.
     Return the result: For each node, return both inc and exc values.
 */
class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ value: Int) {
        self.value = value
    }
}

func maxSumNoAdj(_ root: TreeNode?) -> Int {
    // Recursive function to return the tuple (include, exclude)
    func dfs(_ node: TreeNode?) -> (include: Int, exclude: Int) {
        guard let node = node else {
            return (0, 0)
        }
        
        let left = dfs(node.left)
        let right = dfs(node.right)
        
        // Include this node
        let include = node.value + left.exclude + right.exclude
        
        // Exclude this node
        let exclude = max(left.include, left.exclude) + max(right.include, right.exclude)
        
        return (include, exclude)
    }
    
    let result = dfs(root)
    return max(result.include, result.exclude)
}

// Example usage:
let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)

root.left?.left = TreeNode(1)

root.right?.left = TreeNode(4)
root.right?.right = TreeNode(5)

print(maxSumNoAdj(root))  // Output will depend on the structure and values of the tree
