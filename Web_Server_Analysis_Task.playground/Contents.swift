import Foundation

let log =  """
2024-02-28 12:00 192.168.1.1 GET /home 200
2024-02-28 12:05 192.168.1.2 POST /api/data 500
2024-02-28 12:10 192.168.1.1 GET /about 200
2024-02-28 12:15 192.168.1.3 GET /home 404
2024-02-28 12:15 192.168.1.356 GET /home 200
2024-02-28 12:20 192.168.1.2 GET /contact 200
2024-02-28 12:25 192.168.1.1 POST /api/login 403
2024-02-28 12:45 192.168.1.1 GET /home 200
2024-02-28 13:00 192.168.1.1 GET /about 200
"""
//print(log.components(separated(by: )))
let lines = log.components(separatedBy: "\n")
//log.split(whereSeparator: \.isNewline) as! [String]
//print(lines)
var logEntries = [[String]]()
for line in lines {
    logEntries.append(line.components(separatedBy: " "))
}
//print(logEntries)
let segg = logEntries.map { entry in
    let filtered = logEntries.filter { arr in
        return (arr[2] == entry[2]) && (arr[4] == entry[4])
    }
    return filtered
}
let setSegg = Set(segg)
//print(setSegg)
let arrSegg = Array(setSegg)
let output = arrSegg.map { ot in
    return (ot[0][2], ot[0][4], ot.count)
}
print(output)
