import SwiftUI

/// Favorites view displaying saved trips
struct FavoritesView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.savedTrips) { trip in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(
                                colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 80, height: 80)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(trip.destination)
                                .font(.headline)
                            Text("\(trip.duration) • €\(Int(trip.price))")
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
                        }
                        
                        Spacer()
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    viewModel.removeSavedTrip(viewModel.savedTrips[index])
                }
            }
        }
        .navigationTitle("Saved Trips")
        .overlay {
            if viewModel.savedTrips.isEmpty {
                ContentUnavailableView(
                    "No Saved Trips",
                    systemImage: "bookmark",
                    description: Text("Your saved trips will appear here")
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView(viewModel: ProfileViewModel())
    }
}
