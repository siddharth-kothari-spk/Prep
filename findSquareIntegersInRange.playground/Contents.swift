import Foundation

func findSquareIntegersInRange(start: Int, end: Int) -> [Int] {
    var result: [Int] = []

    for num in start...end {
        let root = sqrt(Double(num))
        print("Num = \(num), Root =\(root)")
        if root.isEqual(to: Double(Int(root))) {
            result.append(num)
        }
    }

    return result
}

// Example usage
let startRange = 1
let endRange = 10
let result = findSquareIntegersInRange(start: startRange, end: endRange)
print(result)

