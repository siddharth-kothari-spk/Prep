
/*
 https://www.geeksforgeeks.org/sorted-linked-list-to-balanced-bst/
 
 Sorted Linked List to Balanced BST
 Last Updated : 06 Apr, 2023
 Given a Singly Linked List which has data members sorted in ascending order. Construct a Balanced Binary Search Tree which has same data members as the given Linked List.
 Examples:
  

 Input:  Linked List 1->2->3
 Output: A Balanced BST
      2
    /  \
   1    3


 Input: Linked List 1->2->3->4->5->6->7
 Output: A Balanced BST
         4
       /   \
      2     6
    /  \   / \
   1   3  5   7

 Input: Linked List 1->2->3->4
 Output: A Balanced BST
       3
     /  \
    2    4
  /
 1

 Input:  Linked List 1->2->3->4->5->6
 Output: A Balanced BST
       4
     /   \
    2     6
  /  \   /
 1   3  5
 */


// Solution:

/*
 
 Algorithm:

 Middle Node Approach:
     Function: sortedListToBST(head)
       i) Takes the head of the sorted linked list head as input.
    
     Base Case: If the list is empty (head is None), return None.
 
     Find Middle Node:
       i) Use two pointers, slow and fast, to traverse the list.
       ii)  slow moves one step at a time, and fast moves two steps at a time.
       iii) When fast reaches the end (or fast.next is None), slow will be at the middle node.
 
     Create Root Node:
       i) Create a new BST node with the value of the middle node. This will be the root of the BST.
 
     Recursively Build Subtrees:
       i) Call sortedListToBST recursively on the left half of the list (nodes before the middle node) to construct the left subtree.
           a) Pass the slow.prev (node before the middle node) as the new head.
 
       ii) Call sortedListToBST recursively on the right half of the list (nodes after the middle node) to construct the right subtree.
           a) Pass the slow.next (node after the middle node) as the new head.
 
     Connect Subtrees:
        i)Set the left child of the root node to the left subtree.
        ii)Set the right child of the root node to the right subtree.
 
     Return Root Node:
        i)Return the root node of the constructed BST.
 
 Explanation:

 This approach leverages the fact that the middle node of a sorted linked list represents a good approximation of the median value, which helps create a balanced BST. By recursively building the left and right subtrees from the halves of the list, we ensure that the BST maintains height balance.

 Time Complexity: O(n), where n is the number of nodes in the linked list. We traverse the list once to find the middle node and perform constant-time operations at each node. The recursive calls contribute to the linear complexity.

 Space Complexity: O(log n) in the average case due to the balanced nature of the BST. In the worst case (skewed list), it can be O(n) due to the recursion depth. However, this is less likely to occur in practice.
 */

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

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

class Solution {
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        if head == nil {
            return nil
        }
        
        return sortedListToBSTHelper(head, nil)
    }
    
    private func sortedListToBSTHelper(_ head: ListNode?, _ tail: ListNode?) -> TreeNode? {
        if head === tail {
            return nil
        }
        
        let mid = getMiddle(head, tail)
        let root = TreeNode(mid!.val)
        
        root.left = sortedListToBSTHelper(head, mid)
        root.right = sortedListToBSTHelper(mid?.next, tail)
        
        return root
    }
    
    private func getMiddle(_ start: ListNode?, _ end: ListNode?) -> ListNode? {
        var slow = start
        var fast = start
        
        while fast !== end && fast?.next !== end {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }
    
    func traversal(_ head: TreeNode?) {
        guard let head = head else { return }
        print(head.val as Any, terminator: " ")
        traversal(head.left)
        traversal(head.right)
        print("\n")
    }
}

// Helper function to create a linked list from an array
func createLinkedList(_ values: [Int]) -> ListNode? {
    let dummy = ListNode(0)
    var current = dummy
    for value in values {
        current.next = ListNode(value)
        current = current.next!
    }
    return dummy.next
}

// Example usage
let values = [1, 2, 3, 4, 5, 6, 7]
let linkedList = createLinkedList(values)
let solution = Solution()
let bstRoot = solution.sortedListToBST(linkedList)
solution.traversal(bstRoot)
