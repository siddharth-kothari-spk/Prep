/*
 Group Anagrams:

     Given an array of strings, group anagrams together.
     Example: ["eat", "tea", "tan", "ate", "nat", "bat"] should return [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]].
 */

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var anagramGroups: [String: [String]] = [:]

    for str in strs {
        let sortedStr = String(str.sorted())
        anagramGroups[sortedStr, default: []].append(str)
    }

    return Array(anagramGroups.values)
}

// Example usage:
let anagramGroups = groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
print(anagramGroups)
