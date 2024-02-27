/*
 The thief has found himself a new place for his thievery again. There is only one entrance to this area, called root.

 Besides the root, each house has one and only one parent house. After a tour, the smart thief realized that all houses in this place form a binary tree. It will automatically contact the police if two directly-linked houses were broken into on the same night.

 Given the root of the binary tree, return the maximum amount of money the thief can rob without alerting the police.

  

 Example 1:


 Input: root = [3,2,3,null,3,null,1]
 Output: 7
 Explanation: Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
 Example 2:


 Input: root = [3,4,5,1,3,null,1]
 Output: 9
 Explanation: Maximum amount of money the thief can rob = 4 + 5 = 9.
 */

// Sol:

/*
 To solve this problem, we can use dynamic programming with recursion. We'll define a recursive function robSubtree that calculates the maximum amount of money the thief can rob from a subtree rooted at a given node. The function returns a tuple containing two values: the maximum amount of money that can be obtained if the current node is included (withCurrent) and the maximum amount of money that can be obtained if the current node is excluded (withoutCurrent). We'll traverse the tree in a depth-first manner and apply memoization to avoid redundant calculations.

 Here's the algorithm:

 Define a helper function robSubtree that takes a node as input and returns a tuple (withCurrent, withoutCurrent) representing the maximum amount of money that can be obtained if the current node is included and excluded, respectively.
 Base case: If the node is nil, return (0, 0).
 Recursively call robSubtree on the left and right children of the current node to obtain the maximum amounts of money that can be obtained from their subtrees.
 Calculate withCurrent as the sum of the current node's value and the maximum amounts of money obtained from the subtrees of its grandchildren (since the current node cannot be directly linked to its children).
 Calculate withoutCurrent as the maximum of the sums obtained by including or excluding the current node.
 Return the tuple (withCurrent, withoutCurrent).
 */


class TreeNode: Equatable, Hashable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
    
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
    }
}

func rob(_ root: TreeNode?) -> Int {
    // Dictionary to store computed results for each node
    var memo = [TreeNode: (Int, Int)]()
    
    // Helper function to recursively calculate maximum amount of money
    func robSubtree(_ node: TreeNode?) -> (withCurrent: Int, withoutCurrent: Int) {
        print("-------------------------")
        guard let node = node else { return (0, 0) }
        
        // Check if result is memoized
        if let result = memo[node] {
            print(result)
            return result
        }
        
        // Recursively calculate results for left and right subtrees
        let leftResult = robSubtree(node.left)
        let rightResult = robSubtree(node.right)
        
        // Calculate maximum amount of money if current node is included or excluded
        let withCurrent = node.val + leftResult.withoutCurrent + rightResult.withoutCurrent
        let withoutCurrent = max(leftResult.withCurrent, leftResult.withoutCurrent) + max(rightResult.withCurrent, rightResult.withoutCurrent)
        
        print("node.val: \(node.val), withCurrent: \(withCurrent), withoutCurrent: \(withoutCurrent) ")
        // Memoize the result for current node
        memo[node] = (withCurrent, withoutCurrent)
        print(memo)
        
        return (withCurrent, withoutCurrent)
    }
    
    // Start recursion from the root node
    let result = robSubtree(root)
    // Return the maximum amount of money obtained
    return max(result.withCurrent, result.withoutCurrent)
}



// https://leetcode.com/problems/house-robber-iii/solutions/4683158/accepted-swift
class Solution {
    func rob(_ root: TreeNode?) -> Int {

        func go(_ node: TreeNode = root!) -> (rob: Int, norob: Int) {
            print("-------------------------")
            let l: (rob: Int, norob: Int)
            let r: (rob: Int, norob: Int)

            if let ln = node.left { l = go(ln) }
            else { l = (0, 0) }

            if let rn = node.right { r = go(rn) }
            else { r = (0, 0) }
            let rob = node.val + l.norob + r.norob
            let norob = max(l.rob, l.norob) + max(r.rob, r.norob)
            print("node.val: \(node.val), rob: \(rob), norob: \(norob)")
            
            return (rob: rob, norob: norob)
        }

        let res = go()

        return max(res.rob, res.norob)
    }
}

// Test cases
let root1 = TreeNode(3)
root1.left = TreeNode(2)
root1.right = TreeNode(4)
root1.left?.right = TreeNode(5)
root1.right?.right = TreeNode(1)
//print(rob(root1)) // Output: 7

let root2 = TreeNode(3)
root2.left = TreeNode(4)
root2.right = TreeNode(5)
root2.left?.left = TreeNode(1)
root2.left?.right = TreeNode(3)
root2.right?.right = TreeNode(1)
//print(rob(root2)) // Output: 9
let sol = Solution()
print(sol.rob(root1))
