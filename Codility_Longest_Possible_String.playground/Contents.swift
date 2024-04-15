/*
 write a function that takes three integers as input and returns the longest possible string that can be created by joining some of the strings "AA", "AB", and "BB" together. The strings "AA", "AB", and "BB" appear a certain number of times, specified by the three input integers. However, the resulting string cannot contain the substring "AAA" or "BBB".
 */

func solution(AA: Int, AB: Int, BB: Int) -> String {
  // Initialize a string to store the result.
  var result = ""

  // Add "AB" strings as many times as possible.
  result += String(repeating: "AB", count: min(AB, min(AA, BB)))

  // Calculate the remaining occurrences of "AA" and "BB" after using them in "AB".
  let remainingAA = AA - min(AB, min(AA, BB))
  let remainingBB = BB - min(AB, min(AA, BB))

  // Add "AA" strings as many times as possible without creating "AAA".
  result += String(repeating: "AA", count: min(remainingAA, remainingBB))

  // Add "BB" strings as many times as possible without creating "BBB".
  result += String(repeating: "BB", count: remainingBB)

  return result
}

//print(solution(AA: 5, AB: 0, BB: 2))


func longestString(aaCount: Int, bbCount: Int, abCount: Int) -> String {
    var aaCount = aaCount
    var bbCount = bbCount
    var abCount = abCount
    var result = ""
    var lastAdded = ""

    print("result: \(result), AA: \(aaCount), BB: \(bbCount), CC: \(abCount)")
    while aaCount > 0 || bbCount > 0 || abCount > 0 {
        if lastAdded == "AA" {
//            if abCount > 0 {
//                result += "AB"
//                abCount -= 1
//                lastAdded = "AB"
//            } else if bbCount > 0 {
            if bbCount > 0 {
                result += "BB"
                bbCount -= 1
                lastAdded = "BB"
            } else {
                break
            }
        } else if lastAdded == "BB" {
            if abCount > 0 {
                result += "AB"
                abCount -= 1
                lastAdded = "AB"
            } else if aaCount > 0 {
                result += "AA"
                aaCount -= 1
                lastAdded = "AA"
            } else {
                break
            }
        } else { // No last added or last added was AB
            if aaCount > bbCount {
                if aaCount > 0 {
                    result += "AA"
                    aaCount -= 1
                    lastAdded = "AA"
                }
            } else {
                if bbCount > 0 {
                    result += "BB"
                    bbCount -= 1
                    lastAdded = "BB"
                }
            }

            // If both are zero and only AB is left
            if aaCount == 0 && bbCount == 0 && abCount > 0 && lastAdded != "AA"{
                result += "AB"
                abCount -= 1
                lastAdded = "AB"
            }
        }
        print("result: \(result), AA: \(aaCount), BB: \(bbCount), AB: \(abCount), lastAdded: \(lastAdded)")
        
    }

    return result
}

// Example usage
//print(longestString(aaCount: 5, bbCount: 2, abCount: 0)) // AABBAABBAA
print(longestString(aaCount: 1, bbCount: 1, abCount: 2))
