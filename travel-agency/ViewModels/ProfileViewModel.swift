import Foundation
import Combine

/// ViewModel for profile and favorites management
/// Manages user profile data and saved trips
class ProfileViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var savedTrips: [Trip] = []
    @Published var isLoading = false
    
    // MARK: - User Profile
    let userName = "Travel Enthusiast"
    let userEmail = "traveler@example.com"
    
    // MARK: - Initialization
    init() {
        loadMockSavedTrips()
    }
    
    // MARK: - Private Methods
    private func loadMockSavedTrips() {
        // Mock saved trips data
        savedTrips = [
            Trip(
                destination: "Paris, France",
                price: 450,
                duration: "3 days",
                imageName: "paris",
                rating: 4.8
            ),
            Trip(
                destination: "Bali, Indonesia",
                price: 890,
                duration: "14 days",
                imageName: "bali",
                rating: 4.9
            ),
            Trip(
                destination: "Tokyo, Japan",
                price: 1200,
                duration: "10 days",
                imageName: "tokyo",
                rating: 4.9
            )
        ]
    }
    
    // MARK: - Public Methods
    /// Removes a trip from saved trips
    /// - Parameter trip: The trip to remove
    func removeSavedTrip(_ trip: Trip) {
        savedTrips.removeAll { $0.id == trip.id }
    }
}
