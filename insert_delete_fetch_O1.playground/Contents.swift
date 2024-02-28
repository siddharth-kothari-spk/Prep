/*
 Implement the RandomizedSet class:

 RandomizedSet() Initializes the RandomizedSet object.
 bool insert(int val) Inserts an item val into the set if not present. Returns true if the item was not present, false otherwise.
 bool remove(int val) Removes an item val from the set if present. Returns true if the item was present, false otherwise.
 int getRandom() Returns a random element from the current set of elements (it's guaranteed that at least one element exists when this method is called). Each element must have the same probability of being returned.
 You must implement the functions of the class such that each function works in average O(1) time complexity.

  

 Example 1:

 Input
 ["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
 [[], [1], [2], [2], [], [1], [2], []]
 Output
 [null, true, false, true, 2, true, false, 2]

 Explanation
 RandomizedSet randomizedSet = new RandomizedSet();
 randomizedSet.insert(1); // Inserts 1 to the set. Returns true as 1 was inserted successfully.
 randomizedSet.remove(2); // Returns false as 2 does not exist in the set.
 randomizedSet.insert(2); // Inserts 2 to the set, returns true. Set now contains [1,2].
 randomizedSet.getRandom(); // getRandom() should return either 1 or 2 randomly.
 randomizedSet.remove(1); // Removes 1 from the set, returns true. Set now contains [2].
 randomizedSet.insert(2); // 2 was already in the set, so return false.
 randomizedSet.getRandom(); // Since 2 is the only number in the set, getRandom() will always return 2.
  
 */

// Sol:
/*
 To implement the RandomizedSet class, we can use a combination of a dictionary and an array. The dictionary will store the mapping between elements and their indices in the array, allowing us to achieve O(1) time complexity for insertion and removal operations. We'll use the array to store the elements themselves, which will help us achieve O(1) time complexity for the getRandom operation.

 Here's the algorithm:

 Initialize two data structures:
     elements: A dictionary to store the mapping between elements and their indices in the array.
     array: An array to store the elements themselves.
 
 Implement the insert method:
    Check if the element already exists in the dictionary. If it does, return false.
    Otherwise, add the element to the dictionary with its index in the array.
    Append the element to the end of the array.
    Return true.
 
 Implement the remove method:
     Check if the element exists in the dictionary. If it doesn't, return false.
     Otherwise, retrieve the index of the element from the dictionary.
     Swap the element at the index with the last element in the array.
     Update the index of the last element in the dictionary.
     Remove the element from the array.
     Remove the element from the dictionary.
     Return true.
 
 Implement the getRandom method:
     Generate a random index within the range of the array length.
     Return the element at the randomly generated index.

 */

class RandomizedSet {
    var elements: [Int: Int]
    var array: [Int]
    
    init() {
        elements = [:]
        array = []
    }
    
    func insert(_ val: Int) -> Bool {
        if elements[val] != nil {
            return false
        }
        elements[val] = array.count
        array.append(val)
        return true
    }
    
    func remove(_ val: Int) -> Bool {
        guard let index = elements[val] else {
            return false
        }
        let lastIndex = array.count - 1
        let lastVal = array[lastIndex]
        array[index] = lastVal
        elements[lastVal] = index
        array.removeLast()
        elements[val] = nil
        return true
    }
    
    func getRandom() -> Int {
        let randomIndex = Int.random(in: 0..<array.count)
        return array[randomIndex]
    }
}

// Test case
let randomizedSet = RandomizedSet()
print(randomizedSet.insert(1)) // Output: true
print(randomizedSet.remove(2)) // Output: false
print(randomizedSet.insert(2)) // Output: true
print(randomizedSet.getRandom()) // Output: 1 or 2 (randomly)
print(randomizedSet.remove(1)) // Output: true
print(randomizedSet.insert(2)) // Output: false
print(randomizedSet.getRandom()) // Output: 2
