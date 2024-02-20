/*
 Write an algorithm to determine if a number n is happy.

 A happy number is a number defined by the following process:

 Starting with any positive integer, replace the number by the sum of the squares of its digits.
 Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
 Those numbers for which this process ends in 1 are happy.
 Return true if n is a happy number, and false if not.
 */

import Foundation

class Solution {
    func isHappy(_ n: Int) -> Bool {
        var numbersProduced: [Int] = []
        var squared = n
        
        if squared == 1 {
            return true
        }
        
        while squared > 1 {
            squared = getSquareOfDigits(squared)
            if numbersProduced.contains(squared) {
                print("numbersProduced = \(numbersProduced)")
                return false
            }
            if squared == 1 {
                print("numbersProduced = \(numbersProduced)")
                return true
            }
            numbersProduced.append(squared)
        }
               
        
        return false
    }
    
    private func getSquareOfDigits(_ num: Int) -> Int {
        var num = num
        var square: Int = 0
        
        while num > 0 {
            let remainder = num % 10
            square += remainder * remainder
            num = num / 10
        }
        return square
    }
}

let sol = Solution()
print(sol.isHappy(19))
print("-------")
print(sol.isHappy(2))
