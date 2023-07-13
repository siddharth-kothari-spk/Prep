//
//  ViewController.swift
//  DI-Sample
//
//  Created by Siddharth Kothari on 13/07/23.
//

import UIKit
import Swinject

class ViewController: UIViewController {

    let container: Container = {
        let container = Container()
        container.register(ColorProvider.self) { _ in
            return ColorProviding()
        }
        container.register(SecondViewController.self) { resolver in
            let vc = SecondViewController(provider: resolver.resolve(ColorProvider.self))
            return vc
        }
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapButton(_ sender: Any) {
        guard let vc = container.resolve(SecondViewController.self) else { return }
        present(vc, animated: true)
    }
}

