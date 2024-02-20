/*
 Given a string expression of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. You may return the answer in any order.

 The test cases are generated such that the output values fit in a 32-bit integer and the number of different results does not exceed 104.

  

 Example 1:

 Input: expression = "2-1-1"
 Output: [0,2]
 Explanation:
 ((2-1)-1) = 0
 (2-(1-1)) = 2
 Example 2:

 Input: expression = "2*3-4*5"
 Output: [-34,-14,-10,-10,10]
 Explanation:
 (2*(3-(4*5))) = -34
 ((2*3)-(4*5)) = -14
 ((2*(3-4))*5) = -10
 (2*((3-4)*5)) = -10
 (((2*3)-4)*5) = 10
 */

// Solution : https://leetcode.com/problems/different-ways-to-add-parentheses/solutions/1185237/swift-simple-recursion-memoization

private var memo = [String: [Int]]()

private let operators: [Character: (Int, Int) -> Int] = [
    "+" : {$0 + $1},
    "-" : {$0 - $1},
    "*" : {$0 * $1}
]

func diffWaysToCompute(_ expression: String) -> [Int] {
    
    if let values = memo[expression] {
        return values
    }
    if let num = Int(expression) {
        return [num]
    }
    
    var results = [Int]()
    
    for i in 0..<expression.count {
        let index =  expression.index(expression.startIndex, offsetBy: i)
        let char = expression[index]
        
        if let op = operators[char] {
            print("----------")
            let left = diffWaysToCompute(String(expression[..<index]))
            let nextIndex = expression.index(after: index)
            let right = diffWaysToCompute(String(expression[nextIndex...]))
            
            print("left = \(left)")
            print("right = \(right)")
            for l in left {
                for r in right {
                    results.append(op(l,r))
                }
            }
        }
    }
    
    memo[expression] = results
    print("memo = \(memo)")
    return results
}

print(diffWaysToCompute("2*3-4*5"))
