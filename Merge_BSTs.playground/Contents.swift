/*
 Given two Binary Search Trees(BST), print the inorder traversal of merged BSTs.

 Examples:

 Input:
 First BST
        3
     /     \
  1       5
 Second BST
      4
   /   \
 2     6
 
 Output: 1 2 3 4 5 6
 */

// Solution 1:

/*
 1. Inorder Traversal and Merge:

 This method involves converting the BSTs into sorted arrays and then merging the arrays. Here's the algorithm:

 1. Inorder Traversal: Perform an inorder traversal on both BSTs. Inorder traversal visits nodes in the order: left subtree, root, right subtree. This ensures you visit nodes in ascending order for a BST.
 
 2. Merge Arrays: Combine the elements from both inorder traversal arrays into a single array.
 
 3. Build New BST: Use the elements in the merged and sorted array to construct a new BST. You can perform an inorder traversal of this array and insert elements one by one into a new BST.
 */

import Foundation

class TreeNode<T> {
  var value: T
  var left: TreeNode?
  var right: TreeNode?

  init(_ value: T) {
    self.value = value
  }
}

func mergeBSTs<T: Comparable>(bst1: TreeNode<T>?, bst2: TreeNode<T>?) -> TreeNode<T>? {
  func inorderTraversal(_ root: TreeNode<T>?, _ array: inout [T]) {
    if let root = root {
      inorderTraversal(root.left, &array)
      array.append(root.value)
      inorderTraversal(root.right, &array)
    }
  }

  var array1: [T] = []
  inorderTraversal(bst1, &array1)
  var array2: [T] = []
  inorderTraversal(bst2, &array2)

  let mergedArray = array1 + array2
  return buildBST(mergedArray)
}

func buildBST<T: Comparable>(_ array: [T]) -> TreeNode<T>? {
  guard !array.isEmpty else { return nil }
    //print(array)
  let midIndex = array.count / 2
    let root = TreeNode(array[midIndex])
  root.left = buildBST(Array(array[..<midIndex]))
  root.right = buildBST(Array(array[Int(midIndex+1)...]))
  return root
}

func inOrder<T: Comparable>(_ root: TreeNode<T>?) {
    if let root = root {
        inOrder(root.left)
        print(root.value)
        inOrder(root.right)
    }
}

let root1 = TreeNode(3)
root1.left = TreeNode(1)
root1.right = TreeNode(5)
//print("root1")
//inOrder(root1)

let root2 = TreeNode(4)
root2.left = TreeNode(2)
root2.right = TreeNode(6)
//print("root2")
//inOrder(root2)

//let mergedRoot = mergeBSTs(bst1: root1, bst2: root2)
//print("mergedRoot")
//inOrder(mergedRoot)


func inOrderTraversal<T: Comparable>(_ root: TreeNode<T>?, _ output: inout [T]) {
    guard let root = root else { return }
    inOrderTraversal(root.left, &output)
    output.append(root.value)
    inOrderTraversal(root.right, &output)
}

func mergeArrays<T: Comparable>(_ arr1: [T], _ arr2: [T]) -> [T] {
    var merged = [T]()
    var i = 0, j = 0
    while i < arr1.count && j < arr2.count {
        if arr1[i] < arr2[j] {
            merged.append(arr1[i])
            i += 1
        } else {
            merged.append(arr2[j])
            j += 1
        }
    }
    while i < arr1.count {
        merged.append(arr1[i])
        i += 1
    }
    while j < arr2.count {
        merged.append(arr2[j])
        j += 1
    }
    return merged
}

func sortedArrayToBST<T: Comparable>(_ arr: [T], _ start: Int, _ end: Int) -> TreeNode<T>? {
    if start > end { return nil }
    let mid = (start + end) / 2
    let node = TreeNode(arr[mid])
    node.left = sortedArrayToBST(arr, start, mid - 1)
    node.right = sortedArrayToBST(arr, mid + 1, end)
    return node
}

func mergeBSTs<T: Comparable>(_ root1: TreeNode<T>?, _ root2: TreeNode<T>?) -> TreeNode<T>? {
    var list1 = [T]()
    var list2 = [T]()

    inOrderTraversal(root1, &list1)
    inOrderTraversal(root2, &list2)
    print(list1)
    print(list2)

    let mergedList = mergeArrays(list1, list2)
    print(mergedList)
    return sortedArrayToBST(mergedList, 0, mergedList.count - 1)
}

let result = mergeBSTs(root1, root2)
inOrder(result)

func preOrder<T: Comparable>(_ node: TreeNode<T>?) {
    guard let node = node else {
        return
    }
    print(node.value)
    preOrder(node.left)
    preOrder(node.right)
}
print("------")
preOrder(result)
