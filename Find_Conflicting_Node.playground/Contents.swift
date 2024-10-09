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

class ListNode {
    var val: Int
    var next: ListNode?

    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func getLength(_ head: ListNode?) -> Int {
    var length = 0
    var current = head
    while current != nil {
        length += 1
        current = current?.next
    }
    return length
}

func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
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

var node1 = ListNode(1)
node1.next = ListNode(2)
node1.next?.next = ListNode(3)
node1.next?.next?.next = ListNode(4)
node1.next?.next?.next?.next = ListNode(5)
node1.next?.next?.next?.next?.next = ListNode(6)

var node2 = ListNode(10)
node2.next = ListNode(11)
node2.next?.next = ListNode(12)
node2.next?.next?.next = node1.next?.next?.next

print(getIntersectionNode(node1, node2)?.val)


// Approach 2:
/*
 2. Second Approach (Using Two Pointers):

     Two pointers traverse both linked lists.
     When a pointer reaches the end of its list, it starts traversing the other list.
     This ensures that both pointers traverse an equal number of nodes, and if they intersect, they will eventually meet at the intersection point.
 */


func getIntersectionNode2(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    // If either list is empty, return nil
    if headA == nil || headB == nil {
        return nil
    }

    var pointerA = headA
    var pointerB = headB

    // Traverse both lists
    while pointerA !== pointerB {
        // If pointerA reaches the end, move it to the head of List B, else move to next
        pointerA = (pointerA == nil) ? headB : pointerA?.next

        // If pointerB reaches the end, move it to the head of List A, else move to next
        pointerB = (pointerB == nil) ? headA : pointerB?.next
    }

    // Both pointers will meet at the intersection point, or at nil if no intersection
    return pointerA
}

print(getIntersectionNode2(node1, node2)?.val)
