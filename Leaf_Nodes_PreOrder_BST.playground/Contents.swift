/*
 Leaf nodes from Preorder of a Binary Search Tree
 Given a Preorder traversal of a Binary Search Tree. The task is to print leaf nodes of the Binary Search Tree from the given preorder.

 Examples:

 Input : preorder[] = {890, 325, 290, 530, 965};
 Output : 290 530 965
 Explanation : Tree represented is,
       890
      /   \
   325    965
   /  \
 290   530

 Input : preorder[] = { 3, 2, 4 };
 Output : 2 4
 */

func findLeafNodesPreorder(_ preorder: [Int]) -> [Int] {
  var leafNodes = [Int]()
  var x = 0
  var y = 1

  while x < preorder.count {
    if y < preorder.count && preorder[y] > preorder[x] {
      // End of left subtree (decreasing order in preorder for BST)
      if x + 1 >= preorder.count || preorder[x + 1] > preorder[x] {
        // Check for leaf node (no children)
        leafNodes.append(preorder[x])
      }
    }
    x = y // Move to next potential child
    y += 1 // Move to next element in the array
  }
    leafNodes.append(preorder[preorder.count - 1]) // In the algorithm, we will not be able to check the condition of the leaf node of the rightmost node or rightmost element of the preorder. So, simply print the rightmost node because we know this will always be a leaf node in preorder traversal.
  return leafNodes
}

print(findLeafNodesPreorder([890, 325, 290, 530, 965]))
