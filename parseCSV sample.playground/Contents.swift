import Foundation

let csvfile = """
Name,Age,Address,Phone Number,Email,Favorite Number,Employed
Burgess Greasley,33,04 Ridge Oak Street,649-893-5297,bgreasley1@4shared.com,337,true
Derwin Brunel,13,0843 Bunting Hill,790-611-6437,dbrunel2@discovery.com,961,true
Sheffie Spadotto,55,5298 Grover Court,265-791-1163,sspadotto3@salon.com,479,true
Courtney Fearnyhough,63,2102 Garrison Circle,502-971-1269,cfearnyhough4@wikipedia.org,876,true
"""

struct People {
    var name: String
    var age: Int
    var address: String
    var phoneNumber: String
    var email: String
    var favNumber: Int
    var employed: Bool
}

var people : [People] = []

func parseCSV(fileURL: URL) {
    do {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        
        var lines = content.components(separatedBy: .newlines)
        
        guard let headersLine = lines.first else {
            print("CSV file is empty.")
            return
        }
        
        let headers = headersLine.components(separatedBy: ",")
        print("Headers: \(headers)")

        lines.removeFirst() // Remove the headers line
        
        
        for line in lines {
            let values = line.components(separatedBy: ",")
            
            // Ensure the number of values matches the number of headers
            guard values.count == headers.count else {
                print("Skipping line: \(line) - Number of values does not match the number of headers.")
                print(values)
                continue
            }
            print("--------------------------")
            
            var dict : [String: String] = [:]
            
            for (header, value) in zip(headers, values) {
                print("\(header): \(value)")
               // let name = header == "name" ? value : " "
                dict[header.lowercased()] = value
            }
            
            let ppl = People(name: dict["name"] ?? "",
                             age: Int(dict["age"] ?? "") ?? 0,
                             address: dict["address"] ?? "",
                             phoneNumber: dict["phoneNumber"] ?? "",
                             email: dict["email"] ?? "",
                             favNumber:  Int(dict["favNumber"] ?? "") ?? 0,
                             employed: (dict["employed"] ?? "") == "true")
            print("------------")
        }
    } catch {
        print("Error reading CSV file: \(error.localizedDescription)")
    }
}

// Replace "your_file.csv" with the path to your CSV file
let filePath = Bundle.main.path(forResource: "sampleCSV", ofType: "csv")
//print(filePath)
let fileURL = URL(fileURLWithPath: filePath!)
parseCSV(fileURL: fileURL)

