/*
 Design a credit card parser with the following requirements:
 1) Determine if a credit card number is valid, given the number and an expiration date.
 2) Return the type of the credit card when the number is valid and return nil when it is not.
  
 The card type can be determined from the first 4 digits as follows:
 Acme: 1121
 Alfa: 1111
 Amex: 3796
  
 A card number is valid if the last 4 digits match the given expiration date and it starts with a valid card prefix.
  
 Valid input will have the following formats:
 Card number: "dddd-dddd-dddd-dddd" (where "d" is an integer)
 Date: "mm/yy"
  
 For example, "1111-1222-1112-1216" with an expiration date of "12/16" is valid input because the first 4 digits of the card number match the Alfa card type and the last 4 digits match the expiration date.
 */

/*
 Algorithm: Credit Card Parser

 Inputs

     card_number: string in the format "dddd-dddd-dddd-dddd" where "d" is a digit.
     expiration_date: string in the format "mm/yy".

 Outputs

     card_type: string if the card is valid and has a recognized type; otherwise nil.

 Steps

     Validate and Parse Inputs:
         Check if the card_number matches the format using regex: ^\d{4}-\d{4}-\d{4}-\d{4}$. If it does not match, return nil.
         Check if the expiration_date matches the format using regex: ^\d{2}/\d{2}$. If it does not match, return nil.

     Extract Data from Inputs:
         Split the card_number by '-' and extract:
             prefix (first 4 digits).
             suffix (last 4 digits).
         Split the expiration_date by '/' and concatenate:
             exp_month (first part).
             exp_year (second part).

     Check Card Type:
         If prefix == "1121", set card_type = "Acme".
         Else if prefix == "1111", set card_type = "Alfa".
         Else if prefix == "3796", set card_type = "Amex".
         Else, return nil.

     Validate Card Number with Expiration Date:
         Create expected_suffix by concatenating exp_month and the last two digits of exp_year.
         If suffix matches expected_suffix, the card is valid; return card_type.
         Else, return nil.
 */


import Foundation

func validateCreditCard(cardNumber: String, expirationDate: String) -> String? {
    // Step 1: Validate formats
    let cardNumberPattern = #"^\d{4}-\d{4}-\d{4}-\d{4}$"#
    let expirationDatePattern = #"^\d{2}/\d{2}$"#
    
    let cardNumberRegex = try! NSRegularExpression(pattern: cardNumberPattern)
    let expirationDateRegex = try! NSRegularExpression(pattern: expirationDatePattern)
    
    if cardNumberRegex.numberOfMatches(in: cardNumber, range: NSRange(location: 0, length: cardNumber.count)) == 0 {
        return nil
    }
    if expirationDateRegex.numberOfMatches(in: expirationDate, range: NSRange(location: 0, length: expirationDate.count)) == 0 {
        return nil
    }
    
    // Step 2: Extract data
    let parts = cardNumber.split(separator: "-")
    let prefix = parts[0]
    let suffix = parts[3]
    
    let expParts = expirationDate.split(separator: "/")
    let expMonth = expParts[0]
    let expYear = expParts[1]
    let expectedSuffix = expMonth + expYear.suffix(2)  // Construct expected last 4 digits
    
    // Step 3: Determine card type
    var cardType: String? = nil
    switch prefix {
    case "1121":
        cardType = "Acme"
    case "1111":
        cardType = "Alfa"
    case "3796":
        cardType = "Amex"
    default:
        return nil
    }
    
    // Step 4: Validate expiration match
    if suffix == expectedSuffix {
        return cardType
    } else {
        return nil
    }
}
/*
// Example Usage
var cardNum = "1111-1222-1112-1216"
if let cardType = validateCreditCard(cardNumber: cardNum, expirationDate: "12/16") {
    print("Card Type: \(cardType)")
} else {
    print("Invalid card or expiration date")
}

cardNum = "1111-122d-1112-1216" // wrong input
if let cardType = validateCreditCard(cardNumber: cardNum, expirationDate: "12/16") {
    print("Card Type: \(cardType)")
} else {
    print("Invalid card or expiration date")
}

cardNum = "1111-1223-1112-1217" // wrong input
if let cardType = validateCreditCard(cardNumber: cardNum, expirationDate: "12/16") {
    print("Card Type: \(cardType)")
} else {
    print("Invalid card or expiration date")
}

cardNum = "4444-1223-1112-1216" // wrong input
if let cardType = validateCreditCard(cardNumber: cardNum, expirationDate: "12/16") {
    print("Card Type: \(cardType)")
} else {
    print("Invalid card or expiration date")
}
*/

// Luhn Algorithm
import Foundation

func isValidCreditCard(number: String) -> Bool {
    // Clean the input string (remove spaces and hyphens)
    let cleanedNumber = number.replacingOccurrences(of: "\\s|-", with: "", options: .regularExpression)
    
    // Ensure the number contains only digits
    guard cleanedNumber.allSatisfy({ $0.isNumber }) else {
        return false
    }
    
    // Reverse the number to facilitate the process from the rightmost digit
    let reversedDigits = cleanedNumber.reversed().map { Int(String($0))! }
    print("reversedDigits: \(reversedDigits)")
    
    // Apply the Luhn algorithm
    var total = 0
    for (index, digit) in reversedDigits.enumerated() {
        print("-------")
        print("index: \(index), digit: \(digit)")
        if index % 2 == 1 {
            // Double every second digit
            let doubled = digit * 2
            // Subtract 9 if the doubled value is greater than 9
            total += doubled > 9 ? doubled - 9 : doubled
            print("doubled: \(doubled)")
        } else {
            // Add other digits directly
            total += digit
        }
        print("total: \(total)")
    }
    
    // Check if the total modulo 10 is zero
    return total % 10 == 0
}

// Example Usage
print(isValidCreditCard(number: "4556 7375 8763 2024")) // Valid card
print(isValidCreditCard(number: "4556 7375 8763 2023")) // Invalid card
