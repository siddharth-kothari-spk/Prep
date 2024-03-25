/*
 Find next greater number with same set of digits
 Given a number n, find the smallest number that has same set of digits as n and is greater than n. If n is the greatest possible number with its set of digits, then print “not possible”.

 Examples:
 For simplicity of implementation, we have considered input number as a string.

 Input:  n = "218765"
 Output: "251678"

 Input:  n = "1234"
 Output: "1243"

 Input: n = "4321"
 Output: "Not Possible"

 Input: n = "534976"
 Output: "536479"
 
 
 Here's an algorithm to find the next greater number with the same set of digits as a given number (n):

 1. **Traverse from right:** Start from the rightmost digit of the number n.
 2. **Find first dip:** Keep moving left until you find a digit that is smaller than the digit to its right. This dip signifies where the number can be increased. If you don't find such a dip (i.e., all digits are in descending order), then the number is the greatest possible and no greater number exists with the same digits.
 3. **Find next greater digit:**  Search to the right of the dip (from step 2) for the next digit that is greater than the digit at the dip.
 4. **Swap:** Swap the digits found in steps 2 and 3.
 5. **Sort remaining digits:**  Sort the digits to the right of the swapped digits (from step 4) in ascending order.

 Here's a breakdown of the logic behind the algorithm:

 - The digits to the right of the dip (found in step 2) are all in descending order because they were larger than the dip digit. Swapping the dip digit with the next greater digit (found in step 3) creates the largest possible value for the leftmost part of the number.
 - Sorting the remaining digits (step 5) ensures that the overall number is the smallest possible number greater than the original number.

 By following these steps, you will be able to find the next greater number with the same set of digits as the original number, or determine that no such number exists.
 */

func nextGreaterNumber(_ n: String) -> String {
    print(n)
    var number = n.map { Int(String($0))! }
    var i = number.count - 1
    // Find the first decreasing digit from the right
    while i > 0 && number[i - 1] >= number[i] {
        i -= 1
    }
    
    // If no such digit found, it means no greater number is possible
    if i == 0 {
        return "Not Possible"
    }
    print("i: \(i)")
    // Find the smallest digit on the right side of number[i-1] that is greater than number[i-1]
    var j = number.count - 1
    print("j: \(j)")
    print("number[i - 1]: \(number[i - 1])")
    while number[j] <= number[i - 1] {
        j -= 1
    }
    print("after j: \(j)")
    // Swap the found two digits
    number.swapAt(i - 1, j)
    print("number: \(number)")
    
    // Reverse the digits from number[i] to the end
    j = number.count - 1
    while i < j {
        number.swapAt(i, j)
        i += 1
        j -= 1
    }
    print("number after swap: \(number)")
    return number.map { String($0) }.joined()
}

// Test cases
print(nextGreaterNumber("218765")) // Output: "251678"
print(nextGreaterNumber("1234"))   // Output: "1243"
print(nextGreaterNumber("4321"))   // Output: "Not Possible"
print(nextGreaterNumber("534976")) // Output: "536479"

