import SwiftUI
import Combine

class ForYouViewModel: ObservableObject {
    @Published var suggestions: [PromptSuggestion] = []
    @Published var isLoading = false
    
    func loadSuggestions() async {
        isLoading = true
        let fetchedSuggestions = await MockDataService.shared.fetchSuggestions()
        await MainActor.run {
            self.suggestions = fetchedSuggestions
            self.isLoading = false
        }
    }
}

struct ForYouView: View {
    @StateObject private var viewModel = ForYouViewModel()
    @State private var showProfile = false
    let onPromptSelected: (String) -> Void
    
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
                                    // Send prompt to AI chat
                                    onPromptSelected(suggestion.title)
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
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    ForYouView(onPromptSelected: { _ in })
}
