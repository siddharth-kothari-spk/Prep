/*
 https://leetcode.com/problems/prefix-and-suffix-search/description/
 Design a special dictionary that searches the words in it by a prefix and a suffix.

 Implement the WordFilter class:

 WordFilter(string[] words) Initializes the object with the words in the dictionary.
 f(string pref, string suff) Returns the index of the word in the dictionary, which has the prefix pref and the suffix suff. If there is more than one valid index, return the largest of them. If there is no such word in the dictionary, return -1.
  

 Example 1:

 Input
 ["WordFilter", "f"]
 [[["apple"]], ["a", "e"]]
 Output
 [null, 0]
 Explanation
 WordFilter wordFilter = new WordFilter(["apple"]);
 wordFilter.f("a", "e"); // return 0, because the word at index 0 has prefix = "a" and suffix = "e".
  

 Constraints:

 1 <= words.length <= 104
 1 <= words[i].length <= 7
 1 <= pref.length, suff.length <= 7
 words[i], pref and suff consist of lowercase English letters only.
 At most 104 calls will be made to the function f.
 */

/*
 To implement the WordFilter class that can search for words by a prefix and a suffix efficiently, we need to design a data structure that supports quick lookups for both prefix and suffix. Given the constraints, a straightforward approach of iterating through the list for each query would be too slow. Instead, we can use a combination of prefix and suffix tries (or hash maps) to facilitate fast lookups.

 Here’s the plan:

 Initialization:

 We need to initialize the WordFilter object with the given words.
 To facilitate quick lookups, we will create a composite key combining both the prefix and the suffix for each word.
 We'll use a dictionary to store these composite keys and map them to the word indices.
 Query:

 For each query, we generate the composite key from the given prefix and suffix.
 We look up this key in our preprocessed dictionary to get the index.

 */

class WordFilter {
    private var prefixSuffixMap: [String: Int]
    
    init(_ words: [String]) {
        self.prefixSuffixMap = [String: Int]()
        
        for (index, word) in words.enumerated() {
            let length = word.count
            for i in 0...length {
                let prefix = String(word.prefix(i))
                for j in 0...length {
                    let suffix = String(word.suffix(j))
                    let key = prefix + "#" + suffix
                    prefixSuffixMap[key] = index
                }
            }
        }
    }
    
    func f(_ pref: String, _ suff: String) -> Int {
        let key = pref + "#" + suff
        return prefixSuffixMap[key, default: -1]
    }
}

var wordFilter = WordFilter(["apple"])
print(wordFilter.f("a", "e"))  // Output: 0

wordFilter = WordFilter(["aabcdee"])
print(wordFilter.f("b", "e"))

