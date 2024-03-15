/*
 https://www.codingninjas.com/studio/problems/allocate-books_1090540?topList=top-google-coding-interview-questions&problemListRedirection=true
 
 Problem statement
 Given an array ‘arr’ of integer numbers, ‘arr[i]’ represents the number of pages in the ‘i-th’ book.



 There are ‘m’ number of students, and the task is to allocate all the books to the students.



 Allocate books in such a way that:

 1. Each student gets at least one book.
 2. Each book should be allocated to only one student.
 3. Book allocation should be in a contiguous manner.


 You have to allocate the book to ‘m’ students such that the maximum number of pages assigned to a student is minimum.



 If the allocation of books is not possible, return -1.



 Example:
 Input: ‘n’ = 4 ‘m’ = 2
 ‘arr’ = [12, 34, 67, 90]

 Output: 113

 Explanation: All possible ways to allocate the ‘4’ books to '2' students are:

 12 | 34, 67, 90 - the sum of all the pages of books allocated to student 1 is ‘12’, and student two is ‘34+ 67+ 90 = 191’, so the maximum is ‘max(12, 191)= 191’.

 12, 34 | 67, 90 - the sum of all the pages of books allocated to student 1 is ‘12+ 34 = 46’, and student two is ‘67+ 90 = 157’, so the maximum is ‘max(46, 157)= 157’.

 12, 34, 67 | 90 - the sum of all the pages of books allocated to student 1 is ‘12+ 34 +67 = 113’, and student two is ‘90’, so the maximum is ‘max(113, 90)= 113’.

 We are getting the minimum in the last case.

 Hence answer is ‘113’.
 Detailed explanation ( Input/output format, Notes, Images )
 Sample Input 1:
 4 2
 12 34 67 90
 Sample Output 1:
 113
 Explanation of sample input 1:
 All possible ways to allocate the ‘4’ books to '2' students are:

 12 | 34, 67, 90 - the sum of all the pages of books allocated to student 1 is ‘12’, and student two is ‘34+ 67+ 90 = 191’, so the maximum is ‘max(12, 191)= 191’.

 12, 34 | 67, 90 - the sum of all the pages of books allocated to student 1 is ‘12+ 34 = 46’, and student two is ‘67+ 90 = 157’, so the maximum is ‘max(46, 157)= 157’.

 12, 34, 67 | 90 - the sum of all the pages of books allocated to student 1 is ‘12+ 34 +67 = 113’, and student two is ‘90’, so the maximum is ‘max(113, 90)= 113’.

 We are getting the minimum in the last case.

 Hence answer is ‘113’.
 Sample Input 2:
 5 4
 25 46 28 49 24
 Sample Output 2:
 71
 Explanation of sample input 2:
 All possible ways to allocate the ‘5’ books to '4' students are:

 25 | 46 | 28 | 49 24 - the sum of all the pages of books allocated to students 1, 2, 3, and 4 are '25', '46', '28', and '73'. So the maximum is '73'.

 25 | 46 | 28 49 | 24 - the sum of all the pages of books allocated to students 1, 2, 3, and 4 are '25', '46', '77', and '24'. So the maximum is '77'.

 25 | 46 28 | 49 | 24 - the sum of all the pages of books allocated to students 1, 2, 3, and 4 are '25', '74', '49', and '24'. So the maximum is '74'.

 25 46 | 28 | 49 | 24 - the sum of all the pages of books allocated to students 1, 2, 3, and 4 are '71', '28', '49', and '24'. So the maximum is '71'.

 We are getting the minimum in the last case.

 Hence answer is ‘71’.
 Expected time complexity:
 The expected time complexity is O(n * log(s)), where ‘n’ is the number of integers in the array ‘arr’ and ‘s’ is the sum of all the elements of ‘arr’.
 Constraints:
 2 <= 'n' <= 10 ^ 3
 1 <= 'm' <= 10 ^ 3
 1 <= 'arr[i]' <= 10 ^ 9
 The sum of all arr[i] does not exceed 10 ^ 9.

 Where ‘n’ denotes the number of books and ‘m’ denotes the number of students. ‘arr[i]’ denotes an element at position ‘i’ in the sequence.

 Time limit: 1 second



 Algo:
 Here's an algorithm for allocating books to students with minimum workload:

 **This approach uses Binary Search**

 1. **Function Definition:** Define a function `allocateBooks(arr, n, m)` that takes three arguments:
     * `arr`: An array of integers representing the number of pages in each book.
     * `n`: The total number of books.
     * `m`: The number of students.

 2. **Input Validation:** Check if the number of students (`m`) is greater than the number of books (`n`). If yes, it's impossible to allocate and return -1.

 3. **Find Maximum Pages:** Calculate the total number of pages (`total_pages`) by summing up all elements in `arr`.

 4. **Binary Search:**
     * Initialize `low` to the maximum number of pages in a book (the largest element in `arr`) and `high` to the total number of pages (`total_pages`).
     * While `low` is less than or equal to `high`:
         * Calculate the mid value (`mid`) as the average of `low` and `high`.
         * If `isValid(arr, n, m, mid)` returns `True`:
             * Update the result (`result`) to `mid` as we found a valid allocation with this maximum workload.
             * Search in the left half (`high = mid - 1`) to find a smaller possible workload.
         * Otherwise, search in the right half (`low = mid + 1`) as the current `mid` workload is not feasible.

 5. **`isValid` Function:** Define a helper function `isValid(arr, n, m, max_pages)` that checks if it's possible to allocate books with a maximum workload of `max_pages`.
     * Initialize `student_count` to 1 and `current_pages` to 0.
     * Iterate through the `arr` array:
         * Add the current book's pages (`arr[i]`) to `current_pages`.
         * If `current_pages` exceeds `max_pages`:
             * Increment `student_count` and reset `current_pages` to the current book's pages.
         * If `student_count` becomes greater than `m` (number of students), it's not possible to allocate with this workload, return `False`.
     * If the loop finishes iterating through all books, and `student_count` is less than or equal to `m`, then the allocation is possible, return `True`.

 6. **Return Result:** After the binary search loop, return the `result` which holds the minimum workload for allocation.

 **Explanation:**

 - Binary search efficiently searches for the optimal workload by checking the feasibility of mid values between the minimum (max pages in a book) and maximum (total pages).
 - The `isValid` function checks if a specific workload can be achieved by allocating books to students.


 This algorithm has a time complexity of O(n * log(total_pages)) due to binary search and the `isValid` function iterating through the book list in the worst case.
 */

func allocateBooks(_ arr: [Int], _ n: Int, _ m: Int) -> Int {
  guard m <= n else { return -1 } // Not possible to allocate if students are more than books
  
  let totalPages = arr.reduce(0, +) // Calculate total number of pages
    print("totalPages: \(totalPages)")
  
  var low = arr.max()! // Minimum workload is the max pages in a book
  var high = totalPages
  var result = totalPages
    print("low: \(low), high: \(high)")
    
  while low <= high {
      print("****************")
    let mid = (low + high) / 2
      print("low: \(low), high: \(high), mid:\(mid)")
    if isValid(arr, n, m, mid) {
      // Update result with the current mid value (possible workload)
      result = mid
        print("result: \(result)")
      high = mid - 1 // Search in left half for smaller workload
    } else {
      low = mid + 1 // Search in right half for higher workload
    }
  }
  
  return result
}

func isValid(_ arr: [Int], _ n: Int, _ m: Int, _ maxPages: Int) -> Bool {
  var studentCount = 1
  var currentPages = 0
  
  for bookPages in arr {
    currentPages += bookPages
      print("currentPages: \(currentPages)")
    if currentPages > maxPages {
      studentCount += 1
      currentPages = bookPages
        print("currentPages: \(currentPages), studentCount: \(studentCount)")
    }
    if studentCount > m {
      return false // Not possible to allocate with this workload
    }
  }
  
  return studentCount <= m // Allocation possible if student count is within limit
}

print(allocateBooks([25,46,28,49,24], 5, 4))
