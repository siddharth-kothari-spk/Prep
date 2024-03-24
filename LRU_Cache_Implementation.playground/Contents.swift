/*
 **LRU Cache Algorithm**

 The Least Recently Used (LRU) cache discards the least recently used items to make space for new entries when the cache reaches its capacity. It maintains items in the order of their access, enabling quick identification of least recently used elements.

 **Data Structures**

 LRU cache implementation typically combines two data structures:

 1. **Doubly Linked List:** This list stores the cached items. Newer items are added at the head, and older items reside towards the tail. This structure allows efficient removal of the least recently used item (from the tail) in constant time (O(1)).

 2. **Hash Table (Map):** This map acts as a fast lookup for items in the cache. Each key in the cache maps to its corresponding node in the doubly linked list. This allows finding a specific item in O(1) time.

 **Algorithm Steps**

 1. **Initialization:**
    - Create a `LRUCache` class with attributes:
       - `capacity`: Maximum number of items the cache can hold.
       - `size`: Current number of items in the cache.
       - `map`: Hash table to store key-node mappings.
       - `dll`: Doubly linked list to store cached items.

 2. **`get(key)`:**
    - Check if the `key` exists in the `map`.
       - If yes:
          - Move the corresponding node to the head of the `dll` (indicating recent use).
          - Return the value associated with the key.
       - If no:
          - Return -1 (or any value indicating cache miss).

 3. **`put(key, value)`:**
    - Check if the cache is full (`size` equals `capacity`).
       - If yes:
          - Remove the least recently used item from the tail of the `dll` and update the `map`.
          - Decrement `size`.
    - Create a new node for the `key-value` pair.
    - Add the new node to the head of the `dll`.
    - Update the `map` with the `key` pointing to the new node.
    - Increment `size`.

 **Example Operations**

 - `get(key)`: This operation searches the `map` for the `key`. If found, the corresponding node is moved to the head of the `dll` to reflect recent use, and the value is returned.

 - `put(key, value)`: This operation checks if the cache is full. If so, it evicts the least recently used item (tail of `dll`) and updates the `map`. Then, a new node for the `key-value` pair is added to the head of the `dll`, and the `map` is updated.

 **Key Points**

 - The LRU cache prioritizes recently accessed items, keeping them readily available.

 - By using a doubly linked list and a hash table, LRU cache achieves efficient operations:
    - Get operation: O(1) time complexity.
    - Put operation: O(1) time complexity (amortized), considering potential eviction in case of a full cache.

 This implementation provides a basic understanding of LRU cache. Specific programming languages might have different syntax for implementing the data structures and operations.
 */

public class LRUCache<Key: Hashable, Value: Equatable> {
  private let capacity: Int
  private var size: Int = 0
  private var map: [Key: DoublyLinkedListNode<Key, Value>] = [:]
  private var head: DoublyLinkedListNode<Key, Value>?
  private var tail: DoublyLinkedListNode<Key, Value>?

  public init(capacity: Int) {
    self.capacity = capacity
  }
    
  public func get(_ key: Key) -> Value? {
    guard let node = map[key] else { return nil }
    moveToHead(node)
    return node.value
  }

  public func put(_ key: Key, _ value: Value) {
    if let existingNode = map[key] {
      existingNode.value = value
      moveToHead(existingNode)
      return
    }

    let newNode = DoublyLinkedListNode(key: key, value: value)
    map[key] = newNode
    if let head = head {
      head.next = newNode
      newNode.previous = head
    } else {
      tail = newNode
    }
    head = newNode
    size += 1

    if size > capacity {
      removeLeastRecentlyUsed()
    }
  }

  private func moveToHead(_ node: DoublyLinkedListNode<Key, Value>) {
    if node === head { return }
    
    // Remove the node from its current position
    node.previous?.next = node.next
    node.next?.previous = node.previous

    // Update head and tail if necessary
    if node === tail {
      tail = node.previous
    }

    // Insert the node at the head
    node.next = head
    head?.previous = node
    head = node
  }

  private func removeLeastRecentlyUsed() {
    guard let tail = tail else { return }
    map.removeValue(forKey: tail.key)
    self.tail = tail.previous
    if let previous = self.tail {
        previous.next = nil
    } else {
      head = nil
    }
    size -= 1
  }
    
    public func description() {
        guard var head = head else {
            print("no head available")
            return
        }
        
        while head != tail && head.next != nil {
            print(head.value)
            guard let next = head.next else { return }
            head = next
        }
    }
}

private class DoublyLinkedListNode<Key, Value: Equatable> {
  let key: Key
  var value: Value
  var next: DoublyLinkedListNode<Key, Value>?
  var previous: DoublyLinkedListNode<Key, Value>?

  init(key: Key, value: Value) {
    self.key = key
    self.value = value
  }
}

extension DoublyLinkedListNode: Equatable {
    static func == (lhs: DoublyLinkedListNode<Key, Value>, rhs: DoublyLinkedListNode<Key, Value>) -> Bool {
        return  lhs.value == rhs.value//lhs === rhs
    }
}


var lruCache = LRUCache<Int, String>(capacity: 3)
lruCache.put(1, "A")
lruCache.put(2, "B")
lruCache.put(3, "C")
//lruCache.description()
lruCache.get(2)
//lruCache.description()
lruCache.get(4)
//lruCache.description()
lruCache.put(4, "D")
lruCache.put(3, "E")
//lruCache.description()
lruCache.get(4)
//lruCache.description()
lruCache.put(1, "A")
lruCache.description()

