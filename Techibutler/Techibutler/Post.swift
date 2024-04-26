//
//  Post.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
