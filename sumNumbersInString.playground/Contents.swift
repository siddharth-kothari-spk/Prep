func sumNumbersInString(_ str: String) -> Int {
    var sum = 0
    var currentNumber = 0

    for char in str {
        if let digit = Int(String(char)) {
            currentNumber = currentNumber * 10 + digit
        } else {
            sum += currentNumber
            currentNumber = 0
        }
    }

    // Add the last number in case the string ends with a number
    sum += currentNumber

    return sum
}

// Example usage
let str = "AB_12_CD_23_EF_30_)"
let result = sumNumbersInString(str)
print(result)

