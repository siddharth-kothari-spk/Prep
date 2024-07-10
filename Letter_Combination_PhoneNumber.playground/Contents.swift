/*
 Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.

 A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.


  

 Example 1:

 Input: digits = "23"
 Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
 Example 2:

 Input: digits = ""
 Output: []
 Example 3:

 Input: digits = "2"
 Output: ["a","b","c"]
 */

/*
 Here’s a step-by-step algorithm:

 Create a Mapping: Define a dictionary that maps each digit to the corresponding letters.
 Edge Case: If the input string is empty, return an empty list.
 Backtracking Function: Define a helper function that performs backtracking to generate the combinations.
 Combine Results: Use the helper function to build the combinations step by step.
 */

func letterCombinations(_ digits: String) -> [String] {
    guard !digits.isEmpty else { return [] }

    let digitToLetters: [Character: [Character]] = [
        "2": ["a", "b", "c"],
        "3": ["d", "e", "f"],
        "4": ["g", "h", "i"],
        "5": ["j", "k", "l"],
        "6": ["m", "n", "o"],
        "7": ["p", "q", "r", "s"],
        "8": ["t", "u", "v"],
        "9": ["w", "x", "y", "z"]
    ]

    var result = [String]()
    
    func backtrack(_ index: Int, _ path: [Character]) {
        if index == digits.count {
            result.append(String(path))
            return
        }

        let digit = digits[digits.index(digits.startIndex, offsetBy: index)]
        guard let letters = digitToLetters[digit] else { return }

        for letter in letters {
            backtrack(index + 1, path + [letter])
        }
    }

    backtrack(0, [])
    return result
}

// Example usage:
print(letterCombinations("23"))  // Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
print(letterCombinations(""))    // Output: []
print(letterCombinations("2"))   // Output: ["a","b","c"]

/*
 Sure, let's go through a dry run for `letterCombinations("23")` with the provided Swift code.

 ### Initial Setup

 1. **Input:** `digits = "23"`
 2. **Mapping:**
    ```swift
    let digitToLetters: [Character: [Character]] = [
        "2": ["a", "b", "c"],
        "3": ["d", "e", "f"]
    ]
    ```
 3. **Result Array:** `result = []`

 ### Function Call

 We start with the initial call: `backtrack(0, [])`.

 ### First Level of Recursion

 **Call:** `backtrack(0, [])`

 1. **Index Check:** `index = 0` is less than `digits.count = 2`, so we proceed.
 2. **Current Digit:** `digit = digits[digits.index(digits.startIndex, offsetBy: 0)] = "2"`
 3. **Possible Letters:** `letters = ["a", "b", "c"]`

 **Iteration over letters "a", "b", and "c":**

 #### First Sub-Call (for "a")

 **Call:** `backtrack(1, ["a"])`

 1. **Index Check:** `index = 1` is less than `digits.count = 2`, so we proceed.
 2. **Current Digit:** `digit = digits[digits.index(digits.startIndex, offsetBy: 1)] = "3"`
 3. **Possible Letters:** `letters = ["d", "e", "f"]`

 **Iteration over letters "d", "e", and "f":**

 ##### First Sub-Sub-Call (for "d")

 **Call:** `backtrack(2, ["a", "d"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["a", "d"]) = "ad"` to `result`.
 2. **Result:** `result = ["ad"]`
 3. **Backtrack:** Return to previous level.

 ##### Second Sub-Sub-Call (for "e")

 **Call:** `backtrack(2, ["a", "e"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["a", "e"]) = "ae"` to `result`.
 2. **Result:** `result = ["ad", "ae"]`
 3. **Backtrack:** Return to previous level.

 ##### Third Sub-Sub-Call (for "f")

 **Call:** `backtrack(2, ["a", "f"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["a", "f"]) = "af"` to `result`.
 2. **Result:** `result = ["ad", "ae", "af"]`
 3. **Backtrack:** Return to previous level.

 #### Second Sub-Call (for "b")

 **Call:** `backtrack(1, ["b"])`

 1. **Index Check:** `index = 1` is less than `digits.count = 2`, so we proceed.
 2. **Current Digit:** `digit = digits[digits.index(digits.startIndex, offsetBy: 1)] = "3"`
 3. **Possible Letters:** `letters = ["d", "e", "f"]`

 **Iteration over letters "d", "e", and "f":**

 ##### First Sub-Sub-Call (for "d")

 **Call:** `backtrack(2, ["b", "d"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["b", "d"]) = "bd"` to `result`.
 2. **Result:** `result = ["ad", "ae", "af", "bd"]`
 3. **Backtrack:** Return to previous level.

 ##### Second Sub-Sub-Call (for "e")

 **Call:** `backtrack(2, ["b", "e"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["b", "e"]) = "be"` to `result`.
 2. **Result:** `result = ["ad", "ae", "af", "bd", "be"]`
 3. **Backtrack:** Return to previous level.

 ##### Third Sub-Sub-Call (for "f")

 **Call:** `backtrack(2, ["b", "f"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["b", "f"]) = "bf"` to `result`.
 2. **Result:** `result = ["ad", "ae", "af", "bd", "be", "bf"]`
 3. **Backtrack:** Return to previous level.

 #### Third Sub-Call (for "c")

 **Call:** `backtrack(1, ["c"])`

 1. **Index Check:** `index = 1` is less than `digits.count = 2`, so we proceed.
 2. **Current Digit:** `digit = digits[digits.index(digits.startIndex, offsetBy: 1)] = "3"`
 3. **Possible Letters:** `letters = ["d", "e", "f"]`

 **Iteration over letters "d", "e", and "f":**

 ##### First Sub-Sub-Call (for "d")

 **Call:** `backtrack(2, ["c", "d"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["c", "d"]) = "cd"` to `result`.
 2. **Result:** `result = ["ad", "ae", "af", "bd", "be", "bf", "cd"]`
 3. **Backtrack:** Return to previous level.

 ##### Second Sub-Sub-Call (for "e")

 **Call:** `backtrack(2, ["c", "e"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["c", "e"]) = "ce"` to `result`.
 2. **Result:** `result = ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce"]`
 3. **Backtrack:** Return to previous level.

 ##### Third Sub-Sub-Call (for "f")

 **Call:** `backtrack(2, ["c", "f"])`

 1. **Index Check:** `index = 2` equals `digits.count = 2`, so we add `String(["c", "f"]) = "cf"` to `result`.
 2. **Result:** `result = ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]`
 3. **Backtrack:** Return to previous level.

 ### Final Result

 After all recursive calls complete, the final result is:
 ```swift
 ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
 ```

 So, the output of `print(letterCombinations("23"))` will be:
 ```swift
 ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
 ```
 */
