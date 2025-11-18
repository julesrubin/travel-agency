import Foundation

class MockDataService {
    static let shared = MockDataService()
    
    private init() {}
    
    func fetchSuggestions() async -> [PromptSuggestion] {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        return [
            PromptSuggestion(title: "Weekend Escape", description: "Under €300", imageName: "weekend_escape"),
            PromptSuggestion(title: "Beach Paradise", description: "Sunny destinations in November", imageName: "beach_paradise"),
            PromptSuggestion(title: "City Break", description: "Explore culture and history", imageName: "city_break"),
            PromptSuggestion(title: "Mountain Adventure", description: "Hiking and nature trails", imageName: "mountain_adventure"),
            PromptSuggestion(title: "Foodie Tour", description: "Culinary delights in Italy", imageName: "foodie_tour")
        ]
    }
    
    func searchTrips(query: String) async -> [Trip] {
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        return [
            Trip(destination: "Paris, France", price: 450, duration: "3 days", imageName: "paris", rating: 4.8),
            Trip(destination: "Rome, Italy", price: 520, duration: "4 days", imageName: "rome", rating: 4.7),
            Trip(destination: "Barcelona, Spain", price: 380, duration: "3 days", imageName: "barcelona", rating: 4.6),
            Trip(destination: "Tokyo, Japan", price: 1200, duration: "10 days", imageName: "tokyo", rating: 4.9),
            Trip(destination: "Bali, Indonesia", price: 900, duration: "14 days", imageName: "bali", rating: 4.8)
        ].filter { query.isEmpty || $0.destination.localizedCaseInsensitiveContains(query) }
    }
}
