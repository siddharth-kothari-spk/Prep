/*
 Group a list of words into anagrams.
 - Sample Input:
 ```
 Words: ["eat", "tea", "tan", "ate", "nat", "bat"]
 ```
 - Expected Output:
 ```
 Anagram Groups:
 ["eat", "tea", "ate"]
 ["tan", "nat"]
 ["bat"]
 */

func groupAnagrams(_ strs: [String]) -> [[String]] {
  var anagramGroups: [String: [String]] = [:]
  for str in strs {
    let sortedString = String(str.sorted()) // Sort characters of the word
    if anagramGroups[sortedString] != nil {
      anagramGroups[sortedString]?.append(str)
    } else {
      anagramGroups[sortedString] = [str]
    }
  }
  return Array(anagramGroups.values) // Convert dictionary values to an array of arrays
}


print(groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
