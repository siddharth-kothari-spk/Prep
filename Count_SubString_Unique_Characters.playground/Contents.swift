/*
 https://leetcode.com/problems/count-unique-characters-of-all-substrings-of-a-given-string/description/
 Let's define a function countUniqueChars(s) that returns the number of unique characters in s.

 For example, calling countUniqueChars(s) if s = "LEETCODE" then "L", "T", "C", "O", "D" are the unique characters since they appear only once in s, therefore countUniqueChars(s) = 5.
 Given a string s, return the sum of countUniqueChars(t) where t is a substring of s. The test cases are generated such that the answer fits in a 32-bit integer.

 Notice that some substrings can be repeated so in this case you have to count the repeated ones too.

  

 Example 1:

 Input: s = "ABC"
 Output: 10
 Explanation: All possible substrings are: "A","B","C","AB","BC" and "ABC".
 Every substring is composed with only unique letters.
 Sum of lengths of all substring is 1 + 1 + 1 + 2 + 2 + 3 = 10
 Example 2:

 Input: s = "ABA"
 Output: 8
 Explanation: The same as example 1, except countUniqueChars("ABA") = 1.
 Example 3:

 Input: s = "LEETCODE"
 Output: 92

 */

/*
 Here is a detailed algorithm to achieve this:

 Understanding the Contribution of Each Character:

 For each character in the string s, determine how many substrings include this character and how many of these substrings consider it as a unique character.
 For a character at position i, it can form substrings starting from any position j where 0 <= j <= i and ending at any position k where i <= k < n.
 Contribution Calculation:

 Let's denote prev[i] as the previous index where the character s[i] appeared.
 Let's denote next[i] as the next index where the character s[i] will appear.
 For each character s[i] at index i, its contribution to the total count is (i - prev[i]) * (next[i] - i). This is because the character s[i] will be a unique character in all substrings starting from any position in the range (prev[i] + 1) to i and ending at any position in the range i to (next[i] - 1).
 Algorithm Steps:

 Precompute the prev and next arrays.
 Iterate through the string and use the contribution formula to sum up the contributions for all characters.

 */

func countUniqueChars(_ s: String) -> Int {
    let n = s.count
    let characters = Array(s)
    var prev = [Int](repeating: -1, count: n)
    var next = [Int](repeating: n, count: n)
    var lastOccurrence = [Character: Int]()

    // Calculate prev array
    for i in 0..<n {
        if let last = lastOccurrence[characters[i]] {
            prev[i] = last
        }
        lastOccurrence[characters[i]] = i
    }

    lastOccurrence.removeAll()

    // Calculate next array
    for i in stride(from: n - 1, through: 0, by: -1) {
        if let last = lastOccurrence[characters[i]] {
            next[i] = last
        }
        lastOccurrence[characters[i]] = i
    }

    // Calculate the sum of counts of unique characters
    var result = 0
    for i in 0..<n {
        result += (i - prev[i]) * (next[i] - i)
    }

    return result
}

// Test cases
print(countUniqueChars("ABC"))      // Output: 10
print(countUniqueChars("ABA"))      // Output: 8
print(countUniqueChars("LEETCODE")) // Output: 92
print(countUniqueChars("ABCA"))      // Output: 18

/*
 Sure! Let's do a dry run of the Swift code for the input "ABCA".

 ### Input
 s = "ABCA"

 ### Steps and Intermediate Values

 1. **Initialization**:
    - `n = 4` (length of the string "ABCA")
    - `characters = ["A", "B", "C", "A"]` (array of characters)
    - `prev = [-1, -1, -1, -1]` (initialize with -1, as initially no previous occurrence)
    - `next = [4, 4, 4, 4]` (initialize with `n`, as initially no next occurrence)
    - `lastOccurrence = [:]` (empty dictionary)

 2. **Calculate `prev` array**:
    - For `i = 0`:
      - `characters[0] = "A"`
      - `lastOccurrence["A"]` does not exist, so `prev[0]` remains `-1`.
      - Update `lastOccurrence["A"] = 0`.
      - `lastOccurrence` becomes `["A": 0]`.
    - For `i = 1`:
      - `characters[1] = "B"`
      - `lastOccurrence["B"]` does not exist, so `prev[1]` remains `-1`.
      - Update `lastOccurrence["B"] = 1`.
      - `lastOccurrence` becomes `["A": 0, "B": 1]`.
    - For `i = 2`:
      - `characters[2] = "C"`
      - `lastOccurrence["C"]` does not exist, so `prev[2]` remains `-1`.
      - Update `lastOccurrence["C"] = 2`.
      - `lastOccurrence` becomes `["A": 0, "B": 1, "C": 2]`.
    - For `i = 3`:
      - `characters[3] = "A"`
      - `lastOccurrence["A"]` exists at index 0, so `prev[3]` is updated to `0`.
      - Update `lastOccurrence["A"] = 3`.
      - `lastOccurrence` becomes `["A": 3, "B": 1, "C": 2]`.

 3. **Calculate `next` array**:
    - Clear `lastOccurrence` dictionary: `lastOccurrence = [:]`.
    - For `i = 3`:
      - `characters[3] = "A"`
      - `lastOccurrence["A"]` does not exist, so `next[3]` remains `4`.
      - Update `lastOccurrence["A"] = 3`.
      - `lastOccurrence` becomes `["A": 3]`.
    - For `i = 2`:
      - `characters[2] = "C"`
      - `lastOccurrence["C"]` does not exist, so `next[2]` remains `4`.
      - Update `lastOccurrence["C"] = 2`.
      - `lastOccurrence` becomes `["A": 3, "C": 2]`.
    - For `i = 1`:
      - `characters[1] = "B"`
      - `lastOccurrence["B"]` does not exist, so `next[1]` remains `4`.
      - Update `lastOccurrence["B"] = 1`.
      - `lastOccurrence` becomes `["A": 3, "B": 1, "C": 2]`.
    - For `i = 0`:
      - `characters[0] = "A"`
      - `lastOccurrence["A"]` exists at index 3, so `next[0]` is updated to `3`.
      - Update `lastOccurrence["A"] = 0`.
      - `lastOccurrence` becomes `["A": 0, "B": 1, "C": 2]`.

 4. **Calculate the result**:
    - Initialize `result = 0`.
    - For `i = 0`:
      - Contribution of `characters[0] ("A")`: `(i - prev[i]) * (next[i] - i) = (0 - (-1)) * (3 - 0) = 1 * 3 = 3`.
      - Add `3` to `result`: `result = 3`.
    - For `i = 1`:
      - Contribution of `characters[1] ("B")`: `(i - prev[i]) * (next[i] - i) = (1 - (-1)) * (4 - 1) = 2 * 3 = 6`.
      - Add `6` to `result`: `result = 3 + 6 = 9`.
    - For `i = 2`:
      - Contribution of `characters[2] ("C")`: `(i - prev[i]) * (next[i] - i) = (2 - (-1)) * (4 - 2) = 3 * 2 = 6`.
      - Add `6` to `result`: `result = 9 + 6 = 15`.
    - For `i = 3`:
      - Contribution of `characters[3] ("A")`: `(i - prev[i]) * (next[i] - i) = (3 - 0) * (4 - 3) = 3 * 1 = 3`.
      - Add `3` to `result`: `result = 15 + 3 = 18`.

 ### Final Result
 The sum of counts of unique characters in all substrings of "ABCA" is `18`.

 ### Explanation:
 - Substrings: "A", "B", "C", "A", "AB", "BC", "CA", "ABC", "BCA", "ABCA".
 - Unique character counts:
   - "A" -> 1
   - "B" -> 1
   - "C" -> 1
   - "A" -> 1
   - "AB" -> 2
   - "BC" -> 2
   - "CA" -> 2
   - "ABC" -> 3
   - "BCA" -> 3
   - "ABCA" -> 2 (A repeats)
 - Sum: 1 + 1 + 1 + 1 + 2 + 2 + 2 + 3 + 3 + 2 = 18

 Therefore, the algorithm correctly computes the desired result for the input "ABCA".
 */
