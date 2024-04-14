/*
 Parse a CSV file with headers and extract specific information based on column names.
 - Sample Input:
 ```
 File: employees.csv
 ID,Name,Department,Salary
 1,John,Digital Marketing,60000
 2,Alice,Development,80000
 ```
 - Expected Output:
 ```
 Employee Information:
 ID: 1, Name: John, Department: Digital Marketing, Salary: 60000
 ID: 2, Name: Alice, Department: Development, Salary: 80000
 */

import Foundation

func parseEmployeeInformation(from file: String, forColumns: [String]) throws -> [String] {
  guard let url = Bundle.main.url(forResource: file, withExtension: "csv") else {
    throw NSError(domain: "CSV file not found", code: 1, userInfo: nil)
  }
  guard let data = try? String(contentsOf: url) else {
    throw NSError(domain: "Error reading CSV file", code: 2, userInfo: nil)
  }
  
  var employeeInfo: [String] = []
  let lines = data.components(separatedBy: .newlines)
   // print(lines)
  guard !lines.isEmpty else { return employeeInfo } // Handle empty file
  
  // Extract column indexes for desired information
  var columnIndexes: [Int] = []
  let headers = lines[0].components(separatedBy: ",")
  for (index, header) in headers.enumerated() {
    if forColumns.contains(header) {
      columnIndexes.append(index)
    }
  }
  guard !columnIndexes.isEmpty else { throw NSError(domain: "Columns not found", code: 3, userInfo: nil) }
   print(columnIndexes)
    
  // Parse employee information from remaining lines
  for line in lines[1...] {
     // print("line: \(line)")
      guard !line.isEmpty else { continue }
    var infoString = ""
    let rowData = line.components(separatedBy: ",")
      if rowData.count < columnIndexes.count {
          print("insufficient data: \(rowData)")
          continue
      }
    for (_, index) in columnIndexes.enumerated() {
      infoString += "\(headers[index]): \(rowData[index]), "
    }
    infoString = String(infoString.dropLast(2)) // Remove trailing comma and space
    employeeInfo.append(infoString)
  }
  
  return employeeInfo
}

do {
  let employeeData = try parseEmployeeInformation(from: "employees", forColumns: ["ID", "Name", "Department", "Salary"])
    print("Employee Information:")
  for info in employeeData {
    print(info)
  }
} catch {
  print("Error parsing CSV file: \(error.localizedDescription)")
}

