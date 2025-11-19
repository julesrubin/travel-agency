import Foundation

/// Mock implementation of DataServiceProtocol for development and testing
/// Provides hardcoded data without requiring a real backend
class MockDataService: DataServiceProtocol {
    
    /// Fetches mock travel suggestions with simulated network delay
    func fetchSuggestions() async throws -> [PromptSuggestion] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return [
            PromptSuggestion(
                title: "Weekend in Paris",
                description: "Romantic getaway under €500",
                imageName: "paris_weekend"
            ),
            PromptSuggestion(
                title: "Bali Beach Retreat",
                description: "2 weeks of sun, surf & serenity",
                imageName: "bali_beach"
            ),
            PromptSuggestion(
                title: "Tokyo Food Tour",
                description: "Best ramen & sushi spots",
                imageName: "tokyo_food"
            ),
            PromptSuggestion(
                title: "Iceland Northern Lights",
                description: "Winter adventure in December",
                imageName: "iceland_lights"
            ),
            PromptSuggestion(
                title: "Greek Island Hopping",
                description: "Santorini, Mykonos & Crete",
                imageName: "greek_islands"
            ),
            PromptSuggestion(
                title: "NYC Shopping Spree",
                description: "Black Friday deals & Broadway",
                imageName: "nyc_shopping"
            ),
            PromptSuggestion(
                title: "Swiss Alps Skiing",
                description: "Luxury chalets in Zermatt",
                imageName: "swiss_alps"
            ),
            PromptSuggestion(
                title: "Morocco Desert Safari",
                description: "Marrakech to Sahara adventure",
                imageName: "morocco_desert"
            ),
            PromptSuggestion(
                title: "Italian Wine Country",
                description: "Tuscany vineyards & cuisine",
                imageName: "tuscany_wine"
            ),
            PromptSuggestion(
                title: "Safari in Kenya",
                description: "Big Five wildlife experience",
                imageName: "kenya_safari"
            ),
            PromptSuggestion(
                title: "Amsterdam Canal Tour",
                description: "Museums, bikes & tulips",
                imageName: "amsterdam_canals"
            ),
            PromptSuggestion(
                title: "Maldives Overwater Villa",
                description: "Luxury all-inclusive resort",
                imageName: "maldives_villa"
            ),
            PromptSuggestion(
                title: "Peru Machu Picchu Trek",
                description: "Inca Trail hiking adventure",
                imageName: "peru_trek"
            ),
            PromptSuggestion(
                title: "Dubai Luxury Escape",
                description: "5-star hotels & desert safari",
                imageName: "dubai_luxury"
            ),
            PromptSuggestion(
                title: "Croatia Coast Cruise",
                description: "Dubrovnik to Split sailing",
                imageName: "croatia_coast"
            ),
            PromptSuggestion(
                title: "Vietnam Street Food",
                description: "Hanoi to Ho Chi Minh culinary tour",
                imageName: "vietnam_food"
            )
        ]
    }
    
    /// Searches for trips matching the query with simulated network delay
    func searchTrips(query: String) async throws -> [Trip] {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        let allTrips = [
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
            ),
            Trip(
                destination: "Reykjavik, Iceland",
                price: 680,
                duration: "5 days",
                imageName: "iceland",
                rating: 4.7
            ),
            Trip(
                destination: "Santorini, Greece",
                price: 720,
                duration: "7 days",
                imageName: "santorini",
                rating: 4.8
            ),
            Trip(
                destination: "New York, USA",
                price: 950,
                duration: "5 days",
                imageName: "nyc",
                rating: 4.6
            ),
            Trip(
                destination: "Zermatt, Switzerland",
                price: 1400,
                duration: "7 days",
                imageName: "zermatt",
                rating: 4.9
            ),
            Trip(
                destination: "Marrakech, Morocco",
                price: 580,
                duration: "6 days",
                imageName: "marrakech",
                rating: 4.7
            ),
            Trip(
                destination: "Barcelona, Spain",
                price: 420,
                duration: "4 days",
                imageName: "barcelona",
                rating: 4.7
            ),
            Trip(
                destination: "Dubai, UAE",
                price: 1100,
                duration: "6 days",
                imageName: "dubai",
                rating: 4.8
            ),
            Trip(
                destination: "Florence, Italy",
                price: 650,
                duration: "5 days",
                imageName: "florence",
                rating: 4.8
            ),
            Trip(
                destination: "Nairobi, Kenya",
                price: 1800,
                duration: "12 days",
                imageName: "nairobi",
                rating: 4.9
            ),
            Trip(
                destination: "Amsterdam, Netherlands",
                price: 480,
                duration: "4 days",
                imageName: "amsterdam",
                rating: 4.6
            ),
            Trip(
                destination: "Malé, Maldives",
                price: 2200,
                duration: "10 days",
                imageName: "maldives",
                rating: 5.0
            ),
            Trip(
                destination: "Cusco, Peru",
                price: 1100,
                duration: "8 days",
                imageName: "cusco",
                rating: 4.8
            ),
            Trip(
                destination: "Dubrovnik, Croatia",
                price: 620,
                duration: "6 days",
                imageName: "dubrovnik",
                rating: 4.7
            ),
            Trip(
                destination: "Hanoi, Vietnam",
                price: 780,
                duration: "10 days",
                imageName: "hanoi",
                rating: 4.7
            ),
            Trip(
                destination: "London, UK",
                price: 550,
                duration: "4 days",
                imageName: "london",
                rating: 4.6
            ),
            Trip(
                destination: "Sydney, Australia",
                price: 1600,
                duration: "12 days",
                imageName: "sydney",
                rating: 4.8
            ),
            Trip(
                destination: "Prague, Czech Republic",
                price: 380,
                duration: "3 days",
                imageName: "prague",
                rating: 4.7
            )
        ]
        
        return allTrips.filter { query.isEmpty || $0.destination.localizedCaseInsensitiveContains(query) }
    }
}
