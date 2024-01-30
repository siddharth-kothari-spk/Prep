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


// setup 2
