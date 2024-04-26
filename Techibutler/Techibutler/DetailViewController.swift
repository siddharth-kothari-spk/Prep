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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display detailed information about the post
        if let post = post {
            // Example: Display post details on the view
            // You can access post properties like post.id, post.title, etc.
            print("Selected Post ID: \(post.id)")
            print("Selected Post Title: \(post.title)")
        }
    }
}
