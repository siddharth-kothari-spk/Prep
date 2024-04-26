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
        var defaultConfig = self.defaultContentConfiguration()
        defaultConfig.text = "ID: \(post.id)"
        defaultConfig.secondaryText = post.title
        self.contentConfiguration = defaultConfig
    }
}
