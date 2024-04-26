//
//  NetworkManager.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import Foundation

class NetworkManager {
    
    public func fetchPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error in response: \(error.debugDescription)")
                completion(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                print("No data availble")
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                print("data available")
                completion(.success(posts))
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
