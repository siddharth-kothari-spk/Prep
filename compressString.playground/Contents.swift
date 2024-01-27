/*
 4. String Compression:
     * Implement a function to perform basic string compression using the counts of repeated characters.
     * Example: "aabcccccaaa" should become "a2b1c5a3".
 */

func compressString(_ str: String) -> String {
    var result = ""
    var count = 1

    for i in 0..<str.count {
       // let currentChar = str[i] // error : 'subscript(_:)' is unavailable: cannot subscript String with an Int, use a String.Index instead.
        let currentChar = str[str.index(str.startIndex, offsetBy: i)]
        let nextChar = (i + 1 < str.count) ? str[str.index(str.startIndex, offsetBy: i + 1)] : nil

        if currentChar == nextChar {
            count += 1
        } else {
            result.append("\(currentChar)\(count)")
            count = 1
        }
    }

    return result.count < str.count ? result : str
}

// Example usage:
let compressedString = compressString("aabcccccaaa!")
print(compressedString)

/*
 
 why we need to write
 let currentChar = str[str.index(str.startIndex, offsetBy: i)]
 cant we just do
 let currentChar = str[i]
 
 
 In Swift, when you access a string using subscripting syntax (e.g., `str[i]`), it returns a `Character` at the specified index, but it doesn't provide direct access to the index. The subscripting syntax allows you to access elements by their position, but it doesn't give you an index that you can use for more advanced operations like slicing or generating a substring.

 On the other hand, when you use `str.index(str.startIndex, offsetBy: i)`, it explicitly provides you with the index at the given offset from the start of the string. This index can then be used to access the character at that specific position. It's a more explicit way of obtaining the index, which can be useful in certain scenarios.

 In the case of the `compressString` function, we need both the current character and the next character. Using `str.index` allows us to obtain the current character using `str.index(str.startIndex, offsetBy: i)` and the next character using `str.index(str.startIndex, offsetBy: i + 1)`.

 If you try to use `str[i]` directly in the loop, Swift will give you an error because it doesn't have an overloaded subscript that takes an integer index for strings. You would need to convert the index to a valid `String.Index` using `str.index(str.startIndex, offsetBy: i)` before using it for subscripting.

 So, while it's possible to use `str[i]` if you first convert `i` to a valid `String.Index`, using `str.index(str.startIndex, offsetBy: i)` directly is more explicit and avoids potential errors related to subscripting with an integer.
 */
