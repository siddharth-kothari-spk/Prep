/// courtsey: https://compleotech.medium.com/viper-architecture-on-ios-7e270441a29a
/// 
import UIKit

protocol Presenting: AnyObject {
    func viewDidLoad()
    func didSelectButton()
}

protocol Routing: AnyObject {
    func moveToNextScreen()
}

protocol Interacting: AnyObject {
    func makeNetworkRequest(completion: () -> Void)
}

protocol Viewable: AnyObject {
    func showMessage()
}

class Router: Routing {
    func moveToNextScreen() {
        print("I moved to next screen!")
    }
}

class Interactor: Interacting {
    func makeNetworkRequest(completion: () -> Void) {
        print("I made the network request!")
        completion()
    }
}

class Presenter: Presenting {
    weak var view: Viewable?
    var router: Routing
    var interactor: Interacting

    init(view: Viewable, router: Routing, interactor: Interacting) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad() {
        view?.showMessage()
    }

    func didSelectButton() {
        interactor.makeNetworkRequest() { [weak self] in
            self?.router.moveToNextScreen()
        }
    }
}

class View: Viewable {
    var presenter: Presenting?

    func viewDidLoad() {
        presenter?.viewDidLoad()
    }

    func didSelectButton() {
        presenter?.didSelectButton()
    }

    func showMessage() {
        print("Hey!!!!")
    }
}

let view = View()
let interactor = Interactor()
let router = Router()
let presenter = Presenter(view: view, router: router, interactor: interactor)
view.presenter = presenter

view.viewDidLoad()
view.didSelectButton()
