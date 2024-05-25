// https://medium.com/@akash.patel2520/mvvm-data-binding-in-ios-uikit-78d77604f99f

/*
 1. Key-Value Observing (KVO):
 KVO is a mechanism provided by Cocoa frameworks that allows objects to observe changes to the properties of other objects. In our example, we’ll use KVO to observe changes in the ViewModel’s user property and update the UI accordingly.
 */

import Foundation
import UIKit

class User {
    init() {}
}
//ViewModel
class UserViewModel_KVO: NSObject {
    @objc var user: User
    
    init(user: User) {
        self.user = user
        super.init()
    }
}

//View
class ViewController_KVO: UIViewController {
    var viewModel: UserViewModel_KVO!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.addObserver(self, forKeyPath: #keyPath(UserViewModel.user), options: [.initial, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Update UI based on changes
    }
}

/*
 2. Closures/Callbacks:
 In this approach, the ViewModel exposes a closure property that the View sets. Whenever the data changes, the ViewModel invokes this closure, updating the UI.
 */

//ViewModel
class UserViewModel_Closure: NSObject {
    override init() {}
    var onDataUpdate: ((User) -> Void)?
    var user: User {
        didSet {
            onDataUpdate?(user)
        }
    }
}

//View
class ViewController_Closure: UIViewController {
    var viewModel: UserViewModel_Closure!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onDataUpdate = { [weak self] user in
            // Update UI based on user data
        }
    }
}

