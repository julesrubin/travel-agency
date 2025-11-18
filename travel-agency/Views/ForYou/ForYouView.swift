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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.suggestions) { suggestion in
                        PromptCardView(suggestion: suggestion)
                            .onTapGesture {
                                // TODO: Navigate to Travel tab and send prompt
                                print("Tapped: \(suggestion.title)")
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("For you")
            .navigationBarTitleDisplayMode(.large)
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
    ForYouView()
}
