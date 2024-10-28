//
//  ChatViewModel.swift
//  TrialApp
//
//  Created by Emiran Kartal on 28.10.2024.
//
// ViewModels/ChatViewModel.swift

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var messageText: String = ""
    @Published var isConnected: Bool = false

    private var webSocketManager = WebSocketManager.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        webSocketManager.$messages
            .receive(on: DispatchQueue.main)
            .assign(to: \.messages, on: self)
            .store(in: &cancellables)
    }

    func connect() {
        webSocketManager.connect()
        isConnected = true
    }

    func disconnect() {
        webSocketManager.disconnect()
        isConnected = false
    }

    func sendMessage() {
        let trimmedMessage = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedMessage.isEmpty else { return }
        webSocketManager.sendMessage(text: trimmedMessage)
        messageText = ""
    }
}
