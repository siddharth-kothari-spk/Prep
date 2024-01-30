// https://leetcode.com/problems/zigzag-conversion/description/?envType=list&envId=du693s

/*
 The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

 P   A   H   N
 A P L S I I G
 Y   I   R
 And then read line by line: "PAHNAPLSIIGYIR"

 Write the code that will take a string and make this conversion given a number of rows:

 string convert(string s, int numRows);
  

 Example 1:

 Input: s = "PAYPALISHIRING", numRows = 3
 Output: "PAHNAPLSIIGYIR"
 Example 2:

 Input: s = "PAYPALISHIRING", numRows = 4
 Output: "PINALSIGYAHRPI"
 Explanation:
 P     I    N
 A   L S  I G
 Y A   H R
 P     I
 Example 3:

 Input: s = "A", numRows = 1
 Output: "A"
 */

// solution: https://leetcode.com/problems/zigzag-conversion/solutions/196299/swift-4-2-solution
/*
 Algo :
 
 Here's the algorithm expressed in a step-by-step manner:

     Base Cases:
         If the input string s has a length less than or equal to 1, return the string as it is.
         If the number of rows (numRows) is less than 2, return the string as it is.

     Initialization:
         Initialize an array zRows of strings to store each row of the ZigZag pattern. The size of this array is the minimum of the string length and the number of rows.
         Initialize variables cursorRow to keep track of the current row and nextLine to determine whether the cursor should move to the next row.

     ZigZag Traversal:
         Iterate through each character (ch) in the input string.
         Append the character to the current row (zRows[cursorRow]).
         If the cursor is at the first row or the last row, toggle nextLine to change the direction of the traversal.
         Update cursorRow based on the value of nextLine.

     Join Rows:
         Return the concatenation of all rows in the ZigZag pattern.
 */

func convert(_ s: String, _ numRows: Int) -> String {
        if s.count <= 1  { return s }
        if numRows < 2 { return s }
        
        var zRows = [String](repeating: String(), count: min(s.count, numRows))

        var cursorRow = 0
        var nextLine = false
        
        for ch in s {
            zRows[cursorRow] += String(ch)
            if cursorRow == 0 || cursorRow == numRows - 1 {
                nextLine.toggle()
            }
            cursorRow += nextLine ? 1 : -1
        }
        return zRows.joined()
    }

print(convert("PAYPALISHIRING", 4)) //PINALSIGYAHRPI

