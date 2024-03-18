/*
 https://www.geeksforgeeks.org/find-the-element-that-appears-once/
 https://www.careercup.com/question?id=7902674
 
 Input: arr[] = {12, 1, 12, 3, 12, 1, 1, 2, 3, 3}
 Output: 2
 In the given array all element appear three times except 2 which appears once.

 Input: arr[] = {10, 20, 10, 30, 10, 30, 30}
 Output: 20
 In the given array all element appear three times except 20 which appears once.
 
 C lang solution:
 int main()
 {
        int B[] = {1,1,1,3,3,3,20,4,4,4};
        int    ones = 0 ;
        int    twos = 0 ;
        int not_threes;
        int x ;

    for( i=0; i< 10; i++ )
    {
        x =  B[i];
         twos |= ones & x ;
         ones ^= x ;
         not_threes = ~(ones & twos) ;
         ones &= not_threes ;
         twos &= not_threes ;
     }

     printf("\n unique element = %d \n", ones );
  
     return 0;

 }
 
 Explanation:

 Initialization:

     An array B is declared to store the input elements.
     Variables ones, twos, and not_threes are used to track bitwise manipulations.
     A variable x is used to hold the current element from the array.
 
 Bitwise Operations:

     The code iterates through the array using a for loop.
     Inside the loop:
         x = B[i]: Assigns the current element to x.
 
         twos |= ones & x: This performs a bitwise OR operation between twos and the bitwise AND of ones and x. It essentially identifies elements that appear twice based on their previous occurrences.
 
         ones ^= x: This performs a bitwise XOR operation between ones and x. It keeps track of elements that appear once or thrice.
 
         not_threes = ~(ones & twos): This calculates the bitwise NOT of the AND operation between ones and twos. It creates a mask to isolate elements that haven't appeared twice yet (potential candidates for the single element).
 
         ones &= not_threes: This performs a bitwise AND operation between ones and not_threes. It keeps only the element that appears once in ones.
 
         twos &= not_threes: This performs a bitwise AND operation between twos and not_threes. It ensures twos only reflects elements that have appeared twice and are not yet cleared.
 
 Extracting the Single Element:

     After the loop, ones will contain the element that appears once in the array.
     The code prints this value using printf.
 */

func singleNumber(nums: [Int]) -> Int? {
    var ones = 0
    var twos = 0
    for num in nums {
        twos |= ones & num  // Identify elements appearing twice
        ones ^= num          // Track elements appearing once or thrice
        let notThrees = ~(ones & twos)  // Isolate potential single element
        ones &= notThrees    // Refine ones to hold the single element
        twos &= notThrees    // Ensure twos reflects valid twice-appearing elements
    }
    return ones  // The element that appears once
}

// Example usage
let nums = [1, 1, 1, 3, 3, 3, 20, 4, 4, 4]
if let result = singleNumber(nums: nums) {
    print("The element with single occurrence is: \(result)")
} else {
    print("No element appears once in the array.")
}
