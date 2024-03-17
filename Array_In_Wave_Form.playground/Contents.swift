
/*
 https://www.geeksforgeeks.org/sort-array-wave-form-2/
 Given an unsorted array of integers, sort the array into a wave array. An array arr[0..n-1] is sorted in wave form if:
 arr[0] >= arr[1] <= arr[2] >= arr[3] <= arr[4] >= …..
 
 Input:  arr[] = {10, 5, 6, 3, 2, 20, 100, 80}
 Output: arr[] = {3, 2, 6, 5, 20, 10, 100, 80} or {10, 5, 6, 2, 20, 3, 100, 80}
 Explanation:
 here you can see {10, 5, 6, 2, 20, 3, 100, 80} first element is larger than the second and the same thing is repeated again and again. large element – small element-large element -small element and so on .it can be small element-larger element – small element-large element -small element too. all you need to maintain is the up-down fashion which represents a wave. there can be multiple answers.

 Input: arr[] = {20, 10, 8, 6, 4, 2}
 Output: arr[] = {20, 8, 10, 4, 6, 2}
 
 */

/*
 Sol1:
 A idea is to use sorting. First sort the input array, then swap all adjacent elements.
 Follow the steps mentioned below to implement the idea:

 Sort the array.
 Traverse the array from index 0 to N-1, and increase the value of the index by 2.
 While traversing the array swap arr[i] with arr[i+1].
 Print the final array.

 */

func waveArraySwap(_ arr: inout [Int]) {
   arr = arr.sorted()
    print("sorted: \(arr)")
    
    for index in stride(from: 0, through: arr.count - 1, by: 2) {
        arr.swapAt(index, index + 1)
    }
    print(arr)
}

var arr = [10, 5, 6, 3, 2, 20, 100, 80]
waveArraySwap(&arr)


/*
 Sol2:
 The idea is based on the fact that if we make sure that all even positioned (at index 0, 2, 4, ..) elements are greater than their adjacent odd elements, we don’t need to worry about oddly positioned elements.

 Follow the steps mentioned below to implement the idea:

 Traverse all even positioned elements of the input array, and do the following.
 If the current element is smaller than the previous odd element, swap the previous and current.
 If the current element is smaller than the next odd element, swap next and current.
 */

func waveArraySwap2(_ arr: inout [Int]) {
    for index in stride(from: 0, to: arr.count - 1, by: 2) {
        //  If the current element is smaller than the previous odd element, swap the previous and current.
        if (index > 0 && arr[index] < arr[index - 1]) {
            arr.swapAt(index - 1, index)
        }
        
        // If the current element is smaller than the next odd element, swap next and current.
        
        if (index < arr.count - 1 && arr[index] < arr[index + 1]) {
            arr.swapAt(index + 1, index)
        }
        
    }
    print(arr)
}

var arr2 = [10, 5, 6, 3, 2, 20, 100, 80]
waveArraySwap2(&arr2)
