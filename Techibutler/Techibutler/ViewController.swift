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
        
        NetworkManager().fetchPosts { result in
            switch result {
                
            case .success(let posts):
                print("total posts recived: \(posts.count)")
            
            case .failure(let error):
                print("error recieved: \(error.localizedDescription)")
            
            }
        }
    }


}

