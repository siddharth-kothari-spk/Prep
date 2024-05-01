/*
 https://leetcode.com/problems/pascals-triangle/description/
 */

func generate(_ numRows: Int) -> [[Int]] {
    guard numRows > 0 else {
        return []
    }
    
    if numRows == 1 {
        return [[1]]
    }
    
    var result: [[Int]] = []
    result.reserveCapacity(numRows)
    
    result.append([1]) // 0th row
    
    for index in 1..<numRows { // 1st to (n-1)th row
        var newRow: [Int] = [1]
        let prevRow = result[index - 1]
        
        for j in 1..<prevRow.count {
            let sum = prevRow[j] + prevRow[j - 1]
            newRow.append(sum)
        }
        newRow.append(1)
        
        result.append(newRow)
    }
    return result
}

let triangle = generate(8)
for row in triangle {
    print(row)
}


