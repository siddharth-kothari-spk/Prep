/*
 An ugly number is a positive integer whose prime factors are limited to 2, 3, and 5.

 Given an integer n, return the nth ugly number.

  

 Example 1:

 Input: n = 10
 Output: 12
 Explanation: [1, 2, 3, 4, 5, 6, 8, 9, 10, 12] is the sequence of the first 10 ugly numbers.
 Example 2:

 Input: n = 1
 Output: 1
 Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.

 */

// Sol: https://leetcode.com/problems/ugly-number-ii/solutions/3235848/best-c-3-solution-dp-tabulation-hash-table-math-one-stop-solution

func nthUglyNumber(_ n: Int) -> Int {
    var index = 0, count = 0
    
    while count < n {
        var isUgly = index + 1
        for factor in [2,3,5] {
            isUgly = keepDividingUntilPossible(dividend: isUgly, divisor: factor)
        }
        
        if isUgly == 1 {
            count += 1
        }
        index += 1
    }
        return index
}

func keepDividingUntilPossible(dividend: Int, divisor: Int) -> Int {
    var dividend = dividend
    var divisor = divisor
    
    while dividend % divisor == 0 {
        dividend /= divisor
    }
    return dividend
}

print(nthUglyNumber(10))
