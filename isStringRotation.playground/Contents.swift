/*
 String Rotation:

     Given two strings, write a function to check if one string is a rotation of the other.
     Example: "waterbottle" and "erbottlewat" are rotations of each other.
 */

func isStringRotation(_ s1: String, _ s2: String) -> Bool {
    return (s1 + s1).contains(s2) && s1.count == s2.count
}

// Example usage:
let areRotations = isStringRotation("waterbottle", "erbottlewat")
print(areRotations)

// logic is if one string is repeated twice then any rotation of it should be available inside it.
// "waterbottlewaterbottle" contains "erbottlewat"
