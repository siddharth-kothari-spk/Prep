/*
 Following is string for events received for screen visit. Each row represents screen visits for one user. Each event is separated by space. Write swift function to calculate visit count for each screen for all users.
 Example
 /home /home/account /home/account/edit_address
 /home /home/transactions
  
 Output -
 /home - 5
 /home/account - 2
 /home/account/edit_address - 1
 /home/transactions - 1
  
 let hits = """
 /home /home/account /home/account/edit_address
 /home /home/transactions
 /home /home/offers
 /home /home/offers /home /home/account
 /home /home/transactions /home /home/account /home /home/transactions /home
 /home /home/offers /home/transactions /home
 /home /home/offers /home/transactions /home /home/offers /home /home/transactions
 /home /home/offers
 /home /home/transactions
 /home /home/transactions /home /home/offers
 """

 */

func countScreenVisits(input: String) {
    // Dictionary to hold the count of each screen visit
    var visitCounts = [String: Int]()
    
    // Splitting the input string into lines, each line represents one user's screen visits
    let lines = input.split(separator: "\n")
    
    // Process each line
    for line in lines {
        // Split each line by spaces to get individual screen paths
        let screens = line.split(separator: " ")
        
        // Count each screen path
        for screen in screens {
            let screenPath = String(screen)
            // Increment the count for this screen path in the dictionary
            visitCounts[screenPath, default: 0] += 1
            
            var keys = visitCounts.keys
            
            for key in keys {
                if screenPath.hasPrefix(key) && screenPath.count != key.count {
                    visitCounts[key, default: 0] += 1
                }
            }
        }
    }
    
    // Output the visit counts sorted by the screen path
    let sortedVisitCounts = visitCounts.sorted { $0.key < $1.key }
    print(sortedVisitCounts)
}

// Example usage with provided data
let hits = """
/home /home/account /home/account/edit_address
/home /home/transactions
/home /home/offers
/home /home/offers /home /home/account
/home /home/transactions /home /home/account /home /home/transactions /home
/home /home/offers /home/transactions /home
/home /home/offers /home/transactions /home /home/offers /home /home/transactions
/home /home/offers
/home /home/transactions
/home /home/transactions /home /home/offers
"""

let hits2 = """
 /home /home/account /home/account/edit_address
 /home /home/transactions
 /home/offers
"""
countScreenVisits(input: hits)
