/*
 https://www.geeksforgeeks.org/minimum-number-of-times-a-has-to-be-repeated-such-that-b-is-a-substring-of-it/
 
 Here's an algorithm to find the minimum number of times a string A has to be repeated such that B is a substring of the repeated string:

 **1. Check if B is already a substring of A:**
    - If B is not present in A at all, then it can never be a substring of any repeated version of A. In this case, return -1.

 **2. Length Check:**
    - If the length of B (len_b) is not divisible by the length of A (len_a), then it's impossible to create a repeated A that contains B as a substring. This is because B needs to be formed by concatenating whole copies of A. In this case, return -1.

 **3. Calculate the number of repetitions (repeats):**
    - Divide the length of B (len_b) by the length of A (len_a) to get the base number of repetitions required (repeats = len_b // len_a). This ensures that the repeated A will be at least as long as B.

 **4. Check if the first occurrence of B aligns with the beginning of the repeated A:**
    - Construct a string by concatenating A 'repeats' number of times.
    - Check if the first 'len_b' characters of this repeated string are exactly equal to B.
    - If they are not equal, it means B's starting position falls within a copy of A in the repeated string, and we need one more repetition. Increment 'repeats' by 1.

 **5. Return the minimum number of repetitions:**
    - After the checks above, 'repeats' will hold the minimum number of times A needs to be repeated such that B becomes a substring. Return this value.

 This algorithm efficiently determines the repetition count by considering the lengths of the strings and performing comparisons at key positions in the repeated string.

 */

func minimumRepetitions(for a: String, and b: String) -> Int {
  guard b.contains(a) else { return -1 } // Check if B is substring of A
  
  let lenA = a.count
  let lenB = b.count
  print(lenA, lenB)
  guard lenB % lenA == 0 else { return -1 } // Check if lengths are divisible
  
  var repeats = lenB / lenA
  let repeatedA = String(repeating: a, count: repeats)
  print(repeats)
  print(repeatedA)
  if repeatedA.contains(b) {
    return repeats
  } else {
    repeats += 1 // Check if B starts at beginning of repeated string
      return (repeatedA + a).contains(b) ? repeats : -1 // Check with one more repetition
  }
}

minimumRepetitions(for: "abcd", and: "cdabcdab")
