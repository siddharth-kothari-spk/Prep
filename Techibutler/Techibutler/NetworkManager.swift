//
//  NetworkManager.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import Foundation

class NetworkManager {
    
    public func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error in response: \(error.debugDescription)")
                return
            }
            
            guard let data = data else {
                print("No data availble")
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                print("Posts: \(posts)")
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
