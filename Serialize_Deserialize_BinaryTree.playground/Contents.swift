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
