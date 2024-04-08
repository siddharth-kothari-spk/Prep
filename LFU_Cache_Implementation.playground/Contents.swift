/*
 LFU Cache Algorithm

 Data Structures:

  HashMap<Key, Node>: Stores key-value pairs with nodes containing the value and a frequency counter.
  FrequencyHashTable: Hash table with buckets (one for each frequency), where each bucket stores a doubly linked list containing nodes with that frequency.
 
 Methods:
     get(key):

        a) Check if key exists in the HashMap.
            1) If yes, increment its frequency and move its node to the head of the corresponding frequency list in the FrequencyHashTable.
            2) Return the associated value.
        b) If no, return -1 (or null) to indicate a cache miss.
 
     put(key, value):

        a)  If key already exists, update its value and move its node as in get.
        b)  Otherwise, create a new node with key, value, and frequency 1.
            1) If the cache is full:
                i) Evict the least frequently used item (head of the lowest non-empty frequency list).
                ii) Delete its key-value pair from the HashMap.
            2) Add the new node to the head of the list corresponding to its frequency (create a new list if needed).
            3) Update the HashMap with the new key-value pair.
 */

import Foundation

class LFUCache<Key: Hashable, Value: Equatable> {
  private let capacity: Int
  private var cache: [Key: Node<Key, Value>] = [:]
  private var frequencies: [Int: DoublyLinkedList<Key, Value>] = [:]

  init(capacity: Int) {
    self.capacity = capacity
  }

  func get(key: Key) -> Value? {
    guard let node = cache[key] else { return nil }
    increaseFrequency(for: node)
    return node.value
  }

  func put(key: Key, value: Value) {
    if capacity <= 0 { return }
    if let existingNode = cache[key] {
      existingNode.value = value
      increaseFrequency(for: existingNode)
    } else {
      let newNode = Node(key: key, value: value, frequency: 1)
      cache[key] = newNode
      frequencies[1, default: DoublyLinkedList()].append(newNode)
      evictLeastFrequentIfNeeded()
    }
  }

    func description() {
        print("cache: \(cache)")
        print("frequencies: \(frequencies)")
    }
    private func increaseFrequency(for node: Node<Key, Value>) {
    let oldFrequency = node.frequency
    frequencies[oldFrequency]?.remove(node)
    node.frequency += 1
    frequencies[node.frequency, default: DoublyLinkedList()].append(node)
  }

  private func evictLeastFrequentIfNeeded() {
    guard cache.count > capacity else { return }
    if let minFrequency = frequencies.keys.min(), let list = frequencies[minFrequency] {
      guard let leastFrequentNode = list.removeFirst() else { return }
      cache.removeValue(forKey: leastFrequentNode.key)
    }
  }
}

class Node<Key: Hashable, Value: Equatable> {
  let key: Key
  var value: Value
  var frequency: Int
  weak var prev: Node?
  weak var next: Node?

  init(key: Key, value: Value, frequency: Int) {
    self.key = key
    self.value = value
    self.frequency = frequency
  }
}

extension Node: Equatable {
    static func == (lhs: Node<Key, Value>, rhs:  Node<Key, Value>) -> Bool {
        return  lhs.value == rhs.value//lhs === rhs
    }
}

extension Node: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}

class DoublyLinkedList<Key: Hashable, Value: Equatable> {
  var head: Node<Key, Value>?
  var tail: Node<Key, Value>?

  func isEmpty() -> Bool {
    return head == nil
  }

  func append(_ node: Node<Key, Value>) {
    if head == nil {
      head = node
      tail = node
    } else {
      node.prev = tail
      tail?.next = node
      tail = node
    }
  }

  func remove(_ node: Node<Key, Value>) {
    if node === head {
      head = node.next
    }
    if node === tail {
      tail = node.prev
    }
    node.prev?.next = node.next
    node.next?.prev = node.prev
  }

  func removeFirst() -> Node<Key, Value>? {
    guard let first = head else { return nil }
    remove(first)
    return first
  }
}

let lfuCache = LFUCache<String, Int>(capacity: 3)

lfuCache.put(key: "a", value: 1)
lfuCache.put(key: "b", value: 2)
lfuCache.put(key: "c", value: 3)

lfuCache.description()
// Get "a" and increase its frequency
print(lfuCache.get(key: "a"))  // Output: 1

lfuCache.description()
lfuCache.put(key: "d", value: 4)  // Evicts least frequent ("b")
lfuCache.description()

print(lfuCache.get(key: "a"))  // Output: 1 (frequency increased again)
print(lfuCache.get(key: "c"))  // Output: 3
print(lfuCache.get(key: "d"))  // Output: 4

lfuCache.description()
lfuCache.put(key: "b", value: 5)  // Adds back "b" with frequency 1
lfuCache.description()

print(lfuCache.get(key: "a"))  // Output: 1
print(lfuCache.get(key: "b"))  // Output: 5 (more frequent than "c")
print(lfuCache.get(key: "c"))  // Output: 3

lfuCache.description()
