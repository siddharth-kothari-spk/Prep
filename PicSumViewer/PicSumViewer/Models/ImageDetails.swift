//
//  ImageDetails.swift
//  PicSumViewer
//
//  Created by Siddharth Kothari on 01/02/24.
//

import Foundation
struct ImageDetails: Codable {
    let format: String
    let width, height: Int
    let filename: String
    let id: Int
    let author: String
    let authorURL, postURL: String

    enum CodingKeys: String, CodingKey {
        case format, width, height, filename, id, author
        case authorURL = "author_url"
        case postURL = "post_url"
    }
}
