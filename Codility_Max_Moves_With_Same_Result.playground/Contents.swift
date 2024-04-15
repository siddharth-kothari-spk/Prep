/*
 You are given an array A consisting of N numbers. In one move you can delete either the first two, the last two, or the first and last elements of A. No move can be performed if the length of A is smaller than 2. The result of each move is the sum of the deleted elements.
 
 Write a function:

 Swift
 public func solution(_ A inout [Int]) -> Int

 that, given an array A of N integers, returns the maximum number of moves that can be performed on A, such that all performed moves have the same result.

 Examples

 Given A = [3, 1, 5, 3, 3, 4, 2], the function should return 3. The first move should delete two last elements (4 and 2 with sum = 6), then A = [3, 1, 5, 3, 3]. The second move may delete first and last elements (3 and 3 with sum = 6), then A = [1, 5, 3]. The third move should delete first two elements (1 and 5 with sum = 6), then A = [3].

 Given A = [4, 1, 4, 3, 3, 2, 5, 2], the function should return 4. It is possible to delete the first and last elements four times, as each such pair of elements sums up to 6.

 Given A = [1, 9, 1, 1, 1, 1, 1, 1, 8, 1], the function should return 1. There is no way to perform move that results with the same sum more than once.

 Given A = [1, 9, 8, 9, 5, 1, 2], the function should return 3. The first move should delete the first two elements, then the second and third moves should delete first and last elements twice.

 Given A = [1, 1, 2, 3, 1, 2, 2, 1, 1, 2], the function should return 4. One of the possible sequence of moves goes as follows:

 Twice delete the last two elements,
 Then delete the first and last elements,
 Last move deletes the first two elements.
 */

public func solution(_ A: inout [Int]) -> Int {
    var maxMoves = 0
    let n = A.count

    // Edge case, not enough elements to perform even one operation
    if n < 2 {
        return 0
    }

    // Dictionary to store the sum and their possible move counts
    var sumCounts = [Int: Int]()

    // Consider the pair of first two and last two
    if n >= 2 {
        let firstTwoSum = A[0] + A[1]
        let lastTwoSum = A[n - 2] + A[n - 1]
        sumCounts[firstTwoSum, default: 0] += 1
        sumCounts[lastTwoSum, default: 0] += 1
    }
    print("sumCounts: \(sumCounts)")
    // Consider the pair of first and last only if different from firstTwo and lastTwo
    if n > 2 {
        let firstLastSum = A[0] + A[n - 1]
        sumCounts[firstLastSum, default: 0] += 1
    }
    print("sumCounts: \(sumCounts)")

    // Determine the maximum possible moves for any given sum
    for (sum, _) in sumCounts {
        print("********")
        print("sum: \(sum)")
        var count = 0
        var i = 0
        var j = n - 1

        while i <= j - 1 {
            // Check first two elements
            if i + 1 <= j && A[i] + A[i + 1] == sum {
                count += 1
                i += 2
                print(" first two elements, i: \(i), j: \(j)")
            }
            // Check last two elements
            else if j - 1 >= i && A[j - 1] + A[j] == sum {
                count += 1
                j -= 2
                print(" last two elements, i: \(i), j: \(j)")
            }
            // Check first and last elements
            else if A[i] + A[j] == sum {
                count += 1
                i += 1
                j -= 1
                print(" first and last elements, i: \(i), j: \(j)")

            } else {
                // If no valid move found, break to stop
                break
            }
        }

        // Update max moves
        maxMoves = max(maxMoves, count)
    }

    return maxMoves
}

var arr = [3, 1, 5, 3, 3, 4, 2] //[1, 9, 8, 9, 5, 1, 2]//[1, 9, 1, 1, 1, 1, 1, 1, 8, 1] // [4, 1, 4, 3, 3, 2, 5, 2] //
solution(&arr)


/*
 
 [3, 1, 5, 3, 3, 4, 2]:
 
 sumCounts: [6: 1, 4: 1]
 sumCounts: [6: 1, 5: 1, 4: 1]
 ********
 sum: 6
  last two elements
  last two elements
  last two elements
 ********
 sum: 5
  first and last elements
  first and last elements
 ********
 sum: 4
  first two elements
 */

/*
 
 [4, 1, 4, 3, 3, 2, 5, 2]
 
 sumCounts: [5: 1, 7: 1]
 sumCounts: [5: 1, 6: 1, 7: 1]
 ********
 sum: 5
  first two elements, i: 2, j: 7
 ********
 sum: 6
  first and last elements, i: 1, j: 6
  first and last elements, i: 2, j: 5
  first and last elements, i: 3, j: 4
  first two elements, i: 5, j: 4
 ********
 sum: 7
  last two elements, i: 0, j: 5
 */
