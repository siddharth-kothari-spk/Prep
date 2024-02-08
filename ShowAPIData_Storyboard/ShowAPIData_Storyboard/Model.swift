//
//  Model.swift
//  ShowAPIData_Storyboard
//
//  Created by Siddharth Kothari on 08/02/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct Support: Codable {
    let url: String
    let text: String
}

struct PaginationData: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let users: [User]
    let support: Support
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case users = "data"
        case support
    }
}


