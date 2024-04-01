//
//  WebSocketViewModel.swift
//  Sample_URLSessionWebSocketTask
//
//  Created by Siddharth Kothari on 01/04/24.
//

import Foundation
import SwiftUI
import Combine

class WebSocketViewModel: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    @Published var message: String? = nil
    
    func connect() {
            guard let url = URL(string: "wss://echo.websocket.org") else { return }
            let session = URLSession(configuration: .default)
            webSocketTask = session.webSocketTask(with: url)
           // webSocketTask?.delegate = self
            webSocketTask?.resume()
        }

        func sendMessage() {
            message = "Hello from the client!"
            if let message = message, let data = message.data(using: .utf8) {
                webSocketTask?.send(.data(data)) { error in
                    if let error = error {
                        print("Error sending message: \(error)")
                    }
                }
            }
        }

        func disconnect() {
            webSocketTask?.cancel(with: .normalClosure, reason: nil)
            webSocketTask = nil
        }
}
