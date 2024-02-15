/*
 Implement the BSTIterator class that represents an iterator over the in-order traversal of a binary search tree (BST):

 BSTIterator(TreeNode root) Initializes an object of the BSTIterator class. The root of the BST is given as part of the constructor. The pointer should be initialized to a non-existent number smaller than any element in the BST.
 boolean hasNext() Returns true if there exists a number in the traversal to the right of the pointer, otherwise returns false.
 int next() Moves the pointer to the right, then returns the number at the pointer.
 Notice that by initializing the pointer to a non-existent smallest number, the first call to next() will return the smallest element in the BST.

 You may assume that next() calls will always be valid. That is, there will be at least a next number in the in-order traversal when next() is called.

  

 Example 1:


 Input
 ["BSTIterator", "next", "next", "hasNext", "next", "hasNext", "next", "hasNext", "next", "hasNext"]
 [[[7, 3, 15, null, null, 9, 20]], [], [], [], [], [], [], [], [], []]
 Output
 [null, 3, 7, true, 9, true, 15, true, 20, false]

 Explanation
 BSTIterator bSTIterator = new BSTIterator([7, 3, 15, null, null, 9, 20]);
 bSTIterator.next();    // return 3
 bSTIterator.next();    // return 7
 bSTIterator.hasNext(); // return True
 bSTIterator.next();    // return 9
 bSTIterator.hasNext(); // return True
 bSTIterator.next();    // return 15
 bSTIterator.hasNext(); // return True
 bSTIterator.next();    // return 20
 bSTIterator.hasNext(); // return False
  

 Constraints:

 The number of nodes in the tree is in the range [1, 105].
 0 <= Node.val <= 106
 At most 105 calls will be made to hasNext, and next.
  

 Follow up:

 Could you implement next() and hasNext() to run in average O(1) time and use O(h) memory, where h is the height of the tree?
 */


/*
 Solution1
 
 To implement the BSTIterator class, we can use an iterative approach along with a stack to perform an in-order traversal of the binary search tree (BST). Here's the algorithm:

 In the constructor BSTIterator(TreeNode root), perform an in-order traversal of the BST and push the nodes onto a stack until reaching the leftmost node (the smallest element).
 For hasNext(), return true if the stack is not empty, indicating there are more elements to traverse.
 For next(), pop the top element from the stack and return its value. If the popped node has a right child, perform an in-order traversal starting from that right child and push the nodes onto the stack until reaching the leftmost node (the next smallest element).

 */


class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
    }
}

class BSTIterator {
    var stack: [TreeNode]
    
    init(_ root: TreeNode?) {
        stack = []
        pushLeft(root)
    }
    
    private func pushLeft(_ node: TreeNode?) {
        var curr = node
        while let node = curr {
            stack.append(node)
            curr = node.left
        }
    }
    
    func next() -> Int {
        let node = stack.removeLast()
        if let rightChild = node.right {
            pushLeft(rightChild)
        }
        return node.val
    }
    
    func hasNext() -> Bool {
        return !stack.isEmpty
    }
}

// Example usage:
let root = TreeNode(7)
root.left = TreeNode(3)
root.right = TreeNode(15)
root.right?.left = TreeNode(9)
root.right?.right = TreeNode(20)

let iterator = BSTIterator(root)
print(iterator.next()) // Output: 3
print(iterator.next()) // Output: 7
print(iterator.hasNext()) // Output: true
print(iterator.next()) // Output: 9
print(iterator.hasNext()) // Output: true
print(iterator.next()) // Output: 15
print(iterator.hasNext()) // Output: true
print(iterator.next()) // Output: 20
print(iterator.hasNext()) // Output: false


// Solution2

class BSTIterator2 {
    private var stack: [Int] = []
    private var index = -1
    
    init(_ root: TreeNode?) {
        inorder(root)
    }
    
    func next() -> Int {
        index += 1
        return stack[index]
    }
    
    func hasNext() -> Bool {
        let i = index + 1
        return stack.count > i
    }
    
    private func inorder(_ node: TreeNode?) {
        guard let node = node else { return }
        inorder(node.left)
        stack.append(node.val)
        inorder(node.right)
    }
}


let root2 = TreeNode(7)
root2.left = TreeNode(3)
root2.right = TreeNode(15)
root2.right?.left = TreeNode(9)
root2.right?.right = TreeNode(20)

let iterator2 = BSTIterator2(root)
print("#####")
print(iterator2.next()) // Output: 3
print(iterator2.next()) // Output: 7
print(iterator2.hasNext()) // Output: true
print(iterator2.next()) // Output: 9
print(iterator2.hasNext()) // Output: true
print(iterator2.next()) // Output: 15
print(iterator2.hasNext()) // Output: true
print(iterator2.next()) // Output: 20
print(iterator2.hasNext()) // Output: false
