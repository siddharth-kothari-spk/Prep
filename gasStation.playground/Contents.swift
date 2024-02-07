/*
 There are n gas stations along a circular route, where the amount of gas at the ith station is gas[i].

 You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from the ith station to its next (i + 1)th station. You begin the journey with an empty tank at one of the gas stations.

 Given two integer arrays gas and cost, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return -1. If there exists a solution, it is guaranteed to be unique

  

 Example 1:

 Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
 Output: 3
 Explanation:
 Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
 Travel to station 4. Your tank = 4 - 1 + 5 = 8
 Travel to station 0. Your tank = 8 - 2 + 1 = 7
 Travel to station 1. Your tank = 7 - 3 + 2 = 6
 Travel to station 2. Your tank = 6 - 4 + 3 = 5
 Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
 Therefore, return 3 as the starting index.
 Example 2:

 Input: gas = [2,3,4], cost = [3,4,3]
 Output: -1
 Explanation:
 You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
 Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
 Travel to station 0. Your tank = 4 - 3 + 2 = 3
 Travel to station 1. Your tank = 3 - 3 + 3 = 3
 You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
 Therefore, you can't travel around the circuit once no matter where you start.
  

 Constraints:

 n == gas.length == cost.length
 1 <= n <= 10^5
 0 <= gas[i], cost[i] <= 10^4
 */

// Solution:

class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        
        let allgas = gas.reduce(0) { $0 + $1 }, allcost = cost.reduce(0) { $0 + $1 }
        guard allgas >= allcost else { return -1 }
        
        var value = 0, gasSum = 0, costSum = 0
        
        for (i, curr) in gas.enumerated() {
            print("i = \(i), curr = \(curr), ")
            gasSum += curr
            costSum += cost[i]
            print("gasSum = \(gasSum), costSum = \(costSum)")
            print("value = \(value)")
            print("--------")
            if gasSum < costSum {
                value = i + 1
                gasSum = 0
                costSum = 0
            }
        }
        return value
    }
}

//let sol = Solution()
//print(sol.canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2]))


/*
 Solution2:
 
 You can solve this problem using a greedy algorithm. The idea is to start from each station and check if you can complete the circuit. You keep track of the total gas available and the total cost needed to reach the next station. If at any point during the traversal you run out of gas, you cannot complete the circuit starting from that station. Here's the algorithm:

 Initialize two variables, total_gas and total_cost to keep track of the current total gas and total cost.
 Initialize a variable start_station to keep track of the potential starting station.
 Iterate over each station in a circular manner (using modular arithmetic to handle the circular nature of the route).
 Increment total_gas by the gas available at the current station.
 Increment total_cost by the cost of traveling to the next station.
 If at any point total_gas becomes negative (indicating that you can't reach the next station), reset start_station to the next station and reset total_gas and total_cost to zero.
 After completing the loop, if total_gas is greater than or equal to total_cost, return start_station as the starting index. Otherwise, return -1.
 */

func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var totalGas = 0
    var totalCost = 0
    var startStation = 0
    
    var currentGas = 0
    var currentCost = 0
    
    for i in 0..<gas.count {
        currentGas += gas[i]
        currentCost += cost[i]
        
        totalGas += gas[i]
        totalCost += cost[i]
        
        if currentGas < currentCost {
            startStation = (i + 1) % gas.count
            currentGas = 0
            currentCost = 0
        }
    }
    
    if totalGas >= totalCost {
        return startStation
    } else {
        return -1
    }
}

// Example usage:
let gas1 = [1,2,3,4,5]
let cost1 = [3,4,5,1,2]
print(canCompleteCircuit(gas1, cost1))  // Output: 3

let gas2 = [2,3,4]
let cost2 = [3,4,3]
print(canCompleteCircuit(gas2, cost2))  // Output: -1

