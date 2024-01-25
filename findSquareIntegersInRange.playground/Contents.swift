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


/*
 Good questions! Let's address each of these concerns:

     Changing the Range:
         The algorithm should work for any valid range of integers where range.first is less than or equal to range.last.
         If the range is reversed (i.e., range.first is greater than range.last), the algorithm will still work correctly, but it will return an empty array since there are no integers in a reversed range that are squares of other integers.

     Starting the Range from 0:
         Starting the range from 0 (e.g., 0...10) will work perfectly fine. The algorithm checks if the square root of each number is an integer, so it will include 0 if it's present in the range.

     Handling Negative Numbers:
         The current algorithm may not work as expected for negative numbers. The sqrt function will return NaN (Not a Number) for negative numbers. If you want to include negative numbers in the range, you would need to adjust the algorithm accordingly.
         One approach to handle negative numbers is to check if the number is greater than or equal to 0 before calculating the square root.
 */

import Foundation

func findSquareIntegersInRange2(start: Int, end: Int) -> [Int] {
    var result: [Int] = []

    for num in start...end {
        if num >= 0 {
            let root = sqrt(Double(num))
            if root.isEqual(to: Double(Int(root))) {
                result.append(num)
            }
        }
    }

    return result
}

// Example usage
let startRange2 = -10
let endRange2 = 10
let result2 = findSquareIntegersInRange2(start: startRange2, end: endRange2)
print(result2)
