//
//  NetworkManager.swift
//  PicSumViewer
//
//  Created by Siddharth Kothari on 01/02/24.
//

import Foundation
class NetworkManager {

    func fetchImageList(completionHandler: @escaping (Result<[ImageDetails], Error>) -> Void) {
        guard let url = URL(string: "https://picsum.photos/list") else { return }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let images = try decoder.decode([ImageDetails].self, from: data)
                completionHandler(.success(images))
                return
            } catch let error {
                completionHandler(.failure(error))
                return
            }
        }
    }
}

