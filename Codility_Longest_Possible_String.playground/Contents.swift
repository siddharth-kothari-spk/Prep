/*
 write a function that takes three integers as input and returns the longest possible string that can be created by joining some of the strings "AA", "AB", and "BB" together. The strings "AA", "AB", and "BB" appear a certain number of times, specified by the three input integers. However, the resulting string cannot contain the substring "AAA" or "BBB".
 */

func longestStringAvoidingPatterns(aCount: Int, bCount: Int, abCount: Int) -> String {
    var aaCount = aCount
    var bbCount = bCount
    var abCount = abCount
    var result = ""
    var lastAdded = ""

    while aaCount > 0 || bbCount > 0 || abCount > 0 {
        if lastAdded == "AA" {
            if bbCount > 0 {
                result += "BB"
                bbCount -= 1
                lastAdded = "BB"
            } else {
                break
            }
        } else if lastAdded == "BB" {
            if aaCount > 0 {
                result += "AA"
                aaCount -= 1
                lastAdded = "AA"
            } else if abCount > 0 {
                result += "AB"
                abCount -= 1
                lastAdded = "AB"
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
            } else if bbCount > 0 {
                result += "BB"
                bbCount -= 1
                lastAdded = "BB"
            }

            // If both are zero and only AB is left
            if aaCount == 0 && bbCount == 0 && abCount > 0 {
                result += "AB"
                abCount -= 1
                lastAdded = "AB"
            }
        }
    }

    return result
}

// Example usage
print(longestStringAvoidingPatterns(aCount: 1, bCount: 1, abCount: 2))
print(longestStringAvoidingPatterns(aCount: 5, bCount: 2, abCount: 0))
