// test prep Amex
class A {
    var bVar: B?
    init(bVar: B? = nil) {
        print("Class A init called")
    }
    deinit {
        print("Class A deinit called")
    }
}
 
class B {
    unowned var aVar: A
    init(aVar: A) {
//        guard let avar = aVar else {
//            return
//        }
        self.aVar = aVar
       // self.aVar = nil
        print("Class B init called")
       // test()
    }
    
    func test() {
        print(aVar)
    }
    
    deinit {
        print("Class B deinit called")
    }
}
 
var classA: A? = A()
let classB = B(aVar: classA!)
classA = nil
print(classB.aVar)
//classA.bVar = classB
//classB.aVar = classA



/* Given two given numbers a and b where a<b, find the number of perfect squares between a and b (a and b
Input :  a = 3, b = 8
Output : [4]
The only perfect square in given range is 4.
 
Input : a = 1, b = 10
Output : [1,4,9]


root = Double(sqrt(num))

Double(Int(root)) == root

num = 4
root = 2.0

Double(Int(2.0)) -> Double(2) -> 2.0


num = 5
root = 2.5

Double(Int(2.5)) -> Double(2) -> 2.0

*/
/*
import Foundation

func findSquares(_ a: Int, _ b: Int) -> [Int] {
    var result : [Int] = [Int]()
    
    var a1 = a < 0 ? 1 : a
    var found = false
    var first = 0
    for num in a1...b {
       // guard num > 0 else { return }
        if num > 0 {
            let root = sqrt(Double(num)) // find complexity of sqrt ?
            
            if root == Double(Int(root))  && !found {
                result.append(num)
                found = true
                first = Int(root)
                break
            }
        }
        else {
            print("num less than 0")
        }
    }
    
    while first*first < b {
        first += 1
        if (a1...b).contains(first*first) {
            result.append(first*first)
        }
        else {
            first = b
        }
    }
    return result
}

print(findSquares(-10,20))
*/

/*
 [11:44] Reeta Shaligram Dubey
 1...10
 startRange = sqrt(start) // 1
 endRange = sqrt(end) // 3.x
 result = [startRange...endRange].map {$0 * $0}
 */


/*
 //Name,Age,Address,Phone Number,Email,Favorite Number,Employed
 */
/*
import Foundation
 let csvfile = """
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


var data : [String] = csvfile.components(separatedBy: "\n")

var people : [People] = []
var filterPeople: [People] = []

for row in data {
    var rowData: [String] = row.components(separatedBy: ",")
    
    if rowData.count == 7 {
        var p =  People(name: rowData[0] as String, 
                        age: Int(rowData[1]) ?? 0,
                        address: rowData[2] as String,
                        phoneNumber: rowData[3] as String,
                        email: rowData[4] as String,
                        favNumber: Int(rowData[5]) ?? 0,
                        employed: rowData[6] == "true")
        people.append(p)
    }
    else {
        print("data missing : \(rowData)")
    }
    
   filterPeople = people.filter { $0.favNumber > 500}
}

print(people)
print("-------")
print(filterPeople)

*/
/*
 1. positive test sample: all proper data set -> Burgess Greasley,33,04 Ridge Oak Street,649-893-5297,bgreasley1@4shared.com,337,true
 2. data set with empty : Burgess Greasley, ,04 Ridge Oak Street,649-893-5297,bgreasley1@4shared.com,337,true
 3. less elemnts than expecetd : Burgess Greasley,33,04 Ridge Oak Street,649-893-5297,bgreasley1@4shared.com,337
 4. improper data for int values: Burgess Greasley,asd,04 Ridge Oak Street,649-893-5297,bgreasley1@4shared.com,XYX,true
 5. breakline missing in csv
 Burgess Greasley,33,04 Ridge Oak Street,649-893-5297,bgreasley1@4shared.com,337,trueDerwin Brunel,13,0843 Bunting Hill,790-611-6437,dbrunel2@discovery.com,961,true
 6. breaklne at improper place
 Burgess Greasley,33,04 Ridge Oak Street,649-893-5297,bgreasley1@4shared.com,337,
 true
 Derwin Brunel,13,0843 Bunting Hill,790-611-6437,dbrunel2@discovery.com,961,true
7. email validation, phone number validation
*/
