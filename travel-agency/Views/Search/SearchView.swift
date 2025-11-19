import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var trips: [Trip] = []
    @Published var isLoading = false
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
    }
    
    func search() async {
        isLoading = true
        do {
            let results = try await dataService.searchTrips(query: searchQuery)
            await MainActor.run {
                self.trips = results
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.trips = []
                self.isLoading = false
            }
        }
    }
}

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    
    init(dataService: DataServiceProtocol = MockDataService()) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(dataService: dataService))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search destinations...", text: $viewModel.searchQuery)
                        .textFieldStyle(.plain)
                        .onChange(of: viewModel.searchQuery) { _, _ in
                            Task {
                                await viewModel.search()
                            }
                        }
                    
                    if !viewModel.searchQuery.isEmpty {
                        Button(action: {
                            viewModel.searchQuery = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .glassmorphism()
                .padding()
                
                // Results
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.trips) { trip in
                            NavigationLink(destination: TripDetailView(trip: trip)) {
                                TripCardView(trip: trip)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if viewModel.trips.isEmpty && !viewModel.searchQuery.isEmpty {
                        ContentUnavailableView(
                            "No trips found",
                            systemImage: "magnifyingglass",
                            description: Text("Try a different search term")
                        )
                    }
                }
            }
            .navigationTitle("Search")
            .task {
                await viewModel.search()
            }
        }
    }
}

struct TripCardView: View {
    let trip: Trip
    
    var body: some View {
        HStack(spacing: 16) {
            // Image placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                    colors: [.orange.opacity(0.6), .pink.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 30))
                        .foregroundColor(.white.opacity(0.7))
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(trip.destination)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(trip.duration)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", trip.rating))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text("€\(Int(trip.price))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
        .glassmorphism()
    }
}

#Preview {
    SearchView()
}
