//
//  WebSocketManager.swift
//  TrialApp
//
//  Created by Emiran Kartal on 28.10.2024.
//
// Networking/WebSocketManager.swift

import Foundation
import Combine

class WebSocketManager: NSObject, ObservableObject {
    static let shared = WebSocketManager()
    private override init() {
        super.init()
        setupWebSocket()
    }

    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession!
    private var isConnected = false

    @Published var messages: [ChatMessage] = []

    private func setupWebSocket() {
        let configuration = URLSessionConfiguration.default
        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue())
    }

    func connect() {
        guard let url = URL(string: "ws://127.0.0.1:8000/ws/chat") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        if let token = NetworkManager.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        webSocketTask = urlSession.webSocketTask(with: request)
        webSocketTask?.resume()
        isConnected = true
        receiveMessage()
    }

    func disconnect() {
        isConnected = false
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }

    func sendMessage(text: String) {
        let messageDict: [String: Any] = ["text": text]
        guard let data = try? JSONSerialization.data(withJSONObject: messageDict, options: []) else {
            print("Failed to serialize message")
            return
        }
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("Failed to convert data to JSON string")
            return
        }

        let message = URLSessionWebSocketTask.Message.string(jsonString)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                print("Error receiving message: \(error)")
                self.isConnected = false
            case .success(let message):
                switch message {
                case .data(let data):
                    self.handleReceivedData(data)
                case .string(let text):
                    if let data = text.data(using: .utf8) {
                        self.handleReceivedData(data)
                    }
                @unknown default:
                    print("Unknown message format received")
                }
                // Continue to receive next message
                self.receiveMessage()
            }
        }
    }

    private func handleReceivedData(_ data: Data) {
        let decoder = JSONDecoder()
        
        // Create a custom date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let message = try decoder.decode(ChatMessage.self, from: data)
            DispatchQueue.main.async {
                self.messages.append(message)
            }
        } catch {
            print("Error decoding message: \(error)")
        }
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession,
                    webSocketTask: URLSessionWebSocketTask,
                    didOpenWithProtocol protocol: String?) {
        print("WebSocket did connect")
    }

    func urlSession(_ session: URLSession,
                    webSocketTask: URLSessionWebSocketTask,
                    didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
                    reason: Data?) {
        isConnected = false
        print("WebSocket did disconnect with code: \(closeCode)")
    }
}
