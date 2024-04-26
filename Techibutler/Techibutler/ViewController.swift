//
//  ViewController.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var posts: [Post] = []
    
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
                
            case .success(let responsePosts):
                print("total posts recived: \(responsePosts.count)")
                self.posts = responsePosts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            
            case .failure(let error):
                print("error recieved: \(error.localizedDescription)")
            
            }
        }
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
