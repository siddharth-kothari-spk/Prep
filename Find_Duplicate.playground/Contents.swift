/*
 Find the duplicate number in an array containing n+1 integers where each integer is
 between 1 and n
 */

func findDuplicate(_ nums: [Int]) -> Int {
    var slow = nums[0]
    var fast = nums[0]

    repeat {
        slow = nums[slow]
        fast = nums[nums[fast]]
    } while slow != fast
    
    fast = nums[0]
    while slow != fast {
        slow = nums[slow]
        fast = nums[fast]
    }
    
    return slow
}

// Example usage:
let nums = [1, 3, 3, 4, 2]
let duplicate = findDuplicate(nums)
print("The duplicate number is: \(duplicate)")
