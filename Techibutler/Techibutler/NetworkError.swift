//
//  NetworkError.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError
    case decodingError
    case noDataAvailable
}
