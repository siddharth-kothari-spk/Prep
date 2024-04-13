func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var frequencyMap = [Int: Int]()
    
    // Count the frequency of each element
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    print(frequencyMap) // [1: 3, 3: 1, 2: 2]
    
    // Create an array of tuples (element, frequency) and sort it by frequency
    let sortedFreq = frequencyMap.sorted { $0.value > $1.value }
    print(sortedFreq) // [(key: 1, value: 3), (key: 2, value: 2), (key: 3, value: 1)]

    // Extract the top k elements from the sorted array
    let topKFrequent = sortedFreq.prefix(k).map { $0.key }
    
    return topKFrequent
}

// Test the function with sample input
let nums = [1, 1, 1, 2, 2, 3]
let k = 2
let result = topKFrequent(nums, k)
print("Top \(k) Frequent Elements:", result)

