//
//  ViewController.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NetworkManager().fetchPosts()
    }


}

