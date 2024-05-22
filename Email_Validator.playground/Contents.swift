/*
 Email Validator
 Design an email validator that checks if a given email address is valid and extracts the domain name. The email address should be in the format "localpart@domain.com".
 * The local part can contain alphanumeric characters, dots, hyphens, and underscores.
 * The domain part should be a valid domain name (e.g., gmail.com, yahoo.com).
 The email address is valid if it follows the specified format. Return the domain name if the email address is valid, otherwise return None.
 */


import Foundation

func isValidLocalPart(_ localPart: String) -> Bool {
    for character in localPart {
        if !(character.isLetter || character.isNumber || character == "." || character == "-" || character == "_") {
            return false
        }
    }
    return true
}

func validateEmail(_ email: String) -> String? {
    // Split the email into parts using "@" as the delimiter
    let parts = email.split(separator: "@")
    
    // Check if there are exactly two parts (local part and domain part)
    guard parts.count == 2 else {
        return nil
    }
    
    let localPart = parts[0]
    let domainPart = parts[1]
    
    // Check if both local part and domain part are non-empty
    guard !localPart.isEmpty && !domainPart.isEmpty else {
        return nil
    }
    
    // Check if the local part contains only valid characters
    guard isValidLocalPart(String(localPart)) else {
        return nil
    }
    
    // Check if the domain part contains at least one dot and is valid
    let domainParts = domainPart.split(separator: ".")
    guard domainParts.count >= 2 else {
        return nil
    }
    
    // Check if each domain part is non-empty and the top-level domain is at least 2 characters long
    for part in domainParts {
        if part.isEmpty || (part == domainParts.last && part.count < 2) {
            return nil
        }
    }
    
    // If all checks pass, return the domain part
    return String(domainPart)
}

// Example usage
var email = "user.name-example_123@example.com"
if let domain = validateEmail(email) {
    print("\(email) is a valid email address. Domain: \(domain)")
} else {
    print("\(email) is not a valid email address.")
}


email = "user. name-example_123@example.com"
if let domain = validateEmail(email) {
    print("\(email) is a valid email address. Domain: \(domain)")
} else {
    print("\(email) is not a valid email address.")
}

email = "user.name-example_123@exa.mple.com"
if let domain = validateEmail(email) {
    print("\(email) is a valid email address. Domain: \(domain)")
} else {
    print("\(email) is not a valid email address.")
}

email = "user. name-example_123@example1.com"
if let domain = validateEmail(email) {
    print("\(email) is a valid email address. Domain: \(domain)")
} else {
    print("\(email) is not a valid email address.")
}
