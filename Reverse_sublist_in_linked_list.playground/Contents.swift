/*
 https://www.geeksforgeeks.org/reverse-sublist-linked-list/
 Reverse a sublist of linked list
 We are given a linked list and positions m and n. We need to reverse the linked list from position m to n.

 Examples:

 Input : 10->20->30->40->50->60->70->NULL
         m = 3, n = 6
 Output : 10->20->60->50->40->30->70->NULL

 Input :  1->2->3->4->5->6->NULL
          m = 2, n = 4
 Output : 1->4->3->2->5->6->NULL
 
 
 Algo:
 Here's the algorithm to reverse a sublist of a linked list:

 **1. Find the start and end nodes of the sublist:**
   - Initialize three pointers: `curr`, `prev`, and `i`. Set `curr` to the head of the linked list, `prev` to `None` (or null), and `i` to 1.
   - Traverse the linked list using a `while` loop until `curr` reaches `None` and `i` is less than or equal to `n` (the end position of the sublist).
     - Inside the loop, if `i` is equal to `m` (the start position of the sublist), store the current node (`curr`) in a variable called `start`.
     - Increment `i` and move `curr` to the next node (`curr = curr.next`).

 **2. Reverse the sublist:**
   - Initialize another two pointers: `prev` (different from the previous `prev`) and `next`. Set `prev` to `None` and `next` to `start`.
   - Use another `while` loop until `next` is `None`:
     - Inside the loop, store the next node (`next.next`) in a temporary variable called `temp`.
     - Set `next.next` to `prev`.
     - Update `prev` to the current `next` (`prev = next`).
     - Update `next` to the temporary variable (`next = temp`).

 **3. Connect the reversed sublist to the rest of the list:**
   - If `start` is not `None` (meaning the sublist is not empty), then:
     - If `prev` is not `None` (meaning the sublist is not the head of the original list), connect the node before the sublist to the new head of the reversed sublist (`prev.next = curr`).
     - Set the new head of the list to the start of the reversed sublist (`start`).

 **4. Return the modified linked list head.**

 This algorithm traverses the list once to find the start and end nodes and then reverses the sublist in place using another loop. Finally, it connects the reversed sublist back to the rest of the list. The time complexity is O(n) in the worst case, where n is the number of nodes in the linked list.
 */


public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
      self.val = val
      self.next = nil
  }
}

func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
  var head = head
  var curr = head
  var prev: ListNode? = nil
  var count = 1
  
  // Find start and end nodes of sublist
  while curr != nil  {
    if count == left {
      let start = curr
      // Reverse the sublist
      var prevNode: ListNode? = nil
      var nextNode = start
      while count <= right {
        let temp = nextNode?.next
        nextNode?.next = prevNode
        prevNode = nextNode
        nextNode = temp
        count += 1
      }
//        printList(curr)
//        printList(prev)
//        printList(start)
//        printList(prevNode)
//      printList(nextNode)
      // Connect reversed sublist to rest of list
      if prev != nil {
        prev?.next = prevNode//curr
      } else {
        head = prevNode
      }
      
        while prevNode?.next != nil {
            prevNode = prevNode?.next
        }
        prevNode?.next = nextNode
//        print("****")
//        printList(head)
      return head
    }
    prev = curr
    curr = curr?.next
    count += 1
  }
  
  // Sublist not found, return original list
  return head
}

func printList(_ head: ListNode?) {
    var localHead = head
    var str: String = ""
    while localHead != nil {
        if let value = localHead?.val {
            str += " " + String(value)
        }
        localHead = localHead?.next
    }
    print(str)
}

var headList = ListNode(10)
headList.next = ListNode(20)
headList.next?.next = ListNode(30)
headList.next?.next?.next = ListNode(40)
headList.next?.next?.next?.next = ListNode(50)
headList.next?.next?.next?.next?.next = ListNode(60)
headList.next?.next?.next?.next?.next?.next = ListNode(70)
headList.next?.next?.next?.next?.next?.next?.next = ListNode(75)

printList(headList) //  10 20 30 40 50 60 70 75
print("****")
printList(reverseBetween(headList, 3, 6)) //  10 20 60 50 40 30 70 75

print("****")
printList(headList) //  10 20 60 50 40 30 70 75
printList(reverseBetween(headList, 2, 4)) //  10 50 60 20 40 30 70 75
