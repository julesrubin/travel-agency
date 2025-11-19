import Foundation

/// Protocol defining data service operations for the travel agency app
/// Enables dependency injection and easy mocking for tests
protocol DataServiceProtocol {
    /// Fetches personalized travel suggestions
    /// - Returns: Array of prompt suggestions
    /// - Throws: DataServiceError if the operation fails
    func fetchSuggestions() async throws -> [PromptSuggestion]
    
    /// Searches for trips based on a query string
    /// - Parameter query: Search query (empty string returns all trips)
    /// - Returns: Array of matching trips
    /// - Throws: DataServiceError if the operation fails
    func searchTrips(query: String) async throws -> [Trip]
}
