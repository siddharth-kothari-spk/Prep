//
//  PostCell.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    func configure(with post: Post) {
        textLabel?.text = "ID: \(post.id)"
        detailTextLabel?.text = post.title
    }
}
