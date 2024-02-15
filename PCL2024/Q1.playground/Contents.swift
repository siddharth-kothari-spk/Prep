/*func allocateSeats(_ N: Int, _ S: String) -> [(Int, [String])] {
    var reservedSeats = Set<String>(S.split(separator: " ").map { String($0) })
    var familiesSeated: [(Int, [String])] = []

    func isFamilySeatAvailable(row: Int, startSeat: Int) -> Bool {
        let prohibitedCombinations = ["ABCD", "CDEF", "EFGH", "GHJK"]
        for i in 0..<4 {
            let seat = Character(UnicodeScalar(65 + startSeat + i)!)
            let seatString = "\(row)\(seat)"
            if reservedSeats.contains(seatString) || prohibitedCombinations.contains(String(seatString.dropLast())) {
                return false
            }
        }
        return true
    }

    func allocateFamily(row: Int) -> [String]? {
        for i in 0...(10 - 4) {
            if isFamilySeatAvailable(row: row, startSeat: i) {
                return (0..<4).map { String(UnicodeScalar(65 + i + $0)!) }
            }
        }
        return nil
    }

    for row in 1...N {
        if let allocatedSeats = allocateFamily(row: row) {
            familiesSeated.append((row, allocatedSeats))
            for seat in allocatedSeats {
                reservedSeats.insert("\(row)\(seat)")
            }
        }
    }

    return familiesSeated
}

// Example usage:
let N = 22
let S = "1A 3C 2B 20G 5A"
let result = allocateSeats(N, S)
print(result.count)
print("Families seated:")
for (row, seats) in result {
    print("Row \(row): \(seats.joined(separator: " "))")
}
*/

/*
func allocateSeats(_ N: Int, _ S: String) -> [(Int, [String])] {
    var reservedSeats = Set<String>(S.split(separator: " ").map { String($0) })
    var familiesSeated: [(Int, [String])] = []

    func isFamilySeatAvailable(row: Int, startSeat: Int) -> Bool {
        let prohibitedCombinations = ["ABCD", "CDEF", "EFGH", "GHJK"]
        for i in 0..<4 {
            let seat = Character(UnicodeScalar(65 + startSeat + i)!)
            let seatString = "\(row)\(seat)"
            if reservedSeats.contains(seatString) || prohibitedCombinations.contains(String(seatString.dropLast())) {
                return false
            }
        }
        return true
    }

    func allocateFamily(row: Int) -> [[String]] {
        var allocatedFamilies: [[String]] = []
        for i in 0...(10 - 4) {
            if isFamilySeatAvailable(row: row, startSeat: i) {
                let seats = (0..<4).map { String(UnicodeScalar(65 + i + $0)!) }
                allocatedFamilies.append(seats)
                for seat in seats {
                    reservedSeats.insert("\(row)\(seat)")
                }
            }
        }
        return allocatedFamilies
    }

    for row in 1...N {
        let allocatedFamilies = allocateFamily(row: row)
        print("allocatedFamilies: \(allocatedFamilies)")
        for seats in allocatedFamilies {
            familiesSeated.append((row, seats))
        }
    }

    return familiesSeated
}

// Example usage:
let N = 1//22//20
let S = ""//"1A 3C 2B 20G 5A"
let result = allocateSeats(N, S)
print(result.count)
print("Families seated:")
for (row, seats) in result {
    print("Row \(row): \(seats.joined(separator: " "))")
}
*/

/*
func allocateSeats(_ N: Int, _ S: String) -> [(Int, [String])] {
    var reservedSeats = Set<String>(S.split(separator: " ").map { String($0) })
    var familiesSeated: [(Int, [String])] = []

    func isFamilySeatAvailable(row: Int, startSeat: Int) -> Bool {
        
        for i in 0..<4 {
            var seat = Character(UnicodeScalar(65 + startSeat + i)!)
            if seat == "I" {seat = "K"}
            let seatString = "\(row)\(seat)"
            if reservedSeats.contains(seatString) {
                return false
            }
        }
        return true
    }

    func allocateFamily(row: Int) -> [[String]] {
        let prohibitedCombinations = ["ABCD", "CDEF", "EFGH", "GHJK"]
        // prohibitedCombinations.contains(seatString)
        var allocatedFamilies: [[String]] = []
        for i in 0...(10 - 4) {
            if isFamilySeatAvailable(row: row, startSeat: i) {
                var seats = (0..<4).map { String(UnicodeScalar(65 + i + $0)!) }
                if seats.contains("I") {
                    seats.insert("K", at: seats.firstIndex(of: "I")!)
                    seats.removeLast()
                }
                print("seats: \(seats)")
                let seatString = seats.joined(separator: "")
                print(seatString)
                if !prohibitedCombinations.contains(seatString) {
                    allocatedFamilies.append(seats)
                    for seat in seats {
                        reservedSeats.insert("\(row)\(seat)")
                    }
                }
//                allocatedFamilies.append(seats)
//                for seat in seats {
//                    reservedSeats.insert("\(row)\(seat)")
//                }
            }
        }
        return allocatedFamilies
    }

    for row in 1...N {
        let allocatedFamilies = allocateFamily(row: row)
        for seats in allocatedFamilies {
            familiesSeated.append((row, seats))
        }
    }

    return familiesSeated
}

// Example usage:
let N = 1//20
let S = ""//"1A 3C 2B 20G 5A"
let result = allocateSeats(N, S)
print("Families seated:")
for (row, seats) in result {
    print("Row \(row): \(seats.joined(separator: " "))")
}
*/

/*
public func solution(_ N : Int, _ S : inout String) -> Int {
    var reservedSeats = Set<String>(S.split(separator: " ").map { String($0) })
    var seatsSetupAvailable: Int = 0

    func isFamilySeatAvailable(row: Int, startSeat: Int) -> Bool {
        
        for i in 0..<4 {
            var seat = Character(UnicodeScalar(65 + startSeat + i)!)
            if seat == "I" {seat = "K"}
            let seatString = "\(row)\(seat)"
            if reservedSeats.contains(seatString) {
                return false
            }
        }
        return true
    }

    func allocateFamily(row: Int) -> Int {
        let prohibitedCombinations = ["ABCD", "CDEF", "EFGH", "GHJK"]
        var combinations: Int = 0
        for i in 0...6 {
            if isFamilySeatAvailable(row: row, startSeat: i) {
                var seats = (0..<4).map { String(UnicodeScalar(65 + i + $0)!) }
                if seats.contains("I") {
                    seats.append("K")
                    seats.removeAll { str in
                        str == "I"
                    }
                }
                let seatString = seats.joined(separator: "")
                if !prohibitedCombinations.contains(seatString) {
                    combinations += 1
                    for seat in seats {
                        reservedSeats.insert("\(row)\(seat)")
                        print("\(row)\(seat)")
                    }
                    print("-----")
                }
            }
        }
        return combinations
    }

    for row in 1...N {
        seatsSetupAvailable += allocateFamily(row: row)
    }

    return seatsSetupAvailable
}

// Example usage:
let N = 2//22//20
var S = "1A 2F 1C"//"1A 3C 2B 20G 5A"
let result = solution(N, &S)
print(result)
//for (row, seats) in result {
//    print("Row \(row): \(seats.joined(separator: " "))")
//}

*/


// Q1:
import Foundation

// you can write to stdout for debugging purposes, e.g.
// print("this is a debug message")

public func solution(_ A : inout [Int], _ B : inout [Int]) -> Int {
    // Implement your solution here
    print("A = \(A)")
    print("B = \(B)")
    var output: Int = 0
    var startA: Int = 1

    while startA < A.count {
        if  checkForZeroSum(A, startA).0 && checkForZeroSum(B, startA).0 && checkForZeroSum(A, startA).1 == checkForZeroSum(B, startA).1 {
               output += 1
           }
       startA += 1
    }
    print(output)
    return output
}

func checkForZeroSum(_ array: [Int], _ index: Int) -> (Bool, Int) {
    var sumA = 0
    var sumB = 0
    for index1 in 0..<index {
        sumA += array[index1]
    }

    for index2 in index..<array.count {
        sumB += array[index2]
    }

    return (sumA == sumB, sumA)
}

// Q2:
import Foundation

// you can write to stdout for debugging purposes, e.g.
// print("this is a debug message")

public func solution(_ N : Int, _ S : inout String) -> Int {
    // Implement your solution here
    var reservedSeats = Set<String>(S.split(separator: " ").map { String($0) })
    var seatsSetupAvailable: Int = 0

    for row in 1...N {
        seatsSetupAvailable += allocateFamily(row: row)
    }

    func allocateFamily(row: Int) -> Int {
        let prohibitedCombinations = ["ABCD", "CDEF", "EFGH", "GHJK"]
        var combinations: Int = 0
        for i in 0...6 {
            if isFamilySeatAvailable(row: row, startSeat: i) {
                var seats = (0..<4).map { String(UnicodeScalar(65 + i + $0)!) }
                if seats.contains("I") {
                   seats.append("K")
                    seats.removeAll { str in
                        str == "I"
                    }
                }
                let seatString = seats.joined(separator: "")
                if !prohibitedCombinations.contains(seatString) {
                    combinations += 1
                    for seat in seats {
                        reservedSeats.insert("\(row)\(seat)")
                    }
                }
            }
        }
        return combinations
    }

    func isFamilySeatAvailable(row: Int, startSeat: Int) -> Bool {
        
        for i in 0..<4 {
            var seat = Character(UnicodeScalar(65 + startSeat + i)!)
            if seat == "I" {seat = "K"}
            let seatString = "\(row)\(seat)"
            if reservedSeats.contains(seatString) {
                return false
            }
        }
        return true
    }

    return seatsSetupAvailable
}

