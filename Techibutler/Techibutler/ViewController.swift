//
//  ViewController.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        view.addSubview(tableView)
        
        fetchPosts()
    }

    private func fetchPosts() {
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


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test \(indexPath.row)"
        cell.detailTextLabel?.text = "detail test \(indexPath.row)"
        return cell
    }
}
