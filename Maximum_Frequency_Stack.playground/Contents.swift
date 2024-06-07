/*
 https://leetcode.com/problems/maximum-frequency-stack/description/
 Design a stack-like data structure to push elements to the stack and pop the most frequent element from the stack.

 Implement the FreqStack class:

 FreqStack() constructs an empty frequency stack.
 void push(int val) pushes an integer val onto the top of the stack.
 int pop() removes and returns the most frequent element in the stack.
 If there is a tie for the most frequent element, the element closest to the stack's top is removed and returned.
  

 Example 1:

 Input
 ["FreqStack", "push", "push", "push", "push", "push", "push", "pop", "pop", "pop", "pop"]
 [[], [5], [7], [5], [7], [4], [5], [], [], [], []]
 Output
 [null, null, null, null, null, null, null, 5, 7, 5, 4]

 Explanation
 FreqStack freqStack = new FreqStack();
 freqStack.push(5); // The stack is [5]
 freqStack.push(7); // The stack is [5,7]
 freqStack.push(5); // The stack is [5,7,5]
 freqStack.push(7); // The stack is [5,7,5,7]
 freqStack.push(4); // The stack is [5,7,5,7,4]
 freqStack.push(5); // The stack is [5,7,5,7,4,5]
 freqStack.pop();   // return 5, as 5 is the most frequent. The stack becomes [5,7,5,7,4].
 freqStack.pop();   // return 7, as 5 and 7 is the most frequent, but 7 is closest to the top. The stack becomes [5,7,5,4].
 freqStack.pop();   // return 5, as 5 is the most frequent. The stack becomes [5,7,4].
 freqStack.pop();   // return 4, as 4, 5 and 7 is the most frequent, but 4 is closest to the top. The stack becomes [5,7].
  

 Constraints:

 0 <= val <= 10^9
 At most 2 * 10^4 calls will be made to push and pop.
 It is guaranteed that there will be at least one element in the stack before calling pop
 */

class FreqStack {
    private var freq: [Int: Int]  // Dictionary to store the frequency of elements
    private var group: [Int: [Int]]  // Dictionary to store stacks of elements grouped by frequency
    private var maxFreq: Int  // Variable to keep track of the current maximum frequency
    
    init() {
        self.freq = [Int: Int]()
        self.group = [Int: [Int]]()
        self.maxFreq = 0
    }
    
    func push(_ val: Int) {
        // Update the frequency of the element
        if let currentFreq = freq[val] {
            freq[val] = currentFreq + 1
        } else {
            freq[val] = 1
        }
        
        let f = freq[val]!
        
        // Update the max frequency if necessary
        if f > maxFreq {
            maxFreq = f
        }
        
        // Push the element onto the corresponding frequency stack
        if group[f] != nil {
            group[f]!.append(val)
        } else {
            group[f] = [val]
        }
    }
    
    func pop() -> Int {
        // Pop the element from the stack corresponding to the current max frequency
        var stack = group[maxFreq]!
        let val = stack.removeLast()
        group[maxFreq] = stack
        
        // Update the frequency of the popped element
        freq[val] = freq[val]! - 1
        
        // If the current max frequency stack is empty, decrease the max frequency
        if group[maxFreq]!.isEmpty {
            group.removeValue(forKey: maxFreq)
            maxFreq -= 1
        }
        
        return val
    }
}

// Example usage
let freqStack = FreqStack()
freqStack.push(5)
freqStack.push(7)
freqStack.push(5)
freqStack.push(7)
freqStack.push(4)
freqStack.push(5)
print(freqStack.pop()) // Outputs 5
print(freqStack.pop()) // Outputs 7
print(freqStack.pop()) // Outputs 5
print(freqStack.pop()) // Outputs 4

/*
 Explanation
 Initialization:

 freq keeps track of the frequency of each element.
 group groups elements by their frequencies, where each frequency maps to a stack of elements.
 maxFreq keeps track of the highest frequency of any element in the stack.
 Push Operation:

 Update the frequency of the element being pushed.
 Update maxFreq if the element's new frequency is greater than the current maxFreq.
 Append the element to the stack corresponding to its new frequency.
 Pop Operation:

 Remove and return the element from the stack corresponding to maxFreq.
 Decrease the element's frequency.
 If the stack for maxFreq becomes empty, decrement maxFreq.
 */
