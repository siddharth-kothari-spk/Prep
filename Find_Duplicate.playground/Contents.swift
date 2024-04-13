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


func findDuplicate2(_ nums: [Int]) -> Int {
    var dict: [Int: Int] = [:]
    
    for num in nums {
        dict[num, default: 0] += 1
        if dict[num]! > 1 {
            return num
        }
    }
    
    return -1
}

print(findDuplicate2(nums))
