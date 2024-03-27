/*
 Minimum Number of Platforms Required for a Railway/Bus Station
 Given the arrival and departure times of all trains that reach a railway station, the task is to find the minimum number of platforms required for the railway station so that no train waits. We are given two arrays that represent the arrival and departure times of trains that stop.

 Examples:

 Input: arr[] = {9:00, 9:40, 9:50, 11:00, 15:00, 18:00}, dep[] = {9:10, 12:00, 11:20, 11:30, 19:00, 20:00}
 Output: 3
 Explanation: There are at-most three trains at a time (time between 9:40 to 12:00)

 Input: arr[] = {9:00, 9:40}, dep[] = {9:10, 12:00}
 Output: 1
 Explanation: Only one platform is needed.


Solution:
 Here's an algorithm to find the minimum number of platforms required for a railway/bus station:

 **Input:**

 * `arr[]`: Array of arrival times of trains/buses (size `n`)
 * `dep[]`: Array of departure times of trains/buses (size `n`)

 **Output:**

 * Minimum number of platforms required

 **Algorithm:**

 1. **Sort both arrival and departure arrays:** This ensures a chronological order of events (arrivals and departures). You can use any sorting algorithm like Merge Sort or Quick Sort.
 2. **Initialize variables:**
     * `platforms`: This variable will store the current number of occupied platforms. Initially, set it to 0.
     * `max_platforms`: This variable will store the maximum number of platforms needed at any given time. Initially, set it to 0.
     * `i`: Index for arrival array (starts at 0)
     * `j`: Index for departure array (starts at 0)
 3. **Iterate through arrival and departure times:**
     * While both `i` and `j` are less than `n`:
         * **If arrival time (arr[i]) is less than or equal to departure time (dep[j])**: This means a new train/bus has arrived. Increment both `platforms` and `i`.
         * **Else (arrival time is greater than departure time)**: This means a train/bus has departed. Decrement `platforms`.
         * **Update max_platforms**: If the current `platforms` is greater than `max_platforms`, update `max_platforms` with the current value.
 4. **Return `max_platforms`**: This represents the minimum number of platforms required.

 **Explanation:**

 By iterating through arrival and departure times, we keep track of the number of trains/buses present at the station at any given time. The `max_platforms` variable stores the highest number of occupied platforms throughout the schedule, which represents the minimum number of platforms needed to handle all arrivals and departures without waiting.


 */

import Foundation

func findMinimumPlatforms(_ arrival: [String],_ departure: [String]) -> Int {
  guard arrival.count == departure.count else { return -1 } // Ensure arrays have same size

  let sortedArrival = sortTimeStrings(arrival)
  let sortedDeparture = sortTimeStrings(departure)

  var platforms = 0
  var maxPlatforms = 0
  var arrivalIndex = 0
  var departureIndex = 0

  while arrivalIndex < arrival.count && departureIndex < departure.count {
      print("*******")
      print("arrivalIndex: \(arrivalIndex), sortedArrival[arrivalIndex]: \(sortedArrival[arrivalIndex]), departureIndex: \(departureIndex), sortedDeparture[departureIndex]: \(sortedDeparture[departureIndex]) ")
      
    if  timeCompare(sortedArrival[arrivalIndex], sortedDeparture[departureIndex])  {
        print("if")
      platforms += 1
      arrivalIndex += 1
      maxPlatforms = max(maxPlatforms, platforms)
    } else {
        print("else")
      platforms -= 1
      departureIndex += 1
    }
      print("maxPlatforms: \(maxPlatforms)")
  }

  return maxPlatforms
}

func sortTimeStrings(_ times: [String]) -> [String] {
  let sortedTimes = times.sorted { time1, time2 -> Bool in
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm" // Set the time format

    guard let date1 = formatter.date(from: time1),
          let date2 = formatter.date(from: time2) else {
      return false // Handle invalid dates (if any)
    }
    return date1 < date2
  }
  print(sortedTimes)
  return sortedTimes
}

func timeCompare(_ time1: String, _ time2: String) -> Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    guard let date1 = formatter.date(from: time1),
          let date2 = formatter.date(from: time2) else {
      return false // Handle invalid dates (if any)
    }
    return date1 < date2
}
var arrival = ["9:00", "9:40", "9:50", "11:00", "15:00", "18:00"]
var departure = ["9:10", "12:00", "11:20", "11:30", "19:00", "20:00"]
print(findMinimumPlatforms(arrival, departure))



// Solution2 :
/*
 To solve this problem, we can use the following algorithm:

 1. **Sort the arrival and departure times** of the trains.
 2. **Initialize** count of platforms needed (`platformsNeeded`) **to 1** and the **result to 1** (since we are examining the first train and at least one platform is needed).
 3. Use two pointers technique, one for arrival (`i`) and one for departure (`j`), starting from the second train for arrival and the first train for departure since we already considered the first train.
 4. Iterate through the trains while `i` is less than the number of trains:
    - If the arrival time of the current train is less than the departure time of the earliest departing train (i.e., `arrival[i] < departure[j]`), this means we need an additional platform:
      - Increase `platformsNeeded`.
      - Move to the next arriving train (`i++`).
      - Update the result if `platformsNeeded` is more than the current result.
    - Else, it means a train has departed, and we can reuse a platform:
      - Decrease `platformsNeeded`.
      - Move to the next departing train (`j++`).
 5. The final result (maximum value of `platformsNeeded` during the iteration) will be the minimum number of platforms required.

 This code defines a `findPlatform` function that takes two arrays of strings (arrival and departure times) and returns the minimum number of platforms required. It also includes a helper function, `timeToMinutes`, to convert the time strings into minutes for easier comparison.
 */
import Foundation

func findPlatform(arrival: [String], departure: [String]) -> Int {
    // Convert time strings to minutes for easier comparison
    let arr = arrival.map { timeToMinutes($0) }.sorted()
    let dep = departure.map { timeToMinutes($0) }.sorted()

    var platformsNeeded = 1 // At least one platform is needed initially
    var result = 1
    var i = 1, j = 0

    while i < arr.count && j < dep.count {
        if arr[i] < dep[j] {
            platformsNeeded += 1
            i += 1
            if platformsNeeded > result {
                result = platformsNeeded
            }
        } else {
            platformsNeeded -= 1
            j += 1
        }
    }

    return result
}

// Helper function to convert time "HH:MM" to minutes
func timeToMinutes(_ time: String) -> Int {
    let components = time.split(separator: ":").map { Int($0)! }
    return components[0] * 60 + components[1]
}

// Example usage
 arrival = ["9:00", "9:40", "9:50", "11:00", "15:00", "18:00"]
 departure = ["9:10", "12:00", "11:20", "11:30", "19:00", "20:00"]
print(findPlatform(arrival: arrival, departure: departure)) // Output: 3

 arrival = ["9:00", "9:40"]
 departure = ["9:10", "12:00"]
print(findPlatform(arrival: arrival, departure: departure)) // Output: 1

