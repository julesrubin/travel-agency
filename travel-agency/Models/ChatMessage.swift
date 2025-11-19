import Foundation

/// Model representing a chat message in the travel assistant
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
