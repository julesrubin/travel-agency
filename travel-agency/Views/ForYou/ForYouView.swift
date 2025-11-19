import SwiftUI

struct ForYouView: View {
    @StateObject private var viewModel: ForYouViewModel
    @State private var showProfile = false
    let onPromptSelected: (String) -> Void
    
    // MARK: - Initialization
    init(
        dataService: DataServiceProtocol = MockDataService(),
        onPromptSelected: @escaping (String) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: ForYouViewModel(dataService: dataService))
        self.onPromptSelected = onPromptSelected
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.suggestions) { suggestion in
                            PromptCardView(suggestion: suggestion)
                                .frame(height: geometry.size.height) // Full screen height
                                .containerRelativeFrame(.horizontal)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.8)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                }
                                .onTapGesture {
                                    // Send prompt to AI chat with full context
                                    let fullPrompt = "I'm interested in: \(suggestion.title) - \(suggestion.description)"
                                    onPromptSelected(fullPrompt)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
            }
            .navigationTitle("For you")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showProfile = true }) {
                        Image(systemName: "person.circle")
                            .foregroundColor(.primary)
                    }
                }
            }
            .refreshable {
                await viewModel.loadSuggestions()
            }
            .task {
                await viewModel.loadSuggestions()
            }
            .overlay {
                if viewModel.isLoading && viewModel.suggestions.isEmpty {
                    ProgressView()
                }
            }
            .overlay {
                if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Button("Try Again") {
                            Task {
                                await viewModel.loadSuggestions()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    ForYouView(onPromptSelected: { _ in })
}
