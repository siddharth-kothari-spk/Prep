import Foundation

//Scenario 1: Dividing by Zero

func divide(numerator: Int, denominator: Int) -> Int {
    guard denominator > 0 else {
        print("Cant divide by zero")
        return -1
    }
  return numerator / denominator
}

let result = divide(numerator: 10, denominator: 0) // fatal error: division by zero
print(result)


// Scenario 2: Force Unwrapping an Optional Without Checking

var name: String? = "A"

if name != nil {
    print("Hello, \(String(describing: name ?? "default"))!")
  /*  if !name?.isEmpty { // Optional type 'Bool?' cannot be used as a boolean; test for '== nil' instead
        print("Hello, \(String(describing: name))!")
    }
  if let unwrappedName = name ?? "empty" // error: initializer for conditional binding must have Optional type, not 'String'
    {
      print("Hello, \(unwrappedName))!")
  }*/
    
} else {
  print("No name provided.")
}

//Scenario 3: Missing Return Statement in a Function

func greet(name: String) {
  print("Hello, \(name)!")
  // Missing return statement
}

let greeting = greet(name: "Charlie") // warn: Constant 'greeting' inferred to have type '()', which may be unexpected
print(greeting) // What will this print? // output: ()

//Scenario 4: Infinite Loop Due to Incorrect Condition
var counter: Int = 0

while counter < 5 {
  print(counter)
  counter -= 1 // Decrementing instead of incrementing // error after reaching Int.min for Int8
}
