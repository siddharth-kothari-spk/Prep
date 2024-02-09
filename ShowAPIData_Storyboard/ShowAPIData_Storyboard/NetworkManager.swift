//
//  NetworkManager.swift
//  ShowAPIData_Storyboard
//
//  Created by Siddharth Kothari on 08/02/24.
//

import Foundation
import Combine

class NetworkManager {
    func fetchAPIData(completionHandler: @escaping (Result<PaginationData, Error>) -> Void) {
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else {
            return
        }
        
       /*
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
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                    print("No data received")
                    return
            }
            
            do {
                let paginationData = try JSONDecoder().decode(PaginationData.self, from: data)
                completionHandler(.success(paginationData))
            } catch let error {
                completionHandler(.failure(error))
                return
            }
        }
        task.resume()
        */
        
        var cancellables: Set<AnyCancellable> = []
        URLSession.shared.dataTaskPublisher(for: url)
            .map{
                print("data: \($0.data)")
                return $0.data
            }
            .decode(type: PaginationData.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            } receiveValue: { paginationData in
                print(paginationData)
                completionHandler(.success(paginationData))
            }
            .store(in: &cancellables)

    }
}
