import Foundation
import Combine

/// ViewModel for the travel chat assistant
/// Manages chat messages and AI interactions
class TravelChatViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var messages: [ChatMessage] = []
    @Published var messageText = ""
    @Published var isProcessing = false
    
    // MARK: - Public Methods
    /// Sends a message and generates AI response
    /// - Parameter text: The message text to send
    @MainActor
    func sendMessage(_ text: String) {
        guard !text.isEmpty else { return }
        
        // Add user message
        let userMessage = ChatMessage(text: text, isUser: true)
        messages.append(userMessage)
        
        // Clear input
        messageText = ""
        
        // Simulate AI response
        isProcessing = true
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            await MainActor.run {
                let aiResponse = ChatMessage(
                    text: "I'd be happy to help you plan a trip! Based on '\(text)', here are some suggestions...",
                    isUser: false
                )
                messages.append(aiResponse)
                isProcessing = false
            }
        }
    }
    
    /// Sends initial prompt if provided
    /// - Parameter prompt: Optional initial prompt to send
    @MainActor
    func handleInitialPrompt(_ prompt: String?) {
        guard let prompt = prompt, !prompt.isEmpty else { return }
        sendMessage(prompt)
    }
}
