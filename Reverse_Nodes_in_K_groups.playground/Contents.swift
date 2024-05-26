/*
 https://leetcode.com/problems/reverse-nodes-in-k-group/description/
 Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

 k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.

 You may not alter the values in the list's nodes, only nodes themselves may be changed.

  

 Example 1:


 Input: head = [1,2,3,4,5], k = 2
 Output: [2,1,4,3,5]
 Example 2:


 Input: head = [1,2,3,4,5], k = 3
 Output: [3,2,1,4,5]
  

 Constraints:

 The number of nodes in the list is n.
 1 <= k <= n <= 5000
 0 <= Node.val <= 1000
  

 Follow-up: Can you solve the problem in O(1) extra memory space?
 */

/*
 Algorithm
 Initialize Pointers:

 Create a dummy node that points to the head of the linked list. This helps in handling edge cases.
 Initialize three pointers: prev (initially pointing to the dummy node), curr (initially pointing to the head), and next (to keep track of the next node).
 Count Nodes:

 Traverse the linked list to count the total number of nodes.
 Reverse in Groups:

 While there are at least k nodes left in the list:
 Use a loop to reverse the next k nodes.
 Adjust the pointers accordingly to connect the reversed part with the previous part and the next part of the list.
 Handle Remaining Nodes:

 If there are less than k nodes left, they remain as is.
 */
class ListNode {
    let value: Int
    var next: ListNode?
    
    init(value: Int, next: ListNode?) {
        self.value = value
        self.next = next
    }
    
    convenience init(value: Int) {
        self.init(value: value, next: nil)
    }
}

func reverseNodesInGroups(_ head: ListNode, _ k: Int) -> ListNode {
    var dummy = ListNode(value: 0, next: head)
    var prev = dummy
    
    var count = 0
    var node: ListNode? = head
    while node != nil {
        count += 1
        node = node?.next ?? nil
    }
    print("count: \(count)")
    
    while count >= k {
        print("-------while------------")
        print("k: \(k)", terminator: " | ")
        var curr = prev.next
        var next = curr?.next
        print("curr = \(curr?.value), next = \(next?.value)")
        
        for index in 1...k-1 {
            print("index: \(index)")
            //print("before: \(printNodes(dummy))")
            curr?.next = next?.next
            next?.next = prev.next
            prev.next = next
            next = curr?.next
            print("after: \(printNodes(dummy))")
        }
        if let curr = curr {
            prev = curr
        }
        count -= k
    }
    guard let result = dummy.next else {
        return dummy
    }
    return result
}

let node: ListNode = ListNode(value: 1)
node.next = ListNode(value: 2)
node.next?.next = ListNode(value: 3)
node.next?.next?.next = ListNode(value: 4)
node.next?.next?.next?.next = ListNode(value: 5)

var checkNode: ListNode? = node
printNodes(checkNode)

print()
print("sample 1")
var result: ListNode? = reverseNodesInGroups(node, 2)
printNodes(result)

func printNodes(_ node: ListNode?) {
    var node = node
    while node != nil, let value = node?.value {
        print(value, terminator: " -> ")
        node = node?.next ?? nil
    }
}
