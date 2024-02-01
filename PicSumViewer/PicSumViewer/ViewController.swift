//
//  ViewController.swift
//  PicSumViewer
//
//  Created by Siddharth Kothari on 31/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkManager().fetchImageList { result in
                    switch result {
                    case .success(let data):
                        print("success data: \(data)")
                    case .failure(let error):
                        print("error : \(error.localizedDescription)")
                    }
                }
    }
}

