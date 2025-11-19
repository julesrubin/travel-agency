import SwiftUI

/// Reusable chat bubble component for displaying messages
struct ChatBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.text)
                .padding(12)
                .background(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(message.isUser ? .white : .primary)
                .cornerRadius(16)
                .frame(maxWidth: 280, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ChatBubbleView(message: ChatMessage(text: "Hello! I'd like to visit Paris.", isUser: true))
        ChatBubbleView(message: ChatMessage(text: "I'd be happy to help you plan a trip to Paris!", isUser: false))
    }
    .padding()
}
