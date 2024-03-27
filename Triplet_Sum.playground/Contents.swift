/*
 https://www.geeksforgeeks.org/find-a-triplet-that-sum-to-a-given-value/
 Given an array arr[] of size n and an integer X. Find if there’s a triplet in the array which sums up to the given integer X.

 Examples:

 Input: array = {12, 3, 4, 1, 6, 9}, sum = 24;
 Output: 12, 3, 9
 Explanation: There is a triplet (12, 3 and 9) present
 in the array whose sum is 24.

 Input: array = {1, 2, 3, 4, 5}, sum = 9
 Output: 5, 3, 1
 Explanation: There is a triplet (5, 3 and 1) present
 in the array whose sum is 9.
 
 
 */
import Foundation

func findTriplet(_ arr: [Int], targetSum: Int) -> (Int, Int, Int)? {
    let n = arr.count
    guard n >= 3 else {
        return nil // Triplet cannot be formed
    }
    
    for i in 0..<n-2 {
        var hashSet = Set<Int>()
        let currentSum = targetSum - arr[i]
        
        for j in i+1..<n {
            let requiredSum = currentSum - arr[j]
            if hashSet.contains(requiredSum) {
                return (arr[i], arr[j], requiredSum)
            }
            hashSet.insert(arr[j])
        }
    }
    
    return nil // No triplet found
}

// Example usage:
let arr = [1, 4, 45, 6, 10, 8, 21]
let targetSum = 22
if let triplet = findTriplet(arr, targetSum: targetSum) {
    print("Triplet found: \(triplet)")
} else {
    print("No triplet found")
}
