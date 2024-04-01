//
//  ContentView.swift
//  Sample_URLSessionWebSocketTask
//
//  Created by Siddharth Kothari on 01/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WebSocketViewModel()

    var body: some View {
        VStack {
            Text("WebSocket Demo")
                .font(.title)
            if let message = viewModel.message {
                Text(message)
                    .padding()
            }
            Button("Send Message") {
                viewModel.sendMessage()
            }
        }
        .padding()
        .onAppear {
            //viewModel.connect()
        }
    }
}

#Preview {
    ContentView()
}
