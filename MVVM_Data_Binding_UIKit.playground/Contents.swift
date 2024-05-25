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

/*
 3. Delegation:
 Delegation is a common way of communicating in iOS development. Here, the ViewModel has a delegate protocol that the View conforms to. When the data changes, the ViewModel notifies the View through delegate methods.
 */

//ViewModel

protocol UserViewModelDelegate: AnyObject {
    func userDidChange(newUser: User)
}

class UserViewModel_Delegate: NSObject {
    override init() {}
    weak var delegate: UserViewModelDelegate?
    var user: User {
        didSet {
            delegate?.userDidChange(newUser: user)
        }
    }
}

//View
class ViewController_Delegate: UIViewController, UserViewModelDelegate {
    var viewModel: UserViewModel_Delegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    func userDidChange(newUser: User) {
        // Update UI based on new user data
    }
}

/*
 4. Combine Framework:
 Combine provides a declarative Swift API for processing values over time. Here, we use Combine’s publishers and subscribers to establish data flow between the ViewModel and View.
 */

//ViewModel

import Combine

struct User_Combine {
    let name: String
    let email: String
    let image: String
}
class UserViewModel_Combine {
    var user: CurrentValueSubject<User_Combine, Never> = CurrentValueSubject<User_Combine, Never>(User_Combine(name: "", email: "", image: ""))
}

//View
class ViewController_Combine: UIViewController {
    var viewModel = UserViewModel_Combine()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.user
            .sink { [weak self] newUser in
                // Update UI based on new user data
            }
            .store(in: &cancellables)
    }
}
