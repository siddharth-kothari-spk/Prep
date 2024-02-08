//
//  NetworkManager.swift
//  ShowAPIData_Storyboard
//
//  Created by Siddharth Kothari on 08/02/24.
//

import Foundation

class NetworkManager {
    func fetchAPIData(completionHandler: @escaping (Result<PaginationData, Error>) -> Void) {
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else {
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(PaginationData.self, from: data)
                completionHandler(.success(decodedData))
                return
            } catch let error {
                completionHandler(.failure(error))
                return
            }
        }
        
    }
}
