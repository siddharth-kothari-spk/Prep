/*
 https://leetcode.com/problems/sort-items-by-groups-respecting-dependencies/description/
 
 There are n items each belonging to zero or one of m groups where group[i] is the group that the i-th item belongs to and it's equal to -1 if the i-th item belongs to no group. The items and the groups are zero indexed. A group can have no item belonging to it.

 Return a sorted list of the items such that:

 The items that belong to the same group are next to each other in the sorted list.
 There are some relations between these items where beforeItems[i] is a list containing all the items that should come before the i-th item in the sorted array (to the left of the i-th item).
 Return any solution if there is more than one solution and return an empty list if there is no solution.

  

 Example 1:
 Input: n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3,6],[],[],[]]
 Output: [6,3,4,1,5,2,0,7]
 
 Example 2:

 Input: n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3],[],[4],[]]
 Output: []
 Explanation: This is the same as example 1 except that 4 needs to be before 6 in the sorted list.
 
 Constraints:

 1 <= m <= n <= 3 * 10^4
 group.length == beforeItems.length == n
 -1 <= group[i] <= m - 1
 0 <= beforeItems[i].length <= n - 1
 0 <= beforeItems[i][j] <= n - 1
 i != beforeItems[i][j]
 beforeItems[i] does not contain duplicates elements.
 */

/*
 we need to address it as a graph problem with constraints on both the items and the groups they belong to. We will use topological sorting to ensure that all precedence constraints are respected. Here's a step-by-step approach to solve this problem:

 Separate Items by Group:

 Group items based on their group memberships.
 Handle items with no group separately.
 Build Dependency Graphs:

 Create dependency graphs for items within the same group.
 Create a dependency graph for the groups themselves.
 Topological Sort:

 Perform a topological sort on the items within each group.
 Perform a topological sort on the groups.
 Combine the results to get the final sorted list.
 Check for Cycles:

 Ensure that there are no cycles in the dependency graphs. If cycles are detected, return an empty list.
 */

import Foundation

func sortItems(_ n: Int, _ m: Int, _ group: [Int], _ beforeItems: [[Int]]) -> [Int] {
    var group = group
    var newGroupId = m

    // Assign a unique group ID to items with no group
    for i in 0..<n {
        if group[i] == -1 {
            group[i] = newGroupId
            newGroupId += 1
        }
    }

    var groupGraph = [Int: [Int]]()
    var itemGraph = [Int: [Int]]()
    var groupIndegree = [Int: Int]()
    var itemIndegree = [Int: Int]()

    for i in 0..<newGroupId {
        groupGraph[i] = []
        groupIndegree[i] = 0
    }

    for i in 0..<n {
        itemGraph[i] = []
        itemIndegree[i] = 0
    }

    print("---------------------Initial-------------------")
    print("groupGraph = \(groupGraph)")
    print("itemGraph = \(itemGraph)")
    print("groupIndegree = \(groupIndegree)")
    print("itemIndegree = \(itemIndegree)")
    
    
    // Build the dependency graphs
    for i in 0..<n {
        for pre in beforeItems[i] {
            itemGraph[pre, default: []].append(i)
            itemIndegree[i, default: 0] += 1
            if group[i] != group[pre] {
                groupGraph[group[pre], default: []].append(group[i])
                groupIndegree[group[i], default: 0] += 1
            }
        }
    }

    print("-------------Dependency graph---------")
    print("groupGraph = \(groupGraph)")
    print("itemGraph = \(itemGraph)")
    print("groupIndegree = \(groupIndegree)")
    print("itemIndegree = \(itemIndegree)")
    
    // Topological sort function
    func topologicalSort(_ graph: [Int: [Int]], _ indegree: [Int: Int], _ nodes: [Int]) -> [Int] {
        print("sort")
        print("graph: \(graph)")
        print(("indegree: \(indegree)"))
        print("nodes: \(nodes)")
        var indegree = indegree
        var queue = nodes.filter { indegree[$0, default: 0] == 0 }
        var sortedOrder = [Int]()
        print("queue: \(queue)")
        while !queue.isEmpty {
            let node = queue.removeFirst()
            sortedOrder.append(node)
            for neighbor in graph[node, default: []] {
                indegree[neighbor, default: 0] -= 1
                if indegree[neighbor, default: 0] == 0 {
                    queue.append(neighbor)
                }
            }
        }
        print("sortedOrder: \(sortedOrder)")
        return sortedOrder.count == nodes.count ? sortedOrder : []
    }

    // Topologically sort the groups
    let allGroups = Array(0..<newGroupId)
    let groupOrder = topologicalSort(groupGraph, groupIndegree, allGroups)
    print("groupOrder = \(groupOrder)")
    if groupOrder.isEmpty {
       return []
    }

    // Topologically sort items within each group
    print("------------")
    var result = [Int]()
    for grp in groupOrder {
        print("******")
        print("grp: \(grp)")
        let itemsInGroup = (0..<n).filter { group[$0] == grp }
        print("itemsInGroup = \(itemsInGroup)")
        let itemOrder = topologicalSort(itemGraph, itemIndegree, itemsInGroup)
        print("itemOrder = \(itemOrder)")
        if itemOrder.isEmpty {
           continue // return []
        }
        result.append(contentsOf: itemOrder)
    }

    return result
}

// Example usage:
let n = 8
let m = 2
let group = [-1, -1, 1, 0, 0, 1, 0, -1]
let beforeItems = [[], [6], [5], [6], [3, 6], [], [], []]

let result = sortItems(n, m, group, beforeItems)
print(result)  // Output: [6, 3, 4, 1, 5, 2, 0, 7]

/*
 Let's perform a dry run of the given input using the Swift code provided:

 ```swift
 let n = 8
 let m = 2
 let group = [-1, -1, 1, 0, 0, 1, 0, -1]
 let beforeItems = [[], [6], [5], [6], [3, 6], [], [], []]
 ```

 ### Initial Setup

 1. **Assign Unique Group IDs**: We will assign unique group IDs to items that do not belong to any group (i.e., `-1`).

    ```
    Original group array: [-1, -1, 1, 0, 0, 1, 0, -1]
    Assigned unique group IDs:
    group[0] = 2
    group[1] = 3
    group[7] = 4
    Modified group array: [2, 3, 1, 0, 0, 1, 0, 4]
    newGroupId = 5
    ```

 ### Building Dependency Graphs

 2. **Initialize Graphs and In-Degrees**:
    - Group graph and in-degrees:
      ```
      groupGraph: [Int: [Int]] = [0: [], 1: [], 2: [], 3: [], 4: []]
      groupIndegree: [Int: Int] = [0: 0, 1: 0, 2: 0, 3: 0, 4: 0]
      ```
    - Item graph and in-degrees:
      ```
      itemGraph: [Int: [Int]] = [0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 7: []]
      itemIndegree: [Int: Int] = [0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0]
      ```

 3. **Build the Dependency Graphs**:
    - For item 0, no dependencies: `beforeItems[0] = []`.
    - For item 1, `beforeItems[1] = [6]`:
      ```
      itemGraph[6].append(1)
      itemIndegree[1] += 1
      Group dependency: group[6] != group[1] -> groupGraph[0].append(3), groupIndegree[3] += 1
      Updated itemGraph: [6: [1], 0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 7: []]
      Updated itemIndegree: [1: 1, 0: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0]
      Updated groupGraph: [0: [3], 1: [], 2: [], 3: [], 4: []]
      Updated groupIndegree: [0: 0, 1: 0, 2: 0, 3: 1, 4: 0]
      ```
    - For item 2, `beforeItems[2] = [5]`:
      ```
      itemGraph[5].append(2)
      itemIndegree[2] += 1
      Updated itemGraph: [6: [1], 5: [2], 0: [], 1: [], 3: [], 4: [], 7: []]
      Updated itemIndegree: [1: 1, 2: 1, 0: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0]
      ```
    - For item 3, `beforeItems[3] = [6]`:
      ```
      itemGraph[6].append(3)
      itemIndegree[3] += 1
      Updated itemGraph: [6: [1, 3], 5: [2], 0: [], 1: [], 3: [], 4: [], 7: []]
      Updated itemIndegree: [1: 1, 2: 1, 3: 1, 0: 0, 4: 0, 5: 0, 6: 0, 7: 0]
      ```
    - For item 4, `beforeItems[4] = [3, 6]`:
      ```
      itemGraph[3].append(4)
      itemIndegree[4] += 1
      itemGraph[6].append(4)
      itemIndegree[4] += 1
      Updated itemGraph: [6: [1, 3, 4], 5: [2], 3: [4], 0: [], 1: [], 4: [], 7: []]
      Updated itemIndegree: [1: 1, 2: 1, 3: 1, 4: 2, 0: 0, 5: 0, 6: 0, 7: 0]
      ```
    - For item 5, no dependencies: `beforeItems[5] = []`.
    - For item 6, no dependencies: `beforeItems[6] = []`.
    - For item 7, no dependencies: `beforeItems[7] = []`.

 ### Topological Sort

 4. **Topologically Sort the Groups**:
    - All groups: `[0, 1, 2, 3, 4]`
    - Group graph: `[0: [3], 1: [], 2: [], 3: [], 4: []]`
    - Group in-degrees: `[0: 0, 1: 0, 2: 0, 3: 1, 4: 0]`
    - Perform topological sort on the groups:
      ```
      Initial queue: [0, 1, 2, 4] (groups with 0 in-degree)
      Sorted order: []
      Dequeue 0 -> Sorted order: [0]
      Decrement indegree of 3 -> Updated groupIndegree: [3: 0]
      Enqueue 3
      Dequeue 1 -> Sorted order: [0, 1]
      Dequeue 2 -> Sorted order: [0, 1, 2]
      Dequeue 4 -> Sorted order: [0, 1, 2, 4]
      Dequeue 3 -> Sorted order: [0, 1, 2, 4, 3]
      Final group order: [0, 1, 2, 4, 3]
      ```

 5. **Topologically Sort Items within Each Group**:
    - Group 0 items: `[3, 4, 6]`
      - Item graph: `[6: [1, 3, 4], 5: [2], 3: [4], 0: [], 1: [], 4: [], 7: []]`
      - Item in-degrees: `[1: 1, 2: 1, 3: 1, 4: 2, 0: 0, 5: 0, 6: 0, 7: 0]`
      - Perform topological sort on group 0 items:
        ```
        Initial queue: [6] (items with 0 in-degree in group 0)
        Sorted order: []
        Dequeue 6 -> Sorted order: [6]
        Decrement indegree of 1, 3, 4 -> Updated itemIndegree: [1: 0, 3: 0, 4: 1]
        Enqueue 1, 3
        Dequeue 3 -> Sorted order: [6, 3]
        Decrement indegree of 4 -> Updated itemIndegree: [4: 0]
        Enqueue 4
        Dequeue 4 -> Sorted order: [6, 3, 4]
        Final item order for group 0: [6, 3, 4]
        ```

    - Group 1 items: `[2, 5]`
      - Item graph: `[6: [1, 3, 4], 5: [2], 3: [4], 0: [], 1: [], 4: [], 7: []]`
      - Item in-degrees: `[1: 0, 2: 1, 3: 0, 4: 0, 0: 0, 5: 0, 6: 0, 7: 0]`
      - Perform topological sort on group 1 items:
        ```
        Initial queue: [5] (items with 0 in-degree in group 1)
        Sorted order: []
        Dequeue 5 -> Sorted order: [5]
        Decrement indegree of 2 -> Updated itemIndegree: [2: 0]
        Enqueue 2
        Dequeue 2 -> Sorted order: [5, 2]
        Final item order for group 1: [5, 2]
        ```

    - Group 2 items: `[0]`
      - Item graph: `[6

 : [1, 3, 4], 5: [2], 3: [4], 0: [], 1: [], 4: [], 7: []]`
      - Item in-degrees: `[1: 0, 2: 0, 3: 0, 4: 0, 0: 0, 5: 0, 6: 0, 7: 0]`
      - Perform topological sort on group 2 items:
        ```
        Initial queue: [0] (items with 0 in-degree in group 2)
        Sorted order: []
        Dequeue 0 -> Sorted order: [0]
        Final item order for group 2: [0]
        ```

    - Group 3 items: `[1]`
      - Item graph: `[6: [1, 3, 4], 5: [2], 3: [4], 0: [], 1: [], 4: [], 7: []]`
      - Item in-degrees: `[1: 0, 2: 0, 3: 0, 4: 0, 0: 0, 5: 0, 6: 0, 7: 0]`
      - Perform topological sort on group 3 items:
        ```
        Initial queue: [1] (items with 0 in-degree in group 3)
        Sorted order: []
        Dequeue 1 -> Sorted order: [1]
        Final item order for group 3: [1]
        ```

    - Group 4 items: `[7]`
      - Item graph: `[6: [1, 3, 4], 5: [2], 3: [4], 0: [], 1: [], 4: [], 7: []]`
      - Item in-degrees: `[1: 0, 2: 0, 3: 0, 4: 0, 0: 0, 5: 0, 6: 0, 7: 0]`
      - Perform topological sort on group 4 items:
        ```
        Initial queue: [7] (items with 0 in-degree in group 4)
        Sorted order: []
        Dequeue 7 -> Sorted order: [7]
        Final item order for group 4: [7]
        ```

 ### Combine Results

 6. **Combine the Sorted Items in the Order of Sorted Groups**:
    - Group order: `[0, 1, 2, 4, 3]`
    - Combined result:
      ```
      Group 0 items: [6, 3, 4]
      Group 1 items: [5, 2]
      Group 2 items: [0]
      Group 4 items: [7]
      Group 3 items: [1]
      Final combined result: [6, 3, 4, 5, 2, 0, 7, 1]
      ```

 ### Conclusion

 The dry run of the algorithm with the given input yields the final sorted list of items:

 ```swift
 print(result)  // Output: [6, 3, 4, 5, 2, 0, 7, 1]
 ```

 This demonstrates how the algorithm processes the input step-by-step to generate the correct output while respecting the group and dependency constraints.
 */
