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
    private var webSocket: URLSessionWebSocketTask?
    @Published var message: String? = nil
}
