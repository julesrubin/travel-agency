import SwiftUI

struct TravelChatView: View {
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Messages area
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if messages.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "airplane.departure")
                                    .font(.system(size: 60))
                                    .foregroundColor(.blue.opacity(0.5))
                                    .padding(.top, 100)
                                
                                Text("Where would you like to go?")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("Ask me anything about your next trip")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            ForEach(messages) { message in
                                ChatBubbleView(message: message)
                            }
                        }
                    }
                    .padding()
                }
                
                // Input area
                HStack(spacing: 12) {
                    TextField("Ask about destinations, activities...", text: $messageText)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(messageText.isEmpty ? .gray : .blue)
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding()
                .background(.ultraThinMaterial)
            }
            .navigationTitle("Travel")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        
        let userMessage = ChatMessage(text: messageText, isUser: true)
        messages.append(userMessage)
        
        let query = messageText
        messageText = ""
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiResponse = ChatMessage(
                text: "I'd be happy to help you plan a trip! Based on '\(query)', here are some suggestions...",
                isUser: false
            )
            messages.append(aiResponse)
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

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
    TravelChatView()
}
