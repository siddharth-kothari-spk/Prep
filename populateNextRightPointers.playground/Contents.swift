/*
 You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:

 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }
 Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

 Initially, all next pointers are set to NULL.

  

 Example 1:


 Input: root = [1,2,3,4,5,6,7]
 Output: [1,#,2,3,#,4,5,6,7,#]
 Explanation: Given the above perfect binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level.
 Example 2:

 Input: root = []
 Output: []

 */

// Solution: https://leetcode.com/problems/populating-next-right-pointers-in-each-node/solutions/1932092/100-fastest-swift-solution-time-o-n-space-o-1


public class Node {
      public var val: Int
      public var left: Node?
      public var right: Node?
        public var next: Node?
      public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
          self.next = nil
      }
  }

class Solution {
    // - Complexity:
    //   - time: O(n), where n is the number of nodes in the binary tree.
    //   - space: O(1), only constant space is used.

    func connect(_ root: Node?) -> Node? {
        var leftMost = root

        while leftMost?.left != nil {
            var head = leftMost
            while head != nil {
                head?.left?.next = head?.right
                if let next = head?.next {
                    head?.right?.next = next.left
                }
                head = head?.next
            }
            leftMost = leftMost?.left
        }

        return root
    }

}

let sol = Solution()
let root = Node(1)
root.left = Node(2)
root.right = Node(3)
root.left?.left = Node(4)
root.left?.right = Node(5)
root.right?.left = Node(6)
root.right?.right = Node(7)
print("Before")
printNextPointers(root)

print(sol.connect(root))

func printNextPointers(_ root: Node?) {
    var current: Node? = root
    while let node = current {
        var temp: Node? = node
        while let innerNode = temp {
            print(innerNode.val, terminator: " ")
            temp = innerNode.next
        }
        print("#")
        current = node.left
    }
}
print("After")
printNextPointers(root)
