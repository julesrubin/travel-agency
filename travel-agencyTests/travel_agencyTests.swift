//
//  travel_agencyTests.swift
//  travel-agencyTests
//
//  Created by Jules RUBIN on 01/11/2025.
//

import XCTest
@testable import travel_agency

/// Minimal test suite for CI pipeline - synchronous tests only
final class travel_agencyTests: XCTestCase {
    
    // MARK: - ViewModel Initialization Tests
    
    func testForYouViewModel_Initializes() {
        let viewModel = ForYouViewModel()
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.suggestions.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testTravelChatViewModel_Initializes() {
        let viewModel = TravelChatViewModel()
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.messages.isEmpty)
        XCTAssertEqual(viewModel.messageText, "")
        XCTAssertFalse(viewModel.isProcessing)
    }
    
    func testProfileViewModel_Initializes() {
        let viewModel = ProfileViewModel()
        XCTAssertNotNil(viewModel)
        XCTAssertFalse(viewModel.savedTrips.isEmpty)
        XCTAssertEqual(viewModel.savedTrips.count, 3)
        XCTAssertEqual(viewModel.userName, "Travel Enthusiast")
        XCTAssertEqual(viewModel.userEmail, "traveler@example.com")
    }
    
    // MARK: - Service Tests
    
    func testMockDataService_Initializes() {
        let service = MockDataService()
        XCTAssertNotNil(service)
    }
    
    func testMockDataService_ConformsToProtocol() {
        let service = MockDataService()
        XCTAssertTrue(service is DataServiceProtocol)
    }
    
    // MARK: - Model Tests
    
    func testTrip_Initialization() {
        let trip = Trip(
            destination: "Paris",
            price: 500,
            duration: "3 days",
            imageName: "paris",
            rating: 4.5
        )
        XCTAssertEqual(trip.destination, "Paris")
        XCTAssertEqual(trip.price, 500)
        XCTAssertEqual(trip.duration, "3 days")
        XCTAssertEqual(trip.rating, 4.5)
    }
    
    func testChatMessage_Initialization() {
        let message = ChatMessage(text: "Hello", isUser: true)
        XCTAssertEqual(message.text, "Hello")
        XCTAssertTrue(message.isUser)
        XCTAssertNotNil(message.id)
    }
    
    func testChatMessage_UniqueIDs() {
        let message1 = ChatMessage(text: "First", isUser: true)
        let message2 = ChatMessage(text: "Second", isUser: false)
        XCTAssertNotEqual(message1.id, message2.id)
    }
    
    // MARK: - ProfileViewModel Business Logic
    
    func testProfileViewModel_RemoveSavedTrip() {
        let viewModel = ProfileViewModel()
        let initialCount = viewModel.savedTrips.count
        
        guard let tripToRemove = viewModel.savedTrips.first else {
            XCTFail("Should have trips")
            return
        }
        
        viewModel.removeSavedTrip(tripToRemove)
        
        XCTAssertEqual(viewModel.savedTrips.count, initialCount - 1)
    }
}
