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
    var currentPage = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Posts"
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        view.addSubview(tableView)
        
        fetchPosts(currentPage)
        Utilities.performHeavyComputation()
    }

    private func fetchPosts(_ currentPage: Int) {
        isLoading = true
        NetworkManager().fetchPosts(currentPage) { result in
            switch result {
                
            case .success(let responsePosts):
                print("total posts recived: \(responsePosts.count)")
                self.posts.append(contentsOf: responsePosts)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            
            case .failure(let error):
                print("error recieved: \(error.localizedDescription)")
            
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let screenHeight = scrollView.frame.size.height
            
            if offsetY > contentHeight - screenHeight {
                if !isLoading {
                    currentPage += 1
                    fetchPosts(currentPage)
                    Utilities.performHeavyComputation()
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
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let post = posts[indexPath.row]
       let detailViewController = DetailViewController()
       detailViewController.post = post
        detailViewController.modalPresentationStyle = .popover
        present(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
