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

print("***********************************")
// Solution2 : 2 pointer strategy
class Solution2 {
    func isHappy(_ n: Int) -> Bool {
        func getSumOfSquares(_ num: Int) -> Int {
            var sum = 0
            var number = num
            
            while number > 0 {
                let digit = number % 10
                sum += digit * digit
                number /= 10
            }
            
            return sum
        }
        
        var tortoise = n
        var hare = getSumOfSquares(n)
        print("initial tortoise: \(tortoise)")
        print("initial hare: \(hare)")
        
        while hare != 1 && hare != tortoise {
            tortoise = getSumOfSquares(tortoise)
            hare = getSumOfSquares(getSumOfSquares(hare))
            print("loop tortoise: \(tortoise)")
            print("loop hare: \(hare)")
        }
        
        return hare == 1
    }
}

let sol2 = Solution2()
print(sol2.isHappy(19))
print("-------")
print(sol2.isHappy(2))
