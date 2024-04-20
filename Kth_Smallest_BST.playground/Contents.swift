/*
 Find k-th smallest element in BST (Order Statistics in BST)
 Last Updated : 11 Oct, 2023
 Given the root of a binary search tree and K as input, find Kth smallest element in BST.
 For example, in the following BST, if k = 3, then the output should be 10, and if k = 5, then the output should be 14.


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

class Solution {
  private var count = 0
  private var result = -1

  func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
    traverse(root, k)
    return result
  }

  private func traverse(_ root: TreeNode?, _ k: Int) {
    guard let root = root else { return }
    traverse(root.left, k)
    count += 1
    if count == k {
      result = root.val
      return
    }
    traverse(root.right, k)
  }
}


let root = TreeNode(20)
root.left = TreeNode(8)
root.right = TreeNode(22)

root.left?.left = TreeNode(4)
root.left?.right = TreeNode(12)

root.left?.right?.left = TreeNode(10)
root.left?.right?.right = TreeNode(14)

let sol = Solution()
print(sol.kthSmallest(root, 3))
