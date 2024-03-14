/*
 * Web Server Log Analysis Task
 * //
 * // You have a string representing a web server log. The log contains access records to the server, each separated by a newline character.
 * // Each record includes the date and time of access, the user's IP address, the request method (GET or POST), the URL that was requested,
 * // and the server's response code. All elements in a record are separated by spaces. The records are not in any strict order
 * // and can pertain to different user sessions.
 * //
 * // Task:
 * //
 * // Write a Swift function that analyzes this log and groups the records by user IP addresses. For each IP address,
 * // output the number of accesses and a list of unique URLs that were requested.
 *
 * // Example log string:
 *
 * let log =
 *
 * """
 *     2024-02-28 12:00 192.168.1.1 GET /home 200
 *     2024-02-28 12:05 192.168.1.2 POST /api/data 500
 *     2024-02-28 12:10 192.168.1.1 GET /about 200
 *     2024-02-28 12:15 192.168.1.3 GET /home 404
 *     2024-02-28 12:15 192.168.1.356 GET /home 200
 *     2024-02-28 12:20 192.168.1.2 GET /contact 200
 *     2024-02-28 12:25 192.168.1.1 POST /api/login 403
 *     2024-02-28 12:45 192.168.1 GET /home 200
 *     2024-02-28 13:00 192.168.1.1 GET /about 200
 * """
 *
 * // Expected Output
 * ("192.168.1.2", "/contact", 1)
 * ("192.168.1.1”, "/about", 2)
 * ("192.168.1.1”, “/home”, 2)
 */


/*
 Algo:
 
 Parse the log string into individual log records.
 Create a dictionary to store IP addresse + url as keys and their associated data (number of accesses and unique URL , ipAddress) as values.
 Iterate through each log record:
 Extract the IP address, URL, and request method from each record.
 Update the dictionary for the corresponding IP address:
 If the IPaddress+url already exists in the dictionary, increment the access count
 If the IP address is new, create a new entry in the dictionary with the access count initialized to 1 and the URL  containing the current URL and ips as current IP.
 Output the results for each IP address in the dictionary.
 */

import Foundation
func analyzeWebServerLog(_ log: String) -> [(String, String, Int)] {
    var ipData = [String: (accessCount: Int, url: String, ip:String)]()
    
    // Parse log string into individual records
    let logRecords =  log.components(separatedBy: "\n")

    // Iterate through each log record
    for record in logRecords {
       // print("record: \(record)")
        let components = record.components(separatedBy: " ")
       // print("components: \(components)")
        guard components.count >= 5 else { continue }
        
        let ipAddress = components[2]
        let url = components[4]
        let key = ipAddress + url
        
        // Update dictionary for the corresponding IP address
        if var data = ipData[key] {
            data.accessCount += 1
           // data.url = url
           // data.ip = ipAddress
            ipData[key] = data
        } else {
            ipData[key] = (accessCount: 1, url: url, ip: ipAddress)
        }
    }
    
    // Output the results for each IP address
    var results = [(String, String, Int)]()
    for (_ , data) in ipData {
        results.append((data.ip, data.url, data.accessCount))
    }
    
    return results
}

// Test
let log = """
    2024-02-28 12:00 192.168.1.1 GET /home 200
    2024-02-28 12:05 192.168.1.2 POST /api/data 500
    2024-02-28 12:10 192.168.1.1 GET /about 200
    2024-02-28 12:15 192.168.1.3 GET /home 404
    2024-02-28 12:15 192.168.1.356 GET /home 200
    2024-02-28 12:20 192.168.1.2 GET /contact 200
    2024-02-28 12:25 192.168.1.1 POST /api/login 403
    2024-02-28 12:45 192.168.1 GET /home 200
    2024-02-28 13:00 192.168.1.1 GET /about 200
    2024-02-29 13:00 192.168.1.1 GET /about 200
    """
let result = analyzeWebServerLog(log)
for (ip, url, count) in result {
    print("(\(ip), \(url), \(count))")
}
/*
func analyzeLog(log: String) {
  var userLogs: [String: (count: Int, uniqueUrls: Set<String>)] = [:]
  
  for line in log.split(separator: "\n") {
      print("*********************")
      print("Line: \(line)")
    let elements = line.split(separator: " ")
    let ipAddress = String(elements[2])
      print("ip: \(ipAddress)")
    
    var accessCount = 1
    var uniqueUrls = Set<String>()
    
    if userLogs[ipAddress] == nil {
      userLogs[ipAddress] = (accessCount, uniqueUrls)
    } else {
      (accessCount, uniqueUrls) = userLogs[ipAddress]!
    }
    
    accessCount += 1
    uniqueUrls.insert(String(elements[4])) // Extract URL from 4th element (index 3)
    print("accessCount: \(accessCount), uniqueurl: \(uniqueUrls)")
    userLogs[ipAddress] = (accessCount, uniqueUrls)
  }
  
  for (ipAddress, (count, urls)) in userLogs {
    print(ipAddress, urls.first!, count)
  }
}

// Example usage
let log = """
2024-02-28 12:00 192.168.1.1 GET /home 200
2024-02-28 12:05 192.168.1.2 POST /api/data 500
2024-02-28 12:10 192.168.1.1 GET /about 200
2024-02-28 12:15 192.168.1.3 GET /home 404
2024-02-28 12:15 192.168.1.356 GET /home 200
2024-02-28 12:20 192.168.1.2 GET /contact 200
2024-02-28 12:25 192.168.1.1 POST /api/login 403
2024-02-28 12:45 192.168.1 GET /home 200
2024-02-28 13:00 192.168.1.1 GET /about 200
"""

analyzeLog(log: log)
*/
