import UIKit

actor MyActor {
    var counter = 0

    func increment() {
        counter += 1
        print("Counter incremented to \(counter)")
    }
}

// Create instances of the actors
let actor1 = MyActor()
let actor2 = MyActor()

// Send messages to the actors
Task {
    await actor1.increment() // Output: Counter incremented to 1
}
Task {
    await actor1.increment() // Output: Counter incremented to 1
}
Task {
    await actor1.increment() // Output: Counter incremented to 1
}
Task {
    await actor2.increment() // Output: Counter incremented to 1
}
Task {
    await actor1.increment() // Output: Counter incremented to 2
}
