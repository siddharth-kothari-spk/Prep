/*
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
    weak var aVar: A?
    init(aVar: A? = nil) {
        print("Class B init called")
    }
    deinit {
        print("Class B deinit called")
    }
}
 
var classA = A()
var classB = B()
classA.bVar = classB
classB.aVar = classA
*/

// setup 2
class A {
    var bVar: B?
    init() {
        print("Class A init called")
    }
    deinit {
        print("Class A deinit called")
    }
}

class B {
    var aVar: A?
    init() {
        print("Class B init called")
    }
    deinit {
        print("Class B deinit called")
    }
}

var classA: A? = A()
var classB: B? = B()

// Creating a strong reference cycle
classA?.bVar = classB
classB?.aVar = classA
print(classA as Any)
print(classB as Any)
// Breaking the strong reference cycle using a closure with a capture list
classA = nil
classB = nil
