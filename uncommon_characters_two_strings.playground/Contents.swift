/*
 https://www.geeksforgeeks.org/find-uncommon-characters-two-strings/
 */

import Foundation
func uncommonCharactersBetween(_ str1: String, _ str2: String) -> String {
    
    var dict: [Character : Int] = [Character : Int]()
    
    for ch in str1 {
        dict[ch] = 1
    }
    
    for ch in str2 {
        if let _ = dict[ch] {
            dict[ch] = -1
        }
        else {
            dict[ch] = 2
        }
    }
    
    let result = dict.filter { dictElement in
        dictElement.value == 1 ||  dictElement.value == 2
    }.keys.sorted()
    
    print(String(result))
    return String(result)
}

uncommonCharactersBetween("characters", "alphabets")
