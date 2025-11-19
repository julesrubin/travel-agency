import SwiftUI

struct TravelChatView: View {
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @Binding var initialPrompt: String?
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Messages area
                GeometryReader { geometry in
                    ScrollView {
                        if messages.isEmpty {
                            // Centered empty state
                            VStack(spacing: 20) {
                                Image(systemName: "airplane.departure")
                                    .font(.system(size: 60))
                                    .foregroundColor(.blue.opacity(0.5))
                                
                                Text("Where would you like to go?")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("Ask me anything about your next trip")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(messages) { message in
                                    ChatBubbleView(message: message)
                                }
                            }
                            .padding()
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)
                }
                
                // Chat input bar
                HStack(spacing: 12) {
                    TextField("Message your AI travel assistant...", text: $messageText)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                        .submitLabel(.send)
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            sendMessage()
                        }
                    
                    if !messageText.isEmpty {
                        Button(action: sendMessage) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .animation(.spring(response: 0.3), value: messageText.isEmpty)
            }
            .navigationTitle("AI Travel Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onChange(of: initialPrompt) { _, newPrompt in
                if let prompt = newPrompt {
                    messageText = prompt
                    sendMessage()
                    initialPrompt = nil  // Clear after sending
                }
            }
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
    TravelChatView(initialPrompt: .constant(nil))
}
