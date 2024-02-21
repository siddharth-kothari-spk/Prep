/*
 You are playing the Bulls and Cows game with your friend.

 You write down a secret number and ask your friend to guess what the number is. When your friend makes a guess, you provide a hint with the following info:

 The number of "bulls", which are digits in the guess that are in the correct position.
 The number of "cows", which are digits in the guess that are in your secret number but are located in the wrong position. Specifically, the non-bull digits in the guess that could be rearranged such that they become bulls.
 Given the secret number secret and your friend's guess guess, return the hint for your friend's guess.

 The hint should be formatted as "xAyB", where x is the number of bulls and y is the number of cows. Note that both secret and guess may contain duplicate digits.

  

 Example 1:

 Input: secret = "1807", guess = "7810"
 Output: "1A3B"
 Explanation: Bulls are connected with a '|' and cows are underlined:
 "1807"
   |
 "7810"
 Example 2:

 Input: secret = "1123", guess = "0111"
 Output: "1A1B"
 Explanation: Bulls are connected with a '|' and cows are underlined:
 "1123"        "1123"
   |      or     |
 "0111"        "0111"
 Note that only one of the two unmatched 1s is counted as a cow since the non-bull digits can only be rearranged to allow one 1 to be a bull.
 */

/*
 Solution:
 
 Here's an algorithm to solve the Bulls and Cows problem:

 Initialize two dictionaries, secretFreq and guessFreq, to store the frequencies of digits in the secret and guess strings, respectively.
 Initialize two variables, bulls and cows, to count the number of bulls and cows, respectively.
 Iterate through each character in the secret and guess strings simultaneously:
 If the characters at the same position are equal, increment the bulls count.
 Otherwise, update the frequencies of the characters in the secretFreq and guessFreq dictionaries.
 Iterate through the keys in the guessFreq dictionary:
 If the key exists in the secretFreq dictionary, add the minimum value of the frequencies of the corresponding key in both dictionaries to the cows count.
 Construct and return the hint string in the format "xAyB", where x is the number of bulls and y is the number of cows.
 */

func getHint(_ secret: String, _ guess: String) -> String {
    
    var freqSecret: [Character: Int] = [:]
    var freqGuess: [Character: Int] = [:]
    var bulls: Int = 0
    var cows: Int = 0
    
    for (charS, charG) in zip(secret, guess) {
        if charS == charG {
            bulls += 1
        }
        else {
            freqSecret[charS, default: 0] += 1
            freqGuess[charG, default: 0] += 1
        }
    }
    print("bulls: \(bulls)")
    print("freqSecret: \(freqSecret)")
    print("freqGuess: \(freqGuess)")
        
    for (char, freq) in freqGuess {
        if let count = freqSecret[char] {
            cows += min(freq, count)
        }
    }
    
    return "\(bulls)A\(cows)B"
}

print(getHint("1123", "1110"))
