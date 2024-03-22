import Foundation


import Foundation

struct JSONParser {

    static func parse(jsonString: String) -> Any? {
        var characters = jsonString  // Use String.characters for older Swift versions
        return parseValue(&characters)
    }

    static func parseValue(_ characters: inout String) -> Any? {
        characters = characters.trimmingCharacters(in: .whitespacesAndNewlines) // Trim whitespace

        guard let next = characters.first else {
            return nil // End of string
        }

        switch next {
        case "{":
            return parseDictionary(&characters)
        case "[":
            return parseArray(&characters)
        case "\"" :
            return parseStringValue(&characters)
        default:
            // Handle alphanumeric strings
            guard next.isLetter || next.isNumber else {
                return nil // Invalid character
            }
            var value = String(next)
            while let char = characters.first, char.isLetter || char.isNumber {
                value.append(char)
            }
            return value
        }
    }

    static func parseDictionary(_ characters: inout String) -> [String: Any]? {
        guard characters.removeFirst() == "{" else { return nil }
        var dictionary = [String: Any]()
        while let key = parseStringValue(&characters) {
            characters = characters.trimmingCharacters(in: .whitespacesAndNewlines) // Trim whitespace
            guard characters.removeFirst() == ":" else { return nil }
            characters = characters.trimmingCharacters(in: .whitespacesAndNewlines) // Trim whitespace
            guard let value = parseValue(&characters) else { return nil }
            dictionary[key] = value
            characters = characters.trimmingCharacters(in: .whitespacesAndNewlines) // Trim whitespace
            // Optional comma handling
            guard characters.isEmpty || characters.removeFirst() == "," else { return nil }
        }
        guard characters.removeFirst() == "}" else { return nil }
        return dictionary
    }

    static func parseArray(_ characters: inout String) -> [Any]? {
        guard characters.removeFirst() == "[" else { return nil }
        var array = [Any]()
        while let value = parseValue(&characters) {
            array.append(value)
            characters = characters.trimmingCharacters(in: .whitespacesAndNewlines) // Trim whitespace
            guard characters.isEmpty || characters.removeFirst() == "," else { return nil }
        }
        guard characters.removeFirst() == "]" else { return nil }
        return array
    }

    static func parseStringValue(_ characters: inout String) -> String? {
        guard characters.removeFirst() == "\"" else { return nil }
        var string = ""
        while let next = characters.first, next != "\"" {
            // Assume simple string parsing without escapes
            string.append(next)
        }
        return string
    }
}



let jsonString = "{\"name\": \"Alice\", \"age\": 30, \"friends\": [\"Bob\", \"Charlie\"]}"
if let parsedObject = JSONParser.parse(jsonString: jsonString) as? [String: Any] {
    print("Name:", parsedObject["name"] as! String)
    print("Age:", parsedObject["age"] as! Int)
}
