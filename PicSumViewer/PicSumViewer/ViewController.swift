//
//  ViewController.swift
//  PicSumViewer
//
//  Created by Siddharth Kothari on 31/01/24.
//

import UIKit

class ViewController: UIViewController {

    let imagesListTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagesListTableView.backgroundColor = .red
        view.addSubview(imagesListTableView)
        setupConstraints()
        getData()
    }
    
    func setupConstraints() {
        imagesListTableView.translatesAutoresizingMaskIntoConstraints = false
        imagesListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imagesListTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        imagesListTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        imagesListTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func getData() {
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

