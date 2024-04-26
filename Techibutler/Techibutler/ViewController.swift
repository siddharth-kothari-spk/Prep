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
    var heightCache: [Int: CGFloat] = [:] // In actual in tableviewcell we are only showing id and title so heightCache does not make sense. It is done here just to show case how we can do memoization

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
    
    private func heightForPost(_ post: Post) -> CGFloat {
        // get height from cache otherwise calculate and save in cache and return
        if let result = heightCache[post.id] {
            return result
        } else {
            let result = computeHeight(post)
            heightCache[post.id] = result
            return result
        }
    }
    
    // Helper function to calculate cell height based on post body
    private func computeHeight(_ post: Post) -> CGFloat {
        let width = tableView.bounds.width - 16
        
        let font = UIFont.systemFont(ofSize: 16)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let estimatedSize = NSString(string: post.body).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                                                     options: .usesLineFragmentOrigin,
                                                                     attributes: attributes,
                                                                     context: nil)
        
        // Add padding for better readability
        let padding: CGFloat = 16
        
        return estimatedSize.height + padding * 2 // Add padding for top and bottom
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        return heightForPost(post)
    }
}
