/*
 Given an integer n, return all the structurally unique BST's (binary search trees), which has exactly n nodes of unique values from 1 to n. Return the answer in any order.

  

 Example 1:


 Input: n = 3
 Output: [[1,null,2,null,3],[1,null,3,2],[2,1,3],[3,1,null,null,2],[3,2,null,1]]
 Example 2:

 Input: n = 1
 Output: [[1]]
 */


// Solution1: https://leetcode.com/problems/unique-binary-search-trees-ii/solutions/1926204/100-fastest-swift-solution

public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init() { self.val = 0; self.left = nil; self.right = nil; }
      public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
      public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
          self.val = val
          self.left = left
          self.right = right
      }
    func printNodes(_ node: TreeNode?) {
        
        guard let node = node else {
            print("null")
            return
        }
        print(node.val)
        
        if let left = node.left {
            printNodes(left)
        }
        else {
            print("null")
        }
        
        if let right = node.right {
            printNodes(right)
        }
        else {
            print("null")
        }
    }
  }

class Solution {
    func generateTrees(_ n: Int) -> [TreeNode?] {
        var nums: [Int] = []
        
        func copyNodes(_ node: TreeNode?, _ left: TreeNode?, _ right: TreeNode?) -> TreeNode? {
            if node == nil { return nil }
            else {
                let newNode = TreeNode(node!.val)
                newNode.left = copyNodes(left, left?.left, left?.right)
                newNode.right = copyNodes(right, right?.left, right?.right)
                return newNode
            }
        }

        func generateNodes(_ node: TreeNode?, _ left: [TreeNode?], _ right: [TreeNode?]) -> [TreeNode?] {
            let leftCount = left.count > 0 ? left.count : 1
            let rightCount = right.count > 0 ? right.count : 1
            var res: [TreeNode?] = []
            
            for i in 0..<leftCount {
                let leftNode = left.count > 0 ? left[i] : nil
                for j in 0..<rightCount {
                    let rightNode = right.count > 0 ? right[j] : nil
                    res.append(copyNodes(node, leftNode, rightNode))
                }
            }
            return res
        }

        func nodes(_ nums: [Int]) -> [TreeNode?] {
            if nums.count == 0 { return [] }
            var res: [TreeNode?] = []

            for (i, num) in nums.enumerated() {
                let node = TreeNode(num)
                let leftNodes = i > 0 ? nodes(Array(nums[0..<i])) : nodes([])
                let rightNodes = i < nums.count - 1 ? nodes(Array(nums[i + 1...nums.count - 1])) : nodes([])
                res += generateNodes(node, leftNodes, rightNodes)
            }
            return res
        }
        
        for num in 1...n { nums.append(num) }
        return nodes(nums)
    }

}

let sol = Solution()
let result1 = sol.generateTrees(3)
for tree in result1 {
    print("---------")
    tree?.printNodes(tree)
}


/*
 Solution2:
 We can use recursion to generate all possible structurally unique BSTs for a given range of values. The idea is to try each value as the root and recursively construct the left and right subtrees. Here's a high-level algorithm:

 Define a function generateTreesHelper that takes two integers, start and end, representing the range of values to consider.
 If start is greater than end, return a list containing a single nil value (representing an empty subtree).
 Initialize an empty list trees.
 Iterate i from start to end (inclusive).
 a. Recursively generate left subtrees by calling generateTreesHelper with start and i - 1.
 b. Recursively generate right subtrees by calling generateTreesHelper with i + 1 and end.
 c. Iterate through all combinations of left and right subtrees and construct a tree with i as the root value.
 Append all generated trees to the trees list.
 Return trees.

 */

func generateTrees(_ n: Int) -> [TreeNode?] {
    func generateTreesHelper(_ start: Int, _ end: Int) -> [TreeNode?] {
        if start > end {
            return [nil]
        }
        
        var trees = [TreeNode?]()
        for i in start...end {
            let leftTrees = generateTreesHelper(start, i - 1)
            let rightTrees = generateTreesHelper(i + 1, end)
            for leftTree in leftTrees {
                for rightTree in rightTrees {
                    let root = TreeNode(i)
                    root.left = leftTree
                    root.right = rightTree
                    trees.append(root)
                }
            }
        }
        return trees
    }
    
    return generateTreesHelper(1, n)
}

// Example usage:
let n1 = 3
let result2 = generateTrees(n1)
for tree in result2 {
    print("---------")
    tree?.printNodes(tree)
}


