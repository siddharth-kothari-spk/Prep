/*
 https://leetcode.com/problems/merge-k-sorted-lists/description/
 You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

 Merge all the linked-lists into one sorted linked-list and return it.

  

 Example 1:

 Input: lists = [[1,4,5],[1,3,4],[2,6]]
 Output: [1,1,2,3,4,4,5,6]
 Explanation: The linked-lists are:
 [
   1->4->5,
   1->3->4,
   2->6
 ]
 merging them into one sorted list:
 1->1->2->3->4->4->5->6
 */

/*
 Algo:
 To merge k sorted linked lists into one sorted linked list, you can use a min-heap (priority queue) to efficiently find the smallest element among the heads of the k lists.

 Initialize a min-heap.
 Insert the head node of each linked list into the min-heap. The heap will use the value of the node for comparison.
 Extract the smallest node from the heap, and add it to the result list.
 If the extracted node has a next node, insert the next node into the heap.
 Repeat steps 3-4 until the heap is empty.
 The resulting list will be the merged sorted linked list.
 */

import Foundation

// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// Custom comparator for ListNode to be used in the priority queue
extension ListNode: Comparable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    public static func < (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val < rhs.val
    }
}

// Min-Heap Priority Queue implementation
public struct PriorityQueue<T: Comparable> {
    private var heap = [T]()
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public mutating func push(_ element: T) {
        heap.append(element)
        heapifyUp(from: heap.count - 1)
    }
    
    public mutating func pop() -> T? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 {
            return heap.removeLast()
        } else {
            let root = heap[0]
            heap[0] = heap.removeLast()
            heapifyDown(from: 0)
            return root
        }
    }
    
    private mutating func heapifyUp(from index: Int) {
        var childIndex = index
        let child = heap[childIndex]
        var parentIndex = (childIndex - 1) / 2
        
        while childIndex > 0 && heap[parentIndex] > child {
            heap[childIndex] = heap[parentIndex]
            childIndex = parentIndex
            parentIndex = (childIndex - 1) / 2
        }
        heap[childIndex] = child
    }
    
    private mutating func heapifyDown(from index: Int) {
        let count = heap.count
        var parentIndex = index
        let parent = heap[parentIndex]
        
        while true {
            let leftChildIndex = 2 * parentIndex + 1
            let rightChildIndex = 2 * parentIndex + 2
            var candidateIndex = parentIndex
            
            if leftChildIndex < count && heap[leftChildIndex] < heap[candidateIndex] {
                candidateIndex = leftChildIndex
            }
            if rightChildIndex < count && heap[rightChildIndex] < heap[candidateIndex] {
                candidateIndex = rightChildIndex
            }
            if candidateIndex == parentIndex {
                return
            }
            heap[parentIndex] = heap[candidateIndex]
            parentIndex = candidateIndex
        }
        heap[parentIndex] = parent
    }
}

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    var priorityQueue = PriorityQueue<ListNode>()
    
    // Initialize the heap with the head of each list
    for list in lists {
        if let node = list {
            priorityQueue.push(node)
        }
    }
    
    let dummy = ListNode(0)
    var current = dummy
    
    // Extract the smallest element from the heap and add it to the result list
    while let smallestNode = priorityQueue.pop() {
        current.next = smallestNode
        current = current.next!
        if let nextNode = smallestNode.next {
            priorityQueue.push(nextNode)
        }
    }
    
    return dummy.next
}

// Example usage:
// Creating example lists: [[1,4,5],[1,3,4],[2,6]]
let list1 = ListNode(1)
list1.next = ListNode(4)
list1.next?.next = ListNode(5)

let list2 = ListNode(1)
list2.next = ListNode(3)
list2.next?.next = ListNode(4)

let list3 = ListNode(2)
list3.next = ListNode(6)

let lists = [list1, list2, list3]

if let mergedList = mergeKLists(lists) {
    print(mergedList)
    var node: ListNode? = mergedList
    while node != nil {
        print(node!.val, terminator: "->")
        node = node?.next
    }
    // Output: 1->1->2->3->4->4->5->6->
}
