import UIKit

// To find the conflicting node (the point where two linked lists intersect) between two singly linked lists

// Approach 1:
/*
 Method 1: Using difference in lengths

     Calculate the lengths of both linked lists.
     Find the length difference between the two lists.
     Move the pointer of the longer list forward by the difference in lengths.
     Now, traverse both lists simultaneously, one node at a time. The first common node is the intersection point (conflicting node).
 */

class ListNode1 {
    var val: Int
    var next: ListNode1?

    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func getLength(_ head: ListNode1?) -> Int {
    var length = 0
    var current = head
    while current != nil {
        length += 1
        current = current?.next
    }
    return length
}

func getIntersectionNode(_ headA: ListNode1?, _ headB: ListNode1?) -> ListNode1? {
    // Get the lengths of both lists
    let lenA = getLength(headA)
    let lenB = getLength(headB)

    var longer = headA
    var shorter = headB
    var diff = lenA - lenB

    // Ensure longer points to the longer list
    if lenB > lenA {
        longer = headB
        shorter = headA
        diff = lenB - lenA
    }

    // Move the pointer of the longer list forward by the difference in lengths
    for _ in 0..<diff {
        longer = longer?.next
    }

    // Traverse both lists simultaneously until the intersection is found
    while longer != nil && shorter != nil {
        if longer === shorter {
            return longer
        }
        longer = longer?.next
        shorter = shorter?.next
    }

    return nil
}

var node1 = ListNode1(1)
node1.next = ListNode1(2)
node1.next?.next = ListNode1(3)
node1.next?.next?.next = ListNode1(4)
node1.next?.next?.next?.next = ListNode1(5)
node1.next?.next?.next?.next?.next = ListNode1(6)

var node2 = ListNode1(10)
node2.next = ListNode1(11)
node2.next?.next = ListNode1(12)
node2.next?.next?.next = node1.next?.next?.next

print(getIntersectionNode(node1, node2)?.val)

