//
//  NetworkService.swift
//  test
//
//  Created by Siddharth Kothari on 15/05/24.
//

import Foundation

enum TestError: Error {
    case invalidUrl
    case invalidData
    case errorInResponse
}

var link = "https://jsonplaceholder.typicode.com/users"

class NetworkService {
    // Result<Int, Error>
    
    func getUsers(completionHandler:@escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: link) else {
            completionHandler(.failure(TestError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                completionHandler(.failure(TestError.errorInResponse))
                return //.failure(TestError.errorInResponse)
                
            }
            
            guard let data = data else {
                completionHandler(.failure(TestError.invalidData))
                return //.failure(TestError.invalidData)
            }
            
            let decoder = JSONDecoder().self
            
            do {
                let users = try decoder.decode([User].self, from: data)
                completionHandler(.success(users))
               // completionHandler(.success(users))
            }
            catch (let error) {
                print("\(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
}
