/*
 convert a Roman numeral to an integer.
 - Sample Input:
 ```
 Roman Numeral: "XIV"
 ```- Expected Output:
 ```
 Integer Value: 14
 */

func romanToInt(_ roman: String) -> Int {
  let romanMap: [Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
  var number = 0
  var previousValue = 0
    var roman = roman.uppercased()
    
  for char in roman.reversed() {
    guard let value = romanMap[char] else { return 0 } // Invalid Roman numeral character
    if value < previousValue {
      number -= value // Handle subtractive notation (IV, IX)
    } else {
      number += value
    }
    previousValue = value
  }
  return number
}

romanToInt("XVIII") // 18
romanToInt("mdcccclxxxviii") // 1988
romanToInt("mdcccclix") // 1959
romanToInt("mmxxii") // 2022
