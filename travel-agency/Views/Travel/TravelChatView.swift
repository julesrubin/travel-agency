import SwiftUI

/// Travel chat assistant view with AI-powered trip planning
struct TravelChatView: View {
    @StateObject private var viewModel = TravelChatViewModel()
    @Binding var initialPrompt: String?
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Messages area
                GeometryReader { geometry in
                    ScrollView {
                        if viewModel.messages.isEmpty {
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
                                ForEach(viewModel.messages) { message in
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
                    TextField("Message your AI travel assistant...", text: $viewModel.messageText)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                        .submitLabel(.send)
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            viewModel.sendMessage(viewModel.messageText)
                        }
                    
                    if !viewModel.messageText.isEmpty {
                        Button(action: { viewModel.sendMessage(viewModel.messageText) }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding()
                .glassEffect(.regular, in: .rect(cornerRadius: 0))
                .animation(.spring(response: 0.3), value: viewModel.messageText.isEmpty)
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
            .onAppear {
                viewModel.handleInitialPrompt(initialPrompt)
                initialPrompt = nil
            }
            .onChange(of: initialPrompt) { _, newPrompt in
                viewModel.handleInitialPrompt(newPrompt)
                initialPrompt = nil
            }
        }
    }
}

#Preview {
    TravelChatView(initialPrompt: .constant(nil))
}
