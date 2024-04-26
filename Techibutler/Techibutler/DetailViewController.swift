//
//  DetailViewController.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var post: Post?
    var postTitle: UILabel!
    var postDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        postDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        postTitle = UILabel(frame: CGRect(x: 50, y: 50, width: 300, height: 60))
        postTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        view.addSubview(postTitle)
        
        postDescription = UILabel(frame: CGRect(x: 50, y: 120, width: 300, height: 300))
        postDescription.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        postDescription.numberOfLines = 0
        view.addSubview(postDescription)
    }
    
    private func postDetails() {
        if let post = post {
            postTitle.text = "Title: " + post.title
            postDescription.text = "Body: \n" + post.body
        }
    }
}
