/*
 Given an integer array nums, return an integer array counts where counts[i] is the number of smaller elements to the right of nums[i].

  

 Example 1:

 Input: nums = [5,2,6,1]
 Output: [2,1,1,0]
 Explanation:
 To the right of 5 there are 2 smaller elements (2 and 1).
 To the right of 2 there is only 1 smaller element (1).
 To the right of 6 there is 1 smaller element (1).
 To the right of 1 there is 0 smaller element.
 Example 2:

 Input: nums = [-1]
 Output: [0]
 Example 3:

 Input: nums = [-1,-1]
 Output: [0,0]
 */
func countSmaller(_ nums: [Int]) -> [Int] {
    var result = Array(repeating: 0, count: nums.count)
    
    for index in 0..<nums.count - 1 {
        let value = nums[index]
        result[index] += nums[index+1..<nums.count].filter({ num in
           // print("num: \(num), value: \(value)")
            return num < value
        }).count
    }
    return result
}
print(countSmaller([5,2,6,1]))
print(countSmaller([-1,-1]))
print(countSmaller([9,11,15,8,5,6]))

//let arr = [5,2,6,1]
//print(arr.filter({ num in
//    num.isMultiple(of: 3)
//}).count)
