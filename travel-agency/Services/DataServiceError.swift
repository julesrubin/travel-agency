import Foundation

/// Custom error types for data service operations
enum DataServiceError: LocalizedError {
    case networkFailure
    case decodingError
    case timeout
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .networkFailure:
            return "Unable to connect to the server. Please check your internet connection."
        case .decodingError:
            return "Failed to process the data. Please try again."
        case .timeout:
            return "The request took too long. Please try again."
        case .invalidData:
            return "Received invalid data from the server."
        case .unknown(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}
