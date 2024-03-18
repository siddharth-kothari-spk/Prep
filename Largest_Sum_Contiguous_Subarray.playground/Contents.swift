/*
 Largest Sum Contiguous Subarray : https://www.geeksforgeeks.org/largest-sum-contiguous-subarray/
 
 Given an array arr[] of size N. The task is to find the sum of the contiguous subarray within a arr[] with the largest sum.
 example: [-2, -3, 4, -1, -2, 1, 5, -3]
 max contiguius array : [4, -1, -2, 1, 5] gives sum 7
 
 Algo:
 Initialize:
     max_so_far = INT_MIN
     max_ending_here = 0

 Loop for each element of the array

   (a) max_ending_here = max_ending_here + a[i]
   (b) if(max_so_far < max_ending_here)
             max_so_far = max_ending_here
   (c) if(max_ending_here < 0)
             max_ending_here = 0
 return max_so_far
 
 */

func largestSumContiguousSubarray(_ arr: [Int]) -> Int {
    var maxSoFar = Int.min
    var maxTillNow = 0
    var startIndex = -1
    var endIndex = -1
    
    for (index, item) in arr.enumerated() {
        maxTillNow += item
        
        if maxSoFar < maxTillNow {
            maxSoFar = maxTillNow
            
            if startIndex == -1 {
                startIndex = index
            }
            else {
                endIndex = index
            }
        }
        
        if maxTillNow < 0 {
            maxTillNow = 0
            startIndex = -1
            endIndex = -1
        }
    }
    
    print(arr[startIndex...endIndex])
    return maxSoFar
}

let arr = [-2, -3, 4, -1, -2, 1, 5, -3]
print(largestSumContiguousSubarray(arr))


// Using dynamic programming

func largestSumContiguousSubarrayDP(_ arr: [Int]) -> Int {
    
    var dp : [Int] = Array(repeating: 0, count: arr.count)
    var result = 0
    dp[0] = arr[0]
    
    for index in 1..<arr.count {
        dp[index] = max(arr[index], arr[index] + dp[index - 1])
        result = max(result, dp[index])
    }
    return result
}

print(largestSumContiguousSubarrayDP(arr))
