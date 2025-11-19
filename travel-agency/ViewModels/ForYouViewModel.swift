import Foundation
import Combine

/// ViewModel for the ForYou feed view
/// Manages personalized travel suggestions with proper error handling
class ForYouViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var suggestions: [PromptSuggestion] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    private let dataService: DataServiceProtocol
    
    // MARK: - Initialization
    /// Initialize with dependency injection
    /// - Parameter dataService: Service for fetching data (defaults to MockDataService)
    init(dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
    }
    
    // MARK: - Public Methods
    /// Loads personalized travel suggestions
    @MainActor
    func loadSuggestions() async {
        isLoading = true
        errorMessage = nil
        
        do {
            suggestions = try await dataService.fetchSuggestions()
        } catch let error as DataServiceError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = DataServiceError.unknown(error).errorDescription
        }
        
        isLoading = false
    }
}
