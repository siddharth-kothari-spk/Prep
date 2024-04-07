/*
 Bottom View of a Binary Tree
 Given a Binary Tree, The task is to print the bottom view from left to right. 
 A node x is there in output if x is the bottommost node at its horizontal distance.
 The horizontal distance of the left child of a node x is equal to a horizontal distance of x minus 1, and that of a right child is the horizontal distance of x plus 1.
 
 Input:                 20
                     /     \
                    8      22
                  /  \       \
                 5    3      25
                     / \
                    10  14

 Output: 5, 10, 3, 14, 25.


 Input:              20
                    /  \
                   8    22
                  / \   / \
                 5  3  4  25
                   / \
                  10  14
 Output: 5 10 4 14 25.
 Explanation: If there are multiple bottom-most nodes for a horizontal distance from the root, then print the later one in the level traversal. 3 and 4 are both the bottom-most nodes at a horizontal distance of 0, we need to print 4.
 
 */

// Solution:
/*
 Algorithm:

 Initialize:
 A dictionary map to store horizontal distance (HD) as key and node value.
 A queue q to perform level-order traversal.
 
 Assign HD:
 Set the root node's HD to 0.
 Enqueue the root node and its HD in the queue.
 
 Level-order traversal:
 While the queue is not empty:
 Dequeue a node temp and its HD (hd).
 Update the value in the map for the current HD with temp.data. This ensures only the bottommost node for each HD is stored.
 If the left child exists, enqueue it with HD (hd - 1).
 If the right child exists, enqueue it with HD (hd + 1).
 
 Print bottom view:
 Iterate over the map in key (HD) order and print the corresponding values.

 */
import Foundation

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

func bottomView(_ root: TreeNode?) -> [Int] {
  var map: [Int: Int] = [:]
  var queue: [(TreeNode, Int)] = []

  if root == nil {
    return []
  }

  queue.append((root!, 0))

  while !queue.isEmpty {
    let (node, hd) = queue.removeFirst()
    map[hd] = node.val

    if let left = node.left {
      queue.append((left, hd - 1))
    }
    if let right = node.right {
      queue.append((right, hd + 1))
    }
  }
  let values = map.map { $0.value }
  return values
}


let root = TreeNode(20)

root.left = TreeNode(8)
root.right = TreeNode(22)

root.left?.left = TreeNode(5)
root.left?.right = TreeNode(3)

root.right?.right = TreeNode(25)

root.left?.right?.left = TreeNode(10)
root.left?.right?.right = TreeNode(14)

/*
               20
             /     \
            8      22
          /  \       \
         5    3      25
             / \
            10  14
*/

print(bottomView(root))


let root2 = TreeNode(20)

root2.left = TreeNode(8)
root2.right = TreeNode(22)

root2.left?.left = TreeNode(5)
root2.left?.right = TreeNode(3)

root2.right?.left = TreeNode(4)
root2.right?.right = TreeNode(25)

root2.left?.right?.left = TreeNode(10)
root2.left?.right?.right = TreeNode(14)

/*
 Input:              20
                    /  \
                   8    22
                  / \   / \
                 5  3  4  25
                   / \
                  10  14
 */
print(bottomView(root2))
