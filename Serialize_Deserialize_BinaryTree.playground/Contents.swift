/*
 https://leetcode.com/problems/serialize-and-deserialize-binary-tree/description/
 Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

 Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

 Clarification: The input/output format is the same as how LeetCode serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.

  

 Example 1:


 Input: root = [1,2,3,null,null,4,5]
 Output: [1,2,3,null,null,4,5]
 Example 2:

 Input: root = []
 Output: []
  

 Constraints:

 The number of nodes in the tree is in the range [0, 104].
 -1000 <= Node.val <= 1000
 */

/*
 to serialize and deserialize a binary tree, we can use a recursive approach to handle the tree's nodes. The basic idea is to convert the tree into a string (serialization) and then parse that string to reconstruct the original tree (deserialization).

 Here is a step-by-step algorithm:

 Serialization:
 Start at the root node.
 Use pre-order traversal (root, left, right) to visit each node.
 For each node:
 Add the node's value to the serialized string.
 If the node is null, add a special character (e.g., #) to represent the null.
 Separate each value with a comma.
 Recursively process the left and right subtrees.
 Deserialization:
 Split the serialized string by commas to get a list of node values.
 Use a helper function to reconstruct the tree:
 Start from the first value in the list.
 If the value is #, return null.
 Otherwise, create a new tree node with the value.
 Recursively construct the left and right subtrees using the remaining values in the list.
 */

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

class Codec {
    
    // Serialize a tree to a single string.
    func serialize(_ root: TreeNode?) -> String {
        func helper(_ node: TreeNode?) -> String {
            guard let node = node else {
                return "#"
            }
            let leftSerialized = helper(node.left)
            let rightSerialized = helper(node.right)
            return "\(node.val),\(leftSerialized),\(rightSerialized)"
        }
        return helper(root)
    }

    // Deserialize a string to a tree.
    func deserialize(_ data: String) -> TreeNode? {
        var nodeValues = data.split(separator: ",").map { String($0) }
        var index = 0
        
        func helper() -> TreeNode? {
            if index >= nodeValues.count || nodeValues[index] == "#" {
                index += 1
                return nil
            }
            let node = TreeNode(Int(nodeValues[index])!)
            index += 1
            node.left = helper()
            node.right = helper()
            return node
        }
        
        return helper()
    }
}

// Example usage:
let codec = Codec()

// Example tree: [1, 2, 3, nil, nil, 4, 5]
let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.right?.left = TreeNode(4)
root.right?.right = TreeNode(5)

let serialized = codec.serialize(root)
print("Serialized: \(serialized)")

if let deserializedRoot = codec.deserialize(serialized) {
    print("Deserialized Root: \(deserializedRoot.val)")  // Should print 1
}

/*
 Sure, let's perform a dry run of the serialization and deserialization process using the input `root = [1, 2, 3, null, null, 4, 5]`.

 ### Tree Structure:
 ```
       1
      / \
     2   3
        / \
       4   5
 ```

 ### Serialization Process

 1. **Start at the root node (1)**:
    - Current serialized string: `1,`

 2. **Move to the left child (2)**:
    - Current serialized string: `1,2,`

 3. **Move to the left child of (2), which is `null`**:
    - Current serialized string: `1,2,#,`

 4. **Move to the right child of (2), which is `null`**:
    - Current serialized string: `1,2,#,#,`

 5. **Move to the right child of (1) (3)**:
    - Current serialized string: `1,2,#,#,3,`

 6. **Move to the left child of (3) (4)**:
    - Current serialized string: `1,2,#,#,3,4,`

 7. **Move to the left child of (4), which is `null`**:
    - Current serialized string: `1,2,#,#,3,4,#,`

 8. **Move to the right child of (4), which is `null`**:
    - Current serialized string: `1,2,#,#,3,4,#,#,`

 9. **Move to the right child of (3) (5)**:
    - Current serialized string: `1,2,#,#,3,4,#,#,5,`

 10. **Move to the left child of (5), which is `null`**:
     - Current serialized string: `1,2,#,#,3,4,#,#,5,#,`

 11. **Move to the right child of (5), which is `null`**:
     - Current serialized string: `1,2,#,#,3,4,#,#,5,#,#`

 Final serialized string: `1,2,#,#,3,4,#,#,5,#,#`

 ### Deserialization Process

 1. **Start with the first value (1)**:
    - Create node with value 1.
    - Current index: 1

 2. **Move to the next value (2)**:
    - Create node with value 2.
    - Attach as the left child of node 1.
    - Current index: 2

 3. **Move to the next value (#)**:
    - Left child of node 2 is `null`.
    - Current index: 3

 4. **Move to the next value (#)**:
    - Right child of node 2 is `null`.
    - Current index: 4

 5. **Move to the next value (3)**:
    - Create node with value 3.
    - Attach as the right child of node 1.
    - Current index: 5

 6. **Move to the next value (4)**:
    - Create node with value 4.
    - Attach as the left child of node 3.
    - Current index: 6

 7. **Move to the next value (#)**:
    - Left child of node 4 is `null`.
    - Current index: 7

 8. **Move to the next value (#)**:
    - Right child of node 4 is `null`.
    - Current index: 8

 9. **Move to the next value (5)**:
    - Create node with value 5.
    - Attach as the right child of node 3.
    - Current index: 9

 10. **Move to the next value (#)**:
     - Left child of node 5 is `null`.
     - Current index: 10

 11. **Move to the next value (#)**:
     - Right child of node 5 is `null`.
     - Current index: 11

 Final deserialized tree:
 ```
       1
      / \
     2   3
        / \
       4   5
 ```

 This matches the original tree structure given as input.
 */
