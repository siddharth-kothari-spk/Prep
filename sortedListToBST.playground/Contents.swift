/*
 Given the head of a singly linked list where elements are sorted in ascending order, convert it to a
 height-balanced
  binary search tree.

  

 Example 1:


 Input: head = [-10,-3,0,5,9]
 Output: [0,-3,9,-10,null,5]
 Explanation: One possible answer is [0,-3,9,-10,null,5], which represents the shown height balanced BST.
 Example 2:

 Input: head = []
 Output: []
 */

/*
 Solution1:
 To convert a sorted singly linked list into a height-balanced binary search tree (BST), you can use a recursive approach. The idea is to find the middle node of the linked list, which will serve as the root of the BST. Then, recursively construct the left and right subtrees by splitting the linked list at the middle node and repeating the process for the left and right halves. Here's how you can implement this algorithm:

 Define a function sortedListToBST that takes the head of the linked list as input and returns the root of the resulting BST.
 Find the middle node of the linked list using the two-pointer technique (fast and slow pointers).
 Split the linked list at the middle node to separate the left and right halves.
 Recursively construct the left subtree by calling sortedListToBST with the left half of the linked list.
 Recursively construct the right subtree by calling sortedListToBST with the right half of the linked list.
 Create a new TreeNode with the value of the middle node and set its left and right children to the roots of the left and right subtrees, respectively.
 Return the root of the BST.
 */

class ListNode: Equatable {
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

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

func sortedListToBST(_ head: ListNode?) -> TreeNode? {
    guard let head = head else { return nil }
    
    // Find the middle node of the linked list using the two-pointer technique
    var prev: ListNode? = nil
    var slow: ListNode? = head
    var fast: ListNode? = head
    
    while let nextFast = fast?.next {
        prev = slow
        slow = slow?.next
        fast = nextFast.next
    }
    
    // Split the linked list at the middle node
    prev?.next = nil
    
    // Create a new TreeNode with the value of the middle node
    let root = TreeNode(slow!.val)
    
    // Recursively construct the left and right subtrees
    root.left = sortedListToBST(head == slow ? nil : head)
    root.right = sortedListToBST(slow?.next)
    
    return root
}

// Function to print the inorder traversal of the BST for testing
func inorderTraversal(_ root: TreeNode?) {
    guard let root = root else { return }
    print(root.val, terminator: " ")
    inorderTraversal(root.left)
    inorderTraversal(root.right)
}


// Example usage:
let head1 = ListNode(-10)
head1.next = ListNode(-3)
head1.next?.next = ListNode(0)
head1.next?.next?.next = ListNode(5)
head1.next?.next?.next?.next = ListNode(9)

let root1 = sortedListToBST(head1)
inorderTraversal(root1)  // Output: -10 -3 0 5 9

//let head2: ListNode? = nil
//let root2 = sortedListToBST(head2)
//inorderTraversal(root2)  // Output:



// Solution2: https://leetcode.com/problems/convert-sorted-list-to-binary-search-tree/solutions/1928048/100-fastest-swift-solution

/*
 // Definition for singly-linked list.
  public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init() { self.val = 0; self.next = nil; }
      public init(_ val: Int) { self.val = val; self.next = nil; }
      public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
  }
 /

 // Definition for a binary tree node.
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
  }
 */
class Solution {
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        var nums: [ListNode] = []
        var curr = head
        
        while curr != nil {
            nums.append(curr!)
            curr = curr?.next
        }
        
        return sortedArrayToBST(nums)
    }
    
    
    func sortedArrayToBST(_ nums: [ListNode]) -> TreeNode? {
        let count = nums.count
        guard count > 0 else { return nil }
        
        let rootIndex = count / 2
        let root = TreeNode(nums[rootIndex].val)
        
        root.left = rootIndex > 0 ? sortedArrayToBST(Array(nums[0..<rootIndex])) : nil
        root.right = rootIndex < count - 1 ? sortedArrayToBST(Array(nums[rootIndex + 1..<count])) : nil
        return root
    }

}

let head2 = ListNode(-10)
let head21 = ListNode(-3)
let head22 = ListNode(0)
let head23 = ListNode(5)
let head24 = ListNode(9)

head2.next = head21
head21.next = head22
head22.next = head23
head23.next = head24


let root2 = Solution().sortedArrayToBST([head2, head21, head22, head23, head24])
inorderTraversal(root1)  // Output: -10 -3 0 5 9
